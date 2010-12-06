Use GameClass
Go

declare @nId Int
select @nId=id from Functions where name='fnManualRemoteInstall'
delete from Functions where id=@nId
delete from FunctionsRights where idFunctions=@nId
go

update Registry set [value]=N'3.80' where [key]=N'BaseVersion'
GO
