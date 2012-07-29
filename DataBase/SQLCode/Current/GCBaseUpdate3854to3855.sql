USE GameClass
GO

/* -----------------------------------------------------------------------------
                               Чистим AutoUpdate
----------------------------------------------------------------------------- */


DELETE FROM [GameClass].[dbo].[AutoUpdate] WHERE 1=1;
GO

/* -----------------------------------------------------------------------------
                               Правим ComputersAdd
----------------------------------------------------------------------------- */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[ComputersAdd] 
	@number int, 
	@ipaddress nvarchar(15), 
	@idGroup int, 
	@macaddress nvarchar(17) 
AS  
set nocount on 

if (exists(select * from Computers where ([number]=@number) and [isdelete]=0)) 
begin 
	raiserror 50000 'Computers with these number or ip-addres already exist!' 
	return 50000 
end 
else 
insert into Computers ([number], [ipaddress], [idGroup], [macaddress]) values (@number, @ipaddress, @idGroup, @macaddress)

GO



/* -----------------------------------------------------------------------------
                               Добавляем столбцы для snmp
----------------------------------------------------------------------------- */


IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'snmp_password' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [snmp_password]  [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('')
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'snmp_mib_ports' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [snmp_mib_ports] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL DEFAULT ('')
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'ignore_offline' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [ignore_offline] [int] NOT NULL DEFAULT (0)
GO

IF NOT EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'client_type' 
  AND id = object_id(N'[GameClass].[dbo].[Computers]')) 
ALTER TABLE [Computers] ADD [client_type] [int] NOT NULL DEFAULT (0)
GO


/* -----------------------------------------------------------------------------
                               Правим ComputersUpdate
----------------------------------------------------------------------------- */


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[ComputersUpdate] 
	@idComp int, 
	@number int,
	@client_type int,
	@idGroup int, 
	@ipaddress nvarchar(15), 
	@macaddress nvarchar(17),
	@snmp_password nvarchar(49),
	@mib_port nvarchar(49),
	@ignore_offline int
AS  
set nocount on 
if (exists(select * from Computers where ([number]=@number) and [id]<>@idComp and [isdelete]=0)) 
begin 
	raiserror 50000 'Computers with these number or ip-addres already exist!' 
	return 50000 
end 
else 
	update Computers set 
	[number]=@number, 
	[client_type]=@client_type, 
	[idGroup]=@idGroup, 
	[ipaddress]=@ipaddress, 
	[macaddress]=@macaddress,
	[snmp_password]=@snmp_password ,
	[snmp_mib_ports]=@mib_port,
	[ignore_offline]=@ignore_offline
		where [id]=@idComp 
GO


/* -----------------------------------------------------------------------------
                               UPDATE Version
----------------------------------------------------------------------------- */
UPDATE Registry SET [value]='3.85.5' WHERE [key]='BaseVersion'
GO


