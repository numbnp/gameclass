USE GameClass
GO

/* -----------------------------------------------------------------------------
         Создание пользователя gcsync для синхронизации
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM master.dbo.syslogins 
   WHERE name = N'gcsync')
BEGIN
  if exists (select * from dbo.sysobjects where id = object_id(N'[tempdb]..[#msver]') )
	  drop table #msver

  DECLARE @MSSQLVERSION int
  create table #msver ([Index] int PRIMARY KEY, [Name] varchar(200), Internal_Value int, Character_Value varchar(200))
  insert into #msver exec master..xp_msver ProductVersion
  select @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS int) from #msver
  drop table #msver

  IF (@MSSQLVERSION = 8) BEGIN
    exec master.dbo.sp_addlogin N'gcsync'
    exec master.dbo.sp_password @new='1C6F8A60-1970-4313-A9EE-5E879558CEC3', @loginame='gcsync'
  END

  IF (@MSSQLVERSION = 9) BEGIN
    exec sp_executesql N'CREATE LOGIN gcsync WITH PASSWORD = ''1C6F8A60-1970-4313-A9EE-5E879558CEC3'' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
  END

END
GO

IF NOT EXISTS (SELECT * FROM sysusers WHERE name = N'gcsync')
BEGIN
  EXEC sp_adduser 'gcsync', 'gcsync', 'public'
END
GO

IF NOT EXISTS (SELECT * FROM [users] WHERE name = N'gcsync')
BEGIN
  INSERT INTO [users]([idUsersGroup],[isdelete],[Name]) VALUES(1,0,N'gcsync')
END
GO

/* -----------------------------------------------------------------------------
         Изменение таблиц AccountsHistory и Accounts для синхронизации
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DF_AccountsHistory_sync]') 
    AND OBJECTPROPERTY(id, N'IsDefaultCnst') = 1)
  ALTER TABLE dbo.AccountsHistory ADD
      sync bigint NOT NULL CONSTRAINT DF_AccountsHistory_sync DEFAULT 0,
      guid uniqueidentifier NOT NULL CONSTRAINT DF_AccountsHistory_guid DEFAULT newid()
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DF_Accounts_sync]') 
    AND OBJECTPROPERTY(id, N'IsDefaultCnst') = 1)
  ALTER TABLE dbo.Accounts ADD
      sync bigint NOT NULL CONSTRAINT DF_Accounts_sync DEFAULT 0,
      guid uniqueidentifier NOT NULL CONSTRAINT DF_Accounts_guid DEFAULT newid(),
      updated datetime NOT NULL CONSTRAINT DF_Accounts_updated DEFAULT GETDATE()
GO

/* -----------------------------------------------------------------------------
         Создание таблицы SyncServers
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SyncServers]') 
    AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  CREATE TABLE [SyncServers] (
      [id] [int] NOT NULL,
      [Name] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
      [ClubName] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
      [LastSync] [datetime] NULL ,
      CONSTRAINT [PK_SyncServers] PRIMARY KEY CLUSTERED ([id]) ON [PRIMARY] ,
      CONSTRAINT [UK_SyncServers_Name] UNIQUE NONCLUSTERED ([Name]) ON [PRIMARY] ,
      CONSTRAINT [CK_SyncServers_id] CHECK ([id] > 0 AND [id] <= 64)
      ) ON [PRIMARY] 
GO

/* -----------------------------------------------------------------------------
                  Новые процедуры для таблицы SyncServers
----------------------------------------------------------------------------- */

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SyncServersSelect]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[SyncServersSelect]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SyncServersInsert]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[SyncServersInsert]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SyncServersDelete]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[SyncServersDelete]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SyncServersUpdate]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[SyncServersUpdate]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GetSyncServerIdByName]') 
    AND OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  DROP FUNCTION [dbo].[GetSyncServerIdByName]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[GetGcsyncUserId]') 
    AND OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  DROP FUNCTION [dbo].[GetGcsyncUserId]
GO


CREATE PROCEDURE SyncServersSelect
  @id INT = NULL

AS 
BEGIN
  SELECT * FROM SyncServers
    WHERE ([id] = @id) OR (@id IS NULL)
    ORDER BY [id] ASC
END
GO

CREATE PROCEDURE SyncServersInsert
  @Name [varchar] (50),
  @ClubName [varchar] (50)

AS
BEGIN
  DECLARE @id int
  IF @id IS NULL BEGIN 
    SELECT TOP 1 @id = [id] FROM SyncServers ORDER BY [id] DESC
    IF @id IS NULL
      SET @id = 0
    SET @id = @id + 1
  END
  INSERT INTO SyncServers ([id], [Name], [ClubName]) VALUES (@id, @Name, @ClubName)
  SELECT SCOPE_IDENTITY() [id]
END
GO

CREATE PROCEDURE SyncServersDelete
  @id int

