USE GameClass
GO

/* -----------------------------------------------------------------------------
       Колонка для расчета неиспользованных денег
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'TimeCost' 
  AND id = object_id(N'[GameClass].[dbo].[SessionsAdd]')) 
ALTER TABLE [SessionsAdd] ADD [TimeCost] [money] NOT NULL DEFAULT (0)
GO

ALTER PROCEDURE SessionsInsert
@idComp int,
@idClients int,
@TimeCost money,
@start datetime,
@stop datetime,
@idTarif int,
@whole int,
@postpay int,
@description nvarchar(100),
@CommonPay money,
@state int,
@status int,
@moment datetime

AS

SET NOCOUNT ON

DECLARE @idSessions int
DECLARE @idSessionsAdd int

DECLARE @idUser int
SELECT @idUser = [id] FROM Users WHERE ([name] = system_user) AND ([isdelete]=0)

INSERT INTO Sessions ([idClients], [postpay], [description], [started], [CommonPay], [operator], [state], [status])
    VALUES ( @idClients, @postpay, @description, @start, @CommonPay, @idUser, @state, @status)
SELECT @idSessions = SCOPE_IDENTITY() -- get id of last inserted record

IF (@idClients <> 0)
BEGIN
  UPDATE Accounts SET [balance] = [balance] - @CommonPay WHERE [id] = @idClients
  UPDATE Accounts SET [summary] = [summary] + @CommonPay WHERE [id] = @idClients
END

INSERT INTO SessionsAdd ([idSessions], [idComp], [TimeCost], [Start], [Stop], [idTarif], [whole], [operator])
  VALUES (@idSessions, @idComp, @TimeCost, @start, @stop, @idTarif, @whole, @idUser)
SELECT @idSessionsAdd = SCOPE_IDENTITY() -- get id of last inserted record

INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
  VALUES (@idSessionsAdd, 0, @moment, @CommonPay)

SELECT @idSessions AS idSessions, @idSessionsAdd AS idSessionsAdd 
GO

ALTER PROCEDURE SessionsUpdate
@IdClient int,
@IdSessions int,
@IdSessionsAdd int,
@TimeCost money,
@CommonPayDiff money = 0,
@SeparateTrafficPayDiff money = 0,
@TrafficCostDiff money = 0,
@SeparateTrafficCostDiff money = 0,
@PrintCostDiff money = 0,
@ServiceCostDiff money = 0,
@TrafficDiff int = 0,
@AdditionalMinutesDiff int = 0,
@Stop datetime,
@Status int,
@State int,
@Moment datetime

AS 
BEGIN
    SET NOCOUNT ON

    DECLARE @idUser int
    SELECT @idUser = [id] FROM Users WHERE ([name] = system_user) AND ([isdelete]=0)

    IF (@CommonPayDiff <> 0) AND (dbo.CheckFunctionsRight('fnCompAdd') = -1) --SELECT * FROM Functions
    BEGIN
        -- добавляем новую запись в SessionsAdd2, ActionType = 1 (добавить денег)
        INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
                VALUES (@IdSessionsAdd, 1, @CommonPayDiff, @Moment)
        -- увеличиваем общую оплаченную сумму
        UPDATE Sessions SET [CommonPay] = [CommonPay] + @CommonPayDiff
                WHERE [id] = @IdSessions
        IF (@IdClient <> 0) 
        BEGIN
        UPDATE Accounts SET [balance] = [balance] - @CommonPayDiff WHERE [id] = @IdClient
        UPDATE Accounts SET [summary] = [summary] + @CommonPayDiff WHERE [id] = @IdClient
        INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  
            VALUES  (@IdClient, @Moment, 2, @CommonPayDiff, N'addtime',0)
        END
    END
    IF (@SeparateTrafficPayDiff <> 0) AND (dbo.CheckFunctionsRight('fnSessionTrafficPayment') = -1) --SELECT * FROM Functions
    BEGIN
       -- добавляем новую запись в SessionsAdd2, ActionType = 3 (добавить денег за трафик)
        INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [summa], [moment])
                VALUES (@IdSessionsAdd, 3, @SeparateTrafficPayDiff, @Moment)
        -- увеличиваем общую оплаченную сумму
        UPDATE Sessions SET [SeparateTrafficPay] = [SeparateTrafficPay] + @SeparateTrafficPayDiff
                WHERE [id] = @IdSessions
        IF (@IdClient <> 0) 
        BEGIN
        UPDATE Accounts SET [balance] = [balance] - @SeparateTrafficPayDiff WHERE [id] = @IdClient
        UPDATE Accounts SET [summary] = [summary] + @SeparateTrafficPayDiff WHERE [id] = @IdClient
        INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])  
            VALUES  (@IdClient, @Moment, 2, @SeparateTrafficPayDiff, N'traffic',0)
        END
    END
    IF (@AdditionalMinutesDiff < 0) AND (dbo.CheckFunctionsRight('fnPenalty') = -1) --SELECT * FROM Functions
        UPDATE Sessions SET [AdditionalMinutes] = [AdditionalMinutes] + @AdditionalMinutesDiff
                WHERE [id] = @IdSessions
    IF (@AdditionalMinutesDiff > 0) AND (dbo.CheckFunctionsRight('TimeBonus') = -1) --SELECT * FROM Functions
        UPDATE Sessions SET [AdditionalMinutes] = [AdditionalMinutes] + @AdditionalMinutesDiff
                WHERE [id] = @IdSessions
    -- корректируем количество и стоимость трафика, время останова
    UPDATE SessionsAdd SET [TrafficCost] = [TrafficCost] + @TrafficCostDiff, 
        [SeparateTrafficCost] = [SeparateTrafficCost] + @SeparateTrafficCostDiff,
        [Traffic] = [Traffic] + @TrafficDiff,
        [stop] = @Stop,
        [TimeCost] = @TimeCost
        WHERE [id] = @IdSessionsAdd
    -- корректируем стоимость печати и услуг, статус и состояние авторизации
    UPDATE Sessions SET [PrintCost] = [PrintCost] + @PrintCostDiff, 
        [ServiceCost] = [ServiceCost] + @ServiceCostDiff,
        [status] = @Status, [state] = @State
        WHERE [id] = @IdSessions
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SessionsUpdateTimeCost]') 
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE SessionsUpdateTimeCost
GO

CREATE PROCEDURE SessionsUpdateTimeCost
@IdSessionsAdd int,
@TimeCost money

AS 
BEGIN
    SET NOCOUNT ON

    UPDATE SessionsAdd SET [TimeCost] = @TimeCost WHERE [id] = @IdSessionsAdd
END
GO

GRANT EXEC ON [SessionsUpdateTimeCost] TO public
GO

ALTER PROCEDURE SessionsChangeTariff
@idSessionsAdd int,
@idTarif int,
@CurrentTime datetime,
@NewTariffStop datetime,
@MoneyLeft money, --сумма стоимости последнего тарифа без учета принтера и трафика
@TimeCost money
    
AS 

SET NOCOUNT ON

DECLARE @postpay int
DECLARE @idSessions int
DECLARE @idSessionsAdd2 int
DECLARE @idComp int
DECLARE @dtRealPayment datetime

SELECT @idSessions = [idSessions] FROM SessionsAdd WHERE [id] = @idSessionsAdd
SELECT @idComp = [idComp] FROM SessionsAdd WHERE [id] = @idSessionsAdd
SELECT @postpay = [postpay] FROM Sessions WHERE [id] = @idSessions
SELECT TOP 1 @idSessionsAdd2 = [id] FROM SessionsAdd2 WHERE [idSessionsAdd] = @idSessionsAdd 
  AND [ActionType] = 0 ORDER BY [id] DESC
SELECT @dtRealPayment = [moment] FROM SessionsAdd2 WHERE [id] = @idSessionsAdd2

UPDATE SessionsAdd SET [stop] = @CurrentTime, [TimeCost] = @TimeCost WHERE [id] = @idSessionsAdd
UPDATE SessionsAdd2 SET [summa] = [summa] - @MoneyLeft WHERE [id] = @idSessionsAdd2

DECLARE @idMe int
SELECT @idMe = [id] FROM Users WHERE ([name] = SYSTEM_USER) AND ([isdelete]=0)

INSERT INTO SessionsAdd ([idSessions], [idComp], [idTarif], [Start], [Stop], [whole],  [operator])
    VALUES (@idSessions, @idComp, @idTarif, @CurrentTime, @NewTariffStop, 0, @idMe)
SELECT @idSessionsAdd = @@IDENTITY -- get id of last inserted record

--время реально оплаты, иначе попадает в лругую смену
INSERT INTO SessionsAdd2 ([idSessionsAdd], [ActionType], [moment], [summa])
   VALUES (@idSessionsAdd, 0, @dtRealPayment, @MoneyLeft)

SELECT  @idSessionsAdd AS idSessionsAdd
GO

/* -----------------------------------------------------------------------------
            Определение отчета для оператора или админа по дереву отчетов
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[IsSpecialReportOrFolder]') 
  and xtype in (N'FN', N'IF', N'TF'))
  drop function [dbo].[IsSpecialReportOrFolder]
GO

CREATE FUNCTION [IsSpecialReportOrFolder] (
  @idReport int
)
  RETURNS int

AS
BEGIN 
  IF @idReport IS NULL RETURN 0
  IF (@idReport = 1) OR (@idReport = 2) RETURN 1
  IF @idReport < 20 RETURN 0
  DECLARE @idParentReport int
  SELECT @idParentReport = ParentId FROM Reports
    WHERE [id] = @idReport
  RETURN [dbo].IsSpecialReportOrFolder(@idParentReport)
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[IsSpecialReport]') 
  and xtype in (N'FN', N'IF', N'TF'))
  drop function [dbo].[IsSpecialReport]
GO

CREATE FUNCTION [IsSpecialReport] (
  @idReport int
)
  RETURNS int

AS
BEGIN 
  DECLARE @IsFolder int
  SELECT @IsFolder = IsFolder FROM Reports
    WHERE [id] = @idReport
  IF (ISNULL(@IsFolder, 1) = 0) AND ([dbo].IsSpecialReportOrFolder(@idReport) = 1) RETURN 1
  RETURN 0
END
GO

/* -----------------------------------------------------------------------------
          Обновление триггера для дерева отчетов
----------------------------------------------------------------------------- */
ALTER TRIGGER ReportsUpdate ON [dbo].[Reports]

