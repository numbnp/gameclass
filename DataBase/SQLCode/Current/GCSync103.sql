USE GameClass
GO

/* -----------------------------------------------------------------------------
                  Изменение Select-процедур для скрытия полей sync и guid
----------------------------------------------------------------------------- */
ALTER PROCEDURE AccountsSelect
  @id INT = NULL

AS 
BEGIN
  SELECT [id], [name], [password], email, phone, photo, seccodes, 
      isenabled, isblocked, isprivileged, isdeleted, privilegedDiscount, 
      zeroBalance, balance, summary, address, memo, PeriodOfValidity, 
      ExpirationDate, assigntarif, userlevel, force_tariff, referal, username, 
      uname, uotch  FROM Accounts 
      WHERE ([isdeleted] = 0) AND ((Accounts.[id] = @id) OR (@id IS NULL))
      ORDER BY [id]
END
GO

ALTER PROCEDURE AccountsHistorySelect
@idAccount int = 0

AS

if (@idAccount = 0) 
  select [id], idAccounts, moment, what, summa, comment, operator 
      from AccountsHistory order by [id]
else
  select top 10 [id], idAccounts, moment, what, summa, comment, operator
      from AccountsHistory where [idAccounts] = @idAccount order by [moment] DESC
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


CREATE PROCEDURE AccountsSelectUnsynchronized
@idSyncServer int

AS
BEGIN
  SELECT guid, [name], [password], email, phone, photo, seccodes, 
      isenabled, isblocked, isprivileged, isdeleted, privilegedDiscount, 
      zeroBalance, balance, summary, address, memo, updated, PeriodOfValidity, 
	ExpirationDate, assigntarif, userlevel, force_tariff, referal, username, 
	uname, uotch  FROM Accounts 
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
@memo nvarchar(2000),
@PeriodOfValidity int,
@ExpirationDate datetime,
@assigntarif int,
@userlevel int,
@force_tariff int,
@referal int,
@username nvarchar(80),
@uname  nvarchar(80),
@uotch nvarchar(80)

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM Accounts WHERE [guid] = @guid)
    INSERT INTO [Accounts]
        ([guid], [name], [password], [email], [phone], [photo], [seccodes], 
        [isenabled], [isblocked], [isprivileged], [isdeleted], [privilegedDiscount], 
        [zeroBalance], [balance], [summary], [address], [memo], [sync], [PeriodOfValidity], 
	[ExpirationDate], [assigntarif], [userlevel], [force_tariff], [referal], [username], 
	[uname], [uotch])
        VALUES(@guid, @name, @password, @email, @phone, @photo, @seccodes,
        @isenabled, @isblocked, @isprivileged, @isdeleted, @privilegedDiscount,
        @zeroBalance, @balance, @summary, @address, @memo, 9223372036854775807,
	@PeriodOfValidity, @ExpirationDate, @assigntarif, @userlevel, @force_tariff, @referal, 
	@username, @uname, @uotch)

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
@updated datetime,
@PeriodOfValidity int,
@ExpirationDate datetime,
@assigntarif int,
@userlevel int,
@force_tariff int,
@referal int,
@username nvarchar(80),
@uname  nvarchar(80),
@uotch nvarchar(80)

