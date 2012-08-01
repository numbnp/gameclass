USE GameClass
GO

/* -----------------------------------------------------------------------------
        Добавление права на печать отчетов на ККМ
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM [dbo].[functions] WHERE [id] = 33)
BEGIN
  INSERT INTO [functions]([id],[name]) VALUES(33,N'fnXReport')
  INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(33,1)
  INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(33,2)
  INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(33,3)
  INSERT INTO [functions]([id],[name]) VALUES(34,N'fnZReport')
  INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(34,3)
END
GO

/* -----------------------------------------------------------------------------
        Исправление Procedure 'TarifsAdd' expect parameter '@BytesInMB'
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputerGroupsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE ComputerGroupsAdd
GO

CREATE PROCEDURE ComputerGroupsAdd
@name nvarchar(15)  
AS 

DECLARE @idGroup int

SET NOCOUNT ON

IF (EXISTS(SELECT * FROM ComputerGroups WHERE [name]=@name AND [isdelete]=0))
BEGIN
  RAISERROR 50000 'ComputerGroups with these name already exist!'
  RETURN 50000
END
ELSE
  INSERT INTO ComputerGroups ([name]) VALUES (@name)
  SELECT @idGroup=[id] from ComputerGroups WHERE [name]=@name AND [isdelete]=0
  SET @name= @name +'Default'
  EXEC TarifsAdd @name=@name, @internet=0, @calctraffic=0, @roundtime=1, @roundmoney=0.1, @idGroup=@idGroup, 
      @BytesInMB=1048576, @SpeedLimitInKB=0, @PluginGroupName=''
GO


/* -----------------------------------------------------------------------------
         Удаляем ненужные таблицы pm
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[old_Information]'))
DROP TABLE old_Information
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[old_errors]'))
DROP TABLE old_errors
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[old_warnings]'))
DROP TABLE old_warnings
GO


/* -----------------------------------------------------------------------------
         Удаляем ненужные процедуры
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ClearStatistics]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE ClearStatistics
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_Operators]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_Operators]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_Computers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_Computers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repGeneral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repGeneral]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repLogs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repLogs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repDetails]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repJournalOp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repJournalOp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repRepair]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repRepair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repUncontrol]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repUncontrol]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repUncontrolClub]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repUncontrolClub]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repServices]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [spgc_repServices]
GO

/* -----------------------------------------------------------------------------
         Каскадные ключи для Sessions для нормального удаления
----------------------------------------------------------------------------- */
ALTER TABLE dbo.SessionsAdd DROP CONSTRAINT FK_SessionsAdd_Sessions
GO

ALTER TABLE dbo.SessionsAdd2 DROP CONSTRAINT FK_SessionsAdd2_SessionsAdd
GO

