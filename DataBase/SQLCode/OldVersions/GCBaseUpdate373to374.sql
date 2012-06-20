Use GameClass
Go

GRANT  EXECUTE  ON [dbo].[AccountsNew]  TO [public]
Go

GRANT  EXECUTE  ON [dbo].[AccountsUpdateCodes]  TO [public]
Go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReports]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CustomReports]
GO

CREATE TABLE [dbo].[CustomReports] (
	[name] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[description] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[sqlcode] [nvarchar] (3500) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[tabindex] [int] NOT NULL ,
	[id] [uniqueidentifier] NOT NULL ,
	[version] [int] NOT NULL 
) ON [PRIMARY]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsAdd]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsSelect]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReportsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CustomReportsUpdate]
GO

CREATE PROCEDURE CustomReportsAdd
@name nvarchar(20),
@description nvarchar(200),
@sqlcode nvarchar(3500),
@tabindex int,
@version int
  
AS 

set nocount on

declare @id as uniqueidentifier

if (exists(select * from CustomReports where [name]=@name or [sqlcode]=@sqlcode) )
begin
  raiserror 50000 'CustomReports with these name or SQL-code already exist!'
  return 50000
end
else begin
 set @id = newid()
  insert into CustomReports ([id], [name], [description], [sqlcode], [tabindex], [version]) values (@id, @name, @description, @sqlcode, @tabindex, @version)
end
GO

CREATE PROCEDURE CustomReportsDelete
@idReport uniqueidentifier
  
AS 

if (not exists(select * from CustomReports where [id]=@idReport))
begin
  raiserror 50000 'This report not exists'
  return 50000
end
else
 delete from CustomReports where [id]=@idReport
GO

CREATE PROCEDURE CustomReportsSelect
    
AS 

set nocount on

select * from CustomReports order by tabindex
GO

CREATE PROCEDURE CustomReportsUpdate
@idReport uniqueidentifier,
@name nvarchar(20),
@description nvarchar(200),
@sqlcode nvarchar(3500),
@tabindex int,
@version int
    
AS 

set nocount on

if (exists(select * from CustomReports where ([name]=@name or [sqlcode]=@sqlcode) and [id]<>@idReport))
begin
  raiserror 50000 'CustomReports with these name or SQL-code already exist!'
  return 50000
end
else
  update CustomReports set [name]=@name, [description]=@description, [sqlcode]=@sqlcode, [tabindex]=@tabindex, [version]=@version where [id]=@idReport
GO

CREATE PROCEDURE CustomReportsImport
@id uniqueidentifier,
@name nvarchar(20),
@description nvarchar(200),
@sqlcode nvarchar(4000),
@tabindex int,
@version int
    
AS 

set nocount on

if (exists(select * from CustomReports where [name]=@name or [sqlcode]=@sqlcode) )
begin
  raiserror 50000 'CustomReports with these name or SQL-code already exist!'
  return 50000
end
else begin
  insert into CustomReports ([id], [name], [description], [sqlcode], [tabindex], [version]) values (@id, @name, @description, @sqlcode, @tabindex, @version)
end

GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsChangeTariff]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsChangeTariff]
GO

CREATE PROCEDURE SessionsChangeTariff
@idSessionsAdd int,
@idTarif int,
@CurrentTime datetime,
@NewTariffStop datetime,
@MoneyLeft money --сумма стоимости последнего тарифа без учета принтера и трафика
    
AS 

set nocount on

declare @postpay int
declare @idSessions int
declare @idSessionsAdd2 int
declare @idComp int

select @idSessions=[idSessions] from SessionsAdd where [id]=@idSessionsAdd
select @idComp=[idComp] from SessionsAdd where [id]=@idSessionsAdd
select @postpay=[postpay] from Sessions where [id]=@idSessions
select top 1 @idSessionsAdd2=[id] from SessionsAdd2 where [idSessionsAdd]=@idSessionsAdd and [ActionType]=0 order by [id] desc

update SessionsAdd set [stop] = @CurrentTime where [id] = @idSessionsAdd
update SessionsAdd2 set [summa] = [summa] - @MoneyLeft where [id] = @idSessionsAdd2

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into SessionsAdd ([idSessions], [idComp], [idTarif], [Start], [Stop], [whole],  [operator])
    values (@idSessions, @idComp, @idTarif, @CurrentTime, @NewTariffStop, 0, @idMe)
select @idSessionsAdd = @@IDENTITY -- get id of last inserted record

insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
   values (@idSessionsAdd, 0, @CurrentTime, @MoneyLeft)

select  @idSessionsAdd as idSessionsAdd
GO

GRANT  EXECUTE  ON [dbo].[SessionsChangeTariff]  TO [public]
Go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsStopIt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsStopIt]
GO

CREATE PROCEDURE SessionsStopIt
@idSessionsAdd int,
@newstop datetime,
@summa money,
@autostop int = 0
    
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
     if (@idAccount <> 0) 
     begin
       update Accounts set [balance]=[balance] + (@payed - @summa) where [id] = @idAccount
       update Accounts set [summary]=[summary] - (@payed - @summa) where [id] = @idAccount
       insert into AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  values  (@idAccount, @newstop, 2, @summa, N'',0)
     end
   end
   -- если клиент остался должен, то 
   if ((@autostop=1) and (@summa - @payed > 0)) update Sessions Set [toResolve]=1 where [id]=@idSessions
end
else -- не было предоплаты
begin
   update SessionsAdd2 set [summa]=[summa]-@payed+@summa, [moment]=@newstop where [id]=@idSessionsAdd2
   if (@autostop=1)  update Sessions Set [toResolve]=1 where [id]=@idSessions  
end
-- в любом случае сбрасываем флажок "постоплата", потому что уже все оплачено
--if (@autostop=0) 
update Sessions set [postpay]=0 where [id]=@idSessions

GO

GRANT  EXECUTE  ON [dbo].[SessionsStopIt]  TO [public]
Go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ClearStatistics]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ClearStatistics]
GO

CREATE PROCEDURE ClearStatistics
 
AS 
delete from Logs
delete from JournalOp
delete from Sessions
delete from SessionsAdd
delete from SessionsAdd2
delete from UnControl
delete from Hardware
delete from Services
delete from Errors
delete from Information
delete from Jobs
delete from Warnings
GO

INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F90}',N'Главный отчет',
N'Отчет отображает итоговые суммы
---
Author: GameClass Software
support@gameclass.ru',
N'set nocount on 
declare @sum money 
declare @dopsumma money 
declare @repair int 
declare @uncontrol int 
declare @uncontrolClub int 
declare @currency nvarchar(1000) 
declare @AccountsAdded money
declare @AccountsReturned money
declare @AccountsPayed money

set @sum = 0 
set @repair = 0 
set @uncontrol = 0 
set @uncontrolClub = 0 
set @dopsumma = 0

select @sum = sum(summa) from [repDetails] where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%) 
select @repair = sum(length) from [repRepair] where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%) 
select @uncontrol = sum(length)  from [repUncontrol] where ([repUncontrol].[start]  >= %TIME-START%) and ([repUncontrol].[stop]<=%TIME-STOP%) 
select @uncontrolClub = sum(length) from [repUncontrolClub] where ([repUncontrolClub].[start]  >= %TIME-START%) and ([repUncontrolClub].[stop]<=%TIME-STOP%) 
select top 1 @currency = [Registry].[value] from [Registry] where [Registry].[key] = ''currency'' 
set @dopsumma = isnull(@dopsumma,0) 
set @sum  = isnull(@sum,0) 
set @repair  = isnull(@repair,0) 
set @uncontrol  = isnull(@uncontrol,0) 
set @uncontrolClub  = isnull(@uncontrolClub,0) 
set @dopsumma  = isnull(@dopsumma,0) 

select @AccountsAdded =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
  where (AH.[What]=0)
  and (%TIME-START%<=AH.[moment]) and (AH.[moment]<=%TIME-STOP%)
select @AccountsReturned =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
  where (AH.[What]=1)
  and (%TIME-START%<=AH.[moment]) and (AH.[moment]<=%TIME-STOP%)
select @AccountsPayed =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
  where (AH.[What]=2)
  and (%TIME-START%<=AH.[moment]) and (AH.[moment]<=%TIME-STOP%)