FOR INSERT, UPDATE, DELETE
AS
BEGIN
  DECLARE @id int
  DECLARE @Code varchar(8000)
  DECLARE @ProcName varchar(100)
  DECLARE @idParent int
  DECLARE @Invariable int

  DECLARE Dcursor CURSOR FOR SELECT DISTINCT [id] 
    FROM 
    (SELECT [id] FROM DELETED WHERE dbo.IsSpecialReport([id]) = 1
    UNION ALL 
    SELECT [id] FROM INSERTED WHERE dbo.IsSpecialReport([id]) = 1) IDTable
  OPEN Dcursor
  FETCH NEXT FROM Dcursor INTO @id

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @ProcName = 'CustomReport' + CONVERT(varchar(5),@id) + 'Execute'
    SET @Code = 'if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].['
    SET @Code = @Code + @ProcName + ']'') and OBJECTPROPERTY(id, N''IsProcedure'') = 1)'
    SET @Code = @Code + 'drop procedure [dbo].[' + @ProcName + ']'
    EXEC (@Code)
    FETCH NEXT FROM Dcursor INTO @id
  END

  CLOSE Dcursor
  DEALLOCATE Dcursor

  DECLARE Icursor CURSOR FOR SELECT [id] FROM INSERTED WHERE dbo.IsSpecialReport([id]) = 1
  OPEN Icursor
  FETCH NEXT FROM Icursor INTO @id

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @Code = CONVERT(varchar(8000),[Code]), @idParent = ParentID, @Invariable = Invariable FROM Reports WHERE [id] = @id
    IF LEN(@Code) > 0 
    BEGIN
      SET @Code = REPLACE(@Code, '%TIME-CURRENT%', '@Current')
      SET @Code = REPLACE(@Code, '%TIME-START%', '@Begin')
      SET @Code = REPLACE(@Code, '%TIME-STOP%', '@End')
      SET @Code = REPLACE(@Code, '%SHIFT-BEGIN%', '@CurrentShiftBegin')
      SET @Code = REPLACE(@Code, '%SHIFT2-BEGIN%', '@PrevShiftBegin')
      SET @Code = REPLACE(@Code, '%SHIFT2-END%', '@PrevShiftEnd')
      SET @ProcName = 'CustomReport' + CONVERT(varchar(5),@id) + 'Execute'
      SET @Code = 'CREATE PROCEDURE ' + @ProcName + '
