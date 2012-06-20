use GameClass
GO

INSERT INTO [functions]([id],[name]) VALUES(19,N'fnRemoveFromTasksTemplate')
INSERT INTO [functions]([id],[name]) VALUES(20,N'fnRemoteTasksKilling')
INSERT INTO [functions]([id],[name]) VALUES(21,N'fnViewFinanceOnShiftReport')
go

INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(19,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(19,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(19,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(20,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(20,3)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(21,1)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(21,2)
INSERT INTO [functionsrights]([idFunctions],[idUsersGroup]) VALUES(21,3)
go

ALTER TABLE [dbo].[Sessions] ADD [state] [int] NOT NULL DEFAULT 0
GO


ALTER TABLE [dbo].[Accounts] ADD [summary] [money] NOT NULL DEFAULT 0
GO

ALTER TABLE [dbo].[Accounts] ADD [address] nvarchar(300) NOT NULL DEFAULT N''
GO

ALTER TABLE [dbo].[Accounts] ADD [memo] nvarchar(2000) NOT NULL DEFAULT N''
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AccountsUpdate]
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
@zeroBalance money,
@memotext nvarchar(2000) = N'',
@address nvarchar(300)=N''

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
  [zeroBalance] = @zeroBalance,
  [memo] = @memotext,
  [address] = @address

   where [id] = @id
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsGo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsGo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsStopIt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsStopIt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsSelect]
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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

insert into Sessions ([state], [idClients], [traffic], [printed], [postpay], [started], [payed], [description], [operator])
    values (@state, @idClients, @traffic, @printed, @postpay, @start, @payed, @descript, @idMe)
select @idSessions = @@IDENTITY -- get id of last inserted record

if (@idClients <> 0) 
begin
  update Accounts set [balance]=[balance] - @payed where [id] = @idClients
  update Accounts set [summary]=[summary] + @payed where [id] = @idClients
end
 
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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsStopIt]  TO [public]
GO

CREATE PROCEDURE SessionsSelect
@now datetime
   
AS 

set nocount on

select S.[state] state, S.[id] idSessions, S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description],
       SA.[id] idSessionsAdd, SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], SA.[minpenalty], SA.[whole], sum(SA2.[summa]) summa
  from Sessions as S
  inner join SessionsAdd as SA on (S.[id] = SA.[idSessions])
  inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd])
  where (SA.[start]<=@now) and (@now<SA.[stop])
  group by S.[state], S.[id], S.[idClients], S.[traffic], S.[printed], S.[postpay], S.[started], S.[payed], S.[description], SA.[id], SA.[idComp], SA.[idTarif], SA.[start], SA.[stop], SA.[minpenalty], SA.[whole]
--  order by SA2.[idSessionsAdd] asc
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SessionsSelect]  TO [public]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsHistorySelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AccountsHistorySelect]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE AccountsHistorySelect
@idAccount int = 0
 
AS

if (@idAccount = 0) 
  select * from AccountsHistory order by [id]
else
  select top 10 * from AccountsHistory where [idAccounts]=@idAccount order by [moment] DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[AccountsHistorySelect]  TO [public]
Go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[repDetails]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[repDetails]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
 Sessions.[idClients]
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
 Sessions.[traffic],
 Sessions.[idClients]
ORDER BY SessionsAdd.[Start]






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spgc_repGeneral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spgc_repGeneral]
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
      where ([moment]  >= @begin) and ([moment]<=@end) and ([idClients]=0)
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end)
  end
  else begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([number] = @CompNumber) and ([idClients]=0)
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([number] = @CompNumber)
  end
end
else begin
  select @dopsumma = sum(summa) from [repServices]
    where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName)
  if (@CompNumber = 0) begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and [operator] = @OperatorName and ([idClients]=0)
    select @repair = sum(length) from [repRepair]
      where ([moment]  >= @begin) and ([moment]<=@end) and [operator] = @OperatorName
  end
  else begin
    select @sum = sum(summa) from [repDetails]
      where ([moment]  >= @begin) and ([moment]<=@end) and ([operator] = @OperatorName) and ([number] = @CompNumber) and ([idClients]=0)
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportCurrent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ReportCurrent]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE ReportCurrent
@NewShiftPoint datetime
   
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
  and S.[idClients]=0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[ReportCurrent]  TO [public]
GO

update Registry set [value]=N'3.72' where [key]=N'BaseVersion'
GO
