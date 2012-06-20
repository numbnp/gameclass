use GameClass
GO

INSERT INTO [functions]([id],[name]) VALUES(22,N'fnVolume')
INSERT INTO [functions]([id],[name]) VALUES(23,N'fnCloseShift')
INSERT INTO [functions]([id],[name]) VALUES(24,N'fnPenalty')
INSERT INTO [functions]([id],[name]) VALUES(25,N'fnAccountsCreate')
INSERT INTO [functions]([id],[name]) VALUES(26,N'fnAccountsClearPassword')
INSERT INTO [functions]([id],[name]) VALUES(27,N'fnChangeTarif')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(22,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(22,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(22,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(23,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(23,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(23,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(24,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(24,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(24,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(27,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(27,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(27,3)
go

SET IDENTITY_INSERT [Accounts] ON
INSERT INTO [Accounts]([id],[name],[isdeleted]) VALUES(0,N'Guest',1)
SET IDENTITY_INSERT [Accounts] OFF

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputerGroups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ComputerGroups]
GO
CREATE TABLE [dbo].[ComputerGroups] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isdelete] [int] NOT NULL DEFAULT 0
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Computers] ADD [idGroup] [int] NOT NULL DEFAULT 1
GO

ALTER TABLE [dbo].[Sessions] ADD [minpenalty] [int] NOT NULL DEFAULT 0
GO

ALTER TABLE [dbo].[SessionsAdd] DROP CONSTRAINT [DF_SessionsAdd_minpenalty] 
ALTER TABLE [dbo].[SessionsAdd] DROP COLUMN [minpenalty] 
GO

ALTER TABLE [dbo].[Tarifs] ADD [idGroup] [int] NOT NULL DEFAULT 1
GO

ALTER TABLE [dbo].[TarifsVariants] ADD [TrafficLimit] [int] NOT NULL DEFAULT 1000
GO

declare @idLast int
INSERT INTO [ComputerGroups]([name]) VALUES('General')
INSERT INTO [ComputerGroups]([name]) VALUES('VIP')
select @idLast = @@IDENTITY
INSERT INTO [Tarifs]([name],[internet],[calctraffic],[idGroup]) VALUES('VIP Tariff',0,0,@idLast)
select @idLast = @@IDENTITY
INSERT INTO [TarifsVariants]([idTarifs],[name],[start],[stop],[cost],[daysofweek]) VALUES(@idLast,'VIP Tariff','01.01.1900','01.01.1900',1,'1234567')
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[repDetails]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[repDetails]
GO

CREATE VIEW dbo.repDetails 

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
 Sessions.[traffic],
 Sessions.[idClients],
 Sessions.[minpenalty],
 Accounts.[name] AccountName
FROM Sessions 
 INNER JOIN SessionsAdd ON SessionsAdd.[idSessions] = Sessions.[id]
 INNER JOIN SessionsAdd2 ON SessionsAdd2.[idSessionsAdd] = SessionsAdd.[id]
 INNER JOIN Tarifs ON Tarifs.[id] = SessionsAdd.[idTarif]
 INNER JOIN Computers ON SessionsAdd.[idComp] = Computers.[id]
 INNER JOIN Users ON Users.[id] = Sessions.[operator]
 INNER JOIN Accounts ON Sessions.[idClients] = Accounts.[id]
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
 Sessions.[traffic],
 Sessions.[idClients],
 Sessions.[minpenalty],
 Accounts.[name]
ORDER BY SessionsAdd.[Start]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputerGroupsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputerGroupsAdd]
GO

CREATE PROCEDURE ComputerGroupsAdd
@name nvarchar(15)  

AS 

declare @idGroup int

set nocount on

if (exists(select * from ComputerGroups where [name]=@name and [isdelete]=0))
begin
  raiserror 50000 'ComputerGroups with these name already exist!'
  return 50000
end
else
  insert into ComputerGroups ([name]) values (@name)
  select @idGroup=[id] from ComputerGroups where [name]=@name and [isdelete]=0
  set @name= @name +'Default'
  exec TarifsAdd @name=@name, @internet=0, @calctraffic=0, @roundtime=1, @roundmoney=0.1, @idGroup=@idGroup
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputerGroupsDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputerGroupsDelete]
GO

CREATE PROCEDURE ComputerGroupsDelete
@idGroup int

AS 

if (not exists(select * from ComputerGroups where [id]=@idGroup and [isdelete]=0))
begin
  raiserror 50000 'This computergroup not exists'
  return 50000
end
else begin
 update ComputerGroups set [isdelete]=1 where [id]=@idGroup
 update Tarifs set [isdelete]=1 where [idGroup]=@idGroup
end
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputerGroupsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputerGroupsSelect]
GO

CREATE PROCEDURE ComputerGroupsSelect

AS 

set nocount on

select * from ComputerGroups where isdelete=0
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputerGroupsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputerGroupsUpdate]
GO

CREATE PROCEDURE ComputerGroupsUpdate
@idGroup int,
@name nvarchar(50)

AS 

set nocount on

if (exists(select * from ComputerGroups where [name]=@name and [id]<>@idGroup and [isdelete]=0))
begin
  raiserror 50000 'ComputerGroups with these name already exist!'
  return 50000
end
else
  update ComputerGroups set [name]=@name where [id]=@idGroup
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputersAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputersAdd]
GO


CREATE PROCEDURE ComputersAdd
@number int,
@ipaddress nvarchar(15),
@idGroup int

AS 

set nocount on

if (exists(select * from Computers where ([number]=@number or [ipaddress]=@ipaddress) and [isdelete]=0))
begin
  raiserror 50000 'Computers with these number or ip-addres already exist!'
  return 50000
end
else
  insert into Computers ([number], [ipaddress], [idGroup]) values (@number, @ipaddress, @idGroup)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputersDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputersDelete]
GO

CREATE PROCEDURE ComputersDelete
@idComp int

AS 

if (not exists(select * from Computers where [id]=@idComp and [isdelete]=0))
begin
  raiserror 50000 'This computer not exists'
  return 50000
end
else
 update Computers set [isdelete]=1 where [id]=@idComp
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputersSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputersSelect]
GO

CREATE PROCEDURE ComputersSelect
@idGroup int 

AS 

set nocount on
if @idGroup=-1
  select * from Computers where isdelete=0 order by [number]
else
  select * from Computers where isdelete=0 and [idGroup]=@idGroup order by [number]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputersUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputersUpdate]
