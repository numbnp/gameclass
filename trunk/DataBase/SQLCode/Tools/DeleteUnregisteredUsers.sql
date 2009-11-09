IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[tempdb]..[#msver]') )
  DROP TABLE #msver
DECLARE @MSSQLVERSION INT
CREATE TABLE #msver ([Index] INT PRIMARY KEY, [Name] VARCHAR(200), Internal_Value INT, Character_Value VARCHAR(200))
INSERT INTO #msver EXEC master..xp_msver ProductVersion
SELECT @MSSQLVERSION=CAST(LEFT(Character_Value,1) AS INT) FROM #msver
DROP TABLE #msver
  
DECLARE @sql VARCHAR(400)
DECLARE @name varchar(255)
DECLARE cur CURSOR FOR 
  SELECT L.[name] FROM master.dbo.syslogins AS L
    LEFT OUTER JOIN GameClass.dbo.Users AS U ON L.[name] = U.[Name] AND U.isdelete = 0
    WHERE U.[Name] IS NULL AND L.[name] <> N'sa' 
      AND L.[name] <> N'sa' AND L.[name] <> N'BUILTIN\Администраторы'
      AND L.[name] <> N'BUILTIN\Administrators' 
      AND L.[name] <> N'gcbackupoperator'
      AND L.[name] <> N'pm_service'
      AND ((@MSSQLVERSION = 8)
      OR (L.[name] <> N'##MS_SQLResourceSigningCertificate##'
      AND L.[name] <> N'##MS_SQLReplicationSigningCertificate##'
      AND L.[name] <> N'##MS_SQLAuthenticatorCertificate##'
      AND L.[name] <> N'##MS_AgentSigningCertificate##'
      AND L.[name] <> N'##MS_PolicyEventProcessingLogin##'
      AND L.[name] <> N'##MS_PolicySigningCertificate##'
      AND L.[name] <> N'##MS_PolicyTsqlExecutionLogin##'))

OPEN cur
FETCH NEXT FROM cur INTO @name

WHILE @@FETCH_STATUS = 0
BEGIN
  IF EXISTS (SELECT * FROM GameClass.dbo.sysusers WHERE name = @name)
  BEGIN
    IF (@MSSQLVERSION = 8) 
      EXEC GameClass.dbo.sp_dropuser @name
    IF (@MSSQLVERSION = 9) 
    BEGIN
      SET @sql = 'DROP USER [' + @name  + ']'
      EXEC (@sql)
    END
  END
  IF (@MSSQLVERSION = 8) 
    EXEC master.dbo.sp_droplogin @name
  IF (@MSSQLVERSION = 9) 
  BEGIN
    SET @sql = 'DROP LOGIN [' + @name + ']'
    EXEC (@sql)
  END
  FETCH NEXT FROM cur INTO @name
END

CLOSE cur
DEALLOCATE cur

DECLARE cur CURSOR FOR 
  SELECT DISTINCT SU.[name] FROM GameClass.dbo.sysusers AS SU
		INNER JOIN GameClass.dbo.Users AS U ON SU.[name] = U.[Name]
    LEFT OUTER JOIN master.dbo.syslogins AS L ON SU.[name] = L.[name]
    WHERE L.[name] IS NULL 

OPEN cur
FETCH NEXT FROM cur INTO @name

WHILE @@FETCH_STATUS = 0
BEGIN
    IF (@MSSQLVERSION = 8) 
      EXEC GameClass.dbo.sp_dropuser @name
    IF (@MSSQLVERSION = 9) 
    BEGIN
      SET @sql = 'DROP USER [' + @name  + ']'
      EXEC (@sql)
    END
  FETCH NEXT FROM cur INTO @name
END

CLOSE cur
DEALLOCATE cur
GO

