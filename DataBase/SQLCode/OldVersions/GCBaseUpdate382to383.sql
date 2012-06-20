USE GameClass
GO

GRANT SELECT ON [Users] TO public
GO

CREATE FUNCTION [IsManager] ()
  RETURNS INT

AS
BEGIN 
  IF EXISTS(SELECT * FROM Users WHERE ([Name] = SYSTEM_USER) AND (idUsersGroup = 2) AND (IsDelete = 0)) 
    RETURN 1
  ELSE
    RETURN 0
  RETURN 0
END
GO

GRANT EXEC ON [IsManager] TO public
GO

ALTER PROCEDURE UsersCreate
  @login_name NVARCHAR(50),
  @group_name NVARCHAR(50),
  @password NVARCHAR(50)

AS 
BEGIN
  DECLARE @error_descr VARCHAR(400)
  DECLARE @idGroup INT
  
  SELECT @idGroup=[id] FROM UsersGroup WHERE [name]=@group_name
  
  /*  проверка на наличие пользователя с таким же именем */
  IF EXISTS(SELECT [id] FROM Users WHERE [name]=@login_name AND [isdelete]=0)
  BEGIN
   RAISERROR 50000  'User already exist!'
   RETURN 50000
  END
  
  DECLARE @err1 INT
  DECLARE @err2 INT
  DECLARE @err3 INT

  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[tempdb]..[#msver]') )
    DROP TABLE #msver
  DECLARE @MSSQLVERSION INT
  CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200))
  INSERT INTO #msver EXEC master..xp_msver ProductVersion
  SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver
  DROP TABLE #msver
  
  DECLARE @sql VARCHAR(400)
  IF (@MSSQLVERSION = 8) 
  EXEC @err1=master.dbo.sp_addlogin @login_name
  IF (@MSSQLVERSION = 9) 
  BEGIN
    SET @sql = 'CREATE LOGIN ' + @login_name + ' WITH PASSWORD = '''', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
    EXEC (@sql)
  END
  EXEC @err2=sp_adduser @login_name, @login_name, 'public'
  IF (@group_name='Management')
    EXEC @err3=sp_addsrvrolemember @login_name, 'sysadmin'
  IF (@err1<>0) OR (@err2<>0)
  BEGIN
    RAISERROR 50000 'Ошибка создания пользователя'
    RETURN 50000
  END
  
  INSERT INTO Users ([name], [idUsersGroup]) VALUES (@login_name,@idGroup)
  EXEC UsersChangePass @login_name, @password
END
GO

ALTER PROCEDURE [dbo].[UsersDelete]
  @idUsers INT

AS 
BEGIN
  DECLARE @login_name NVARCHAR(50)
  SELECT @login_name=[name] FROM Users WHERE [id]=@idUsers
  
  IF object_id('tempdb..#ActiveUsers') IS NOT NULL 
    DROP TABLE #ActiveUsers
  
  CREATE TABLE #ActiveUsers (
    [spid] [INT] NOT NULL,
    [ecid] [INT] NOT NULL,
    [status] [VARCHAR] (50) NULL,
    [loginame] [VARCHAR] (50) NULL,
    [hostname] [VARCHAR] (50) NULL,
    [blk] [INT] NOT NULL,
    [dbname] [VARCHAR] (50) NULL,
    [cmd] [VARCHAR] (50) NULL
  ) ON [PRIMARY]
  
  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[tempdb]..[#msver]') )
    DROP TABLE #msver
  DECLARE @MSSQLVERSION INT
  CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200))
  INSERT INTO #msver EXEC master..xp_msver ProductVersion
  SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver
  DROP TABLE #msver
  
  IF (@MSSQLVERSION = 9) 
  BEGIN
		ALTER TABLE #ActiveUsers ADD [request_id] [INT] NULL 
  END

  INSERT #ActiveUsers EXEC sp_who @login_name
  
  IF @login_name = SYSTEM_USER
  BEGIN
   RAISERROR 50000 'You can''t delete yourself!'
  
  END
  
  IF EXISTS(SELECT * FROM #ActiveUsers) 
  BEGIN
   RAISERROR 50000 'You can''t delete active user!'
   
  END

  IF object_id('tempdb..#ActiveUsers') IS NOT NULL 
    DROP TABLE #ActiveUsers
  
  DECLARE @err1 INT
  DECLARE @err2 INT
  EXEC @err1=sp_dropuser @login_name
  EXEC @err2=master.dbo.sp_droplogin @login_name
  /* логическое удаление пользователя */
  IF (@err1<>0) OR (@err2<>0)
  BEGIN
    RAISERROR 50000 'Error deleting user!'
   
  END

  UPDATE Users SET [isdelete]=1 WHERE [id]=@idUsers
END
GO

/*
    AutoUpdates
*/

CREATE TABLE dbo.AutoUpdate (
  [id] INT NOT NULL IDENTITY (1, 1),
  idTable INT NOT NULL,
  idAction INT NOT NULL,
  idRecord INT NOT NULL,
  moment datetime NOT NULL DEFAULT GETDATE()
)  ON [PRIMARY]
GO
  
ALTER TABLE dbo.AutoUPDATE ADD CONSTRAINT
  PK_AutoUPDATE PRIMARY KEY CLUSTERED (id) ON [PRIMARY]
GO

CREATE TABLE dbo.AutoUpdateActions (
  [id] INT NOT NULL, 
  [Name] VARCHAR(50) NOT NULL
)  ON [PRIMARY]
GO

ALTER TABLE dbo.AutoUpdateActions ADD CONSTRAINT
  PK_AutoUpdateActions PRIMARY KEY CLUSTERED (id) ON [PRIMARY]
GO

INSERT dbo.AutoUpdateActions VALUES (1, 'Insert')
INSERT dbo.AutoUpdateActions VALUES (2, 'Delete')
INSERT dbo.AutoUpdateActions VALUES (3, 'Update')
GO

CREATE TABLE dbo.AutoUpdateTables (
  [id] INT NOT NULL, 
  [Name] VARCHAR(50) NOT NULL
)  ON [PRIMARY]
GO

ALTER TABLE dbo.AutoUpdateTables ADD CONSTRAINT
  PK_AutoUpdateTables PRIMARY KEY CLUSTERED (id) ON [PRIMARY]
GO

INSERT dbo.AutoUpdateTables VALUES (1, 'Accounts')
GO

CREATE TRIGGER AccountsAutoUPDATE ON [dbo].[Accounts] 

FOR INSERT, UPDATE, DELETE 
AS
BEGIN
  DECLARE @idI INT
  DECLARE @idD INT
  DECLARE @idAction INT
  DECLARE @isdeleted INT

  DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD], 
    I.isdeleted FROM INSERTED AS I
    FULL OUTER JOIN DELETED AS D ON I.id = D.id
  OPEN IDcursor
  FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT(@idI IS NULL) AND (@idD IS NULL) 
      SET @idAction = 1 --Insert
    IF (@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 2 --Delete
    IF NOT(@idI IS NULL) AND NOT(@idD IS NULL) 
      BEGIN 
        IF @isdeleted = 0
          SET @idAction = 3 --Update
        ELSE
          SET @idAction = 2 --Delete
      END
    INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, ISNULL(@idI,@idD))
    FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted
  END

  CLOSE IDcursor
  DEALLOCATE IDcursor
END
GO

CREATE PROCEDURE [dbo].[AutoUpdateSelectLastId]

AS 
BEGIN
  SELECT ISNULL((SELECT TOP 1 id FROM [AutoUpdate] ORDER BY id DESC), 0) id
END
GO

GRANT EXECUTE ON [dbo].[AutoUpdateSelectLastId] TO PUBLIC 
GO

CREATE PROCEDURE [dbo].[AutoUpdateSelect]
  @idPrev INT = -1

AS 
BEGIN
  SELECT * FROM [AutoUpdate] WHERE ([id] > @idPrev) ORDER BY [id] ASC 
END
GO

GRANT EXECUTE ON [dbo].[AutoUpdateSelect] TO PUBLIC 
GO

CREATE PROCEDURE AccountsUpdatePhoto
  @id INT,
  @photo image

AS 
BEGIN
  UPDATE Accounts SET [photo] = @photo WHERE [id]=@id
END
GO

GRANT EXECUTE ON [dbo].[AccountsUpdatePhoto] TO PUBLIC 
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsNew]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[AccountsNew]
GO

CREATE PROCEDURE AccountsInsert
  @seccodes NVARCHAR(80) = N''

AS 
BEGIN
  INSERT INTO Accounts([seccodes]) VALUES (@seccodes)
  SELECT SCOPE_IDENTITY() [id]
END
GO

GRANT EXECUTE ON [dbo].[AccountsInsert] TO PUBLIC 
GO

ALTER PROCEDURE AccountsSelect
  @id INT = NULL

AS 
BEGIN
  SELECT Accounts.* FROM Accounts 
    WHERE ([isdeleted] = 0) AND ((Accounts.[id] = @id) OR (@id IS NULL))
    ORDER BY [id]
END
GO

GRANT  EXECUTE  ON [dbo].[AccountsSelect]  TO [public]
GO

ALTER PROCEDURE AccountsDelete
  @id INT

AS
BEGIN 
  UPDATE Accounts SET [isdeleted]=1 WHERE [id]=@id
END
GO


ALTER PROCEDURE AccountsUnblock
  @id INT

AS 
BEGIN
  UPDATE Accounts SET [isblocked] = 0 WHERE [id]=@id
END
GO

ALTER PROCEDURE AccountsUpdateCodes
  @id INT,
  @seccodes NVARCHAR(80)

AS 
BEGIN
  UPDATE Accounts SET [seccodes] = @seccodes WHERE [id]=@id
END
GO

/* -----------------------------------------------------------------------------
                       AccountsDiscounts for AutoUpdate
----------------------------------------------------------------------------- */
EXEC sp_rename 'AccountsDiscount' ,'AccountsDiscounts'

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsDiscountSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsDiscountSelect]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsDiscountInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsDiscountInsert]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsDiscountDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsDiscountDelete]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsDiscountUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsDiscountUpdate]
GO

CREATE PROCEDURE AccountsDiscountsSelect
  @id INT = NULL

AS 
BEGIN
  SELECT * FROM AccountsDiscounts 
    WHERE ([id] = @id) OR (@id IS NULL)
    ORDER BY summary asc
END
GO

GRANT EXECUTE ON [dbo].[AccountsDiscountsSelect] TO [public]
GO

CREATE PROCEDURE AccountsDiscountsInsert
  @summary money = 0,
  @discount INT = 0

AS
BEGIN
  INSERT INTO AccountsDiscounts ([summary], [discount]) VALUES (@summary, @discount)
  SELECT SCOPE_IDENTITY() [id]
END
GO

CREATE PROCEDURE AccountsDiscountsDelete
  @id money

AS
BEGIN 
  DELETE FROM AccountsDiscounts WHERE [id] = @id
END
GO

CREATE PROCEDURE AccountsDiscountsUpdate
  @id INT,
  @summary money,
  @discount INT

AS 
BEGIN
  UPDATE AccountsDiscounts SET [summary] = @summary, [discount] = @discount
    WHERE [id]=@id
END
GO

CREATE TRIGGER AccountsDiscountsAutoUPDATE ON [dbo].[AccountsDiscounts] 

FOR INSERT, UPDATE, DELETE 
AS
BEGIN
  DECLARE @idI INT
  DECLARE @idD INT
  DECLARE @idAction INT
  DECLARE @isdeleted INT

  DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD] 
    FROM INSERTED AS I  
    FULL OUTER JOIN DELETED AS D ON I.id = D.id
  OPEN IDcursor
  FETCH NEXT FROM IDcursor INTO @idI, @idD

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT(@idI IS NULL) AND (@idD IS NULL) 
      SET @idAction = 1 --Insert
    IF (@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 2 --Delete
    IF NOT(@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 3 --Update
    INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(2/*AccountsDiscounts*/, @idAction, ISNULL(@idI,@idD))
    FETCH NEXT FROM IDcursor INTO @idI, @idD
  END

  CLOSE IDcursor
  DEALLOCATE IDcursor
END
GO

INSERT dbo.AutoUpdateTables VALUES (2, 'AccountsDiscounts')
GO

/* -----------------------------------------------------------------------------
                       Registry for AutoUpdate
----------------------------------------------------------------------------- */
ALTER TABLE [dbo].[Registry] DROP CONSTRAINT [PK_Registry] 
GO

ALTER TABLE [dbo].[Registry] ADD [id] INT NOT NULL IDENTITY (1, 1)
GO

ALTER TABLE [dbo].[Registry] ADD [Public] INT NOT NULL DEFAULT (0)
GO

UPDATE Registry SET [Public] = 1 WHERE [Key] LIKE '%Volume%'
GO

UPDATE Registry SET [Public] = 1 WHERE [Key] = 'TasksTemplate'
GO

DECLARE @Name VARCHAR(60)
DECLARE PublicNameCursor CURSOR FOR 
  SELECT [Name]+'\%' FROM Users WHERE idUsersGroup < 2 /*No Managers*/
OPEN PublicNameCursor
FETCH NEXT FROM PublicNameCursor INTO @Name
WHILE @@FETCH_STATUS = 0
BEGIN
  UPDATE Registry SET [Public] = 1 WHERE [Key] LIKE @Name
  FETCH NEXT FROM PublicNameCursor INTO @Name
END
CLOSE PublicNameCursor
DEALLOCATE PublicNameCursor
GO

UPDATE Registry SET [key] = [Name]+'\'+'LastLogin', [Public] = (case WHEN (idUsersGroup < 2) THEN 1 ELSE 0 END)
  FROM Registry	INNER JOIN Users ON [key] = 'LastLogon' + [Name]
GO

UPDATE Registry SET [value] = REPLACE ([value],'/',CHAR(13)+CHAR(10))
  WHERE [key] = 'TasksTemplate'
GO


ALTER TABLE dbo.Registry ADD CONSTRAINT
  PK_Registry PRIMARY KEY CLUSTERED (id) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX UK_Registry_Key ON dbo.Registry
  ([Key]) ON [PRIMARY]
GO

CREATE PROCEDURE RegistrySelectByKey
  @key NVARCHAR(200)

AS 
BEGIN
  SET NOCOUNT ON
  SELECT [value] FROM Registry WHERE [key]=@key
END
GO

GRANT EXECUTE ON [dbo].[RegistrySelectByKey] TO [public]
GO

ALTER PROCEDURE RegistrySelect
  @id INT = null

AS 
BEGIN
  SET NOCOUNT ON
  SELECT [id], [key], [value] FROM Registry 
    WHERE ([id] = @id) OR (@id IS NULL)
    ORDER BY [key] ASC
END
GO

ALTER PROCEDURE RegistryInsert
  @key VARCHAR(200) = NULL,
  @value VARCHAR(7000) = ''

AS 
BEGIN
  SET NOCOUNT ON
  SET @key = ISNULL(@key,newid())
  DECLARE @Public INT
  IF (dbo.IsManager() = 1)
    SET @Public = 0
  ELSE
    SET @Public = 1
  INSERT INTO Registry ([key], [value], [Public]) VALUES (@key, @value, @Public)
  SELECT SCOPE_IDENTITY() [id]
END
GO

CREATE PROCEDURE RegistryUpdate
  @id INT,
  @key VARCHAR(200),
  @value VARCHAR(7000)

AS
BEGIN 
  SET NOCOUNT ON
  DECLARE @Public INT
  IF (dbo.IsManager() = 1)
    SET @Public = 1
  ELSE
    SET @Public = 0
  IF (EXISTS(SELECT * FROM Registry WHERE ([id] = @id) AND (([Public] = 1) OR (@Public = 1))))
    UPDATE Registry SET [value] = @value, [key] = @key  WHERE [id] = @id
END
GO

GRANT EXEC ON [RegistryUpdate] to public
GO

CREATE TRIGGER RegistryAutoUPDATE ON [dbo].[Registry] 

FOR INSERT, UPDATE, DELETE 
AS
BEGIN
  DECLARE @idI INT
  DECLARE @idD INT
  DECLARE @idAction INT
  DECLARE @isdeleted INT

  DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD] 
    FROM INSERTED AS I  
    FULL OUTER JOIN DELETED AS D ON I.id = D.id
  OPEN IDcursor
  FETCH NEXT FROM IDcursor INTO @idI, @idD

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT(@idI IS NULL) AND (@idD IS NULL) 
      SET @idAction = 1 --Insert
    IF (@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 2 --Delete
    IF NOT(@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 3 --Update
    INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(3/*Registry*/, @idAction, ISNULL(@idI,@idD))
    FETCH NEXT FROM IDcursor INTO @idI, @idD
  END

  CLOSE IDcursor
  DEALLOCATE IDcursor
END
GO

INSERT dbo.AutoUpdateTables VALUES (3, 'Registry')
GO

/* -----------------------------------------------------------------------------
                       _pm_jobs for AutoUpdate
----------------------------------------------------------------------------- */
CREATE PROCEDURE PMJobsSelect
  @id INT = -1

AS 
BEGIN
  SET NOCOUNT ON
  SELECT jobs.* FROM jobs
    WHERE ([id] = @id) OR (@id IS NULL)
    ORDER BY [id] asc
END
GO

GRANT  EXECUTE  ON [dbo].[PMJobsSelect]  TO [public]
GO

CREATE PROCEDURE PMJobsSelectUnprocessed

AS 
BEGIN
  SET NOCOUNT ON
  DECLARE @Id INT
  SELECT @Id = ISNULL(CAST([value] as INT),0) FROM Registry WHERE [key] = 'PrinterScanId'
  SELECT jobs.* FROM jobs
    WHERE [id] > @Id
    ORDER BY [id] ASC
END
GO

GRANT  EXECUTE  ON [dbo].[PMJobsSelectUnprocessed]  TO [public]
GO

CREATE TRIGGER _pm_jobsAutoUPDATE ON [dbo].[_pm_jobs] 

FOR INSERT, UPDATE, DELETE 
AS
BEGIN
  DECLARE @idI INT
  DECLARE @idD INT
  DECLARE @idAction INT
  DECLARE @isdeleted INT

  DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD] 
    FROM INSERTED AS I  
    FULL OUTER JOIN DELETED AS D ON I.id = D.id
  OPEN IDcursor
  FETCH NEXT FROM IDcursor INTO @idI, @idD

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT(@idI IS NULL) AND (@idD IS NULL) 
      SET @idAction = 1 --Insert
    IF (@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 2 --Delete
    IF NOT(@idI IS NULL) AND NOT(@idD IS NULL) 
      SET @idAction = 3 --Update
    INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(4/*_pm_jobs*/, @idAction, ISNULL(@idI,@idD))
    FETCH NEXT FROM IDcursor INTO @idI, @idD
  END

  CLOSE IDcursor
  DEALLOCATE IDcursor
END
GO

INSERT dbo.AutoUpdateTables VALUES (4, '_pm_jobs')
GO
/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.83' WHERE [key]='BaseVersion'
GO