ALTER TABLE dbo.SessionsAdd WITH NOCHECK ADD CONSTRAINT
	FK_SessionsAdd_Sessions FOREIGN KEY
	(
	idSessions
	) REFERENCES dbo.Sessions
	(
	id
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
	 NOT FOR REPLICATION
GO

ALTER TABLE dbo.SessionsAdd2 WITH NOCHECK ADD CONSTRAINT
	FK_SessionsAdd2_SessionsAdd FOREIGN KEY
	(
	idSessionsAdd
	) REFERENCES dbo.SessionsAdd
	(
	id
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
	 NOT FOR REPLICATION

GO

/* -----------------------------------------------------------------------------
         Обновление SessionsAddMoney для правильной работы с УЗ
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsAddMoney]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE SessionsAddMoney
GO

CREATE PROCEDURE SessionsAddMoney
@IdClient int,
@IdSessions int,
@IdSessionsAdd int,
@NewStop datetime,
@Summa money,
@Moment datetime

AS 
BEGIN
    SET NOCOUNT ON
    -- добавляем новую запись в SessionsAdd2, ActionType = 1 (добавить денег)
    INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
        VALUES (@IdSessionsAdd, 1, @Summa, @Moment)
    -- увеличиваем общую оплаченную сумму
    UPDATE Sessions SET [payed] = [payed] + @summa
        WHERE [id] = @IdSessions
    -- увеличиваем время до скольки нужно
    UPDATE SessionsAdd SET [stop] = @NewStop
        WHERE [id] = @IdSessionsAdd
    IF (@IdClient <> 0) 
    BEGIN
        UPDATE Accounts SET [balance] = [balance] - @Summa WHERE [id] = @IdClient
        UPDATE Accounts SET [summary] = [summary] + @Summa WHERE [id] = @IdClient
        INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  
            VALUES  (@IdClient, @Moment, 2, @summa, N'addtime',0)
    END
END
GO


/* -----------------------------------------------------------------------------
                  Новые функции
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserGroup]') )
DROP FUNCTION [GetUserGroup]
GO

CREATE FUNCTION [GetUserGroup] ()
  RETURNS int

AS
BEGIN 
  DECLARE @idGroup int
  SELECT TOP 1 @idGroup = idUsersGroup FROM Users 
    WHERE [Name] = SYSTEM_USER AND IsDelete = 0
  RETURN @idGroup
END
GO 

GRANT EXEC ON [GetUserGroup] TO public
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserGroupName]'))
DROP FUNCTION [GetUserGroupName]
GO

CREATE FUNCTION [GetUserGroupName] ()
  RETURNS varchar(50)

AS
BEGIN 
  DECLARE @GroupName varchar(50)
  SELECT TOP 1 @GroupName = UG.[Name] FROM Users U
    INNER JOIN UsersGroup UG ON idUsersGroup = UG.[id]
    WHERE U.[Name] = SYSTEM_USER AND U.IsDelete = 0 AND UG.IsDelete = 0
  RETURN @GroupName
END
GO

GRANT EXEC ON [GetUserGroupName] TO public
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CheckFunctionsRight]') )
DROP FUNCTION [CheckFunctionsRight]
GO

CREATE FUNCTION [CheckFunctionsRight] (
@FunctionName nvarchar(50)
)
  RETURNS int

AS
BEGIN 
    DECLARE @Result int
    SET @Result = NULL
    SELECT TOP 1 @Result = [FunctionsRights].[id] FROM [FunctionsRights] 
        INNER JOIN [Functions] ON [idFunctions] = [Functions].[id] 
        AND [Name] = @FunctionName
        WHERE [idUsersGroup] = dbo.GetUserGroup()
    IF @Result IS NULL
        SET @Result = 0
    ELSE
        SET @Result = -1
    RETURN @Result
END
GO 

GRANT EXEC ON [CheckFunctionsRight] TO public
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetLogonInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE GetLogonInfo
GO

CREATE PROCEDURE GetLogonInfo
@id int,
@Value bigint

AS
BEGIN
  SET NOCOUNT ON
    DECLARE @isManager int
    DECLARE @idGroup int
  
    SET @isManager = 0
    SET @idGroup = -1
    SELECT @idGroup = [idUsersGroup] FROM Users WHERE ([name] = SYSTEM_USER) AND ([isdelete]=0)
    IF (@idGroup = 2)
      SET @isManager = 1
    SELECT GETDATE(), CAST(@isManager AS bit)
END
GO

/* -----------------------------------------------------------------------------
                          Дефолты для новых опций
----------------------------------------------------------------------------- */
/* -----------------------------------------------------------------------------
          Создание таблиц и процедур для учета услуг RunPad
----------------------------------------------------------------------------- */
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServicesRunpad]'))
CREATE TABLE [ServicesRunpad] (
        [id] [int] IDENTITY (1, 1) NOT NULL ,
        [idService] [int] NULL ,
        [idServiceBase] [int] NOT NULL ,
        [ComputerLoacation] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [ComputerDescription] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [ComputerName] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [ComputerIP] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [UserDomain] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [UserName] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [VipName] [varchar] (256) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        [DataCount] [int] NOT NULL ,
        [DataSize] [int] NOT NULL ,
        [DataTime] [int] NOT NULL ,
        [Comment] [varchar] (512) COLLATE Cyrillic_General_CI_AS NOT NULL ,
        CONSTRAINT [PK_ServicesRunpad] PRIMARY KEY  CLUSTERED
        (
                [id]
        )  ON [PRIMARY]
) ON [PRIMARY]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServicesRunpadInsert3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE ServicesRunpadInsert3
GO

CREATE PROC ServicesRunpadInsert3
@comp_loc    varchar(256),   -- местоположение машины (организация)
@comp_desc   varchar(256),   -- описание машины (возможен номер)
@comp_name   varchar(256),   -- имя машины
@comp_ip     varchar(256),   -- IP
@user_domain varchar(256),   -- домен
@user_name   varchar(256),   -- имя пользователя Windows
@vip_name    varchar(256),   -- VIP-имя (если есть)
@id          int,            -- id услуги
@data_count  int,            -- кол-во (страниц, файлов и пр.)
@data_size   int,            -- размер в КБ обработанных данных
@data_time   int,            -- время в секундах пользования услугой
@comments    varchar(512)    -- комментарии (например, название распечатанного документа)

AS
BEGIN
  SET NOCOUNT ON
  INSERT INTO [ServicesRunpad]
    ([idService], [idServiceBase], 
    [ComputerLoacation] ,[ComputerDescription] ,[ComputerName] ,[ComputerIP] ,
    [UserDomain] ,[UserName] , [VipName],
    [DataCount], [DataSize], [DataTime], [Comment])
  VALUES
    ( NULL, @id + 40000, 
    @comp_loc, @comp_desc, @comp_name, @comp_ip,
    @user_domain, @user_name, @vip_name, 
    @data_count, @data_size, @data_time, @comments)
END
GO

GRANT EXEC ON [ServicesRunpadInsert3] TO pm_service
GO

DROP TRIGGER ServicesRunpadAutoUpdate;
GO

CREATE TRIGGER ServicesRunpadAutoUpdate ON [dbo].[ServicesRunpad]

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
    INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(5/*ServicesRunpad*/, @idAction, ISNULL(@idI,@idD))
    FETCH NEXT FROM IDcursor INTO @idI, @idD
  END

  CLOSE IDcursor
  DEALLOCATE IDcursor
END
GO

if not exists (select * from dbo.AutoUpdateTables where id = 5)
INSERT dbo.AutoUpdateTables VALUES (5, 'ServicesRunpad')
GO


ALTER TRIGGER RegistryAutoUpdate ON [dbo].[Registry]

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


/* -----------------------------------------------------------------------------
                  Новые отчеты: создание таблиц и процедур
----------------------------------------------------------------------------- */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ReportColumns_Reports]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ReportColumns] DROP CONSTRAINT FK_ReportColumns_Reports
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportColumns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReportColumns]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Reports]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Reports]
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportColumns]'))
CREATE TABLE [dbo].[ReportColumns] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[ReportId] [int] NOT NULL ,
	[Name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[Field] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[ChartRole] [int] NOT NULL ,
	[ChartDefault] [int] NOT NULL ,
	[IsGeneral] [int] NOT NULL ,
	[AggregateFunction] [int] NOT NULL ,
	[Visible] [int] NOT NULL ,
	[Width] [int] NOT NULL ,
	[OrderIndex] [int] NOT NULL 
) ON [PRIMARY]
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Reports]'))
CREATE TABLE [dbo].[Reports] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[Code] [text] COLLATE Cyrillic_General_CI_AS NULL ,
	[Description] [varchar] (4000) COLLATE Cyrillic_General_CI_AS NULL ,
	[IsFolder] [int] NOT NULL ,
	[ParentId] [int] NOT NULL ,
	[OrderIndex] [int] NOT NULL ,
	[Author] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[Version] [int] NOT NULL ,
	[GUID] [uniqueidentifier] NOT NULL,
	[Invariable] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ReportColumns] WITH NOCHECK ADD 
	CONSTRAINT [PK_ReportsColumns] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Reports] WITH NOCHECK ADD 
	CONSTRAINT [PK_Reports] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ReportColumns] ADD 
	CONSTRAINT [DF_ReportsColumns_ChartRole] DEFAULT (0) FOR [ChartRole],
	CONSTRAINT [DF_ReportsColumns_ChartDefault] DEFAULT (0) FOR [ChartDefault],
	CONSTRAINT [DF_ReportsColumns_IsGeneral] DEFAULT (0) FOR [IsGeneral],
	CONSTRAINT [DF_ReportsColumns_Visible] DEFAULT (0) FOR [Visible],
	CONSTRAINT [DF_ReportsColumns_Width] DEFAULT (0) FOR [Width],
	CONSTRAINT [DF_ReportsColumns_OrderId] DEFAULT (0) FOR [OrderIndex],
	CONSTRAINT [CK_ReportColumns_ChartDefault] CHECK ([ChartDefault] = 0 or [ChartDefault] = 1),
	CONSTRAINT [CK_ReportColumns_IsGeneral] CHECK ([IsGeneral] = 0 or [IsGeneral] = 1),
	CONSTRAINT [CK_ReportColumns_Visible] CHECK ([Visible] = 0 or [Visible] = 1)