if object_id(''tempdb..#t'') is not null 
DROP TABLE #t 
CREATE TABLE #t ( 
[id] [int] IDENTITY (1, 1) NOT NULL , 
[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NULL , 
[result] [varchar] (255) COLLATE Cyrillic_General_CI_AS NULL  
) ON [PRIMARY] 
INSERT INTO #t (name,result) VALUES (N''Итоговая прибыль'', CAST ( @sum+@dopsumma AS VARCHAR(255)) ) 
INSERT INTO #t (name,result) VALUES (N''За оплату компьютеров'', CAST ( @sum AS VARCHAR(255)) ) 
INSERT INTO #t (name,result) VALUES (N''За оплату услуг'', CAST ( @dopsumma AS VARCHAR(255)) ) 
INSERT INTO #t (name,result) VALUES (N''Потрачено на ремонт (минут)'', @repair) 
INSERT INTO #t (name,result) VALUES (N''Не было контроля компьютеров (минут)'', @uncontrol) 
INSERT INTO #t (name,result) VALUES (N''Не был запущен GameClass (минут)'', @uncontrolClub) 

INSERT INTO #t (name,result) VALUES (N''Добавлено на счета учетных записей'', CAST ( @AccountsAdded AS VARCHAR(255))) 

INSERT INTO #t (name,result) VALUES (N''Возвращено со счетов учетных записей'', CAST ( @AccountsReturned AS VARCHAR(255))) 

INSERT INTO #t (name,result) VALUES (N''Проплачено со счетов учетных записей'', CAST ( @AccountsPayed AS VARCHAR(255)))

SELECT name [Описание], result [Значение] FROM #t order by [id] asc 
',1,0)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F91}',N'Детальный отчет',
N'Отчет отображает все сеансы
---
Author: GameClass Software
support@gameclass.ru',
N'select * from [repDetails] 
where ([moment]  >= %TIME-START%) and ([moment]<=%TIME-STOP%)',1,1)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F92}',N'Журнал операторов',
N'Отчет показывает суммы, сданные операторами в своих сменах
---
Author: GameClass Software
support@gameclass.ru',N'select * from [repJournalOp]
 where ([repJournalOp].[moment] between %TIME-START% and %TIME-STOP%)',1,2)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F93}',N'Не работал GameClass',
N'Отчет показывает интервали времени, в течение которых GameClass не был запущен. В эти моменты клуб не контролировался полностью
---
Author: GameClass Software
support@gameclass.ru',N'select * from [repUncontrolClub]
 where 
  ([repUncontrolClub].[start] >= %TIME-START%) and 
  ([repUncontrolClub].[stop]  <= %TIME-STOP%)',1,3)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F94}',N'Не было контроля',
N'Отчет показывает интервалы времени, в течение которых не было контроля клиентских компьютеров
---
Author: GameClass Software
support@gameclass.ru',N'select * from [repUncontrol]
 where 
  ([repUncontrol].[start] >= %TIME-START%) and 
  ([repUncontrol].[stop]  <= %TIME-STOP%)',1,4)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F95}',N'Отчет по ремонту',
N'Отчет показывает интервалы времени, во время которых был применен ремонт с длительностью более минуты
---
Author: GameClass Software
support@gameclass.ru',N'select * from [repRepair]
  where 
   ([repRepair].[moment] >= %TIME-START%) and 
   ([repRepair].[moment] <= %TIME-STOP%)',1,5)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F96}',N'Отчет по услугам',
N'Отчет показывает информацию о проданных услугах
---
Author: GameClass Software
support@gameclass.ru',N'select * from [repServices]
  where ([repServices].[moment] between %TIME-START% and %TIME-STOP%)',1,6)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F98}',N'Важные сообщения',
N'Сообщения системы за последнюю неделю
---
Author: GameClass Software
support@gameclass.ru',N'select 
 [Logs].[moment], 
 [Logs].[message],
 [Users].[name]
from [Logs]
 inner join [Users]
 on ([Logs].[operator] = [Users].[id])
 where [Logs].[Prioritet] = 0 and DATEDIFF(day , [Logs].[moment], getdate())<=7
 order by [Logs].[moment] desc',1,7)
INSERT INTO [CustomReports]([id],[name],[description],[sqlcode],[version],[tabindex]) VALUES(N'{A2D71DA5-35B9-43AD-A829-A765E0927F99}',N'Учетные записи',
N'Отчет по учетным записям
---
Author: GameClass Software
support@gameclass.ru',N'select  
 name [Имя], 
 balance [Баланс], 
 zeroBalance [Нулевой баланс], 
 summary [Накоплено], 
 isprivileged [Привелигированный], 
 privilegedDiscount [Скидка], 
 isblocked [Заблокирован], 
 isenabled [Отключен] 
from accounts where
 id>0 and
 isdeleted<>1',1,8)

insert into [Registry]([value],[key]) values(N'SetVolume',N'1')

update Registry set [value]=N'3.74' where [key]=N'BaseVersion'
GO