AS
BEGIN 
  DELETE FROM SyncServers WHERE [id] = @id
END
GO

CREATE PROCEDURE SyncServersUpdate
  @id int,
  @Name [varchar] (50),
  @ClubName [varchar] (50)

AS 
BEGIN
  UPDATE SyncServers SET 
      Name = @Name, 
      ClubName = @ClubName
    WHERE [id] = @id
END
GO

CREATE FUNCTION [GetSyncServerIdByName] (@Name [varchar] (50))
  RETURNS int

AS
BEGIN 
  DECLARE @id int
  SELECT TOP 1 @id = [id] FROM SyncServers 
    WHERE [Name] = @Name
  RETURN @id
END
GO 

CREATE FUNCTION [GetGcsyncUserId] ()
  RETURNS INT

AS
BEGIN 
  DECLARE @id int
  SET @id = 0
  SELECT TOP 1 @id = [id] FROM Users WHERE [Name] = 'gcsync'
  RETURN @id
END
GO

GRANT EXECUTE ON [dbo].[SyncServersSelect] TO [gcsync]
GO

GRANT EXECUTE ON [dbo].[GetGcsyncUserId] TO [gcsync]
GO
/* -----------------------------------------------------------------------------
                  Новые процедуры и функции
----------------------------------------------------------------------------- */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsSelectUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsSelectUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsInsertUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsInsertUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsUpdateUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsUpdateUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsSyncUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsSyncUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsHistorySelectUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsHistorySelectUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsHistoryInsertUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsHistoryInsertUnsynchronized]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsHistorySyncUnsynchronized]') 
    AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [dbo].[AccountsHistorySyncUnsynchronized]
GO

CREATE PROCEDURE AccountsSelectUnsynchronized
@idSyncServer int

AS
BEGIN
  SELECT guid, [name], [password], email, phone, photo, seccodes, 
      isenabled, isblocked, isprivileged, isdeleted, privilegedDiscount, 
      zeroBalance, balance, summary, address, memo, updated  FROM Accounts 
      WHERE (sync & CAST(POWER(2.0, @idSyncServer - 1) AS bigint)) = 0
      AND [id] <> 0
      ORDER BY [id]
END
GO

CREATE PROCEDURE AccountsInsertUnsynchronized
@guid uniqueidentifier,
@name nvarchar(50),  
@password nvarchar(50),  
@email nvarchar(80),  
@phone nvarchar(50),  
@photo image,  
@seccodes nvarchar(80),  
@isenabled int,  
@isblocked int,  
@isprivileged int,  
@isdeleted int,  
@privilegedDiscount int,  
@zeroBalance money,  
@balance money,  
@summary money,  
@address nvarchar(300),  
@memo nvarchar(2000)

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM Accounts WHERE [guid] = @guid)
    INSERT INTO [Accounts]
        ([guid], [name], [password], [email], [phone], [photo], [seccodes], 
        [isenabled], [isblocked], [isprivileged], [isdeleted], [privilegedDiscount], 
        [zeroBalance], [balance], [summary], [address], [memo], [sync])
        VALUES(@guid, @name, @password, @email, @phone, @photo, @seccodes,
        @isenabled, @isblocked, @isprivileged, @isdeleted, @privilegedDiscount,
        @zeroBalance, @balance, @summary, @address, @memo, 9223372036854775807)

END
GO

/* Update не меняет поле balance */
CREATE PROCEDURE AccountsUpdateUnsynchronized
@guid uniqueidentifier,
@name nvarchar(50),  
@password nvarchar(50),  
@email nvarchar(80),  
@phone nvarchar(50),  
@photo image,  
@seccodes nvarchar(80),  
@isenabled int,  
@isblocked int,  
@isprivileged int,  
@isdeleted int,  
@privilegedDiscount int,  
@zeroBalance money,  
@summary money,  
@address nvarchar(300),  
@memo nvarchar(2000),
@updated datetime 

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM Accounts WHERE [guid] = @guid)
    INSERT INTO [Accounts]
        ([guid], [name], [password], [email], [phone], [photo], [seccodes], 
        [isenabled], [isblocked], [isprivileged], [isdeleted], [privilegedDiscount], 
        [zeroBalance], [balance], [summary], [address], [memo], [sync])
        VALUES(@guid, @name, @password, @email, @phone, @photo, @seccodes,
        @isenabled, @isblocked, @isprivileged, @isdeleted, @privilegedDiscount,
        @zeroBalance, 0.00, @summary, @address, @memo, 9223372036854775807)
  ELSE
    UPDATE [Accounts] SET
        [name] = @name, [password] = @password, [email] = @email, [phone] = @phone,
        [photo] = @photo, [seccodes] = @seccodes, [isenabled] = @isenabled, 
        [isblocked] = @isblocked, [isprivileged] = @isprivileged, [isdeleted] = @isdeleted,
        [privilegedDiscount] = @privilegedDiscount, [zeroBalance] = @zeroBalance,
        [summary] = @summary, [address] = @address, [memo] = @memo, 
	[sync] = 9223372036854775807, [updated] = @updated
        WHERE [guid] = @guid AND [updated] <= @updated