@Current datetime,
@Begin datetime,
@End datetime,
@CurrentShiftBegin datetime,
@PrevShiftBegin datetime,
@PrevShiftEnd datetime

AS
SET NOCOUNT ON
' + CASE WHEN @Invariable <> 1 THEN 'IF dbo.GetCustomReportParentId() = ' + CONVERT(varchar(5),@idParent) ELSE ' ' END + '
BEGIN
' + @Code + '
END
'
      EXEC (@Code)
      SET @Code = 'GRANT EXEC ON [' + @ProcName + '] TO public'
      EXEC (@Code)
    END
    FETCH NEXT FROM Icursor INTO @id
  END

  CLOSE Icursor
  DEALLOCATE Icursor
END
GO

/* -----------------------------------------------------------------------------
			      Новый текущий отчет 
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

select @Time = ISNULL(sum(SA2.[summa]),0) from sessions as S
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
            Корректируем
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetLastOperatorName]') 
  and xtype in (N'FN', N'IF', N'TF'))
  drop function [dbo].[GetLastOperatorName]
GO


CREATE FUNCTION [GetLastOperatorName] ()
  RETURNS varchar(50)

AS
BEGIN 
  DECLARE @LastOperatorName varchar(50)
  SELECT @LastOperatorName = [Value] FROM Registry
    WHERE [Key] = 'LastOperatorName'
  SET @LastOperatorName = ISNULL(@LastOperatorName, '')
  RETURN @LastOperatorName
END
GO

GRANT EXEC ON [GetLastOperatorName] TO public
GO

DELETE FROM  REPORTS WHERE id = 20
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomReport20Execute]') 
  and OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE CustomReport20Execute
GO

SET IDENTITY_INSERT [Reports] ON
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID], [Invariable])
  VALUES(20, 'Текущий отчет', '  
  declare @LastShiftPoint datetime
  declare @Time money
  declare @Services money
  declare @Print money
  declare @Internet money
  declare @AccountsAdded money
  declare @AccountsPayed money
  declare @AccountsReturned money
  declare @Rest money
  declare @ReportString varchar(100)
  
  if object_id(''tempdb..#t20'') is not null   
  DROP TABLE #t20 
  
  CREATE TABLE #t20 (   
  [Name] varchar(100),   
  [Value] varchar(50)   
  ) ON [PRIMARY]   
  
  EXEC ReportCurrent %TIME-CURRENT%, @LastShiftPoint OUTPUT, @Time OUTPUT, @Services OUTPUT, @Print OUTPUT, @Internet OUTPUT, 
    @AccountsAdded OUTPUT, @AccountsPayed OUTPUT, @AccountsReturned OUTPUT, @Rest OUTPUT 
  
  DECLARE @TotalReceipts money
  SET @TotalReceipts = @Time + @Services + @Print + @Internet + @AccountsAdded - @AccountsReturned
  DECLARE @RemovedMoney money
  SELECT @RemovedMoney = ISNULL(CONVERT(money, Value), 0.0) FROM Registry WHERE [Key]=''RemovedMoney''
  
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentHeader''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentBegin''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@LastShiftPoint, 20))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentEnd''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),GETDATE(), 20))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentOperator''

  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, dbo.GetLastOperatorName())
  INSERT INTO #t20([Name], [Value]) VALUES ('''', '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTotal''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTime''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Time))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentServices''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Services))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentPrint''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Print))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentInternet''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Internet))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentAccountsAdded''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@AccountsAdded))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentAccountsPayed''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@AccountsPayed))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentAccountsReturned''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@AccountsReturned))
  INSERT INTO #t20([Name], [Value]) VALUES ('''', '''')
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTotalSum''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@TotalReceipts))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentOperatorSum''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@TotalReceipts 
  - @RemovedMoney))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentManagerSum''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@RemovedMoney))
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentRest''
  INSERT INTO #t20([Name], [Value]) VALUES (@ReportString, CONVERT(varchar(50),@Rest))
  SELECT * FROM #t20
  if object_id(''tempdb..#t20'') is not null   
  DROP TABLE #t20 
', 'Текущий отчет оператора', 0, 1, 1, 'NodaSoft',1,'431B783B-C9D0-4241-8B26-2C5F42B3B30D', 1)
SET IDENTITY_INSERT [Reports] OFF
GO

/* -----------------------------------------------------------------------------
                 Изменяемая цена на услуги
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'Cost' and id = object_id(N'[GameClass].[dbo].[Services]')) 
ALTER TABLE [Services] ADD [Cost] [money] NOT NULL DEFAULT (0)
GO

UPDATE S SET S.[Cost] = SB.[price] FROM Services S
  INNER JOIN ServicesBase SB ON SB.[id] = S.[idServicesBase]
GO

ALTER VIEW dbo.repServices 

AS 
SELECT    
 Users.[name] AS operator, 
 ServicesBase.[name], 
 Services.[count], 
 Services.[cost] price, 
 Services.[moment],
 Services.[cost]*Services.[count] AS summa,
 Services.[TypeCost],
 Computers.[number] as ComputerNumber,
 Accounts.[name] as UserName
FROM Services
 INNER JOIN ServicesBase ON ServicesBase.[id] = Services.[idServicesBase]
 INNER JOIN Users ON Services.[operator] = Users.[id]
 LEFT OUTER JOIN Computers ON Computers.[id] = Services.[idComputer]
 LEFT OUTER JOIN Accounts ON Accounts.[id] = Services.[idAccount]
GO

ALTER PROCEDURE ServiceToSell
@idService int,
@count int,
@now datetime,
@idComputer int,
@idAccount int,
@TypeCost int,
@UseCustomCost int = 0,
@CustomCost money = 0

AS 
BEGIN
  set nocount on

  declare @idMe int
  select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)
	if (@idComputer = -1) set @idComputer = NULL
	if (@idAccount = -1) or (@idAccount = 0) set @idAccount = NULL
  DECLARE @Cost money
  IF (@UseCustomCost = 0) 
    BEGIN
      SELECT @Cost = price FROM ServicesBase WHERE [id] = @idService
      SET @Cost = ISNULL(@Cost, 0)
    END
  ELSE
    SET @Cost = @CustomCost
  insert into Services ([idServicesBase], [count], [operator], [moment], 
    [idComputer], [idAccount], [TypeCost], [Cost]) 
    values (@idService, @count, @idMe, @now, @idComputer, @idAccount, @TypeCost, @Cost)
END
GO

/* -----------------------------------------------------------------------------
                    Цена на печать из pm_costs
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PMJobs]') 
  and xtype in (N'FN', N'IF', N'TF'))
  drop function [dbo].[PMJobs]
GO

CREATE FUNCTION PMJobs (
  @id int = -1,
  @Unprocessed int = 0
)
RETURNS @PMJobs TABLE (
	[id] [int] NOT NULL,
	[idPrinter] [int] NOT NULL ,
	[idUser] [int] NOT NULL ,
	[idComputer] [int] NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[jid] [int] NOT NULL ,
	[doc] [varchar] (1024) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[tbytes] [int] NOT NULL ,
	[tpages] [int] NOT NULL ,
	[pbytes] [int] NOT NULL ,
	[ppages] [int] NOT NULL ,
	[copies] [int] NOT NULL ,
	[isColor] [tinyint] NOT NULL ,
	[isDuplex] [tinyint] NOT NULL ,
	[format] [char] (64) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isDelete] [tinyint] NOT NULL ,
	[isOk] [tinyint] NOT NULL ,
	[comment] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL ,
	[isVisible] [tinyint] NOT NULL ,
	[PaperWidth] [int] NOT NULL ,
	[PaperLength] [int] NOT NULL ,
	[SPLFormat] [varchar] (64) COLLATE Cyrillic_General_CI_AS NULL ,
	[SPLFileName] [varchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
	[ip] [varchar] (64) COLLATE Cyrillic_General_CI_AS NOT NULL,
	[printer] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL,
	[user] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL,
	[status] [varchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL,
        [Cost] [money] NOT NULL
)

AS
BEGIN
  DECLARE @GCCost money
  SELECT @GCCost = CAST(REPLACE([value], ',', '.') AS money) FROM [Registry] WHERE [key] = N'printers\DefaultPrinter'
  SET @GCCost = ISNULL(@GCCost, 1)
  DECLARE @UsePMCosts int
  SELECT @UsePMCosts = CONVERT(int, Value) FROM Registry WHERE [Key] = 'printers\UsePMCosts'
  DECLARE @ScanId INT
  SELECT @ScanId = CAST([value] as INT) FROM Registry WHERE [key] = 'PrinterScanId'
  SET @ScanId = ISNULL(@ScanId, 0)
  IF ISNULL(@UsePMCosts, 0) = 0
    BEGIN
      INSERT @PMJobs SELECT jobs.*, @GCCost Cost FROM jobs
        WHERE ((([id] = @id) OR (@id IS NULL)) AND (@Unprocessed = 0))
              OR (([id] > @ScanId) AND (@Unprocessed <> 0))
        ORDER BY [id] asc
    END
  ELSE
    BEGIN
      INSERT @PMJobs SELECT J.*, 
        ISNULL(CASE WHEN (isColor = 0) AND (isDuplex = 0) THEN C.BW
        WHEN (isColor = 0) AND (isDuplex <> 0) THEN C.DuplexBW
        WHEN (isColor <> 0) AND (isDuplex = 0) THEN C.Color
        ELSE C.DuplexColor
        END, @GCCost) Cost FROM jobs J
        LEFT OUTER JOIN _pm_costs C ON (J.idPrinter = C.idPrinter) AND (J.format = C.Format) 
        WHERE ((([id] = @id) OR (@id IS NULL)) AND (@Unprocessed = 0))
              OR (([id] > @ScanId) AND (@Unprocessed <> 0))
        ORDER BY [id] asc
    END
  RETURN  
END
GO

ALTER PROCEDURE PMJobsSelect
  @id INT = -1

AS 
BEGIN
  SELECT * FROM dbo.PMJobs(@id, 0)
END
GO

ALTER PROCEDURE PMJobsSelectUnprocessed

AS 
BEGIN
  SELECT * FROM dbo.PMJobs(0, 1)
END
GO

/* -----------------------------------------------------------------------------
			   Обновление вьюшки repDeatils
----------------------------------------------------------------------------- */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[repDetails]') 
         and OBJECTPROPERTY(id, N'IsView') = 1)
    drop view [dbo].[repDetails]
