USE GameClass
GO

ALTER PROCEDURE [dbo].[UsersDelete]
  @idUsers INT
WITH ENCRYPTION
AS 
BEGIN
  DECLARE @login_name NVARCHAR(50)
  SELECT @login_name=[name] FROM Users WHERE [id]=@idUsers
  
  IF object_id('tempdb..#ActiveUsers') IS NOT NULL 
    DROP TABLE #ActiveUsers
  
  CREATE TABLE #ActiveUsers (
    [spid] [INT] NOT NULL,
    [ecid] [INT] NOT NULL,
    [status] [VARCHAR] (50) NULL,
    [loginame] [VARCHAR] (50) NULL,
    [hostname] [VARCHAR] (50) NULL,
    [blk] [INT] NOT NULL,
    [dbname] [VARCHAR] (50) NULL,
    [cmd] [VARCHAR] (50) NULL
  ) ON [PRIMARY]
  
  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[tempdb]..[#msver]') )
    DROP TABLE #msver
  DECLARE @MSSQLVERSION INT
  CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200))
  INSERT INTO #msver EXEC master..xp_msver ProductVersion
  SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver
  DROP TABLE #msver
  
  IF (@MSSQLVERSION = 9) 
  BEGIN
		ALTER TABLE #ActiveUsers ADD [request_id] [INT] NULL 
  END

  INSERT #ActiveUsers EXEC sp_who @login_name
  
  IF @login_name = SYSTEM_USER
  BEGIN
   RAISERROR 50000 'You can''t delete yourself!'
  
  END
  
  IF EXISTS(SELECT * FROM #ActiveUsers) 
  BEGIN
   RAISERROR 50000 'You can''t delete active user!'
   
  END

  IF object_id('tempdb..#ActiveUsers') IS NOT NULL 
    DROP TABLE #ActiveUsers
  
  DECLARE @err1 INT
  DECLARE @err2 INT
  EXEC @err1=sp_dropuser @login_name
  EXEC @err2=master.dbo.sp_droplogin @login_name
  /* логическое удаление пользователя */
  IF (@err1<>0) OR (@err2<>0)
  BEGIN
    RAISERROR 50000 'Error deleting user!'
   
  END

  UPDATE Users SET [isdelete]=1 WHERE [id]=@idUsers
END
GO

