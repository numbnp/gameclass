USE GameClass
GO


/* -----------------------------------------------------------------------------
			      Ќовый текущий отчет 
----------------------------------------------------------------------------- */
ALTER PROCEDURE ReportCurrent
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

-- тут нужно получить момент последнего завершени€ смены
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

-- подсчет денег дл€ аккаунтов
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
   олонки дл€ отдельно настраиваемых ограничений по суммам внутри тарифа
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'useseparatesumm' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [useseparatesumm] [int] NOT NULL DEFAULT (0)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'startmoneymin' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [startmoneymin] [int] NOT NULL DEFAULT (1)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'startmoneymax' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [startmoneymax] [int] NOT NULL DEFAULT (100)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'addmoneymin' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [addmoneymin] [int] NOT NULL DEFAULT (1)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'addmoneymax' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [addmoneymax] [int] NOT NULL DEFAULT (100)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'maximumtrust' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [maximumtrust] [int] NOT NULL DEFAULT (200)
GO

ALTER PROCEDURE TarifsUpdate
@idTarif int,
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int,
@BytesInMB int,
@SpeedLimitInKB int,
@PluginGroupName nvarchar(50),
@userlevel int,
@useseparatesumm int,
@startmoneymin int,
@startmoneymax int,
@addmoneymin int,
@addmoneymax int,
@maximumtrust int
  
AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
         [roundmoney]=@roundmoney, [idGroup]=@idGroup, [BytesInMB]=@BytesInMB,
    [SpeedLimitInKB]=@SpeedLimitInKB, [PluginGroupName]=@PluginGroupName, [userlevel]=@userlevel,
	[useseparatesumm]=@useseparatesumm,
	[startmoneymin]=@startmoneymin,
	[startmoneymax]=@startmoneymax,
	[addmoneymin]=@addmoneymin,
	[addmoneymax]=@addmoneymax,
	[maximumtrust]=@maximumtrust
    where [id]=@idTarif
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetShiftPoint]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetShiftPoint]
GO

CREATE PROCEDURE GetShiftPoint
@NewShiftPoint datetime
AS 

set nocount on

-- тут нужно получить момент последнего завершени€ смены
if exists (select * from JournalOp)  
 select top 1 [JournalOp].[moment] as value from JournalOp where ([JournalOp].[moment]<@NewShiftPoint) order by [moment] desc
else
 select top 1 SA.[start] as value from SessionsAdd as SA order by SA.[start]

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[GetShiftPoint]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


/* -----------------------------------------------------------------------------
   олонки уровн€ доступа оператора
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'seclevel' 
  AND id = object_id(N'[GameClass].[dbo].[Users]')) 
ALTER TABLE [Users] ADD [seclevel] [int] NOT NULL DEFAULT (1)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'operatorlevel' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [operatorlevel] [int] NOT NULL DEFAULT (1)
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[UsersChangeSecLevel]') 
        AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[UsersChangeSecLevel]
GO

CREATE PROCEDURE UsersChangeSecLevel
@login_name nvarchar(50),
@seclevel INT
AS 

/*  проверка на наличие такого пользовател€ */
if not exists (select [id] from Users where [name]=@login_name and [isdelete]=0)
begin
 raiserror 50000 'User not exist!'
 return 50000
end

UPDATE Users SET [seclevel] = @seclevel WHERE [name] = @login_name
GO

ALTER PROCEDURE [dbo].[UsersCreate]  
	@login_name NVARCHAR(50),  
	@group_name NVARCHAR(50),  
	@password NVARCHAR(50),  
	@seclevel INT  