GO

ALTER TABLE [dbo].[Reports] ADD 
	CONSTRAINT [DF_Reports_IsFolder] DEFAULT (0) FOR [IsFolder],
	CONSTRAINT [DF_Reports_ParentId] DEFAULT (0) FOR [ParentId],
	CONSTRAINT [DF_Reports_OrderId] DEFAULT (0) FOR [OrderIndex],
	CONSTRAINT [DF_Reports_Version] DEFAULT (1) FOR [Version],
	CONSTRAINT [DF_Reports_uid] DEFAULT (newid()) FOR [GUID],
	CONSTRAINT [DF_Reports_Invariable] DEFAULT (0) FOR [Invariable],
	CONSTRAINT [CK_Reports_IsFolder] CHECK ([IsFolder] = 0 or [IsFolder] = 1),
	CONSTRAINT [CK_Reports_Version] CHECK ([Version] > 0),
	CONSTRAINT [CK_Reports_Invariable] CHECK ([Invariable] = 0 or [Invariable] = 1)
GO

ALTER TABLE [dbo].[ReportColumns] ADD 
	CONSTRAINT [FK_ReportColumns_Reports] FOREIGN KEY 
	(
		[ReportId]
	) REFERENCES [dbo].[Reports] (
		[id]
	) ON DELETE CASCADE 
GO


IF NOT EXISTS (SELECT * FROM [dbo].[functions] WHERE [id] = 35)
BEGIN
	INSERT INTO [Functions]([id],[name]) VALUES(35, N'CustomReports')
	INSERT INTO [FunctionsRights]([idFunctions],[idUsersGroup]) VALUES(35, 1)
	INSERT INTO [FunctionsRights]([idFunctions],[idUsersGroup]) VALUES(35, 2)
	INSERT INTO [FunctionsRights]([idFunctions],[idUsersGroup]) VALUES(35, 3)
END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CustomReportsAdd]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[CustomReportsAdd]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CustomReportsDelete]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[CustomReportsDelete]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CustomReportsImport]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[CustomReportsImport]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CustomReportsSelect]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[CustomReportsSelect]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CustomReportsUpdate]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[CustomReportsUpdate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetCustomReportParentId]') )
DROP FUNCTION [GetCustomReportParentId]
GO

CREATE FUNCTION [GetCustomReportParentId] ()
  RETURNS int

AS
BEGIN 
  DECLARE @idParent int
  SELECT TOP 1 @idParent = CASE dbo.GetUserGroupName()
      WHEN 'Staff' THEN 1
      WHEN 'Tech' THEN 2
      ELSE NULL
    END
    FROM [Functions]
    INNER JOIN [FunctionsRights] ON [idFunctions] = [Functions].[id] 
    AND [idUsersGroup] = dbo.GetUserGroup()
    WHERE Name = 'CustomReports'
  RETURN @idParent
END
GO 

GRANT EXEC ON [GetCustomReportParentId] TO public
GO

CREATE PROCEDURE CustomReportsSelect

AS
BEGIN
  SELECT [id], [Name], '' [Code], '' [Description], [IsFolder], 0 [ParentId], 
      [OrderIndex], [Author], [Version], [GUID], [Invariable] 
    FROM [Reports]
    WHERE [ParentId] = dbo.GetCustomReportParentId()
END
GO

GRANT EXEC ON [CustomReportsSelect] TO public
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportColumnsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CustomReportColumnsSelect
GO

CREATE PROCEDURE CustomReportColumnsSelect
@idReport int

AS
BEGIN
  SELECT RC.* FROM ReportColumns RC 
    INNER JOIN Reports R ON RC.ReportId = R.id
    WHERE R.[ParentId] = dbo.GetCustomReportParentId() AND RC.ReportId = @idReport
    ORDER BY RC.OrderIndex ASC
END
GO

GRANT EXEC ON [CustomReportColumnsSelect] TO public
GO


/* -----------------------------------------------------------------------------
              Новые отчеты: конвертация старых и новые папки
----------------------------------------------------------------------------- */
--DROP TRIGGER ReportsUpdate 
CREATE TRIGGER ReportsUpdate ON [dbo].[Reports]

FOR INSERT, UPDATE, DELETE
AS
BEGIN
  DECLARE @id int
  DECLARE @Code varchar(8000)
  DECLARE @ProcName varchar(100)
  DECLARE @idParent int
  DECLARE @Invariable int

  DECLARE Dcursor CURSOR FOR SELECT DISTINCT [id] 
    FROM 
    (SELECT [id] FROM DELETED WHERE IsFolder <> 1 AND ParentID IN (1,2)
    UNION ALL 
    SELECT [id] FROM INSERTED WHERE IsFolder <> 1 AND ParentID IN (1,2)) IDTable
  OPEN Dcursor
  FETCH NEXT FROM Dcursor INTO @id

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @ProcName = 'CustomReport' + CONVERT(varchar(5),@id) + 'Execute'
    SET @Code = 'if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].['
    SET @Code = @Code + @ProcName + ']'') and OBJECTPROPERTY(id, N''IsProcedure'') = 1)'
    SET @Code = @Code + 'drop procedure [dbo].[' + @ProcName + ']'
    EXEC (@Code)
    FETCH NEXT FROM Dcursor INTO @id
  END

  CLOSE Dcursor
  DEALLOCATE Dcursor

  DECLARE Icursor CURSOR FOR SELECT [id] FROM INSERTED WHERE IsFolder <> 1 AND ParentID IN (1,2)
  OPEN Icursor
  FETCH NEXT FROM Icursor INTO @id

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @Code = CONVERT(varchar(8000),[Code]), @idParent = ParentID, @Invariable = Invariable FROM Reports WHERE [id] = @id
    IF LEN(@Code) > 0 
    BEGIN
      SET @Code = REPLACE(@Code, '%TIME-CURRENT%', '@Current')
      SET @Code = REPLACE(@Code, '%TIME-START%', '@Begin')
      SET @Code = REPLACE(@Code, '%TIME-STOP%', '@End')
      SET @Code = REPLACE(@Code, '%SHIFT-BEGIN%', '@CurrentShiftBegin')
      SET @Code = REPLACE(@Code, '%SHIFT2-BEGIN%', '@PrevShiftBegin')
      SET @Code = REPLACE(@Code, '%SHIFT2-END%', '@PrevShiftEnd')
      SET @ProcName = 'CustomReport' + CONVERT(varchar(5),@id) + 'Execute'
      SET @Code = 'CREATE PROCEDURE ' + @ProcName + '
