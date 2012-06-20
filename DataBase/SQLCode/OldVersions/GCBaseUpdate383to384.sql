USE GameClass
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

DROP VIEW dbo.jobs
GO


CREATE VIEW dbo.jobs AS SELECT dbo._pm_jobs.*, RTRIM(dbo._pm_computers.ip) AS [ip], 
        dbo._pm_printers.name AS [printer], dbo._pm_users.name AS [user], 
        case dbo._pm_jobs.isOk when 0 then 'Error' when 1 then 'Ok!' end AS [status] 
    FROM  dbo._pm_jobs INNER JOIN dbo._pm_printers ON dbo._pm_jobs.idPrinter = dbo._pm_printers.id 
    INNER JOIN dbo._pm_computers ON dbo._pm_jobs.idComputer = dbo._pm_computers.id 
    INNER JOIN dbo._pm_users ON dbo._pm_jobs.idUser = dbo._pm_users.id
GO

DELETE FROM [FunctionsRights] WHERE idFunctions = 5
GO 

DELETE FROM [Functions] WHERE [id] = 5
GO

/* -----------------------------------------------------------------------------
                          Добавляем в услуги сессии и аккаунты
----------------------------------------------------------------------------- */

SET IDENTITY_INSERT [ServicesBase] ON
INSERT INTO [ServicesBase]([id],[name],[price],[isdelete]) VALUES(0,N'Распечатка с машины оператора',1,0)
SET IDENTITY_INSERT [ServicesBase] OFF
GO

DECLARE @price money
SELECT @price = CAST([value] AS money) FROM [Registry] WHERE [key] = N'printers\DefaultPrinter'
SET @price = ISNULL(@price, 1)
UPDATE ServicesBase SET [price] = @price WHERE [id] = 0
GO

/* TypeCost 1-отдельная оплата 2-из предоплаты 3-из постоплаты */
ALTER TABLE dbo.Services ADD
	idComputer int NULL,
	idAccount int NULL,
	TypeCost int NOT NULL CONSTRAINT DF_Services_TypeCost DEFAULT 1
GO


ALTER PROCEDURE ServiceToSell
@idService int,
@count int,
@now datetime,
@idComputer int,
@idAccount int,
@TypeCost int

AS 
BEGIN
  set nocount on

  declare @idMe int
  select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)
	if (@idComputer = -1) set @idComputer = NULL
	if (@idAccount = -1) or (@idAccount = 0) set @idAccount = NULL
  insert into Services ([idServicesBase], [count], [operator], [moment], [idComputer], [idAccount], [TypeCost]) 
    values (@idService, @count, @idMe, @now, @idComputer, @idAccount, @TypeCost)
END
GO

ALTER PROCEDURE RegistryUpdate
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
  BEGIN
    UPDATE Registry SET [value] = @value, [key] = @key  WHERE [id] = @id
    IF (@key = N'printers\DefaultPrinter') UPDATE ServicesBase SET [price] = CAST(@value AS money) WHERE [id] = 0
  END
END
GO

ALTER TABLE dbo.Sessions ADD
	Services money NOT NULL CONSTRAINT DF_Sessions_Services DEFAULT 0
GO

ALTER PROCEDURE SessionsUpdate
@idSessions int,
@traffic int,
@printed int,
@idSessionsAdd int,
@newstop datetime,
@newstatus int,
@newstate int,
@Services money

AS 
BEGIN
  set nocount on
  declare @idMe int
  select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

  if (exists (select * from Sessions where [id] = @idSessions))
  begin
    update Sessions Set [traffic] = [traffic] + @traffic, 
      [printed] = [printed] + @printed, 
      [operator] = @idMe, 
      [status]=@newstatus, 
      [state]=@newstate,
      [Services]=@Services
      where [id] = @idSessions
    update SessionsAdd Set [stop]=@newstop where [id]=@idSessionsAdd
  end
END
GO

ALTER PROCEDURE SessionsSelect
@now datetime

AS 
BEGIN
    SET NOCOUNT ON
    SELECT S.[id] idSessions, S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description],
            SA.[id] idSessionsAdd, SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole], 
            sum(SA2.[summa]) summa, S.[state], S.[status], S.[TrafficAdded], S.[Services]
        FROM Sessions AS S
        INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions])
        INNER JOIN SessionsAdd2 AS SA2 ON (SA.[id] = SA2.[idSessionsAdd])
        WHERE ((SA.[start]<=@now) OR (S.[status]=0)) AND (@now<SA.[stop]) AND (SA2.[ActionType] <> 3) --чтоб не считать деньги за траф в сумме
        GROUP BY S.[id], S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description], SA.[id], 
            SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole], S.[state], S.[status], S.[TrafficAdded], S.[Services]
END
GO

ALTER VIEW dbo.repServices 

AS 
SELECT    
 Users.[name] AS operator, 
 ServicesBase.[name], 
 Services.[count], 
 ServicesBase.[price], 
 Services.[moment],
 ServicesBase.[price]*Services.[count] AS summa,
 Services.[TypeCost],
 Computers.[number] as ComputerNumber,
 Accounts.[name] as UserName