GO

CREATE PROCEDURE ComputersUpdate
@idComp int,
@number int,
@ipaddress nvarchar(15),
@idGroup int

AS 

set nocount on

if (exists(select * from Computers where ([number]=@number or [ipaddress]=@ipaddress) and [id]<>@idComp and [isdelete]=0))
begin
  raiserror 50000 'Computers with these number or ip-addres already exist!'
  return 50000
end
else
  update Computers set [number]=@number, [ipaddress]=@ipaddress, [idGroup]=@idGroup where [id]=@idComp
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportCurrent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ReportCurrent]
GO

CREATE PROCEDURE ReportCurrent
@NewShiftPoint datetime

AS 

set nocount on

declare @LastShiftPoint datetime
declare @ServiceSumma money
declare @printed int
declare @traffic int
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
  where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint)

-- подсчет трафика и распечатанных страниц
select @traffic =  ISNULL(Sum(s.[traffic]),0), @printed =  ISNULL(Sum(s.[printed]),0) from sessions as S
  inner join SessionsAdd as SA on (SA.[idSessions] = S.[id])
  where (S.[postpay]=0)
  and (@LastShiftPoint<=SA.[start]) and (SA.[start]<=@NewShiftPoint)

-- подсчет денег для аккаунтов
-- добавлено
select @AccountsAdded =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
  where (AH.[What]=0)
  and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
-- возвращено
select @AccountsReturned =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH
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
declare @LastTarifMoney money --всего денег на последнем тарифе
declare @idComp int

select @idSessions=[idSessions] from SessionsAdd where [id]=@idSessionsAdd
select @idComp=[idComp] from SessionsAdd where [id]=@idSessionsAdd
select @postpay=[postpay] from Sessions where [id]=@idSessions
--select @LastTarifMoney=sum([summa]) from SessionsAdd2 where [idSessionsAdd]=@idSessionsAdd 
select top 1 @idSessionsAdd2=[id] from SessionsAdd2 where [idSessionsAdd]=@idSessionsAdd and [ActionType]=0 order by [id] desc