@Current datetime,
@Begin datetime,
@End datetime,
@CurrentShiftBegin datetime,
@PrevShiftBegin datetime,
@PrevShiftEnd datetime

AS
SET NOCOUNT ON
' + CASE WHEN @Invariable <> 1 THEN 'IF dbo.GetCustomReportParentId() = ' + CONVERT(varchar(5),@idParent) ELSE ' ' END + '
BEGIN
' + @Code + '
END
'
      EXEC (@Code)
      SET @Code = 'GRANT EXEC ON [' + @ProcName + '] TO public'
      EXEC (@Code)
    END
    FETCH NEXT FROM Icursor INTO @id
  END

  CLOSE Icursor
  DEALLOCATE Icursor
END
GO

--SELECT * FROM  REPORTS
--DELETE FROM  REPORTS
--SELECT NEWID()
SET IDENTITY_INSERT [Reports] ON
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID])
  VALUES(1, 'Для операторов', NULL, NULL, 1, 0, 0, 'NodaSoft',1,'36DA3A2E-8EF9-427A-BC94-49789AEE306B')
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID])
  VALUES(2, 'Для админов', NULL, NULL, 1, 0, 1, 'NodaSoft',1,'8237ACEC-878E-462D-9133-64AEF9CCC5BB')
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID])
  VALUES(3, 'Старые', NULL, NULL, 1, 0, 2, 'NodaSoft',1,'E284FD91-2C90-491E-8237-5138982C4DD4')
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID], [Invariable])
  VALUES(20, 'Текущий отчет', '  
  declare @LastShiftPoint datetime
  declare @Time money
  declare @Services money
  declare @Print money
  declare @Internet money
  declare @AccountsAdded money
  declare @AccountsPayed money
  declare @AccountsReturned money
  declare @Rest money
  declare @ReportString varchar(100)
  
  if object_id(''tempdb..#t'') is not null   
  DROP TABLE #t 
  
  CREATE TABLE #t (   
  [Name] varchar(100),   
  [Value] varchar(50)   
  ) ON [PRIMARY]   
  
  EXEC ReportCurrent %TIME-CURRENT%, @LastShiftPoint OUTPUT, @Time OUTPUT, @Services OUTPUT, @Print OUTPUT, @Internet OUTPUT, 
    @AccountsAdded OUTPUT, @AccountsPayed OUTPUT, @AccountsReturned OUTPUT, @Rest OUTPUT 
  
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentHeader''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentBegin''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@LastShiftPoint, 20))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentEnd''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),GETDATE(), 20))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentOperator''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, ''щзукфещк'')
  INSERT INTO #t([Name], [Value]) VALUES ('''', '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTotal''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTime''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Time))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentServices''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Services))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentPrint''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Print))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentInternet''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Internet))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentAccountsAdded''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@AccountsAdded))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentAccountsPayed''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@AccountsPayed))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentAccountsReturned''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@AccountsReturned))
  INSERT INTO #t([Name], [Value]) VALUES ('''', '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTotalSum''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),0))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentOperatorSum''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),0))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentManagerSum''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),0))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentRest''
  INSERT INTO #t([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),0))
  SELECT * FROM #t
', 'Текущий отчет оператора', 0, 1, 1, 'NodaSoft',1,'431B783B-C9D0-4241-8B26-2C5F42B3B30D', 1)
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID], [Invariable])
  VALUES(21, 'Последние сеансы', 'select * from [repDetails] where ([moment]  >=%TIME-START%) and ([moment]<=%TIME-STOP%)', 
  'Выводит список последних сеансов', 0, 1, 1, 'NodaSoft',1,'90409714-441E-4810-A10C-00F439AE41B2', 1)
UPDATE [Reports] SET Invariable = 1 WHERE [id] IN (20, 21)
SET IDENTITY_INSERT [Reports] OFF
DBCC CHECKIDENT ('Reports', RESEED, 100)
INSERT INTO [Reports] ([name], [description], [code], [author], [isfolder], [parentid], [orderindex], [version], [GUID])
  SELECT [name], [description], [sqlcode], 'NodaSoft', 0, 3, [tabindex], [version], [id] FROM [CustomReports]
    

/* -----------------------------------------------------------------------------
           Измения для сеансов: отдельная плата за трафик, услуги и т.д.
		таблицы Session SessionsAdd
----------------------------------------------------------------------------- */

ALTER TABLE [Sessions] ADD [CommonPay] [money] NOT NULL DEFAULT (0)
ALTER TABLE [Sessions] ADD [SeparateTrafficPay] [money] NOT NULL DEFAULT (0)
ALTER TABLE [Sessions] ADD [PrintCost] [money] NOT NULL DEFAULT (0)
ALTER TABLE [Sessions] ADD [ServiceCost] [money] NOT NULL DEFAULT (0)
ALTER TABLE [Sessions] ADD [AdditionalMinutes] [int] NOT NULL DEFAULT (0)
GO

ALTER TABLE [SessionsAdd] ADD [Traffic] [float] NOT NULL 
        CONSTRAINT [DF_SessionsAdd_Traffic] DEFAULT (0)