FROM Services
 INNER JOIN ServicesBase ON ServicesBase.[id] = Services.[idServicesBase]
 INNER JOIN Users ON Services.[operator] = Users.[id]
 LEFT OUTER JOIN Computers ON Computers.[id] = Services.[idComputer]
 LEFT OUTER JOIN Accounts ON Accounts.[id] = Services.[idAccount]
GO

/* -----------------------------------------------------------------------------
          В текущем отчете не отображалась сумма, списанная с карт клиентов
					и коррекция для услуг
----------------------------------------------------------------------------- */

ALTER PROCEDURE ReportCurrent
@NewShiftPoint datetime

AS 

set nocount on

declare @LastShiftPoint datetime
declare @ServiceSumma money
declare @printed int
declare @traffic bigint
declare @AccountsAdded money
declare @AccountsReturned money
declare @AccountsPayed money

-- тут нужно получить момент последнего завершения смены
if exists (select * from JournalOp)  
 select top 1 @LastShiftPoint=[moment] from JournalOp where [moment]<=@NewShiftPoint order by [moment] desc
else
 select top 1 @LastShiftPoint=SA.[start] from SessionsAdd as SA order by SA.[start]

if (@LastShiftPoint is NULL) 
begin
  select top 1 @LastShiftPoint = S.[moment] from Services as S order by [moment] desc
end

set @LastShiftPoint=ISNULL(@LastShiftPoint,@NewShiftPoint)
-- получим дату последнего отчета оператора (предыдущего оператора) 

-- подсчет доп.расходов (услуг)
select @ServiceSumma=ISNULL(sum(RS.[summa]),0) from repServices as RS
  where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint) and (TypeCost = 1)

-- подсчет трафика и распечатанных страниц
select @traffic =  ISNULL(Sum(CAST(s.[traffic] AS bigint)),0), @printed =  ISNULL(Sum(s.[printed]),0) from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA.[start]) and (SA.[start]<=@NewShiftPoint)

-- подсчет денег для аккаунтов
-- добавлено
select @AccountsAdded= ISNULL(Sum(AH.summa),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
where (AH.What=0)  
 and usersgroup.name='Staff'
 and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
-- возвращено
select @AccountsReturned =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
  where (AH.[What]=1)
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
-- проплачено
select @AccountsPayed =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
  where (AH.[What]=2)
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)

select ISNULL(sum(SA2.[summa]),0) as time, @ServiceSumma as service, @traffic as traffic, @printed as printed, 
  @AccountsAdded as AccountsAdded,  @AccountsPayed as AccountsPayed, @AccountsReturned as AccountsReturned, @LastShiftPoint as LastShiftPoint from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA2.[moment]) and (SA2.[moment]<=@NewShiftPoint)
  and S.[idClients]=0
GO

/* -----------------------------------------------------------------------------
                          Учет трафика для оператора
----------------------------------------------------------------------------- */

ALTER TABLE dbo.JournalOp ADD
	traffic int NOT NULL CONSTRAINT DF_JournalOp_traffic DEFAULT 0,
	removedMoney money NOT NULL CONSTRAINT DF_JournalOp_removedMoney DEFAULT 0
GO

ALTER PROCEDURE ReportCurrentInsert
@moment datetime,
@summa money,
@removedMoney money = 0,
@comment nvarchar(200)='',
@traffic int = 0

AS 
BEGIN
  set nocount on
  declare @idMe int
  select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)
  insert into JournalOp ([moment], [summa], [removedMoney], [comment], [operator], [traffic])
    values (@moment, @summa, @removedMoney, @comment, @idMe, @traffic)
	update [Registry] set [Value]='0' where [Key]='RemovedMoney'
END
GO

ALTER VIEW dbo.repJournalOp 

AS 
SELECT     dbo.Users.Name AS operator, dbo.JournalOp.moment, dbo.JournalOp.traffic, dbo.JournalOp.summa, dbo.JournalOp.comment 
FROM         dbo.JournalOp INNER JOIN 
                      dbo.Users ON dbo.JournalOp.operator = dbo.Users.id 
GO

/* -----------------------------------------------------------------------------
                          Дефолты для новых опций
----------------------------------------------------------------------------- */
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('ServerScript', '0', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('ServiceByPrepay', '0', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('ServiceByPostpay', '0', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('OuterProxy\SetLimit', '0', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('Internet\TariffingMode', '1', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('OperatorIP', '192.168.0.254', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('OperatorPrinterControl', '-1', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('OperatorTrafficControl', '-1', 0)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('OperatorTrafficInbound', '0', 1)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('OperatorTrafficOutbound', '0', 1)
INSERT INTO [Registry] ([Key], [Value], [Public]) 
  VALUES('RemovedMoney', '0', 0)

IF NOT EXISTS(SELECT * FROM [Registry] WHERE [Key] = 'TasksTemplate')
  INSERT INTO [Registry] ([Key], [Value], [Public]) 
    VALUES('TasksTemplate', '', 1)
UPDATE [Registry] SET [Public] = 1  WHERE [Key] = 'TasksTemplate'
/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.84' WHERE [key]='BaseVersion'
GO