update SessionsAdd set [stop] = @CurrentTime where [id] = @idSessionsAdd
update SessionsAdd2 set [summa] = [summa] - @MoneyLeft where [id] = @idSessionsAdd2

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)
select @idMe
insert into SessionsAdd ([idSessions], [idComp], [idTarif], [Start], [Stop], [whole],  [operator])
    values (@idSessions, @idComp, @idTarif, @CurrentTime, @NewTariffStop, 0, @idMe)
select @idSessionsAdd = @@IDENTITY -- get id of last inserted record

insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
   values (@idSessionsAdd, 0, @CurrentTime, @MoneyLeft)

-- return @idSessions and @idSessionsAdd
select  @idSessionsAdd as idSessionsAdd
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsGo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsGo]
GO


CREATE PROCEDURE SessionsGo
@state int,
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

AS 

set nocount on

declare @idSessions int
declare @idSessionsAdd int

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into Sessions ([state], [idClients], [traffic], [printed], [postpay], [started], [payed], [description], [operator], [minpenalty])
    values (@state, @idClients, @traffic, @printed, @postpay, @start, @payed, @descript, @idMe, @minpenalty)
select @idSessions = @@IDENTITY -- get id of last inserted record

if (@idClients <> 0) 
begin
  update Accounts set [balance]=[balance] - @payed where [id] = @idClients
  update Accounts set [summary]=[summary] + @payed where [id] = @idClients
end
 
insert into SessionsAdd ([idSessions], [idComp], [idTarif], [Start], [Stop], [whole],  [operator])
    values (@idSessions, @idComp, @idTarif, @start, @stop, @whole, @idMe)
select @idSessionsAdd = @@IDENTITY -- get id of last inserted record

insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
   values (@idSessionsAdd, 0, @start, @summa)

-- return @idSessions and @idSessionsAdd
select @idSessions as idSessions, @idSessionsAdd as idSessionsAdd
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsMoveComps]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsMoveComps]
GO

CREATE PROCEDURE SessionsMoveComps
@idSessionsAdd int,
@idComp int

AS 

set nocount on

update SessionsAdd set [idComp]=@idComp where [id]=@idSessionsAdd
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsSelect]
GO

CREATE PROCEDURE SessionsSelect
@now datetime

AS 

set nocount on
/*
declare @idLastSumma int

select top 1 @idLastSumma =SA2.[summa]
  from Sessions as S
  inner join SessionsAdd as SA on (S.[id] = SA.[idSessions])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  order by [start] desc
*/
select S.[state] state, S.[id] idSessions, S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description],
       SA.[id] idSessionsAdd, SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole], sum(SA2.[summa]) summa
  from Sessions as S
  inner join SessionsAdd as SA on (S.[id] = SA.[idSessions])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (SA.[start]<=@now) and (@now<SA.[stop])
  group by S.[state], S.[id], S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description], SA.[id], SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], S.[minpenalty], SA.[whole]
--  order by SA2.[idSessionsAdd] asc
GO

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
   update SessionsAdd2 set [summa]=@summa, [moment]=@newstop where [id]=@idSessionsAdd2
   if (@autostop=1)  update Sessions Set [toResolve]=1 where [id]=@idSessions  
end
-- в любом случае сбрасываем флажок "постоплата", потому что уже все оплачено
--if (@autostop=0) 
update Sessions set [postpay]=0 where [id]=@idSessions
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsUpdate]
GO

CREATE PROCEDURE SessionsUpdate
@idSessions int,
@traffic int,
@printed int,
@idSessionsAdd int,
@newstop datetime

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


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsUpdatePenalty]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsUpdatePenalty]
GO

CREATE PROCEDURE SessionsUpdatePenalty
@idSessions int,
@idSessionsAdd int,
@newstop datetime,
@minpenalty int,
@moment datetime

AS 

set nocount on