ALTER TABLE [SessionsAdd] ADD [TrafficCost] [money] NOT NULL 
        CONSTRAINT [DF_SessionsAdd_TrafficCost] DEFAULT (0)
ALTER TABLE [SessionsAdd] ADD [SeparateTrafficCost] [money] NOT NULL 
        CONSTRAINT [DF_SessionsAdd_SeparateTrafficCost] DEFAULT (0)
GO

-- Избавляемся от типа bit
ALTER TABLE dbo.TarifsVariants DROP CONSTRAINT DF_TarifsVariants_TrafficSeparatePayment
GO

ALTER TABLE dbo.TarifsVariants DROP CONSTRAINT DF_TarifsVariants_FreePacket
GO

ALTER TABLE TarifsVariants ALTER COLUMN TrafficSeparatePayment int 
GO

ALTER TABLE TarifsVariants ALTER COLUMN FreePacket int 
GO

ALTER TABLE dbo.TarifsVariants ADD CONSTRAINT DF_TarifsVariants_TrafficSeparatePayment DEFAULT (0) FOR TrafficSeparatePayment
GO

ALTER TABLE dbo.TarifsVariants ADD CONSTRAINT DF_TarifsVariants_FreePacket DEFAULT (0) FOR FreePacket
GO

UPDATE [Sessions] SET [CommonPay] = [payed]
GO

UPDATE [Sessions] SET [ServiceCost] = [Services]
GO

DECLARE @Price money
SELECT @Price = CAST([value] AS money) FROM [Registry] WHERE [key] = N'printers\DefaultPrinter'
SET @Price = ISNULL(@Price, 1)
UPDATE [Sessions] SET [PrintCost] = [printed] * @Price
GO

UPDATE SA SET SA.Traffic = CAST(S.traffic AS float), SA.TrafficCost = S.CommonPay - S.ServiceCost - S.PrintCost
 FROM SessionsAdd SA
    INNER JOIN (SELECT MAX(SA0.id) id FROM Sessions S0 
        INNER JOIN SessionsAdd SA0 ON S0.id = SA0.idSessions
        GROUP BY S0.id) SALT ON SA.id = SALT.id
    INNER JOIN Sessions S ON S.id = SA.idSessions
GO

UPDATE SA SET SA.SeparateTrafficCost = SASTP.SeparateTrafficPay
FROM SessionsAdd SA
    INNER JOIN (SELECT SA.id, SUM(SA2.summa) AS SeparateTrafficPay 
        FROM SessionsAdd SA
        INNER JOIN SessionsAdd2 SA2 ON SA.id = SA2.idSessionsAdd AND ACtionType = 3
        GROUP BY SA.id) SASTP ON SA.id = SASTP.id
GO

UPDATE S SET S.SeparateTrafficPay = SSTP.SeparateTrafficPay
FROM Sessions S
    INNER JOIN (SELECT S.id, SUM(SA.SeparateTrafficCost) AS SeparateTrafficPay 
        FROM Sessions S
        INNER JOIN SessionsAdd SA ON S.id = SA.idSessions
        GROUP BY S.id) SSTP ON S.id = SSTP.id
GO

UPDATE [Sessions] SET [AdditionalMinutes] = -[minpenalty]
GO

ALTER TABLE dbo.Sessions DROP CONSTRAINT DF_Sessions_traffic
GO

ALTER TABLE dbo.Sessions DROP CONSTRAINT DF_Sessions_printed
GO

ALTER TABLE dbo.Sessions DROP CONSTRAINT DF_Sessions_payed
GO

ALTER TABLE dbo.Sessions DROP CONSTRAINT DF_Sessions_TrafficAdded
GO

ALTER TABLE dbo.Sessions DROP CONSTRAINT DF_Sessions_Services
GO

-- Удаляем констрейнт DF__Sessions__minpen__40058253
DECLARE @ConstraintName nvarchar(200)
SET @ConstraintName = NULL
SELECT TOP 1 @ConstraintName = name FROM dbo.sysobjects WHERE name LIKE '%DF%Sessions%minpen%'
IF NOT @COnstraintName IS NULL BEGIN
  SET @ConstraintName = N'ALTER TABLE dbo.Sessions DROP CONSTRAINT ' + @ConstraintName
  exec sp_executesql @ConstraintName
END
GO

ALTER TABLE dbo.Sessions DROP COLUMN minpenalty, traffic, printed, payed, TrafficAdded, Services
GO

/* -----------------------------------------------------------------------------
           Измения для сеансов: отдельная плата за трафик, услуги и т.д.
		процедуры SessionsSelect
----------------------------------------------------------------------------- */
ALTER PROCEDURE SessionsSelect
  @id int = NULL,
  @dt datetime

