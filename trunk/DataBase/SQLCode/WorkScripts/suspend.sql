USE master
GO
sp_configure 'allow updates', 1
GO
RECONFIGURE WITH OVERRIDE
GO

--sp_resetstatus GameClass
select status from sysdatabases where name = 'GameClass' -- 1077936153 -- 1077936153


update sysdatabases set status= 32768 where name = 'GameClass'

Use master 
go 
sp_dboption 'GameClass', 'single_user', 'true' 
go

Тут Перезапуск базы

USE GameClass
GO 
DBCC CHECKDB('GameClass', REPAIR_ALLOW_DATA_LOSS) 
go

sp_dboption 'GameClass', 'single_user', 'false' 
go

update sysdatabases set status= 1077936153 where name = 'GameClass'

USE master
GO
sp_configure 'allow updates', 0
GO

USE GameClass
go
select * from Registry where [key] LIKE 'BaseVersion'
go

exec ReportCurrent @NewShiftPoint = '28 jan 2007 23:59'