-- добавляем новую запись в SessionsAdd2, ActionType = 1 (добавить денег)
--insert into SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
--  values (@idSessionsAdd, 1, @summa, @moment)

-- увеличиваем общую оплаченную сумму
--update Sessions set [payed] = [payed] + @summa where [id]=@idSessions

-- увеличиваем время до скольки нужно
update SessionsAdd set [stop]=@newstop where [id]=@idSessionsAdd
update Sessions set  [minpenalty]=@minpenalty  where [id]=@idSessions
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsVariantsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsVariantsAdd]
GO

CREATE PROCEDURE TarifsVariantsAdd
@idTarifs int, 
@name nvarchar(50),
@start datetime,
@stop datetime,
@cost money,
@ispacket int = 0,
@daysofweek nvarchar(7),
@condition nvarchar(50) = N'',
@TrafficLimit int = 1000

AS 

set nocount on

insert into TarifsVariants ([idTarifs], [name], [start], [stop],[ispacket], [cost], [daysofweek], [condition],[TrafficLimit])
  values (@idTarifs, @name, @start, @stop, @ispacket, @cost, @daysofweek, @condition, @TrafficLimit)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsVariantsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsVariantsSelect]
GO

CREATE PROCEDURE TarifsVariantsSelect
@idTarifs int

AS 
select [id], [name], [start], [stop], [cost], [ispacket], [daysofweek], [condition],[TrafficLimit] from TarifsVariants where [idTarifs]=@idTarifs
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsVariantsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsVariantsUpdate]
GO

CREATE PROCEDURE TarifsVariantsUpdate
@idVariants int,
@name nvarchar(50),
@start datetime,
@stop datetime,
@cost money,
@ispacket int,
@daysofweek nvarchar(7),
@condition nvarchar(50),
@TrafficLimit int

AS 

set nocount on

update TarifsVariants set 
  [name]=@name, 
  [start]=@start, 
  [stop]=@stop, 
  [cost]=@cost, 
  [ispacket] = @ispacket,
  [daysofweek]=@daysofweek,
  [condition] = @condition,
  [TrafficLimit] = @TrafficLimit
  where [id] = @idVariants
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsAdd]
GO

CREATE PROCEDURE TarifsAdd
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int

AS 

set nocount on

declare @priorityshow int

if (exists (select * from Tarifs where [name]=@name and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

select @priorityshow=max([priorityshow])+1 from Tarifs where [isdelete]=0

insert into Tarifs ([name], [internet], [calctraffic], [roundtime], [roundmoney], [priorityshow], [idGroup])
  values (@name, @internet, @calctraffic, @roundtime, @roundmoney, @priorityshow, @idGroup)

exec TarifsVariantsAdd 
  @idTarifs = @@identity, 
  @name=N'default',
  @start='0:00:00',
  @stop='0:00:00',
  @cost=1,
  @ispacket=0,
  @daysofweek=N'1234567'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsSelect]
GO

CREATE PROCEDURE TarifsSelect
@idGroup int 

AS 
set nocount on
if @idGroup=-1
  select * from Tarifs  where [isdelete]=0 order by [priorityshow] asc
else
  select * from Tarifs  where [isdelete]=0 and [idGroup]=@idGroup order by [priorityshow] asc
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TarifsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[TarifsUpdate]
GO

CREATE PROCEDURE TarifsUpdate
@idTarif int,
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int

AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
                                   [roundmoney]=@roundmoney, [idGroup]=@idGroup  where [id]=@idTarif
GO


GRANT  EXECUTE  ON [dbo].[spgc_Operators]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_Computers]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repGeneral]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repLogs]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repDetails]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repJournalOp]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repRepair]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repUncontrol]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repUncontrolClub]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[spgc_repServices]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[AccountsUpdate]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[ReportCurrent]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsChangeTariff]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsGo]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsMoveComps]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsSelect]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsStopIt]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsUpdate]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SessionsUpdatePenalty]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[ComputerGroupsSelect]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[ComputersSelect]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[TarifsVariantsSelect]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[TarifsSelect]  TO [public]
GO

update Registry set [value]=N'3.73' where [key]=N'BaseVersion'
GO
