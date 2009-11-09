USE GameClass
GO

IF NOT EXISTS (SELECT * FROM master.dbo.syslogins 
   WHERE name = N'gcbackupoperator')
BEGIN
  exec master.dbo.sp_addlogin N'gcbackupoperator', N'j4hhf6kd'
END
IF NOT EXISTS (SELECT * FROM GameClass.dbo.sysusers
   WHERE name = N'gcbackupoperator')
BEGIN
  exec sp_adduser 'gcbackupoperator', 'gcbackupoperator', 'db_backupoperator'
END

  exec master.dbo.sp_password @new='j4hhf6kd', @loginame='gcbackupoperator'
GO