AS 
BEGIN
    SET NOCOUNT ON
    SELECT SS.idSessions, idSessionsAdd, SS.idComp, SS.idClients, SS.started, SS.start, SS.stop, 
            SS.idTarif, SS.whole, SS.postpay, SS.description,
            SS.CommonPay, SS.SeparateTrafficPay, SS.PrintCost, SS.ServiceCost, SS.AdditionalMinutes, 
            SUM(SA.[Traffic]) SummaryTraffic, SUM(SA.[TrafficCost]) SummaryTrafficCost, SUM(SA.[SeparateTrafficCost]) SummarySeparateTrafficCost,
            SS.CurrentTraffic, SS.CurrentTrafficCost, SS.CurrentSeparateTrafficCost,
            SS.CurrentCommonPay, SS.CurrentSeparateTrafficPay,
            SS.state, SS.status FROM
    (SELECT S.[id] idSessions, SA.[id] idSessionsAdd, SA.[idComp], S.[idClients], S.[started], SA.[start], SA.[stop], 
            SA.[idTarif], SA.[whole], S.[postpay], S.[description],
            S.[CommonPay], S.[SeparateTrafficPay], S.[PrintCost], S.[ServiceCost], 
            S.[AdditionalMinutes], 
            SUM(SA.[Traffic]) SummaryTraffic, SUM(SA.[TrafficCost]) SummaryTrafficCost, SUM(SA.[SeparateTrafficCost]) SummarySeparateTrafficCost,
            SA.[Traffic] CurrentTraffic, SA.[TrafficCost] CurrentTrafficCost, SA.[SeparateTrafficCost] CurrentSeparateTrafficCost,
            ISNULL(SUM(SA2Common.[summa]), 0) CurrentCommonPay, ISNULL(SUM(SA2SeparateTraff.[summa]), 0) CurrentSeparateTrafficPay,
            S.[state], S.[status]
        FROM Sessions AS S
        INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions])
        LEFT OUTER JOIN SessionsAdd2 AS SA2Common 
            ON (SA.[id] = SA2Common.[idSessionsAdd]) AND (SA2Common.[ActionType] <> 3)
        LEFT OUTER JOIN SessionsAdd2 AS SA2SeparateTraff 
            ON (SA.[id] = SA2SeparateTraff.[idSessionsAdd]) AND (SA2SeparateTraff.[ActionType] = 3)
        WHERE (((SA.[start]<=@dt) OR (S.[status]=0)) AND (@dt<SA.[stop]) AND (@id IS NULL)) OR (SA.[idSessions] = @id)
        GROUP BY S.[id], S.[idClients], S.[postpay], S.[started], S.[CommonPay], S.[SeparateTrafficPay], S.[PrintCost], S.[ServiceCost], 
            S.[description], SA.[id], SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[AdditionalMinutes], 
            SA.[whole], SA.[Traffic], SA.[TrafficCost], SA.[SeparateTrafficCost], S.[state], S.[status]
        ) SS
        INNER JOIN SessionsAdd AS SA ON (SA.[idSessions] = SS.[idSessions])
        GROUP BY SS.idSessions, idSessionsAdd, SS.idComp, SS.idClients, SS.started, SS.start, SS.stop, 
            SS.idTarif, SS.whole, SS.postpay, SS.description,
            SS.CommonPay, SS.SeparateTrafficPay, SS.PrintCost, SS.ServiceCost, SS.AdditionalMinutes, 
            SS.CurrentTraffic, SS.CurrentTrafficCost, SS.CurrentSeparateTrafficCost,
            SS.CurrentCommonPay, SS.CurrentSeparateTrafficPay,
            SS.state, SS.status
        ORDER BY SS.idSessions
END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SessionsSave]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[SessionsSave]
GO

CREATE PROCEDURE SessionsInsert
@idComp int,
@idClients int,
@start datetime,
@stop datetime,
@idTarif int,
@whole int,
@postpay int,
@description nvarchar(100),
@CommonPay money,
@state int,
@status int,
@moment datetime

AS

SET NOCOUNT ON

DECLARE @idSessions int
DECLARE @idSessionsAdd int

DECLARE @idUser int
SELECT @idUser = [id] FROM Users WHERE ([name] = system_user) AND ([isdelete]=0)

INSERT INTO Sessions ([idClients], [postpay], [description], [started], [CommonPay], [operator], [state], [status])
    VALUES ( @idClients, @postpay, @description, @start, @CommonPay, @idUser, @state, @status)
SELECT @idSessions = SCOPE_IDENTITY() -- get id of last inserted record

IF (@idClients <> 0)
BEGIN
  UPDATE Accounts SET [balance] = [balance] - @CommonPay WHERE [id] = @idClients
  UPDATE Accounts SET [summary] = [summary] + @CommonPay WHERE [id] = @idClients
END

INSERT INTO SessionsAdd ([idSessions], [idComp], [Start], [Stop], [idTarif], [whole], [operator])
  VALUES (@idSessions, @idComp, @start, @stop, @idTarif, @whole, @idUser)
SELECT @idSessionsAdd = SCOPE_IDENTITY() -- get id of last inserted record

INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
  VALUES (@idSessionsAdd, 0, @moment, @CommonPay)

SELECT @idSessions AS idSessions, @idSessionsAdd AS idSessionsAdd 
GO

GRANT  EXECUTE  ON [dbo].[SessionsInsert]  TO [public]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SessionsStopIt]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[SessionsStopIt]
GO

CREATE PROCEDURE SessionsStop
@idSessionsAdd int,
@newstop datetime,
@ResultCommonPay money,
@ResultSeparateTrafficPay money = 0,
@autostop int = 0

AS 
BEGIN

SET NOCOUNT ON

DECLARE @postpay int
DECLARE @idSessions int
DECLARE @idSessionsAdd2 int
DECLARE @CommonPay money
DECLARE @SeparateTrafficPay money
DECLARE @idAccount int

SELECT @idSessions = [idSessions] FROM SessionsAdd WHERE [id] = @idSessionsAdd
SELECT @CommonPay = [CommonPay], @SeparateTrafficPay = [SeparateTrafficPay], 
    @idAccount = [idClients], @postpay = [postpay] FROM Sessions WHERE [id] = @idSessions
SELECT TOP 1 @idSessionsAdd2 = [id] FROM SessionsAdd2 WHERE [idSessionsAdd] = @idSessionsAdd ORDER BY [id] DESC

UPDATE SessionsAdd SET [stop] = @newstop WHERE [id] = @idSessionsAdd
UPDATE Sessions SET [CommonPay] = @ResultCommonPay, [SeparateTrafficPay] = @ResultSeparateTrafficPay WHERE [id] = @idSessions  
IF ( @postpay = 0 ) -- была предоплата
BEGIN
   -- добавляем новую запись в SessionsAdd2, ActionType = 2 
   IF ((@ResultCommonPay - @CommonPay) <> 0) BEGIN
     INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])  
         VALUES (@idSessionsAdd, 2,  (@ResultCommonPay - @CommonPay), @newstop)   
   END
   -- добавляем новую запись в SessionsAdd2, ActionType = 4
   IF ((@ResultSeparateTrafficPay - @SeparateTrafficPay) <> 0) BEGIN
     INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])  
         VALUES (@idSessionsAdd, 4,  (@ResultSeparateTrafficPay - @SeparateTrafficPay), @newstop)   
   END
   -- возвращаем сдачу или снимаем со счета клиента
   IF (@idAccount <> 0) 
   BEGIN
     UPDATE Accounts SET [balance] = [balance] + (@CommonPay - @ResultCommonPay) 
           + (@SeparateTrafficPay - @ResultSeparateTrafficPay) WHERE [id] = @idAccount
     UPDATE Accounts SET [summary] = [summary] - (@CommonPay - @ResultCommonPay) 
           - (@SeparateTrafficPay - @ResultSeparateTrafficPay) WHERE [id] = @idAccount
     INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  
         VALUES  (@idAccount, @newstop, 2, @ResultCommonPay + @ResultSeparateTrafficPay, N'change',0)
   END
   -- если клиент остался должен, то 
   IF ((@autostop=1) AND (@ResultCommonPay - @CommonPay > 0)) UPDATE Sessions SET [toResolve]=1 WHERE [id]=@idSessions
