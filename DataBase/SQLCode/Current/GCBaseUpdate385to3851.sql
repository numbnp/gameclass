USE GameClass
GO


/* -----------------------------------------------------------------------------
	Колонки для ограничения пользователей (карточек)
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'userlevel' 
  AND id = object_id(N'[GameClass].[dbo].[Tarifs]')) 
ALTER TABLE [Tarifs] ADD [userlevel] [int] NOT NULL DEFAULT (3)
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
@userlevel int
/*WITH ENCRYPTION*/  
AS 

set nocount on

if (exists(select * from Tarifs where ([name]=@name) and [id]<>@idTarif and [isdelete]=0))
begin
  raiserror 50000 'Tarif with these name already exist!'
  return 50000
end

update Tarifs set [name]=@name ,[internet]=@internet ,[calctraffic]=@calctraffic ,[roundtime]=@roundtime ,
         [roundmoney]=@roundmoney, [idGroup]=@idGroup, [BytesInMB]=@BytesInMB,
    [SpeedLimitInKB]=@SpeedLimitInKB, [PluginGroupName]=@PluginGroupName, [userlevel]=@userlevel
    where [id]=@idTarif
GO


/* -----------------------------------------------------------------------------
       Колонки для ограничения клиента в выборе тарифов
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'assigntarif' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [assigntarif] [int] NOT NULL DEFAULT (0)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'userlevel' 
  AND id = object_id(N'[GameClass].[dbo].[Accounts]')) 
ALTER TABLE [Accounts] ADD [userlevel] [int] NOT NULL DEFAULT (3)
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
@userlevel int
/*WITH ENCRYPTION*/
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
  [userlevel] = @userlevel
  WHERE [id] = @id
END
GO

/* -----------------------------------------------------------------------------
	Колонки для хранения MAC-адресов компов
----------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'macaddress' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [macaddress] [nvarchar] (17) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('00-00-00-00-00-00')
GO


/* -----------------------------------------------------------------------------
	Функция обновления информации о компьютере
----------------------------------------------------------------------------- */


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputersUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputersUpdate]
GO

CREATE PROCEDURE ComputersUpdate
@idComp int,
@number int,
@ipaddress nvarchar(15),
@idGroup int,
@macaddress nvarchar(17)
/*WITH ENCRYPTION*/
AS 

set nocount on

if (exists(select * from Computers where ([number]=@number or [ipaddress]=@ipaddress) and [id]<>@idComp and [isdelete]=0))
begin
  raiserror 50000 'Computers with these number or ip-addres already exist!'
  return 50000
end
else
  update Computers set [number]=@number, [ipaddress]=@ipaddress, [idGroup]=@idGroup, [macaddress]=@macaddress where [id]=@idComp
GO

/* -----------------------------------------------------------------------------
	Функция добовления компьютера
----------------------------------------------------------------------------- */



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ComputersAdd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ComputersAdd]
GO


CREATE PROCEDURE ComputersAdd
@number int,
@ipaddress nvarchar(15),
@idGroup int,
@macaddress nvarchar(17)
/*WITH ENCRYPTION*/
AS 

set nocount on

if (exists(select * from Computers where ([number]=@number or [ipaddress]=@ipaddress) and [isdelete]=0))
begin
  raiserror 50000 'Computers with these number or ip-addres already exist!'
  return 50000
end
else
  insert into Computers ([number], [ipaddress], [idGroup], [macaddress]) values (@number, @ipaddress, @idGroup, @macaddress)
GO



/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.1' WHERE [key]='BaseVersion'
GO
