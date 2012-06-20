Use GameClass
Go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SessionsSave]
GO


CREATE PROCEDURE SessionsSave
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
@minpenalty int,
@state int,
@status int,
@moment datetime
  
AS 

set nocount on

declare @idSessions int
declare @idSessionsAdd int

declare @idMe int
select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

insert into Sessions ([idClients], [traffic], [printed], [postpay], [started], [payed], [description], [operator], [minpenalty], [state], [status])
    values ( @idClients, @traffic, @printed, @postpay, @start, @payed, @descript, @idMe, @minpenalty, @state, @status)
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
   values (@idSessionsAdd, 0, @moment, @summa)

select @idSessions as idSessions, @idSessionsAdd as idSessionsAdd

GO

GRANT  EXECUTE  ON [dbo].[SessionsSave]  TO [public]
GO

update Registry set [value]=N'3.75a' where [key]=N'BaseVersion'
GO
