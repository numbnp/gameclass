IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'GameClass')
        DROP DATABASE [GameClass]
GO
create database GameClass
go
use GameClass
go 

if exists (select * from dbo.sysobjects where id = object_id(N'[tempdb]..[#msver]') )
	drop table #msver
GO
DECLARE @MSSQLVERSION int
SELECT @MSSQLVERSION=CAST(REPLACE(LEFT(CAST(SERVERPROPERTY('ProductVersion')AS VARCHAR(20)),2),'.','') as INT);
if (@MSSQLVERSION=0)
BEGIN
	CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200)) 
	INSERT INTO #msver EXEC master..xp_msver ProductVersion 
	SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver 
	DROP TABLE #msver 
END

IF (@MSSQLVERSION = 8) BEGIN
  exec master.dbo.sp_addlogin 'operator'
  exec master.dbo.sp_password @new=NULL ,@loginame='operator'
  exec master.dbo.sp_addlogin 'manager'
  exec master.dbo.sp_password @new=NULL ,@loginame='manager'
  exec master.dbo.sp_addlogin 'pm_service'
  exec master.dbo.sp_password @new='rfnfgekmnf',@loginame='pm_service'
END

IF (@MSSQLVERSION = 9) BEGIN
  exec sp_executesql N'CREATE LOGIN operator WITH PASSWORD = '''' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF' 
  exec sp_executesql N'CREATE LOGIN manager WITH PASSWORD = '''' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF' 
  exec sp_executesql N'CREATE LOGIN pm_service WITH PASSWORD = ''rfnfgekmnf'' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
END

IF (@MSSQLVERSION = 10) BEGIN
  exec sp_executesql N'CREATE LOGIN operator WITH PASSWORD = '''' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF' 
  exec sp_executesql N'CREATE LOGIN manager WITH PASSWORD = '''' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF' 
  exec sp_executesql N'CREATE LOGIN pm_service WITH PASSWORD = ''rfnfgekmnf'' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
END

exec sp_adduser 'operator', 'operator', 'public'

exec sp_adduser 'manager', 'manager', 'public'
exec sp_addsrvrolemember 'manager','sysadmin'

exec sp_adduser 'pm_service', 'pm_service', 'public'
GO


