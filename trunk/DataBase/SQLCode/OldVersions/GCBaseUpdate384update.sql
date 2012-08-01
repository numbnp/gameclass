USE GameClass
GO

/* -----------------------------------------------------------------------------
            На пакетах при полной сумме аккаунтов не списываются деньги
----------------------------------------------------------------------------- */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsStopIt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE SessionsStopIt
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
   end
   -- снимаем со счета клиента
   if (@idAccount <> 0) 
   begin
     update Accounts set [balance]=[balance] + (@payed - @summa) where [id] = @idAccount
     update Accounts set [summary]=[summary] - (@payed - @summa) where [id] = @idAccount
     insert into AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  values  (@idAccount, @newstop, 2, @summa, N'',0)
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
update Sessions set [postpay]=0, [status]=2 where [id]=@idSessions
GO

/* -----------------------------------------------------------------------------
          В текущем отчете сумма, возвращенная с карт клиентов
					вычиталась из выручки
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportCurrent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE ReportCurrent
GO

CREATE PROCEDURE ReportCurrent
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
  and usersgroup.name='Staff'
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
        Нет Jobs и Err 
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ClearStatistics]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE ClearStatistics
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
delete from _pm_jobs
delete from old_Information
delete from old_errors
delete from old_warnings
GO

/* -----------------------------------------------------------------------------
        Нет версии в _pm_registry
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM [dbo].[_pm_registry] WHERE [name] = 'version')
BEGIN
INSERT [dbo].[_pm_registry] ([name], [value]) 
  VALUES('version', '3,09')
END
GO

/* -----------------------------------------------------------------------------
        Неправильно записывает цену распечатки при цифрах после запятой
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RegistryUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE RegistryUpdate
GO

CREATE PROCEDURE RegistryUpdate
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
    IF (@key = N'printers\DefaultPrinter') UPDATE ServicesBase SET [price] = CAST(replace(@value, ',', '.') AS money) WHERE [id] = 0
  END
END
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