END
GO

CREATE PROCEDURE AccountsSyncUnsynchronized
@guid uniqueidentifier,
@idSyncServer int

AS
BEGIN
  UPDATE Accounts 
      SET sync = sync | CAST(POWER(2.0, @idSyncServer - 1) AS bigint)
      WHERE guid = @guid
END
GO

CREATE PROCEDURE AccountsHistorySelectUnsynchronized
@idSyncServer int

AS
BEGIN
  SELECT AH.guid, A.guid AS guidAccounts, moment, what, summa, comment
      FROM AccountsHistory AS AH
      INNER JOIN Accounts AS A ON A.[id] = AH.idAccounts
      WHERE (AH.sync & CAST(POWER(2.0, @idSyncServer - 1) AS bigint)) = 0
      ORDER BY AH.[id]
END
GO

CREATE PROCEDURE AccountsHistoryInsertUnsynchronized
@guid uniqueidentifier,
@guidAccounts uniqueidentifier,
@moment datetime,
@what int,
@summa money,
@comment nvarchar(200),
@initialization int

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM AccountsHistory WHERE [guid] = @guid)
  BEGIN 
    DECLARE @idAccounts int
    SELECT TOP 1 @idAccounts = [id] FROM Accounts WHERE [guid] = @guidAccounts
    INSERT INTO [AccountsHistory]
        ([guid], [idAccounts], [moment], [what], [summa], [comment], [operator], [sync])
        VALUES(@guid, @idAccounts, @moment, @what, @summa, @comment, dbo.GetGcsyncUserId(), 9223372036854775807)
    IF @initialization <> 1
    BEGIN
      IF @what <> 0 
        SET @summa = - @summa 
      UPDATE [Accounts] SET [balance] = [balance] + @summa WHERE [id] = @idAccounts
    END
  END
END
GO

CREATE PROCEDURE AccountsHistorySyncUnsynchronized
@guid uniqueidentifier,
@idSyncServer int

AS
BEGIN
  UPDATE AccountsHistory 
      SET sync = sync | CAST(POWER(2.0, @idSyncServer - 1) AS bigint)
      WHERE guid = @guid
END
GO

GRANT EXEC ON [AccountsSelectUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsInsertUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsUpdateUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsSyncUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsHistorySelectUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsHistoryInsertUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsHistorySyncUnsynchronized] TO [gcsync]
GO

/* -----------------------------------------------------------------------------
                 Триггер для Accounts сбрасывающий sync при Update
----------------------------------------------------------------------------- */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[AccountsUpdateTrigger]') 
    AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
  DROP TRIGGER [dbo].[AccountsUpdateTrigger]
GO

CREATE TRIGGER AccountsUpdateTrigger ON [dbo].[Accounts]

FOR UPDATE
AS
BEGIN
  
  DECLARE @id int
  DECLARE @sync bigint

  DECLARE Icursor CURSOR FOR SELECT [id], [sync] FROM INSERTED
  OPEN Icursor
  FETCH NEXT FROM Icursor INTO @id, @sync

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT (@sync = 9223372036854775807)
      UPDATE Accounts SET [updated] = GETDATE(), [sync] = 0 WHERE [id] = @id
    FETCH NEXT FROM Icursor INTO @id, @sync
  END

  CLOSE Icursor
  DEALLOCATE Icursor
END
GO

/* -----------------------------------------------------------------------------
                          Дефолты для новых опций
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM Registry WHERE [key] = 'SyncOptions\SyncInterval')
  INSERT INTO [Registry] ([Key], [Value], [Public]) 
      VALUES('SyncOptions\SyncInterval', '5', 0)
GO

IF NOT EXISTS (SELECT * FROM Registry WHERE [key] = 'SyncOptions\InitializationDate')
  INSERT INTO [Registry] ([Key], [Value], [Public]) 
      VALUES('SyncOptions\InitializationDate', '', 0)
GO

IF NOT EXISTS (SELECT * FROM Registry WHERE [key] = 'SyncOptions\Version')
  INSERT INTO [Registry] ([Key], [Value], [Public]) 
      VALUES('SyncOptions\Version', '0', 0)
GO

IF NOT EXISTS (SELECT * FROM Registry WHERE [key] = 'SyncOptions\')
  INSERT INTO [Registry] ([Key], [Value], [Public]) 
      VALUES('SyncOptions\', '0', 0)
GO

/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value] = '1.0.0', [Public] = 0 WHERE [key]='SyncOptions\Version'
GO