CREATE TABLE [dbo].[Accounts] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[password] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[email] [nvarchar] (80) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[phone] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[photo] [image] NULL ,
	[seccodes] [nvarchar] (80) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isenabled] [int] NOT NULL ,
	[isblocked] [int] NOT NULL ,
	[isprivileged] [int] NOT NULL ,
	[isdeleted] [int] NOT NULL ,
	[privilegedDiscount] [int] NOT NULL ,
	[zeroBalance] [money] NOT NULL ,
	[balance] [money] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[AccountsDiscount] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[summary] [money] NOT NULL ,
	[discount] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[AccountsHistory] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idAccounts] [int] NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[what] [int] NOT NULL ,
	[summa] [money] NOT NULL ,
	[comment] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[operator] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Computers] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[number] [int] NOT NULL ,
	[ipaddress] [nvarchar] (15) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[vip] [int] NOT NULL ,
	[isdelete] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Errors] (
	[id] [bigint] IDENTITY (1, 1) NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[Info] [varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[code] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Functions] (
	[id] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FunctionsRights] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idFunctions] [int] NOT NULL ,
	[idUsersGroup] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Hardware] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idComputers] [int] NOT NULL ,
	[hw_id] [int] NOT NULL ,
	[hw_value] [nvarchar] (500) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[operator] [int] NOT NULL ,
	[histored] [int] NOT NULL ,
	[comment] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[HardwareType] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Information] (
	[id] [bigint] IDENTITY (1, 1) NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[Info] [varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Jobs] (
	[id] [bigint] IDENTITY (1, 1) NOT NULL ,
	[jid] [int] NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[printer] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[ip] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[user] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[doc] [varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[tbytes] [int] NOT NULL ,
	[tpages] [int] NOT NULL ,
	[pbytes] [int] NOT NULL ,
	[ppages] [int] NOT NULL ,
	[copies] [int] NOT NULL ,
	[status] [char] (10) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[JournalOp] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[summa] [money] NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[operator] [int] NOT NULL ,
	[comment] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Logs] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[prioritet] [int] NOT NULL ,
	[message] [nvarchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[operator] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Mail] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[from] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[to] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[incoming] [int] NOT NULL ,
	[body] [nvarchar] (1024) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[readed] [int] NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[operator] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Mappings] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[listenport] [int] NOT NULL ,
	[mappedport] [int] NOT NULL ,
	[mappedip] [nvarchar] (15) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Registry] (
	[Key] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[Value] [nvarchar] (1000) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Services] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idServicesBase] [int] NOT NULL ,
	[count] [int] NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[operator] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ServicesBase] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[price] [money] NOT NULL ,
	[isdelete] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Sessions] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idClients] [int] NOT NULL ,
	[traffic] [int] NOT NULL ,
	[printed] [int] NOT NULL ,
	[postpay] [int] NOT NULL ,
	[started] [datetime] NOT NULL ,
	[payed] [money] NOT NULL ,
	[toResolve] [int] NOT NULL ,
	[description] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[operator] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SessionsAdd] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idSessions] [int] NOT NULL ,
	[idComp] [int] NOT NULL ,
	[idTarif] [int] NOT NULL ,
	[Start] [datetime] NOT NULL ,
	[Stop] [datetime] NOT NULL ,
	[minpenalty] [int] NOT NULL ,
	[whole] [int] NOT NULL ,
	[operator] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SessionsAdd2] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idSessionsAdd] [int] NOT NULL ,
	[ActionType] [int] NOT NULL ,
	[moment] [datetime] NOT NULL ,
	[summa] [money] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tarifs] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[internet] [int] NOT NULL ,
	[calctraffic] [int] NOT NULL ,
	[roundtime] [int] NOT NULL ,
	[roundmoney] [money] NOT NULL ,
	[isdelete] [int] NOT NULL ,
	[priorityshow] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TarifsVariants] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idTarifs] [int] NOT NULL ,
	[name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[start] [datetime] NOT NULL ,
	[stop] [datetime] NOT NULL ,
	[cost] [money] NOT NULL ,
	[ispacket] [int] NOT NULL ,
	[daysofweek] [nvarchar] (7) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[condition] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Uncontrol] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idComputers] [int] NOT NULL ,
	[start] [datetime] NOT NULL ,
	[stop] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Users] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[idUsersGroup] [int] NOT NULL ,
	[isdelete] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UsersGroup] (
	[id] [int] NOT NULL ,
	[Name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isdelete] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Warnings] (
	[id] [bigint] IDENTITY (1, 1) NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[Info] [varchar] (4000) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[code] [int] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Accounts] WITH NOCHECK ADD 
	CONSTRAINT [DF_Accounts_name] DEFAULT (N'') FOR [name],
	CONSTRAINT [DF_Accounts_password] DEFAULT (N'') FOR [password],
	CONSTRAINT [DF_Accounts_email] DEFAULT (N'') FOR [email],
	CONSTRAINT [DF_Accounts_phone] DEFAULT (N'') FOR [phone],
	CONSTRAINT [DF_Accounts_seccodes] DEFAULT (N'') FOR [seccodes],
	CONSTRAINT [DF_Accounts_enabled] DEFAULT (1) FOR [isenabled],
	CONSTRAINT [DF_Accounts_blocked] DEFAULT (1) FOR [isblocked],
	CONSTRAINT [DF_Accounts_isprivileged] DEFAULT (0) FOR [isprivileged],
	CONSTRAINT [DF_Accounts_isdeleted] DEFAULT (0) FOR [isdeleted],
	CONSTRAINT [DF_Accounts_privilegedDiscount] DEFAULT (0) FOR [privilegedDiscount],
	CONSTRAINT [DF_Accounts_zeroBalance] DEFAULT (0) FOR [zeroBalance],
	CONSTRAINT [DF_Accounts_balance] DEFAULT (0) FOR [balance],
	CONSTRAINT [PK_Accounts] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AccountsDiscount] WITH NOCHECK ADD 
	CONSTRAINT [DF_AccountsDiscount_summary] DEFAULT (0) FOR [summary],
	CONSTRAINT [DF_AccountsDiscount_discount] DEFAULT (0) FOR [discount],
	CONSTRAINT [PK_AccountsDiscount] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AccountsHistory] WITH NOCHECK ADD 
	CONSTRAINT [DF_AccountsHistory_comment] DEFAULT (N'') FOR [comment],
	CONSTRAINT [PK_AccountsHistory] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Computers] WITH NOCHECK ADD 
	CONSTRAINT [DF_Computers_vip] DEFAULT (0) FOR [vip],
	CONSTRAINT [DF_Computers_isdelete] DEFAULT (0) FOR [isdelete],
	CONSTRAINT [PK_Table1] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Errors] WITH NOCHECK ADD 
	CONSTRAINT [DF_Errors_Info] DEFAULT ('') FOR [Info],
	CONSTRAINT [DF_Errors_code] DEFAULT (0) FOR [code],
	CONSTRAINT [PK_Errors] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Functions] WITH NOCHECK ADD 
	CONSTRAINT [PK_Functions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[FunctionsRights] WITH NOCHECK ADD 
	CONSTRAINT [PK_FunctionsRights] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Hardware] WITH NOCHECK ADD 
	CONSTRAINT [DF_Hardware_hw_id] DEFAULT (1) FOR [hw_id],
	CONSTRAINT [DF_Hardware_histored] DEFAULT (0) FOR [histored],
	CONSTRAINT [DF_Hardware_comment] DEFAULT (N'') FOR [comment],
	CONSTRAINT [PK_Hardware] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[HardwareType] WITH NOCHECK ADD 
	CONSTRAINT [PK_HardwareType] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Information] WITH NOCHECK ADD 
	CONSTRAINT [DF_Information_Info] DEFAULT ('') FOR [Info],
	CONSTRAINT [PK_Information] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Jobs] WITH NOCHECK ADD 
	CONSTRAINT [DF_Jobs_jid] DEFAULT (0) FOR [jid],
	CONSTRAINT [DF_Jobs_printer] DEFAULT ('') FOR [printer],
	CONSTRAINT [DF_Jobs_ip] DEFAULT ('') FOR [ip],
	CONSTRAINT [DF_Jobs_tbytes] DEFAULT (0) FOR [tbytes],
	CONSTRAINT [DF_Jobs_tpages] DEFAULT (0) FOR [tpages],
	CONSTRAINT [DF_Jobs_pbytes] DEFAULT (0) FOR [pbytes],
	CONSTRAINT [DF_Jobs_ppages] DEFAULT (0) FOR [ppages],
	CONSTRAINT [DF_Jobs_copies] DEFAULT (1) FOR [copies],
	CONSTRAINT [DF_Jobs_status] DEFAULT ('Ok') FOR [status],
	CONSTRAINT [PK_Jobs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[JournalOp] WITH NOCHECK ADD 
	CONSTRAINT [DF_JournalOp_comment] DEFAULT (N'') FOR [comment],
	CONSTRAINT [PK_JournalOp] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Logs] WITH NOCHECK ADD 
	CONSTRAINT [DF_Logs_prioritet] DEFAULT (0) FOR [prioritet],
	CONSTRAINT [DF_Logs_message] DEFAULT (N'') FOR [message],
	CONSTRAINT [PK_Logs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Mail] WITH NOCHECK ADD 
	CONSTRAINT [DF_Mail_from_type] DEFAULT (0) FOR [from],
	CONSTRAINT [DF_Mail_incoming] DEFAULT (1) FOR [incoming],
	CONSTRAINT [DF_Mail_readed] DEFAULT (0) FOR [readed],
	CONSTRAINT [PK_Mail] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Registry] WITH NOCHECK ADD 
	CONSTRAINT [DF_Registry_Value] DEFAULT (N'') FOR [Value],
	CONSTRAINT [PK_Registry] PRIMARY KEY  CLUSTERED 
	(
		[Key]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Services] WITH NOCHECK ADD 
	CONSTRAINT [PK_Services_1] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ServicesBase] WITH NOCHECK ADD 
	CONSTRAINT [DF_Services_isdelete] DEFAULT (0) FOR [isdelete],
	CONSTRAINT [PK_Services] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Sessions] WITH NOCHECK ADD 
	CONSTRAINT [DF_Sessions_traffic] DEFAULT (0) FOR [traffic],
	CONSTRAINT [DF_Sessions_printed] DEFAULT (0) FOR [printed],
	CONSTRAINT [DF_Sessions_postpay] DEFAULT (0) FOR [postpay],
	CONSTRAINT [DF_Sessions_payed] DEFAULT (0) FOR [payed],
	CONSTRAINT [DF_Sessions_toResolve] DEFAULT (0) FOR [toResolve],
	CONSTRAINT [PK_Sessions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[SessionsAdd] WITH NOCHECK ADD 
	CONSTRAINT [DF_SessionsAdd_minpenalty] DEFAULT (0) FOR [minpenalty],
	CONSTRAINT [DF_SessionsAdd_whole] DEFAULT (0) FOR [whole],
	CONSTRAINT [PK_SessionsAdd] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[SessionsAdd2] WITH NOCHECK ADD 
	CONSTRAINT [DF_SessionsAdd2_ActionType] DEFAULT (0) FOR [ActionType],
	CONSTRAINT [PK_SessionsAdd2] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Tarifs] WITH NOCHECK ADD 
	CONSTRAINT [DF_Tarifs_roundtime] DEFAULT (1) FOR [roundtime],
	CONSTRAINT [DF_Tarifs_roundmoney] DEFAULT (1) FOR [roundmoney],
	CONSTRAINT [DF_Tarifs_isdelete] DEFAULT (0) FOR [isdelete],
	CONSTRAINT [DF_Tarifs_priorityshow] DEFAULT (0) FOR [priorityshow],
	CONSTRAINT [PK_Tarifs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TarifsVariants] WITH NOCHECK ADD 
	CONSTRAINT [DF_TarifsVariants_ispacket] DEFAULT (0) FOR [ispacket],
	CONSTRAINT [DF_TarifsVariants_condition] DEFAULT (N'') FOR [condition],
	CONSTRAINT [PK_TarifsWhole] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Uncontrol] WITH NOCHECK ADD 
	CONSTRAINT [PK_Uncontrol] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Users] WITH NOCHECK ADD 
	CONSTRAINT [DF_Users_isdelete] DEFAULT (0) FOR [isdelete],
	CONSTRAINT [PK_Users] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[UsersGroup] WITH NOCHECK ADD 
	CONSTRAINT [DF_UsersGroup_isdelete] DEFAULT (0) FOR [isdelete],
	CONSTRAINT [PK_UsersGroup] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Warnings] WITH NOCHECK ADD 
	CONSTRAINT [DF_Warnings_Info] DEFAULT ('') FOR [Info],
	CONSTRAINT [DF_Warnings_code] DEFAULT (0) FOR [code],
	CONSTRAINT [PK_Warnings] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

GRANT  INSERT  ON [dbo].[Errors]  TO [pm_service]
GO

GRANT  INSERT  ON [dbo].[Information]  TO [pm_service]
GO

GRANT  INSERT  ON [dbo].[Jobs]  TO [pm_service]
GO

GRANT  INSERT  ON [dbo].[Warnings]  TO [pm_service]
GO

ALTER TABLE [dbo].[FunctionsRights] ADD 
	CONSTRAINT [FK_FunctionsRights_Functions] FOREIGN KEY 
	(
		[idFunctions]
	) REFERENCES [dbo].[Functions] (
		[id]
	) NOT FOR REPLICATION 
GO

alter table [dbo].[FunctionsRights] nocheck constraint [FK_FunctionsRights_Functions]
GO

ALTER TABLE [dbo].[SessionsAdd] ADD 
	CONSTRAINT [FK_SessionsAdd_Sessions] FOREIGN KEY 
	(
		[idSessions]
	) REFERENCES [dbo].[Sessions] (
		[id]
	) NOT FOR REPLICATION 
GO

alter table [dbo].[SessionsAdd] nocheck constraint [FK_SessionsAdd_Sessions]
GO