AS   
BEGIN  
	DECLARE @error_descr VARCHAR(400)  
	DECLARE @idGroup INT  
	SELECT @idGroup=[id] FROM UsersGroup WHERE [name]=@group_name  
	/*  проверка на наличие пользовател€ с таким же именем */  
	IF EXISTS(SELECT [id] FROM Users WHERE [name]=@login_name AND [isdelete]=0)  
	BEGIN  
		RAISERROR 50000  'User already exist!'  
		RETURN 50000  
	END
	DECLARE @err1 INT  
	DECLARE @err2 INT  
	DECLARE @err3 INT  
	IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[tempdb]..[#msver]') )  
		DROP TABLE #msver  
	DECLARE @MSSQLVERSION INT  
	SELECT @MSSQLVERSION=CAST(REPLACE(LEFT(CAST(SERVERPROPERTY('ProductVersion')AS VARCHAR(20)),2),'.','') as INT); 
	if (@MSSQLVERSION=0) 
	BEGIN 
		CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200))  
		INSERT INTO #msver EXEC master..xp_msver ProductVersion  
		SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver  
		DROP TABLE #msver  
	END 
	DECLARE @sql VARCHAR(400)  
	SET @err1 = 0 

	IF (@MSSQLVERSION = 8)   
	EXEC @err1=master.dbo.sp_addlogin @login_name  

	IF (@MSSQLVERSION = 9)   
	BEGIN  
		SET @sql = 'CREATE LOGIN [' + @login_name + '] WITH PASSWORD = '''', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'  
		EXEC (@sql)  
	END

	IF (@MSSQLVERSION = 10)   
	BEGIN  
		SET @sql = 'CREATE LOGIN [' + @login_name + '] WITH PASSWORD = '''', CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF'  
		EXEC (@sql)  
	END  

	EXEC @err2=sp_adduser @login_name, @login_name, 'public'  
	IF (@group_name='Management')  
		EXEC @err3=sp_addsrvrolemember @login_name, 'sysadmin'  
	IF (@err1<>0) OR (@err2<>0)  
	BEGIN  
		RAISERROR 50000 'ќшибка создани€ пользовател€'  
		RETURN 50000  
	END  
	INSERT INTO Users ([name], [idUsersGroup], [seclevel]) VALUES (@login_name,@idGroup,@seclevel)  
	EXEC UsersChangePass @login_name, @password  
END  
GO

ALTER PROCEDURE TarifsUpdate
@idTarif int,
@name nvarchar(100),
@internet int,
@calctraffic int,
@roundtime int,
@roundmoney money,
@idGroup int,
@BytesInMB int,
@SpeedLimitInKB int,
@PluginGroupName nvarchar(50),
@userlevel int,
@operatorlevel int,
@useseparatesumm int,
@startmoneymin int,
@startmoneymax int,
@addmoneymin int,
@addmoneymax int,
@maximumtrust int
AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
         [roundmoney]=@roundmoney, [idGroup]=@idGroup, [BytesInMB]=@BytesInMB,
    [SpeedLimitInKB]=@SpeedLimitInKB, [PluginGroupName]=@PluginGroupName, [userlevel]=@userlevel,
	[operatorlevel]=@operatorlevel,
	[useseparatesumm]=@useseparatesumm,
	[startmoneymin]=@startmoneymin,
	[startmoneymax]=@startmoneymax,
	[addmoneymin]=@addmoneymin,
	[addmoneymax]=@addmoneymax,
	[maximumtrust]=@maximumtrust
    where [id]=@idTarif
GO

ALTER PROCEDURE GetLogonInfo
@id int,
@Value bigint
AS
BEGIN
  SET NOCOUNT ON
    DECLARE @isManager int
    DECLARE @idGroup int
    DECLARE @UserLevel int
  
    SET @isManager = 0
    SET @idGroup = -1
    SELECT @idGroup = [idUsersGroup] FROM Users WHERE ([name] = SYSTEM_USER) AND ([isdelete]=0)
    SELECT @UserLevel = [seclevel] FROM Users WHERE ([Name] = SYSTEM_USER) AND ([isdelete]=0)

    IF (@idGroup = 2)
      SET @isManager = 1
    SELECT GETDATE(), CAST(@isManager AS bit), @UserLevel
END
GO


/* -----------------------------------------------------------------------------
   олонка назначенного тарифа
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'force_tariff' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [force_tariff] [int] NOT NULL DEFAULT (-1)
GO


ALTER PROCEDURE AccountsUpdate
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
@address nvarchar(300)=N'',
@summary money,
@PeriodOfValidity int = 0,
@ExpirationDate datetime,
@assigntarif int,
@userlevel int,
@force_tariff int

AS 

IF (EXISTS (SELECT * FROM Accounts WHERE ([name]=@name) AND (@name <> N'') AND ([id]<>@id) AND ([isdeleted]=0))) BEGIN
  RAISERROR 50001 'Account already exists! Choose other name...'
  RETURN 50001
END

IF (EXISTS (SELECT * FROM Accounts WHERE [id] = @id AND [isdeleted] = 0)) BEGIN
 UPDATE Accounts SET
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
  [address] = @address,
  [summary] = @summary,
  [PeriodOfValidity] = @PeriodOfValidity,
  [ExpirationDate] = @ExpirationDate,
  [assigntarif] = @assigntarif,
  [userlevel] = @userlevel,
  [force_tariff] = @force_tariff
  WHERE [id] = @id
END
GO


/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.2' WHERE [key]='BaseVersion'
GO


