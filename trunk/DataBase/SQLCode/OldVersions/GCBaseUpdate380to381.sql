Use GameClass
Go

ALTER TABLE [dbo].[Registry] DROP CONSTRAINT [PK_Registry]
GO
ALTER TABLE [dbo].[Registry] DROP CONSTRAINT [DF_Registry_Value]
GO
ALTER TABLE [dbo].[Registry] ALTER COLUMN [Key] [varchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
ALTER TABLE [dbo].[Registry] ALTER COLUMN [Value] [varchar] (7000) COLLATE Cyrillic_General_CI_AS NOT NULL 
GO
ALTER TABLE [dbo].[Registry] WITH NOCHECK ADD 
	CONSTRAINT [DF_Registry_Value] DEFAULT (N'') FOR [Value],
	CONSTRAINT [PK_Registry] PRIMARY KEY CLUSTERED ([Key]) ON [PRIMARY] 
GO

ALTER PROCEDURE RegistryInsert
@key varchar(200),
@value varchar(7000)
  
AS 
set nocount on
if (exists(select * from registry where [key]=@key))
  update Registry set  [value]=@value where [key]=@key
else
  insert into Registry ([key], [value]) values (@key, @value)
GO

ALTER PROCEDURE SessionsUpdate
@idSessions int,
@traffic int,
@printed int,
@idSessionsAdd int,
@newstop datetime,
@newstatus int,
@newstate int
  
AS 

set nocount on

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

if (exists (select * from Sessions where [id] = @idSessions))
begin
  update Sessions Set [traffic] = [traffic] + @traffic, 
    [printed] = [printed] + @printed, 
    [operator] = @idMe, 
    [status]=@newstatus, 
    [state]=@newstate
    where [id] = @idSessions
  update SessionsAdd Set [stop]=@newstop where [id]=@idSessionsAdd
end
GO

ALTER PROCEDURE UsersDelete
@idUsers int
  
AS 

declare @login_name nvarchar(50)
select @login_name=[name] from Users where [id]=@idUsers

if object_id('tempdb..#ActiveUsers') is not null DROP TABLE #ActiveUsers

CREATE TABLE #ActiveUsers (
[spid] [int] NOT NULL,
[ecid] [int] NOT NULL,
[status] [varchar] (50) NULL ,
[loginame] [varchar] (50) NULL ,
[hostname] [varchar] (50) NULL ,
[blk] [int] NOT NULL,
[dbname] [varchar] (50) NULL ,
[cmd] [varchar] (50) NULL 
) ON [PRIMARY]

INSERT #ActiveUsers EXEC sp_who @login_name

if @login_name=SYSTEM_USER
begin
 raiserror 50000 'You can''t delete yourself!'
 return 50000
end

IF EXISTS(SELECT * FROM #ActiveUsers) 
begin
 raiserror 50000 'You can''t delete active user!'
 return 50000
end

if object_id('tempdb..#ActiveUsers') is not null DROP TABLE #ActiveUsers

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

update Registry set [value]=N'3.81' where [key]=N'BaseVersion'
GO