ALTER TABLE [dbo].[SessionsAdd2] ADD 
	CONSTRAINT [FK_SessionsAdd2_SessionsAdd] FOREIGN KEY 
	(
		[idSessionsAdd]
	) REFERENCES [dbo].[SessionsAdd] (
		[id]
	) NOT FOR REPLICATION 
GO

alter table [dbo].[SessionsAdd2] nocheck constraint [FK_SessionsAdd2_SessionsAdd]
GO

ALTER TABLE [dbo].[TarifsVariants] ADD 
	CONSTRAINT [FK_TarifsWhole_Tarifs] FOREIGN KEY 
	(
		[idTarifs]
	) REFERENCES [dbo].[Tarifs] (
		[id]
	) NOT FOR REPLICATION 
GO

alter table [dbo].[TarifsVariants] nocheck constraint [FK_TarifsWhole_Tarifs]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsDelete
@number int
/*WITH ENCRYPTION*/ 
AS 
update Accounts set [isdeleted]=1 where [id]=@number

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsDiscountDelete
@summary money
/*WITH ENCRYPTION*/ 
AS 
delete from AccountsDiscount where [summary] = @summary

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsDiscountInsert
@summary money,
@discount int
/*WITH ENCRYPTION*/ 
AS 
insert into AccountsDiscount
 ([summary], [discount])
 values
 (@summary, @discount)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsDiscountSelect
/*WITH ENCRYPTION*/ 
AS 
select * from AccountsDiscount order by summary asc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[AccountsDiscountSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsDiscountUpdate
@id int,
@summary money,
@discount int
/*WITH ENCRYPTION*/ 
AS 
update AccountsDiscount
 set
  [summary] = @summary,
  [discount] = @discount
 where [id]=@id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsHistorySelect
@idAccount int = 0
/*WITH ENCRYPTION*/ 
AS 

if (@idAccount = 0) 
  select * from AccountsHistory order by [id]
else
  select top 10 * from AccountsHistory where [idAccounts]=@idAccount

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[AccountsHistorySelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsMoneyPay
@id int,
@summa money,
@moment datetime,
@comment nvarchar(200) = N''
/*WITH ENCRYPTION*/ 
AS 

/*
 what = 0 - popolnenie balanca
 what = 1 - zabiranie deneg s balanca
*/

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

update Accounts set
 [balance] = [balance] + @summa
 where [id]= @id and ([isdeleted]=0)

insert into AccountsHistory
 ([idAccounts], [moment], [what], [summa], [comment], [operator])
 values
 (@id, @moment, 0, @summa, @comment, @idMe)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[AccountsMoneyPay]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsMoneyReturn
@id int,
@summa money,
@moment datetime,
@comment nvarchar(200) = N''
/*WITH ENCRYPTION*/ 
AS 

/*
 what = 0 - popolnenie balanca
 what = 1 - zabiranie deneg s balanca
*/

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

update Accounts set
 [balance] = [balance] - @summa
 where [id]= @id and ([isdeleted]=0)

insert into AccountsHistory
 ([idAccounts], [moment], [what], [summa], [comment], [operator])
 values
 (@id, @moment,1, @summa, @comment, @idMe)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsNew
@seccodes nvarchar(80) = N''
/*WITH ENCRYPTION*/ 
AS 
insert into Accounts 
 ([seccodes])   values  (@seccodes)

select @@identity [id]

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsSelect
@number int = -1
/*WITH ENCRYPTION*/ 
AS 
if (@number = -1) begin
select Accounts.* from Accounts where [isdeleted] = 0 
  order by Accounts.[id]
end
else
begin
select Accounts.* from Accounts where [isdeleted] = 0 
  and Accounts.[id] = @number
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[AccountsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsUnblock
@number int
/*WITH ENCRYPTION*/ 
AS 
update Accounts set
 [isblocked] = 0
 where [id]=@number

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[AccountsUnblock]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsUpdate
@id int,
@name nvarchar(50),
@password nvarchar(50),
@email nvarchar(80),
@phone nvarchar(50),
@isenabled int,
@isblocked int,
@isprivileged int, 
@privilegedDiscount int, 
@zeroBalance money
/*WITH ENCRYPTION*/ 
AS 

if (exists (select * from Accounts where ([name]=@name) and (@name <> N'') and ([id]<>@id) and ([isdeleted]=0))) begin
  raiserror 50001 'Account already exists! Choose other name...'
  return 50001
end

if (exists (select * from Accounts where [id] = @id and [isdeleted] = 0)) begin
 update Accounts set
  [name] = @name,
  [password] = @password,
  [email] = @email,
  [phone] = @phone,
  [isenabled] = @isenabled,
  [isblocked] = @isblocked,
  [isprivileged] = @isprivileged, 
  [privilegedDiscount] = @privilegedDiscount, 
  [zeroBalance] = @zeroBalance
   where [id] = @id
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE AccountsUpdateCodes
@number int,
@seccodes nvarchar(80)
/*WITH ENCRYPTION*/ 
AS 
update Accounts set
 [seccodes] = @seccodes
 where [id]=@number

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ClearStatistics
/*WITH ENCRYPTION*/ 
AS 
delete from Logs
delete from JournalOp
delete from Sessions
delete from SessionsAdd
delete from SessionsAdd2
delete from UnControl
delete from Hardware
delete from Services






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ComputersAdd
@number int,
@ipaddress nvarchar(15),
@vip int
/*WITH ENCRYPTION*/ 
AS 

set nocount on

if (exists(select * from Computers where ([number]=@number or [ipaddress]=@ipaddress) and [isdelete]=0))
begin
  raiserror 50000 'Computers with these number or ip-addres already exist!'
  return 50000
end
else
  insert into Computers ([number], [ipaddress], [vip]) values (@number, @ipaddress, @vip)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ComputersDelete
@idComp int
/*WITH ENCRYPTION*/ 
AS 

if (not exists(select * from Computers where [id]=@idComp and [isdelete]=0))
begin
  raiserror 50000 'This computer not exists'
  return 50000
end
else
 update Computers set [isdelete]=1 where [id]=@idComp






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
 selecting all not deleted computers
*/
CREATE PROCEDURE ComputersSelect
/*WITH ENCRYPTION*/ 
AS 

set nocount on

select * from Computers where isdelete=0






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ComputersSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ComputersUpdate
@idComp int,
@number int,
@ipaddress nvarchar(15),
@vip int
/*WITH ENCRYPTION*/ 
AS 

set nocount on

if (exists(select * from Computers where ([number]=@number or [ipaddress]=@ipaddress) and [id]<>@idComp and [isdelete]=0))
begin
  raiserror 50000 'Computers with these number or ip-addres already exist!'
  return 50000
end
else
  update Computers set [number]=@number, [ipaddress]=@ipaddress, [vip]=@vip where [id]=@idComp






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
  selecting functions, that have right current user
*/
CREATE PROCEDURE FunctionsSelect
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

select f.* from [Functions] as f
 inner join FunctionsRights as fr on (f.[id]=fr.[idFunctions])
 inner join Users as u on (u.[idUsersGroup] = fr.[idUsersGroup]) and (u.[id]=@idMe)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[FunctionsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






CREATE PROCEDURE GetLogonInfo
/*WITH ENCRYPTION*/ 
AS 
declare @isManager as int
declare @idGroup int

set @isManager=0
set @idGroup = -1
select @idGroup = [idUsersGroup] from Users where ([name] = system_user) and ([isdelete]=0)

if (@idGroup = 2) set @isManager=1

select GETDATE() as [Date], @isManager as [isManager]






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[GetLogonInfo]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE GroupsSelect
/*WITH ENCRYPTION*/ 
AS 
select * from UsersGroup






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[GroupsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE HardwareInsert
@idComputers int,
@hardware nvarchar(50),
@value nvarchar(500),
@moment datetime,
@comment nvarchar(200)
/*WITH ENCRYPTION*/ 
AS 

declare @idHardware int
declare @idOperator int
set @idHardware = 0
declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)


/* проверяем наличие типа железа */
select @idHardware=[id]  from HardwareType where [name]=@hardware
if (@idHardware = 0) begin
  insert into HardwareType ([name]) values (@hardware)
  select @idHardware = @@identity
end

update Hardware set histored=1 where [idComputers]=@idComputers and [hw_id] = @idHardware
insert into Hardware ([idComputers], [hw_id], [hw_value], [moment], [operator], [histored], [comment])
  values (@idComputers, @idHardware, @value, @moment, @idMe, 0, @comment)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[HardwareInsert]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE HardwareSelect
@idComputers int,
@histored int=1
/*WITH ENCRYPTION*/ 
AS 

select 
  hw.[id],
  c.[number],
  hwt.[name],
  hw.[hw_value],
  hw.[moment],
  hw.[comment],
  u.[name] operator
from hardware as hw
inner join HardwareType as hwt on (hw.[hw_id] = hwt.[id])
inner join Computers as C on (hw.[idComputers] = C.[id])
inner join Users as U on (hw.[operator] = U.[id])
-- conditions
where C.[number] = @idComputers and hw.[histored]<>@histored and hw.[hw_value]<>N''
order by hw.[moment]

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[HardwareSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO







CREATE PROCEDURE JournalOpSelect
/*WITH ENCRYPTION*/ 
AS 
select jo.[id], jo.[summa], jo.[moment], u.[name] operator  from journalop as jo 
  inner join users as u on (jo.[operator]=u.[id])
  order by jo.[moment] desc






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
 inserting Log Message
 prioritet:
 0 - High Security Message
 1 - System Message
 2 - Info Message
*/
CREATE PROCEDURE LogsInsert
@prioritet int,
@message nvarchar(4000),
@moment datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into Logs ([prioritet], [message], [moment], [operator]) values (@prioritet, @message, @moment, @idMe)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[LogsInsert]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO






CREATE PROCEDURE MappingsAdd
@listenport int,
@mappedport int,
@mappedip nvarchar(15)
/*WITH ENCRYPTION*/ 
AS 
insert into Mappings (listenport, mappedport, mappedip) values (@listenport, @mappedport, @mappedip)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[MappingsAdd]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO






CREATE PROCEDURE MappingsDelete
@id int
/*WITH ENCRYPTION*/ 
AS 
delete from Mappings where [id]=@id





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[MappingsDelete]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO






CREATE PROCEDURE MappingsSelect
/*WITH ENCRYPTION*/ 
AS 
select * from Mappings





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[MappingsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
 initial operation
 called on the start App
*/
CREATE PROCEDURE OnInitDatabase
/*WITH ENCRYPTION*/ 
AS 
set dateformat dmy






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[OnInitDatabase]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE PrinterScan
@idLast int = 0,
@mode int = 0,
@printer nvarchar(500) = N'',
@begin datetime = '01 jan 1900 0:00:00',
@end datetime = '31 dec 2100 0:00:00'
/*WITH ENCRYPTION*/ 
AS 
if (@mode = 0)
 select jobs.* from jobs where jobs.[id]>@idLast order by [id] asc
else
begin
 if (@printer = N'')
  select jobs.* from jobs where (@begin<jobs.[dt]) and (jobs.[dt]<@end) order by [id] asc
 if (@printer <> N'')
  select jobs.* from jobs where (@begin<jobs.[dt]) and (jobs.[dt]<@end) and (@printer=jobs.[printer]) order by [id] asc
end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[PrinterScan]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE RegistryInsert
@key nvarchar(200),
@value nvarchar(1000)
/*WITH ENCRYPTION*/ 
AS 

set nocount on

if (exists(select * from registry where [key]=@key))
  update Registry set  [value]=@value where [key]=@key
else
  insert into Registry ([key], [value]) values (@key, @value)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[RegistryInsert]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE RegistrySelect
@key nvarchar(200)
/*WITH ENCRYPTION*/ 
AS 

set nocount on

select [value] from Registry where [key]=@key






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[RegistrySelect]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE ReportCurrent
@NewShiftPoint datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @LastShiftPoint datetime
declare @ServiceSumma money
declare @printed int
declare @traffic int

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
  where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint)

-- подсчет трафика и распечатанных страниц
select @traffic =  ISNULL(Sum(s.[traffic]),0), @printed =  ISNULL(Sum(s.[printed]),0) from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA.[start]) and (SA.[start]<=@NewShiftPoint)

select ISNULL(sum(SA2.[summa]),0) as time, @ServiceSumma as service, @traffic as traffic, @printed as printed, @LastShiftPoint as LastShiftPoint from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA2.[moment]) and (SA2.[moment]<=@NewShiftPoint)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ReportCurrent]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ReportCurrentInsert
@moment datetime,
@summa money,
@comment nvarchar(200)=''
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into JournalOp ([moment], [summa], [comment], [operator])
  values (@moment, @summa, @comment, @idMe)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ReportCurrentInsert]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE RightsSelect
/*WITH ENCRYPTION*/ 
AS 

set nocount on

create table #Temp ([id] int, [name] nvarchar(50), [rOperators] int, [rAdmins] int, [rBosses] int)
create table #Temp2 ([idFunctions] int,  [name] nvarchar(50))

declare @temp int
declare @idFunctions int
declare @name nvarchar(50)
declare @rOperators int
declare @rAdmins int
declare @rBosses int
declare @idOperators int
declare @idAdmins int
declare @idBosses int

select @idOperators=[id] from UsersGroup where [name]='Staff'
select @idAdmins=[id] from UsersGroup where [name]='Tech'
select @idBosses=[id] from UsersGroup where [name]='Management'

insert into #Temp2 ([idFunctions], [name])  select [id], [name]  from [Functions]

set  @idFunctions=-1
while (0 = 0)    
begin   
  -- получаем идентификатор очередной выбираемой записи по возрастанию   
  select top 1 @idFunctions=[idFunctions], @name=[name] from #Temp2 where [idFunctions]>@idFunctions order by [idFunctions]
  -- если ничего не получили, то цикл завершен   
  if (@@rowcount=0) break
  set @rOperators=0
  set @rAdmins=0
  set @rBosses=0
  if (exists (select * from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idOperators)) set @rOperators=1
  if (exists (select * from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idAdmins)) set @rAdmins=1
  if (exists (select * from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idBosses)) set @rBosses=1
  insert into #Temp ([id], [name], [rOperators], [rAdmins], [rBosses]) 
    values (@idFunctions, @name, @rOperators, @rAdmins, @rBosses)
end

select [id], [name], [rOperators], [rAdmins], [rBosses] from #Temp






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[RightsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE RightsUpdate
@idFunctions int,
@rOperators int,
@rAdmins int,
@rBosses int
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idOperators int
declare @idAdmins int
declare @idBosses int

select @idOperators=[id] from UsersGroup where [name]='Staff'
select @idAdmins=[id] from UsersGroup where [name]='Tech'
select @idBosses=[id] from UsersGroup where [name]='Management'

if (@rOperators=0)
  delete from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idOperators
else
  if (not exists (select * from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idOperators))
    insert into FunctionsRights ([idFunctions], [idUsersGroup]) values (@idFunctions, @idOperators)

if (@rAdmins=0)
  delete from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idAdmins
else
  if (not exists (select * from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idAdmins))
    insert into FunctionsRights ([idFunctions], [idUsersGroup]) values (@idFunctions, @idAdmins)

if (@rBosses=0)
  delete from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idBosses
else
  if (not exists (select * from FunctionsRights where [idFunctions]=@idFunctions and [idUsersGroup]=@idBosses))
    insert into FunctionsRights ([idFunctions], [idUsersGroup]) values (@idFunctions, @idBosses)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ServiceToSell
@goods nvarchar(100),
@count int,
@now datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

declare @idServicesBase int
select @idServicesBase= [id] from ServicesBase where [name] = @goods and [isdelete]=0

insert into Services ([idServicesBase], [count], [operator], [moment]) 
  values (@idServicesBase, @count, @idMe, @now)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ServiceToSell]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ServicesBaseAdd
@goods nvarchar(100),
@price money
/*WITH ENCRYPTION*/ 
AS 

if (not exists(select * from ServicesBase where [name]=@goods and [isdelete]=0))
begin
  insert into ServicesBase ([name], [price]) values (@goods, @price)
end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ServicesBaseAdd]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ServicesBaseDelete
@goods nvarchar(100)
/*WITH ENCRYPTION*/ 
AS 