END
ELSE -- не было предоплаты
BEGIN
   UPDATE SessionsAdd2 SET [summa] = [summa] - @CommonPay + @ResultCommonPay
   - @SeparateTrafficPay + @ResultSeparateTrafficPay , [moment] = @newstop WHERE [id] = @idSessionsAdd2
   IF (@autostop=1) UPDATE Sessions SET [toResolve]=1 WHERE [id] = @idSessions  
END
-- в любом случае сбрасываем флажок "постоплата", потому что уже все оплачено
--IF (@autostop=0) 
UPDATE Sessions SET [postpay]=0, [status]=2 WHERE [id] = @idSessions
END
GO


GRANT  EXECUTE  ON [dbo].[SessionsStop]  TO [public]
GO

INSERT INTO [Functions]([id],[name]) VALUES(36, N'TimeBonus')
GO

INSERT INTO [FunctionsRights]([idFunctions],[idUsersGroup]) VALUES(36, 2)
GO

ALTER PROCEDURE SessionsUpdate
@IdClient int,
@IdSessions int,
@IdSessionsAdd int,
@CommonPayDiff money = 0,
@SeparateTrafficPayDiff money = 0,
@TrafficCostDiff money = 0,
@SeparateTrafficCostDiff money = 0,
@PrintCostDiff money = 0,
@ServiceCostDiff money = 0,
@TrafficDiff int = 0,
@AdditionalMinutesDiff int = 0,
@Stop datetime,
@Status int,
@State int,
@Moment datetime

AS 
BEGIN
    SET NOCOUNT ON

    DECLARE @idUser int
    SELECT @idUser = [id] FROM Users WHERE ([name] = system_user) AND ([isdelete]=0)

    IF (@CommonPayDiff <> 0) AND (dbo.CheckFunctionsRight('fnCompAdd') = -1) --SELECT * FROM Functions
    BEGIN
        -- добавляем новую запись в SessionsAdd2, ActionType = 1 (добавить денег)
        INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
                VALUES (@IdSessionsAdd, 1, @CommonPayDiff, @Moment)
        -- увеличиваем общую оплаченную сумму
        UPDATE Sessions SET [CommonPay] = [CommonPay] + @CommonPayDiff
                WHERE [id] = @IdSessions
        IF (@IdClient <> 0) 
        BEGIN
        UPDATE Accounts SET [balance] = [balance] - @CommonPayDiff WHERE [id] = @IdClient
        UPDATE Accounts SET [summary] = [summary] + @CommonPayDiff WHERE [id] = @IdClient
        INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  
            VALUES  (@IdClient, @Moment, 2, @CommonPayDiff, N'addtime',0)
        END
    END
    IF (@SeparateTrafficPayDiff <> 0) AND (dbo.CheckFunctionsRight('fnSessionTrafficPayment') = -1) --SELECT * FROM Functions
    BEGIN
       -- добавляем новую запись в SessionsAdd2, ActionType = 3 (добавить денег за трафик)
        INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
                VALUES (@IdSessionsAdd, 3, @SeparateTrafficPayDiff, @Moment)
        -- увеличиваем общую оплаченную сумму
        UPDATE Sessions SET [SeparateTrafficPay] = [SeparateTrafficPay] + @SeparateTrafficPayDiff
                WHERE [id] = @IdSessions
        IF (@IdClient <> 0) 
        BEGIN
        UPDATE Accounts SET [balance] = [balance] - @SeparateTrafficPayDiff WHERE [id] = @IdClient
        UPDATE Accounts SET [summary] = [summary] + @SeparateTrafficPayDiff WHERE [id] = @IdClient
        INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  
            VALUES  (@IdClient, @Moment, 2, @SeparateTrafficPayDiff, N'traffic',0)
        END
    END
    IF (@AdditionalMinutesDiff < 0) AND (dbo.CheckFunctionsRight('fnPenalty') = -1) --SELECT * FROM Functions
        UPDATE Sessions SET [AdditionalMinutes] = [AdditionalMinutes] + @AdditionalMinutesDiff
                WHERE [id] = @IdSessions
    IF (@AdditionalMinutesDiff > 0) AND (dbo.CheckFunctionsRight('TimeBonus') = -1) --SELECT * FROM Functions
        UPDATE Sessions SET [AdditionalMinutes] = [AdditionalMinutes] + @AdditionalMinutesDiff
                WHERE [id] = @IdSessions
    -- корректируем количество и стоимость трафика, время останова
    UPDATE SessionsAdd SET [TrafficCost] = [TrafficCost] + @TrafficCostDiff, 
        [SeparateTrafficCost] = [SeparateTrafficCost] + @SeparateTrafficCostDiff,
        [Traffic] = [Traffic] + @TrafficDiff,
        [stop] = @Stop
        WHERE [id] = @IdSessionsAdd
    -- корректируем стоимость печати и услуг, статус и состояние авторизации
    UPDATE Sessions SET [PrintCost] = [PrintCost] + @PrintCostDiff, 
        [ServiceCost] = [ServiceCost] + @ServiceCostDiff,
        [status] = @Status, [state] = @State
        WHERE [id] = @IdSessions
END
GO
/* -----------------------------------------------------------------------------
			 Удаление старых отчетов
----------------------------------------------------------------------------- */