AS 
BEGIN
  IF NOT EXISTS (SELECT * FROM Accounts WHERE [guid] = @guid)
    INSERT INTO [Accounts]
        ([guid], [name], [password], [email], [phone], [photo], [seccodes], 
        [isenabled], [isblocked], [isprivileged], [isdeleted], [privilegedDiscount], 
        [zeroBalance], [balance], [summary], [address], [memo], [sync], [PeriodOfValidity], 
	[ExpirationDate], [assigntarif], [userlevel], [force_tariff], [referal], [username], 
	[uname], [uotch])
        VALUES(@guid, @name, @password, @email, @phone, @photo, @seccodes,
        @isenabled, @isblocked, @isprivileged, @isdeleted, @privilegedDiscount,
        @zeroBalance, 0.00, @summary, @address, @memo, 9223372036854775807,
	@PeriodOfValidity, @ExpirationDate, @assigntarif, @userlevel, @force_tariff, @referal, 
	@username, @uname, @uotch)
  ELSE
    UPDATE [Accounts] SET
        [name] = @name, [password] = @password, [email] = @email, [phone] = @phone,
        [photo] = @photo, [seccodes] = @seccodes, [isenabled] = @isenabled, 
        [isblocked] = @isblocked, [isprivileged] = @isprivileged, [isdeleted] = @isdeleted,
        [privilegedDiscount] = @privilegedDiscount, [zeroBalance] = @zeroBalance,
        [summary] = @summary, [address] = @address, [memo] = @memo, 
	[sync] = 9223372036854775807, [updated] = @updated, [PeriodOfValidity] = @PeriodOfValidity, [ExpirationDate] = @ExpirationDate,
	[assigntarif] = @assigntarif, [userlevel] = @userlevel, [force_tariff] = @force_tariff, [referal] = @referal, [username] = @username, 
	[uname] = @uname, [uotch] = @uotch
        WHERE [guid] = @guid AND [updated] <= @updated
END
GO



GRANT EXEC ON [AccountsSelectUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsInsertUnsynchronized] TO [gcsync]
GO

GRANT EXEC ON [AccountsUpdateUnsynchronized] TO [gcsync]
GO

/* ----------------------------------------------------------------------------- 
Новый текущий отчет  
----------------------------------------------------------------------------- */ 
ALTER PROCEDURE [dbo].[ReportCurrent] 
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
and (@LastShiftPoint<=SA.[start]) and (SA.[start]<=@NewShiftPoint) and (S.[idClients]=0) 
-- подсчет денег для аккаунтов 
-- добавлено 
select @AccountsAdded= ISNULL(Sum(AH.summa),0) from AccountsHistory as AH 
inner join users on (users.id=AH.operator) 
inner join usersgroup on (usersgroup.id=users.idUsersGroup) 
where (AH.What=0)   
and usersgroup.name='Staff' 
and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint) 
AND (users.name <> 'gcsync')
-- возвращено 
select @AccountsReturned =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH 
inner join users on (users.id=AH.operator) 
inner join usersgroup on (usersgroup.id=users.idUsersGroup) 
where (AH.[What]=1) 
and usersgroup.name='Staff' 
and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint)
AND (users.name <> 'gcsync')
-- проплачено 
select @AccountsPayed =  ISNULL(Sum(AH.[summa]),0) from AccountsHistory as AH 
where (AH.[What]=2) 
and (@LastShiftPoint<=AH.[moment]) and (AH.[moment]<=@NewShiftPoint) 
select @Time = ISNULL(sum(SA2.[summa]),0) - @Internet from sessions as S 
inner join SessionsAdd as SA on (SA.[idSessions] = S.[id]) 
inner join SessionsAdd2 as SA2 on (SA.[id] = SA2.[idSessionsAdd]) 
where (S.[postpay]=0) 
and (@LastShiftPoint<=SA2.[moment]) and (SA2.[moment]<=@NewShiftPoint) 
and S.[idClients]=0 
SELECT @Rest= SUM(Rest) FROM  
(SELECT S.[id], S.[CommonPay] + S.[SeparateTrafficPay] - S.[PrintCost] - S.[ServiceCost] 
- SUM(SA.[TimeCost]) - SUM(SA.[TrafficCost]) - SUM(SA.[SeparateTrafficCost]) Rest, S.[status] 
FROM Sessions AS S 
INNER JOIN SessionsAdd AS SA ON (S.[id] = SA.[idSessions]) 
WHERE S.PostPay = 0 
GROUP BY S.id, S.status, S.CommonPay, S.SeparateTrafficPay, S.PrintCost, S.ServiceCost) SS 
INNER JOIN SessionsAdd AS SA ON (SS.[id] = SA.[idSessions]) 
WHERE ((SA.[start] <= @NewShiftPoint) OR (SS.[status]=0)) AND (@NewShiftPoint < SA.[stop]) 
SET @Rest = ISNULL(@Rest, 0.0) 
GO

/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value] = '1.0.3', [Public] = 0 WHERE [key]='SyncOptions\Version'
GO

