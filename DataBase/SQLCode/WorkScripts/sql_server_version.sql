if exists (select * from dbo.sysobjects where id = object_id(N'[tempdb]..[#msver]') )
	drop table #msver
GO
DECLARE @MSSQLVERSION int
create table #msver ([Index] int PRIMARY KEY, [Name] varchar(200), Internal_Value int, Character_Value varchar(200))
insert into #msver exec xp_msver ProductVersion
select @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS int) from #msver
drop table #msver
select @MSSQLVERSION