/* -----------------------------------------------------------------------------
			   Обновление вьюшки repDeatils
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[repDetails]') 
         and OBJECTPROPERTY(id, N'IsView') = 1)
    drop view [dbo].[repDetails]
GO

CREATE VIEW dbo.repDetails 
   
AS 
SELECT TOP 100 PERCENT 
 Computers.[ipaddress],
 Tarifs.[name],
 SA.[Start],
 SA.[Stop], 
 SA2.[moment],
 SA2.[summa],
 DATEDIFF(minute, SA.[Start], SA.[Stop]) AS length,
 Users.[Name] AS operator,
 S.[description],
 Computers.[number],
 S.[PrintCost],
-- S.[traffic],
 sum(SA.[Traffic]) AS [Traffic],
 sum(SA.[TrafficCost]) AS [TrafficCost],
 sum(SA.[SeparateTrafficCost]) AS [SeparateTrafficCost],
 S.[idClients]
FROM Sessions AS S
 INNER JOIN SessionsAdd AS SA ON SA.[idSessions] = S.[id]
 INNER JOIN SessionsAdd2 AS SA2 ON SA2.[idSessionsAdd] = SA.[id]
 INNER JOIN Tarifs ON Tarifs.[id] = SA.[idTarif]
 INNER JOIN Computers ON SA.[idComp] = Computers.[id]
 INNER JOIN Users ON Users.[id] = S.[operator]
WHERE 
  (SA.[idTarif] <> 0) AND (S.[postpay] = 0)
GROUP BY 
 Computers.[ipaddress],
 Tarifs.[name],
 SA.[Start],
 SA.[Stop], 
 SA2.[moment],
 SA2.[summa],
 Users.[Name],
 S.[description],
 Computers.[number],
 S.[PrintCost],
 S.[idClients]
ORDER BY SA.[Start]

GO

/* -----------------------------------------------------------------------------
			      Новый текущий отчет 
----------------------------------------------------------------------------- */
ALTER PROCEDURE ReportCurrent
@NewShiftPoint datetime,
@LastShiftPoint datetime OUTPUT,
@Time money OUTPUT,
@Serices money OUTPUT,
@Print money OUTPUT,
@Internet money OUTPUT,
@AccountsAdded money OUTPUT,
@AccountsPayed money OUTPUT,
@AccountsReturned money OUTPUT,
@Rest money OUTPUT

AS 

set nocount on

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
select @Serices = ISNULL(sum(RS.[summa]),0) from repServices as RS
  where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint) and (TypeCost = 1)

-- подсчет трафика и распечатанных страниц
select @Internet =  ISNULL(Sum(SA.TrafficCost),0), @Print =  ISNULL(Sum(S.[PrintCost]),0) from sessions as S
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
  and usersgroup.name='Staff'
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
-- проплачено
select @AccountsPayed =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
  where (AH.[What]=2)
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)

select @Time = ISNULL(sum(SA2.[summa]),0) from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA2.[moment]) and (SA2.[moment]<=@NewShiftPoint)
  and S.[idClients]=0
GO

/* -----------------------------------------------------------------------------
			Пересчет поля summary для УЗ
----------------------------------------------------------------------------- */
--
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DiscountsRecalc]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[DiscountsRecalc]
GO

CREATE PROCEDURE DiscountsRecalc
@dtStart datetime

AS 
BEGIN

SET NOCOUNT ON

UPDATE A SET summary = newSummary FROM Accounts A INNER JOIN
(SELECT A.id, ISNULL(SUM(summa), 0) newSummary FROM Accounts A
LEFT OUTER JOIN AccountsHistory AH ON A.id = AH.idAccounts AND AH.moment > @dtStart AND AH.what in (2,3)
GROUP BY A.id) AAH ON A.id = AAH.id
END
GO

/* -----------------------------------------------------------------------------
                         Изменения для УЗ по чекам
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DF_Accounts_PeriodOfValidity]') 
    AND OBJECTPROPERTY(id, N'IsDefaultCnst') = 1)
  ALTER TABLE dbo.Accounts ADD
      PeriodOfValidity int NOT NULL CONSTRAINT DF_Accounts_PeriodOfValidity DEFAULT 0,
      ExpirationDate datetime NOT NULL CONSTRAINT DF_Accounts_ExpirationDate DEFAULT DATEADD(day, 30, GETDATE())
GO

ALTER PROCEDURE AccountsUpdate
@id int,
@name nvarchar(50),
@password nvarchar(50),
@email nvarchar(80),
@phone nvarchar(50),
@isenabled int,
@isblocked int,
@isprivileged int, 
@privilegedDiscount int, 
@zeroBalance money,
@memotext nvarchar(2000) = N'',
@address nvarchar(300)=N'',
@summary money,
@PeriodOfValidity int = 0,
@ExpirationDate datetime

AS 

IF (EXISTS (SELECT * FROM Accounts WHERE ([name]=@name) AND (@name <> N'') AND ([id]<>@id) AND ([isdeleted]=0))) BEGIN
  RAISERROR 50001 'Account already exists! Choose other name...'
  RETURN 50001
END

IF (EXISTS (SELECT * FROM Accounts WHERE [id] = @id AND [isdeleted] = 0)) BEGIN
 UPDATE Accounts SET
  [name] = @name,
  [password] = @password,
  [email] = @email,
  [phone] = @phone,
  [isenabled] = @isenabled,
  [isblocked] = @isblocked,
  [isprivileged] = @isprivileged, 
  [privilegedDiscount] = @privilegedDiscount, 
  [zeroBalance] = @zeroBalance,
  [memo] = @memotext,
  [address] = @address,
  [summary] = @summary,
  [PeriodOfValidity] = @PeriodOfValidity,
  [ExpirationDate] = @ExpirationDate
  WHERE [id] = @id
END
GO


CREATE FUNCTION [GetFreeCheckAccountsName] ()
  RETURNS nvarchar(50)

AS
BEGIN 
  DECLARE @Name nvarchar(50)
  DECLARE @Number int
  SELECT TOP 1 @Number = CAN.Number FROM (SELECT CAST(RIGHT([name], LEN([name]) - 5) AS int) Number FROM Accounts 
    WHERE [name] LIKE 'Check%') CAN
    ORDER BY CAN.Number DESC
  SET @Number = ISNULL(@Number, 0)
  SET @Number = @Number + 1
  SET @Name = N'Check' + CAST(@Number AS nvarchar(20))
  RETURN @Name
END
GO 

GRANT EXEC ON [GetFreeCheckAccountsName] TO public
GO

/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85' WHERE [key]='BaseVersion'
GO