update ServicesBase set [isdelete]=1 where [name]=@goods






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ServicesBaseSelect
/*WITH ENCRYPTION*/ 
AS 
select * from ServicesBase where [isdelete]=0






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ServicesBaseSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE ServicesBaseUpdate
@oldgoods nvarchar(100),
@newgoods nvarchar(100),
@newprice money

/*WITH ENCRYPTION*/ 
AS 

update ServicesBase set [name]=@newgoods, [price]=@newprice
  where [name]=@oldgoods






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE SessionsAddMoney
@idSessions int,
@idSessionsAdd int,
@newstop datetime,
@summa money,
@moment datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

-- добавляем новую запись в SessionsAdd2, ActionType = 1 (добавить денег)
insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
  values (@idSessionsAdd, 1, @summa, @moment)

-- увеличиваем общую оплаченную сумму
update Sessions set [payed] = [payed] + @summa where [id]=@idSessions

-- увеличиваем время до скольки нужно
update SessionsAdd set [stop]=@newstop  where [id]=@idSessionsAdd






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsAddMoney]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE SessionsGo
@idClients int, 
@idComp int,
@idTarif int,
@postpay int,
@traffic int,
@printed int,
@payed money,
@descript nvarchar(100),
@start datetime,
@stop datetime,
@summa money,
@whole int,
@minpenalty int
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idSessions int
declare @idSessionsAdd int

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into Sessions ([idClients], [traffic], [printed], [postpay], [started], [payed], [description], [operator])
    values (@idClients, @traffic, @printed, @postpay, @start, @payed, @descript, @idMe)
select @idSessions = @@IDENTITY -- get id of last inserted record

if (@idClients <> 0) update Accounts set [balance]=[balance] - @payed where [id] = @idClients
 
insert into SessionsAdd ([idSessions], [idComp], [idTarif], [Start], [Stop], [whole], [minpenalty], [operator])
    values (@idSessions, @idComp, @idTarif, @start, @stop, @whole, @minpenalty, @idMe)
select @idSessionsAdd = @@IDENTITY -- get id of last inserted record

insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
   values (@idSessionsAdd, 0, @start, @summa)

-- return @idSessions and @idSessionsAdd
select @idSessions as idSessions, @idSessionsAdd as idSessionsAdd

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsGo]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE SessionsMoveComps
@idSessionsAdd int,
@idComp int
/*WITH ENCRYPTION*/ 
AS 

set nocount on

update SessionsAdd set [idComp]=@idComp where [id]=@idSessionsAdd






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsMoveComps]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE SessionsReadUncontrolState
@now datetime
/*WITH ENCRYPTION*/ 
AS 
 

set nocount on

declare @idClub int
select @idClub=[id] from Computers where [ipaddress]='Club'

if (exists(select U.[idComputers] from Uncontrol as U where U.[start]<=@now and @now<U.[stop] and U.[idComputers]=@idClub))
  select [id] idComputers from Computers where ipaddress<>'Club'
else
  select U.[idComputers] from Uncontrol as U where U.[start]<=@now and @now<U.[stop] and U.[idComputers]<>@idClub






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsReadUncontrolState]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE SessionsSelect
@now datetime

/*WITH ENCRYPTION*/ 
AS 

set nocount on

select S.[id] idSessions, S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description],
       SA.[id] idSessionsAdd, SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], SA.[minpenalty], SA.[whole], sum(SA2.[summa]) summa
  from Sessions as S
  inner join SessionsAdd as SA on (S.[id] = SA.[idSessions])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (SA.[start]<=@now) and (@now<SA.[stop])
  group by S.[id], S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description], SA.[id], SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], SA.[minpenalty], SA.[whole]
--  order by SA2.[idSessionsAdd] asc






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE SessionsStopIt
@idSessionsAdd int,
@newstop datetime,
@summa money,
@autostop int = 0
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @postpay int
declare @idSessions int
declare @idSessionsAdd2 int
declare @payed money
declare @idAccount int

select @idSessions=[idSessions] from SessionsAdd where [id]=@idSessionsAdd
select @payed=[payed] from Sessions where [id]=@idSessions
select @idAccount=[idClients] from Sessions where [id]=@idSessions
select @postpay=[postpay] from Sessions where [id]=@idSessions
select top 1 @idSessionsAdd2=[id] from SessionsAdd2 where [idSessionsAdd]=@idSessionsAdd order by [id] desc

update SessionsAdd set [stop] = @newstop where [id] = @idSessionsAdd
update Sessions set [payed]=@summa where [id]=@idSessions  
if ( @postpay = 0 ) -- была предоплата
begin
   -- добавляем новую запись в SessionsAdd2, ActionType = 2 
   if ((@summa - @payed)<>0) begin
     insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])   values (@idSessionsAdd, 2,  (@summa - @payed), @newstop)   
     -- снимаем со счета клиента
     if (@idAccount <> 0) update Accounts set [balance]=[balance] + (@payed - @summa) where [id] = @idAccount
   end
   -- если клиент остался должен, то 
   if ((@autostop=1) and (@summa - @payed > 0)) update Sessions Set [toResolve]=1 where [id]=@idSessions
end
else -- не было предоплаты
begin
   update SessionsAdd2 set [summa]=@summa, [moment]=@newstop where [id]=@idSessionsAdd2
   if (@autostop=1)  update Sessions Set [toResolve]=1 where [id]=@idSessions  
end
-- в любом случае сбрасываем флажок "постоплата", потому что уже все оплачено
--if (@autostop=0) 
update Sessions set [postpay]=0 where [id]=@idSessions

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsStopIt]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE SessionsUpdate
@idSessions int,
@traffic int,
@printed int,
@idSessionsAdd int,
@newstop datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

if (exists (select * from Sessions where [id] = @idSessions))
begin
  update Sessions Set [traffic] = [traffic] + @traffic, [printed] = [printed] + @printed, [operator] = @idMe where [id] = @idSessions
  update SessionsAdd Set [stop]=@newstop where [id]=@idSessionsAdd
end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsUpdate]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE TarifsAdd
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @priorityshow int