GO

CREATE VIEW dbo.repDetails 
   
AS 
SELECT TOP 100 PERCENT 
 Computers.[ipaddress],
 Tarifs.[name],
 SA.[Start],
 SA.[Stop], 
 SA2.[moment],
 SA2.[summa],
 DATEDIFF(minute, SA.[Start], SA.[Stop]) AS length,
 Users.[Name] AS operator,
 S.[description],
 Computers.[number],
 S.[PrintCost],
 S.[AdditionalMinutes],
 sum(SA.[Traffic]) AS [Traffic],
 sum(SA.[TrafficCost]) AS [TrafficCost],
 sum(SA.[SeparateTrafficCost]) AS [SeparateTrafficCost],
 S.[idClients],
 A.[name] AS AccountName
FROM Sessions AS S
 INNER JOIN SessionsAdd AS SA ON SA.[idSessions] = S.[id]
 INNER JOIN SessionsAdd2 AS SA2 ON SA2.[idSessionsAdd] = SA.[id]
 INNER JOIN Tarifs ON Tarifs.[id] = SA.[idTarif]
 INNER JOIN Computers ON SA.[idComp] = Computers.[id]
 INNER JOIN Users ON Users.[id] = S.[operator]
 INNER JOIN Accounts A ON A.[id] = S.[idClients]
