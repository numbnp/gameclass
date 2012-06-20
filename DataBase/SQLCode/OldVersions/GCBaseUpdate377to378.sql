Use GameClass
Go

exec master.dbo.sp_password @new='j4hhf6kd', @loginame='gcbackupoperator'
go

ALTER PROCEDURE SessionsTrafficPayment
@IdClient int,
@IdSessions int,
@IdSessionsAdd int,
@TrafficAdded int,
@Summa money,
@Moment datetime

AS 
BEGIN
    SET NOCOUNT ON
    -- добавляем новую запись в SessionsAdd2, ActionType = 3 (добавить денег за трафик)
    INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
        VALUES (@IdSessionsAdd, 3, @Summa, @Moment)
    -- увеличиваем доплаченный трафик
    UPDATE Sessions SET [TrafficAdded] = [TrafficAdded] + @TrafficAdded 
        WHERE [id]=@idSessions

    if (@IdClient <> 0) 
    begin
        update Accounts set [balance]=[balance] - @Summa where [id] = @IdClient
        update Accounts set [summary]=[summary] + @Summa where [id] = @IdClient
        insert into AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  values  (@IdClient, @Moment, 2, @summa, N'traffic',0)
    end

END
GO

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
  where (@LastShiftPoint<=RS.[moment]) and (RS.[moment]<=@NewShiftPoint)

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
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
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

update Registry set [value]=N'3.78' where [key]=N'BaseVersion'
GO