if (exists (select * from Tarifs where [name]=@name and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

select @priorityshow=max([priorityshow])+1 from Tarifs where [isdelete]=0

insert into Tarifs ([name], [internet], [calctraffic], [roundtime], [roundmoney], [priorityshow])
  values (@name, @internet, @calctraffic, @roundtime, @roundmoney, @priorityshow)

exec TarifsVariantsAdd 
  @idTarifs = @@identity, 
  @name=N'default',
  @start='0:00:00',
  @stop='0:00:00',
  @cost=1,
  @ispacket=0,
  @daysofweek=N'1234567'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE TarifsDelete
@idTarif int
/*WITH ENCRYPTION*/ 
AS 

set nocount on
declare @count int

if (not exists(select * from Tarifs where [id]=@idTarif))
begin
  raiserror 50000 'This tarif not exist!'
  return 50000
end

select @count=count(id) from Tarifs where [isdelete]=0
if (@count = 1)
begin
  raiserror 50001 'Last tarif dont must be deleted!'
  return 50001
end

update Tarifs set [isdelete]=1 where [id]=@idTarif
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE TarifsMoveUp
@idTarif int
/*WITH ENCRYPTION*/ 
AS 

set nocount on

if (exists(select * from Tarifs where [priorityshow]=0 and [id]=@idTarif and [isdelete]=0)) return

update Tarifs set [priorityshow]=0 where [id]=@idTarif and [isdelete]=0
update Tarifs set [priorityshow]=[priorityshow]+1 where [id]<>@idTarif and [isdelete]=0






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE TarifsSelect
/*WITH ENCRYPTION*/ 
AS 

set nocount on

select * from Tarifs  where [isdelete]=0 order by [priorityshow] asc






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[TarifsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE TarifsUpdate
@idTarif int,
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money
/*WITH ENCRYPTION*/ 
AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
                                   [roundmoney]=@roundmoney  where [id]=@idTarif






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE TarifsVariantsAdd
@idTarifs int, 
@name nvarchar(50),
@start datetime,
@stop datetime,
@cost money,
@ispacket int = 0,
@daysofweek nvarchar(7),
@condition nvarchar(50) = N''
/*WITH ENCRYPTION*/ 
AS 

set nocount on

insert into TarifsVariants ([idTarifs], [name], [start], [stop],[ispacket], [cost], [daysofweek], [condition])
  values (@idTarifs, @name, @start, @stop, @ispacket, @cost, @daysofweek, @condition)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE TarifsVariantsDelete
@idVariants int
/*WITH ENCRYPTION*/ 
AS 
set nocount on
declare @count int
declare @idTarif int

select @idTarif=[idTarifs] from TarifsVariants where [id]=@idVariants

select @count=count(id) from TarifsVariants where [idTarifs]=@idTarif
if (@count = 1)
begin
  raiserror 50001 'Last Interval must be exist!'
  return 50001
end

delete from TarifsVariants where [id]=@idVariants
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE TarifsVariantsSelect
@idTarifs int
/*WITH ENCRYPTION*/ 
AS 
select [id], [name], [start], [stop], [cost], [ispacket], [daysofweek], [condition] from TarifsVariants where [idTarifs]=@idTarifs






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[TarifsVariantsSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE TarifsVariantsUpdate
@idVariants int,
@name nvarchar(50),
@start datetime,
@stop datetime,
@cost money,
@ispacket int,
@daysofweek nvarchar(7),
@condition nvarchar(50)
/*WITH ENCRYPTION*/ 
AS 

set nocount on

update TarifsVariants set 
  [name]=@name, 
  [start]=@start, 
  [stop]=@stop, 
  [cost]=@cost, 
  [ispacket] = @ispacket,
  [daysofweek]=@daysofweek,
  [condition] = @condition
  where [id] = @idVariants
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
  call on the start App GCServer.exe
*/
CREATE PROCEDURE UnControlClubStart
@now datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idLast int
declare @idClub int

-- определим id Клуба (в таблице Uncontrol вперемешку данные о клубе и компах)
select @idClub = [id] from Computers where [ipaddress]='Club'

-- ищем последнюю запись
select top 1 @idLast=[id] from Uncontrol where [idComputers]=@idClub order by [id] desc
if ( exists ( select top 1 * from Uncontrol where [idComputers]=@idClub order by [id] desc ) )
begin
  -- при старте отмечаем последний интервал неконтроля, что он только что кончился
  update Uncontrol set [stop] = @now where ([id]=@idLast)  
end

insert into Uncontrol ([idComputers], [start], [stop]) values ( @idClub, @now, @now)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[UnControlClubStart]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
  call on the pulse timer  App GCServer.exe
*/
CREATE PROCEDURE UnControlClubTimer
@now datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idLast int
declare @idClub int

-- определим id Клуба (в таблице Uncontrol вперемешку данные о клубе и компах)
select @idClub = [id] from Computers where [ipaddress]='Club'

-- ищем последнюю запись
select top 1 @idLast=[id] from Uncontrol where [idComputers]=@idClub order by [id] desc
if ( exists ( select top 1 * from Uncontrol where [idComputers]=@idClub order by [id] desc ) )
begin
  -- при старте отмечаем последний интервал неконтроля, что он только что кончился
  update Uncontrol set [start] = @now, [stop] = @now  where ([id]=@idLast)  
end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[UnControlClubTimer]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
  mark uncontrol interval of @idComp computer
*/
CREATE PROCEDURE UnControlCompStart
@idComp int,
@now datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

insert into Uncontrol ( [idComputers], [start], [stop]) values ( @idComp, @now, @now )






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[UnControlCompStart]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







/*
  mark uncontrol interval of @idComp computer
*/
CREATE PROCEDURE UnControlCompTimer
@idComp int,
@now datetime
/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @idLast int

-- ищем последнюю запись
select top 1 @idLast=[id] from Uncontrol where [idComputers]=@idComp order by [id] desc
if ( exists ( select top 1 * from Uncontrol where [idComputers]=@idComp order by [id] desc ) )
begin
  -- отмечаем последний интервал неконтроля, что он стал подлиннее :)
  update Uncontrol set [stop] = @now where ([id]=@idLast)  
end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[UnControlCompTimer]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE UsersChangePass
@login_name nvarchar(50),
@pw nvarchar(50)
/*WITH ENCRYPTION*/ 
AS 

/*  проверка на наличие такого пользователя */
if not exists (select [id] from Users where [name]=@login_name and [isdelete]=0)
begin
 raiserror 50000 'User not exist!'
 return 50000
end

if @pw='' set @pw=NULL

declare @err1 int
exec @err1=master.dbo.sp_password @new=@pw,@loginame=@login_name
if (@err1<>0)
begin
 raiserror 50000 'Error set password!'
 return 50000
end
GO

CREATE PROCEDURE UsersCreate
@login_name nvarchar(50),
@group_name nvarchar(50),
@password nvarchar(50)
  
AS 

declare @error_descr varchar(400)
declare @idGroup int

select @idGroup=[id] from UsersGroup where [name]=@group_name

/*  проверка на наличие пользователя с таким же именем */
if exists (select [id] from Users where [name]=@login_name and [isdelete]=0)
begin
 raiserror 50000  'User already exist!'
 return 50000
end

declare @err1 int
declare @err2 int
declare @err3 int

if exists (select * from dbo.sysobjects where id = object_id(N'[tempdb]..[#msver]') )
	drop table #msver
DECLARE @MSSQLVERSION int
create table #msver ([Index] int PRIMARY KEY, [Name] varchar(200), Internal_Value int, Character_Value varchar(200))
insert into #msver exec master..xp_msver ProductVersion
select @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS int) from #msver
drop table #msver

declare @sql varchar(400)
IF (@MSSQLVERSION = 8) 
  exec @err1=master.dbo.sp_addlogin @login_name
IF (@MSSQLVERSION = 9) 
BEGIN
	set @sql = 'CREATE LOGIN ' + @login_name + ' WITH PASSWORD = '''' ,CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'
  exec (@sql)
END
exec @err2=sp_adduser @login_name, @login_name, 'public'
if (@group_name='Management')
  exec @err3=sp_addsrvrolemember @login_name, 'sysadmin'
if (@err1<>0) or (@err2<>0)
begin
 raiserror 50000 'Ошибка создания пользователя'
 return 50000
end

insert into Users ([name] ,[idUsersGroup]) values (@login_name,@idGroup)
exec UsersChangePass @login_name, @password
GO

GRANT  EXECUTE  ON [dbo].[UsersCreate]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE UsersDelete
@idUsers int
/*WITH ENCRYPTION*/ 
AS 

declare @login_name nvarchar(50)
select @login_name=[name] from Users where [id]=@idUsers

if @login_name=SYSTEM_USER
begin
 raiserror 50000 'You can''t delete yourself!'
 return 50000
end

declare @err1 int
declare @err2 int
exec @err1=sp_dropuser @login_name
exec @err2=master.dbo.sp_droplogin @login_name
/* логическое удаление пользователя */
if (@err1<>0) or (@err2<>0)
begin
 raiserror 50000 'Error deleting user!'
 return 50000
end

update Users set [isdelete]=1 where [id]=@idUsers






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[UsersDelete]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE UsersSelect
/*WITH ENCRYPTION*/ 
AS 
select Users.*, UsersGroup.name [group] from Users
 inner join UsersGroup on (Users.[idUsersGroup]=UsersGroup.[id]) 
 where Users.[isdelete]=0
 order by [group]






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[UsersSelect]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE secChangePass
@oldpass nvarchar(100),
@newpass nvarchar(100)
/*WITH ENCRYPTION*/ 
AS 

if @oldpass=''  set @oldpass=NULL
if @newpass=''  set @newpass=NULL

exec master.dbo.sp_password @old=@oldpass, @new=@newpass






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[secChangePass]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_Computers] 

/*WITH ENCRYPTION*/ 
AS 

select distinct [number] from [Computers]
where [number]<>0






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_Operators] 

@begin datetime,
@end datetime

/*WITH ENCRYPTION*/ 
AS 

select distinct [operator] from [repJournalOp]
    where [repJournalOp].[moment] between @begin and @end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [spgc_repDetails] 

@begin datetime,
@end datetime,
@OperatorName nvarchar(50),
@compNumber int

/*WITH ENCRYPTION*/ 
AS 

if (len(@OperatorName) = 0) 
begin
  if (@compNumber = 0)
    select * from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end)
  else
    select * from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([number]=@compNumber)
end
else 
begin
  if (@compNumber = 0)
    select * from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName)
  else
    select * from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName) and ([number]=@compNumber)
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [spgc_repGeneral] 

@begin datetime,
@end datetime,
@OperatorName nvarchar(50),
@CompNumber int

/*WITH ENCRYPTION*/ 
AS 

set nocount on

declare @sum money
declare @dopsumma money
declare @repair int
declare @uncontrol int
declare @uncontrolClub int
declare @currency nvarchar(1000)

set @sum = 0
set @repair = 0
set @uncontrol = 0
set @uncontrolClub = 0
set @dopsumma = 0

if (len(@OperatorName) = 0) begin
  select @dopsumma = sum(summa) from [repServices]
    where ([moment]  >= @begin) and ([moment]<=@end) 
  if (@CompNumber = 0) begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end)
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end)
  end
  else begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([number] = @CompNumber)
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([number] = @CompNumber)
  end
end
else begin
  select @dopsumma = sum(summa) from [repServices]
    where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName)
  if (@CompNumber = 0) begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and [operator] = @OperatorName
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end) and [operator] = @OperatorName
  end
  else begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName) and ([number] = @CompNumber)
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName) and ([number] = @CompNumber)
  end
end

select @uncontrol = sum(length)  from [repUncontrol]
    where ([repUncontrol].[start]  >= @begin) and ([repUncontrol].[stop]<=@end)

select @uncontrolClub = sum(length) from [repUncontrolClub]
    where ([repUncontrolClub].[start]  >= @begin) and ([repUncontrolClub].[stop]<=@end)


select top 1 @currency = [Registry].[value] from [Registry]
  where [Registry].[key] = 'currency'

set @dopsumma = isnull(@dopsumma,0)
set @sum  = isnull(@sum,0)
set @repair  = isnull(@repair,0)
set @uncontrol  = isnull(@uncontrol,0)
set @uncontrolClub  = isnull(@uncontrolClub,0)
set @dopsumma  = isnull(@dopsumma,0)

select @sum+@dopsumma [summa], @sum [generalsumma], @dopsumma [dopsumma], @repair [repair], @uncontrol [uncontrol], @uncontrolClub [uncontrolclub], 
           @currency [currency]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_repJournalOp] 

@begin datetime,
@end datetime,
@OperatorName nvarchar(50)

/*WITH ENCRYPTION*/ 
AS 

if (len(@OperatorName) = 0)
  select * from [repJournalOp]
    where [repJournalOp].[moment] between @begin and @end
else 
  select * from [repJournalOp]
    where ([repJournalOp].[moment] between @begin and @end) and
              ([repJournalOp].[operator] = @OperatorName)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_repLogs] 

/*WITH ENCRYPTION*/ 
AS 

select [Logs].[moment], 
       [Logs].[message],
       [Users].[name]
from [Logs]
inner join [Users]
on ([Logs].[operator] = [Users].[id])
where [Logs].[Prioritet] = 0 and DATEDIFF(day , [Logs].[moment], getdate())<=7
order by [Logs].[moment] desc






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_repRepair] 

@begin datetime,
@end datetime,
@OperatorName nvarchar(50),
@CompNumber int

/*WITH ENCRYPTION*/ 
AS 

if (len(@OperatorName) = 0) begin
  if (@CompNumber = 0) begin
    select * from [repRepair]
      where ([repRepair].[moment]  >= @begin) and ([repRepair].[moment]<=@end)
  end
  else begin
    select * from [repRepair]
      where ([repRepair].[moment]  >= @begin) and ([repRepair].[moment]<=@end) and ([number] = @CompNumber)
  end
end  
else begin
  if (@CompNumber = 0) begin
    select * from [repRepair]
      where ([repRepair].[moment]  >= @begin) and ([repRepair].[moment]<=@end) and [repRepair].[operator] = @OperatorName
  end
  else begin
    select * from [repRepair]
      where ([repRepair].[moment]  >= @begin) and ([repRepair].[moment]<=@end) and ([repRepair].[operator] = @OperatorName) and ([number] = @CompNumber)
  end
end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_repServices] 

@begin datetime,
@end datetime,
@OperatorName nvarchar(50)

/*WITH ENCRYPTION*/ 
AS 

if (len(@OperatorName) = 0)
  select * from [repServices]
    where [repServices].[moment] between @begin and @end
else 
  select * from [repServices]
    where ([repServices].[moment] between @begin and @end) and
              ([repServices].[operator] = @OperatorName)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_repUncontrol] 

@begin datetime,
@end datetime,
@CompNumber int

/*WITH ENCRYPTION*/ 
AS 

if (@CompNumber = 0)
  select * from [repUncontrol]
      where ([repUncontrol].[start]  >= @begin) and ([repUncontrol].[stop]<=@end)
else
  select * from [repUncontrol]
      where ([repUncontrol].[start]  >= @begin) and ([repUncontrol].[stop]<=@end) and ([number] = @CompNumber)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO







CREATE PROCEDURE [spgc_repUncontrolClub] 

@begin datetime,
@end datetime

/*WITH ENCRYPTION*/ 
AS 

select * from [repUncontrolClub]
    where ([repUncontrolClub].[start]  >= @begin) and ([repUncontrolClub].[stop]<=@end)






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.repDetails 
/*WITH ENCRYPTION*/ 
AS 
SELECT TOP 100 PERCENT 
 Computers.[ipaddress],
 Tarifs.[name],
 SessionsAdd.[Start],
 SessionsAdd.[Stop], 
 SessionsAdd2.[moment],
 SessionsAdd2.[summa],
 DATEDIFF(minute, SessionsAdd.[Start], SessionsAdd.[Stop]) AS length,
 Users.[Name] AS operator,
 Sessions.[description],
 Computers.[number],
 Sessions.[printed],
 Sessions.[traffic]
FROM Sessions 
 INNER JOIN SessionsAdd ON SessionsAdd.[idSessions] = Sessions.[id]
 INNER JOIN SessionsAdd2 ON SessionsAdd2.[idSessionsAdd] = SessionsAdd.[id]
 INNER JOIN Tarifs ON Tarifs.[id] = SessionsAdd.[idTarif]
 INNER JOIN Computers ON SessionsAdd.[idComp] = Computers.[id]
 INNER JOIN Users ON Users.[id] = Sessions.[operator]
--LEFT OUTER JOIN  dbo.TarifsVariants ON dbo.Tarifs.id = dbo.TarifsVariants.idTarifs 
WHERE 
  (SessionsAdd.[idTarif] <> 0) AND (Sessions.[postpay] = 0) -- AND (DATEDIFF(minute, SessionsAdd.[Start], SessionsAdd.[Stop]) > 0) 
GROUP BY 
 Computers.[ipaddress],
 Tarifs.[name],
 SessionsAdd.[Start],
 SessionsAdd.[Stop], 
 SessionsAdd2.[moment],
 SessionsAdd2.[summa],
 Users.[Name],
 Sessions.[description],
 Computers.[number],
 Sessions.[printed],
 Sessions.[traffic]
ORDER BY SessionsAdd.[Start]




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.repJournalOp 
/*WITH ENCRYPTION*/ 
AS 
SELECT     dbo.Users.Name AS operator, dbo.JournalOp.moment, dbo.JournalOp.summa, dbo.JournalOp.comment 
FROM         dbo.JournalOp INNER JOIN 
                      dbo.Users ON dbo.JournalOp.operator = dbo.Users.id 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.repRepair 
/*WITH ENCRYPTION*/ 
AS 
SELECT TOP 100 PERCENT
 Computers.[ipaddress],
 SessionsAdd.[Start],
 SessionsAdd.[Stop],
 SessionsAdd2.[moment],
 Users.[Name] AS operator, 
 DATEDIFF(minute,  SessionsAdd.[Start], SessionsAdd.[Stop]) AS length,
 Sessions.[description],
 Computers.[number]
FROM Sessions 
 INNER JOIN SessionsAdd ON SessionsAdd.[idSessions] = Sessions.[id]
 INNER JOIN SessionsAdd2 ON SessionsAdd2.[idSessionsAdd] = SessionsAdd.[id]
 INNER JOIN Computers ON SessionsAdd.[idComp] = Computers.[id]
 INNER JOIN Users ON Users.[id] = Sessions.[operator]
WHERE     
 (SessionsAdd.[idTarif] = 0) AND (DATEDIFF(minute, SessionsAdd.[Start], SessionsAdd.[Stop]) > 0) 
ORDER BY SessionsAdd.[Start]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.repServices 
/*WITH ENCRYPTION*/ 
AS 
SELECT    
 Users.[name] AS operator, 
 ServicesBase.[name], 
 Services.[count], 
 ServicesBase.[price], 
 Services.[moment],
 ServicesBase.[price]*Services.[count] AS summa 
FROM Services
 INNER JOIN ServicesBase ON ServicesBase.[id] = Services.[idServicesBase]
 INNER JOIN Users ON Services.[operator] = Users.[id]



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.repUncontrol 
/*WITH ENCRYPTION*/ 
AS 
SELECT     TOP 100 PERCENT dbo.Computers.number number, dbo.Computers.ipaddress ipAddress, dbo.Uncontrol.start start,  
                      dbo.Uncontrol.stop stop, DATEDIFF(minute, dbo.Uncontrol.start, dbo.Uncontrol.stop) length 
FROM         dbo.Uncontrol INNER JOIN 
                      dbo.Computers ON dbo.Uncontrol.idComputers = dbo.Computers.id 
WHERE     (dbo.Computers.ipaddress <> 'Club') AND (DATEDIFF(minute, dbo.Uncontrol.start, dbo.Uncontrol.stop) > 0) 
ORDER BY start



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.repUncontrolClub 
/*WITH ENCRYPTION*/ 
AS 
SELECT     TOP 100 PERCENT dbo.Uncontrol.start start, dbo.Uncontrol.stop stop, DATEDIFF(minute, dbo.Uncontrol.start, dbo.Uncontrol.stop) length 
FROM         dbo.Uncontrol INNER JOIN 
                      dbo.Computers ON dbo.Uncontrol.idComputers = dbo.Computers.id 
WHERE     (dbo.Computers.ipaddress = 'Club') AND (DATEDIFF(minute, dbo.Uncontrol.start, dbo.Uncontrol.stop) > 0) 
ORDER BY start 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

INSERT INTO [usersgroup]([id],[isdelete],[Name]) VALUES(1,0,N'Staff')
INSERT INTO [usersgroup]([id],[isdelete],[Name]) VALUES(2,0,N'Management')
INSERT INTO [usersgroup]([id],[isdelete],[Name]) VALUES(3,0,N'Tech')
go

INSERT INTO [users]([idUsersGroup],[isdelete],[Name]) VALUES(1,0,N'operator')
INSERT INTO [users]([idUsersGroup],[isdelete],[Name]) VALUES(2,0,N'manager')
go

INSERT INTO [functions]([id],[name]) VALUES(1,N'fnCompStart')
INSERT INTO [functions]([id],[name]) VALUES(2,N'fnCompStop')
INSERT INTO [functions]([id],[name]) VALUES(3,N'fnCompMove')
INSERT INTO [functions]([id],[name]) VALUES(4,N'fnPassChange')
INSERT INTO [functions]([id],[name]) VALUES(5,N'fnMainReport')
INSERT INTO [functions]([id],[name]) VALUES(6,N'fnCurrentReport')
INSERT INTO [functions]([id],[name]) VALUES(7,N'fnClearStatistics')
INSERT INTO [functions]([id],[name]) VALUES(8,N'fnLastSessions')
INSERT INTO [functions]([id],[name]) VALUES(9,N'fnCompAdd')
INSERT INTO [functions]([id],[name]) VALUES(10,N'fnRemont1')
INSERT INTO [functions]([id],[name]) VALUES(11,N'fnRemontLong')
INSERT INTO [functions]([id],[name]) VALUES(12,N'fnBossOptions')
INSERT INTO [functions]([id],[name]) VALUES(13,N'fnRemoteControl')
INSERT INTO [functions]([id],[name]) VALUES(14,N'fnSideline')
INSERT INTO [functions]([id],[name]) VALUES(15,N'fnManualPrint')
INSERT INTO [functions]([id],[name]) VALUES(16,N'fnShellMode')
INSERT INTO [functions]([id],[name]) VALUES(18,N'fnRemoteClientsManage')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(1,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(1,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(2,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(2,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(3,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(3,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(4,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(4,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(5,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(6,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(6,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(6,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(7,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(8,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(8,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(8,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(9,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(9,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(10,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(10,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(11,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(11,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(12,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(13,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(14,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(14,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(14,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(15,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(15,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(18,2)
go

INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.1',0,1,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.2',0,2,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.3',0,3,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.4',0,4,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.5',0,5,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.6',0,6,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.7',0,7,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.8',0,8,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.9',0,9,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.10',0,10,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.11',0,11,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.12',0,12,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.13',0,13,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.14',0,14,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.15',0,15,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.16',0,16,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.17',0,17,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.18',0,18,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.19',0,19,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.20',0,20,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.21',0,21,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.22',0,22,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.23',0,23,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.24',0,24,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'192.168.0.25',0,25,0)
INSERT INTO [computers]([ipaddress],[isdelete],[number],[vip]) VALUES(N'Club',1,0,0)
go

INSERT INTO [tarifs]([calctraffic],[internet],[isdelete],[name],[priorityshow],[roundmoney],[roundtime]) VALUES(1,1,0,N'Internet',1,0.5,1)
INSERT INTO [tarifs]([calctraffic],[internet],[isdelete],[name],[priorityshow],[roundmoney],[roundtime]) VALUES(0,0,0,N'Games',2,0.5,1)
go

INSERT INTO [TarifsVariants]([condition],[cost],[daysofweek],[idTarifs],[ispacket],[name],[start],[stop])  VALUES('',10,N'1234567',1,0,N'По умолчанию','0:00:00','0:00:00')
INSERT INTO [TarifsVariants]([condition],[cost],[daysofweek],[idTarifs],[ispacket],[name],[start],[stop]) VALUES('',8,N'1234567',1,0,N'ночь почасовая','23:00:00','7:00:00')
INSERT INTO [TarifsVariants]([condition],[cost],[daysofweek],[idTarifs],[ispacket],[name],[start],[stop]) VALUES('',50,N'1234567',1,1,N'пакет вся ночь','0:00:00','7:00:00')
INSERT INTO [TarifsVariants]([condition],[cost],[daysofweek],[idTarifs],[ispacket],[name],[start],[stop]) VALUES('',8,N'1234567',2,0,N'По умолчанию','0:00:00','0:00:00')
INSERT INTO [TarifsVariants]([condition],[cost],[daysofweek],[idTarifs],[ispacket],[name],[start],[stop]) VALUES('',30,N'1234567',2,1,N'пакет вся ночь','0:00:00','7:00:00')
go

INSERT INTO [registry]([Key],[Value]) VALUES(N'AddMoneyMaximum',N'100')
INSERT INTO [registry]([Key],[Value]) VALUES(N'AddMoneyMinimum',N'1')
INSERT INTO [registry]([Key],[Value]) VALUES(N'ClubName',N'My Club')
INSERT INTO [registry]([Key],[Value]) VALUES(N'Currency',N'$')
INSERT INTO [registry]([Key],[Value]) VALUES(N'MaximumTrustPostPay',N'200')
INSERT INTO [registry]([Key],[Value]) VALUES(N'OnlyPrePayMode',N'0')
INSERT INTO [registry]([Key],[Value]) VALUES(N'PostPayMode',N'0')
INSERT INTO [registry]([Key],[Value]) VALUES(N'PrintedPageCost',N'3')
INSERT INTO [registry]([Key],[Value]) VALUES(N'StartMoneyMaximum',N'200')
INSERT INTO [registry]([Key],[Value]) VALUES(N'StartMoneyMinimum',N'0,5')
INSERT INTO [registry]([Key],[Value]) VALUES(N'TrafficByteInMB',N'1048576')
INSERT INTO [registry]([Key],[Value]) VALUES(N'TrafficCost',N'5')
INSERT INTO [registry]([Key],[Value]) VALUES(N'UnixServerIP',N'192.168.0.253')
INSERT INTO [registry]([Key],[Value]) VALUES(N'BaseVersion',N'3.7')
go