WHERE 
  (SA.[idTarif] <> 0) AND (S.[postpay] = 0)
GROUP BY 
 Computers.[ipaddress],
 Tarifs.[name],
 SA.[Start],
 SA.[Stop], 
 SA2.[moment],
 SA2.[summa],
 Users.[Name],
 S.[description],
 Computers.[number],
 S.[PrintCost],
 S.[AdditionalMinutes],
 S.[idClients],
 A.[name]
ORDER BY SA.[Start]
GO

/* -----------------------------------------------------------------------------
                          Главный и детальный отчеты
----------------------------------------------------------------------------- */
DELETE FROM Reports WHERE id IN (50, 51)
GO

SET IDENTITY_INSERT [Reports] ON
INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID], [Invariable])
  VALUES(50, 'Главный отчет', '
if object_id(''tempdb..#t50'') is not null 
  DROP TABLE #t50

declare @sum money
declare @dopsumma money
declare @repair int
declare @uncontrol int
declare @uncontrolClub int
declare @AccountsAdded money
declare @AccountsReturned money
declare @AccountsPayed money
declare @PrinterPayed money
declare @TrafficCost money
declare @OperatorTraffic numeric(12,2)
set @sum=0
set @repair=0
set @uncontrol=0
set @uncontrolClub=0
set @dopsumma=0
select @sum=sum(summa) from repDetails where (moment>=%TIME-START%) and (moment<=%TIME-STOP%) and idClients=0
select @repair=sum(length) from repRepair where (moment>=%TIME-START%) and (moment<=%TIME-STOP%)
select @uncontrol=sum(length)  from repUncontrol where (repUncontrol.start>=%TIME-START%) and (repUncontrol.stop<=%TIME-STOP%)
select @uncontrolClub=sum(length) from repUncontrolClub where (repUncontrolClub.start>=%TIME-START%) and  (repUncontrolClub.stop<=%TIME-STOP%)
select @dopsumma = sum(count*price) from [repServices]
where (repServices.moment between %TIME-START% and %TIME-STOP%) and (TypeCost = 1)

set @sum=isnull(@sum,0)
set @repair=isnull(@repair,0)
set @uncontrol=isnull(@uncontrol,0)
set @uncontrolClub=isnull(@uncontrolClub,0)
set @dopsumma=isnull(@dopsumma,0)

select @AccountsAdded= ISNULL(Sum(AH.summa),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
where (AH.What=0)
 and usersgroup.name=''Staff''
and (%TIME-START%<=AH.moment) and (AH.moment<=%TIME-STOP%)

select @AccountsReturned=ISNULL(Sum(AH.summa),0) from AccountsHistory as AH
 inner join users on (users.id=AH.operator)
 inner join usersgroup on (usersgroup.id=users.idUsersGroup)
where (AH.What=1)
 and usersgroup.name=''Staff''
and (%TIME-START%<=AH.moment) and (AH.moment<=%TIME-STOP%)

select @AccountsPayed=ISNULL(sum(summa),0) from repDetails where (moment>=%TIME-START%)  and (moment<=%TIME-STOP%) and idClients<>0

select @PrinterPayed=ISNULL(sum(PrintCost),0) from Sessions
  where (started>=%TIME-START%)  and (started<=%TIME-STOP%)

select @TrafficCost=ISNULL(sum(SA.TrafficCost), 0)
from Sessions S
 inner join SessionsAdd SA on (S.id = SA.idSessions)
where
 S.[started] > %TIME-START% and S.[started] < %TIME-STOP%

select @OperatorTraffic=sum(CAST(traffic as numeric(12,2)))/1024/1024
from JournalOp
where [moment] > %TIME-START% and [moment] < %TIME-STOP%

DECLARE @ReportString varchar(100)

CREATE TABLE #t50 (
[id] [int] IDENTITY (1, 1) NOT NULL ,
[Name] varchar(100),
[Value] varchar(50)
) ON [PRIMARY]
  SELECT @ReportString = [Value] FROM Registry WHERE [Key] = ''ReportStrings\CurrentTotalSum''
  INSERT INTO #t50 ([Name], [Value]) VALUES (@ReportString, 
  CONVERT(varchar(50),@sum+@dopsumma+@AccountsAdded-@AccountsReturned, 20) )
INSERT INTO #t50 ([Name], [Value]) VALUES (N'''', '''')
INSERT INTO #t50 ([Name], [Value]) VALUES (N''За оплату компьютеров'', CAST ( @sum AS varchar(50)) )
INSERT INTO #t50 ([Name], [Value]) VALUES (N''За оплату услуг'', CAST ( @dopsumma AS varchar(50)) )
INSERT INTO #t50 ([Name], [Value]) VALUES (N''За трафика'', CAST ( @TrafficCost AS varchar(50)))
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Добавлено на счета учетных записей'', CAST ( @AccountsAdded AS varchar(50)))
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Возвращено со счетов учетных записей'', CAST ( @AccountsReturned AS varchar(50)))
INSERT INTO #t50 ([Name], [Value]) VALUES (N'''', '''')
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Проплачено со счетов учетных записей'', CAST ( @AccountsPayed AS varchar(50)))
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Оплачено за печать'', CAST ( @PrinterPayed AS varchar(50)))
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Потрачено на ремонт (минут)'', @repair)
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Не было контроля компьютеров (минут)'', @uncontrol)
INSERT INTO #t50 ([Name], [Value]) VALUES (N''Не был запущен GameClass (минут)'', @uncontrolClub)
SELECT [Name] [Описание], [Value] [Значение] FROM #t50 order by [id] asc
if object_id(''tempdb..#t50'') is not null 
  DROP TABLE #t50
if object_id(''tempdb..#t50'') is not null 
  DROP TABLE #t50
', 'Главный отчет менеджера', 0, 0, 5, 'NodaSoft',1,'431B783B-C9D0-4241-8B26-2C5F42B3B30A', 0)


INSERT INTO [Reports]([id], [Name], [Code], [Description], [IsFolder], [ParentId], [OrderIndex], [Author], [Version], [GUID], [Invariable])
  VALUES(51, 'Детальный отчет', '
if object_id(''tempdb..#t51'') is not null DROP TABLE #t51

CREATE TABLE #t51 (
 [№] [varchar] (3) COLLATE Cyrillic_General_CI_AS NULL,
 [IP] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
 [Тариф] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
 [Начало] [datetime] NULL,
 [Конец] [datetime] NULL,
 [Время] [datetime] NULL,
 [Сумма] [numeric] (12,2) NULL,
 [Длительность] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL,
 [Оператор] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
 [Комментарий] [varchar] (30) COLLATE Cyrillic_General_CI_AS NULL,
 [Трафик в МБ] [numeric] (12,2) NULL,
 [Трафик в $] [numeric] (12,2) NULL,
 [Штраф] [varchar] (3) COLLATE Cyrillic_General_CI_AS NULL,
 [idClient] [int],
 [Клиент] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]

insert into #t51
select
 number,
 convert(varchar(15), ipaddress),
 convert(varchar(15), name),
 start,
 stop,
 moment,
 convert(numeric(12,2) ,CAST(summa as money)),
 convert(varchar(5), (case WHEN (length > 0) THEN length ELSE 0 END)),
 convert(varchar(10), operator),
 convert(varchar(30), description),
 convert(numeric(12,2) ,Traffic)/1024/1024,
 convert(numeric(12,2) ,TrafficCost + SeparateTrafficCost),
 convert(varchar(3), -AdditionalMinutes),
 idClients,
 convert(varchar(15), AccountName)
from
 [repDetails]
where
 [moment] between %TIME-START% and %TIME-STOP%
order by
 [moment]

select
 [№],
 [Тариф],
 [Время],
 [Начало],
 [Конец],
 [Длительность],
 [Трафик в МБ],
 [Трафик в $],
 [Сумма],
 [idClient],
 [Клиент],
 [Штраф],
 [Оператор],
 [IP],
 [Комментарий]
from
 #t51
', 'Детальный отчет менеджера', 0, 0, 6, 'NodaSoft',1,'431B783B-C9D0-4241-8B26-2C5F42B3B30E', 0)
SET IDENTITY_INSERT [Reports] OFF
GO

