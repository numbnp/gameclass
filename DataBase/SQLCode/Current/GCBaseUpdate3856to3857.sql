USE GameClass
GO

/* -----------------------------------------------------------------------------
				Добавляем поле с громкостью в тарифы
----------------------------------------------------------------------------- */

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'forcedvolume' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [forcedvolume]  [int] NOT NULL DEFAULT (-1)
GO

/* -----------------------------------------------------------------------------
				Обновляем процедуру сохранения тарифа
----------------------------------------------------------------------------- */


USE [GameClass]
GO
/****** Объект:  StoredProcedure [dbo].[TarifsUpdate]    Дата сценария: 02/04/2013 09:43:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[TarifsUpdate] 
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
@maximumtrust int,
@forcedvolume int
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
	[maximumtrust]=@maximumtrust,
	[forcedvolume]=@forcedvolume 
where [id]=@idTarif 
GO


/* ---------------------------------------------------------------------------------------------------------------------------------------
                               Создаем процедуры для работы с временем последнего использования акка
------------------------------------------------------------------------------------------------------------------------------------------ */


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsGetLastUsed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsGetLastUsed]
GO

CREATE PROCEDURE [dbo].[AccountsGetLastUsed] 
@id INT = NULL 
AS  
BEGIN 
	SELECT TOP 1 AccountsHistory.moment FROM AccountsHistory  
		WHERE (idAccounts = @id) AND (what >= 2)
		ORDER BY [moment] DESC 
END 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsGetLastUsed]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsHistoryInsert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsHistoryInsert]
GO


CREATE PROCEDURE [dbo].[AccountsHistoryInsert] 
@idAccount INT = NULL,
@moment datetime,
@what	INT,
@summa money,
@comment nvarchar(200)=''
 
AS  
BEGIN 
	declare @idMe int 
	select @idMe = [id] from Users where ([name] = system_user) and ([isdelete]=0)

	INSERT INTO AccountsHistory  ([idAccounts], [moment], [what], [summa], [comment], [operator])   
		VALUES  (@idAccount, @moment, @what, @summa, @comment,@idMe) 
END 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsHistoryinsert]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/* -----------------------------------------------------------------------------
				Добавляем поле с "Железным" кодом авторизации в акки
----------------------------------------------------------------------------- */

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'hardcode' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [hardcode]  [nvarchar](50) NOT NULL DEFAULT (N'')
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'ignorehardcode' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [ignorehardcode]  [int] NOT NULL DEFAULT (1)
GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsGetIdByHardCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsGetIdByHardCode]
GO


CREATE PROCEDURE [dbo].[AccountsGetIdByHardCode]  
@hardcode nvarchar(200)='' 
AS   
BEGIN  
	SELECT TOP 1 Accounts.id FROM Accounts
		WHERE (hardcode = @hardcode) 
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsGetIdByHardCode]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AccountsUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[AccountsUpdate]
GO

CREATE PROCEDURE [dbo].[AccountsUpdate] 
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
@force_tariff int, 
@referal int, 
@username nvarchar(50), 
@uname nvarchar(50), 
@uotch nvarchar(50),
@hardcode nvarchar(50),
@ignorehardcode int
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
[force_tariff] = @force_tariff, 
[referal] = @referal, 
[username] = @username, 
[uname] = @uname, 
[uotch] = @uotch, 
[hardcode] = @hardcode,
[ignorehardcode] = @ignorehardcode
WHERE [id] = @id 
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

GRANT  EXECUTE  ON [dbo].[AccountsUpdate]  TO [public]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/* -----------------------------------------------------------------------------
				Обновляем тригер
----------------------------------------------------------------------------- */


ALTER TRIGGER [dbo].[AccountsAutoUPDATE] ON [dbo].[Accounts]  
FOR INSERT, UPDATE, DELETE  
AS 
BEGIN 
DECLARE @idI INT 
DECLARE @idD INT 
DECLARE @idAction INT 
DECLARE @idRecord INT 
DECLARE @isdeleted INT 
DECLARE @flag INT 
DECLARE @idActionOld INT 
DECLARE @idTableOld INT 
DECLARE @idRecordOld INT 
DECLARE IDcursor CURSOR FOR SELECT I.id AS [idI], D.id AS [idD],  
I.isdeleted FROM INSERTED AS I 
FULL OUTER JOIN DELETED AS D ON I.id = D.id 
OPEN IDcursor 
FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted 
WHILE @@FETCH_STATUS = 0 
BEGIN 
IF NOT(@idI IS NULL) AND (@idD IS NULL)  
SET @idAction = 1 --Insert 
IF (@idI IS NULL) AND NOT(@idD IS NULL)  
SET @idAction = 2 --Delete 
IF NOT(@idI IS NULL) AND NOT(@idD IS NULL)  
BEGIN  
IF @isdeleted = 0 
SET @idAction = 3 --Update 
ELSE 
SET @idAction = 2 --Delete 
END 
SET @idRecord = ISNULL(@idI,@idD) 
IF @idAction = 2 
BEGIN 
SELECT @flag=count([id]) FROM [GameClass].[dbo].[AutoUpdate] WHERE  
(idTable=1) AND (idAction=2) AND (idRecord=@idRecord) 
IF @flag >0 
BEGIN
	DELETE FROM [GameClass].[dbo].[AutoUpdate] WHERE (idTable=1) AND (idAction=2) AND (idRecord=@idRecord) 
	INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord) 
END
ELSE 
INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord) 
END 
IF @idAction <> 2 
INSERT AutoUpdate(idTable, idAction, idRecord) VALUES(1/*Accounts*/, @idAction, @idRecord) 
FETCH NEXT FROM IDcursor INTO @idI, @idD, @isdeleted 
END 
CLOSE IDcursor 
DEALLOCATE IDcursor 
END 
GO



/* -----------------------------------------------------------------------------
                               UPDATE Version
---------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.7' WHERE [key]='BaseVersion'
GO


