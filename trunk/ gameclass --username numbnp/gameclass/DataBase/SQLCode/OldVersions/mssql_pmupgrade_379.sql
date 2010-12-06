

-- очистка таблиц не нужна, так как созданные таблицы по умолчанию пустые
-- DELETE FROM [_pm_jobs]
-- DELETE FROM [_pm_computers]
-- DELETE FROM [_pm_users]
-- DELETE FROM [_pm_printers]

-- GO


-- сначала заполняем таблицы, на которые будут ссылаться записи в таблице _pm_jobs

INSERT INTO [_pm_printers]([name])
SELECT DISTINCT [printer] FROM [Jobs]

GO 

INSERT INTO [_pm_users]([name])
SELECT DISTINCT [user] FROM [Jobs]

GO 

INSERT INTO [_pm_computers]([name], [ip])
SELECT DISTINCT [ip], [ip] FROM [Jobs]

GO

-- заполняем _pm_jobs, 
-- идентификаторы внешних ключей берем из ранее заполненных таблиц

INSERT INTO [_pm_jobs](
    [idPrinter], [idUser], [idComputer], [dt], [jid], 
    [doc], [tbytes], [tpages], [pbytes], [ppages], 
    [copies], [iscolor], [format], [isOk], [isdelete])
SELECT [_pm_printers].[id], [_pm_users].[id], [_pm_computers].[id], 
    [Jobs].[dt], [Jobs].[jid], [Jobs].[doc], [Jobs].[tbytes], 
    [Jobs].[tpages], [Jobs].[pbytes], [Jobs].[ppages], 
    [Jobs].[copies], [Jobs].[iscolor], [Jobs].[format], 
    case when [Jobs].[status] = 'Ok!' then 1 else 0 end, 
    [Jobs].[isdelete] 
FROM [Jobs]
LEFT OUTER JOIN [_pm_printers] ON ([Jobs].[printer] = [_pm_printers].[name])
LEFT OUTER JOIN [_pm_users] ON ([Jobs].[user] = [_pm_users].[name])
LEFT OUTER JOIN [_pm_computers] ON ([Jobs].[ip] = [_pm_computers].[ip])

GO

-- переименуем старые таблицы (можно удалить, 
-- но на всякий случай сохраняем возможность простого отката)

EXEC sp_rename 'jobs', 'old_jobs'
EXEC sp_rename 'warnings', 'old_warnings'
EXEC sp_rename 'errors', 'old_errors'
EXEC sp_rename 'information', 'old_information'

GO

-- создаем представление, эмулирующее старую таблицу [jobs]

CREATE VIEW dbo.jobs
AS
SELECT 
  dbo._pm_jobs.*, 
  RTRIM(dbo._pm_computers.ip) AS [ip], 
  dbo._pm_printers.name AS [printer], 
  dbo._pm_users.name AS [user], 
  case dbo._pm_jobs.isOk when 0 then 'Error' when 1 then 'Ok!' end AS [status]
FROM  dbo._pm_jobs 
INNER JOIN dbo._pm_printers ON dbo._pm_jobs.idPrinter = dbo._pm_printers.id 
INNER JOIN dbo._pm_users ON dbo._pm_jobs.idUser = dbo._pm_users.id 
INNER JOIN dbo._pm_computers ON dbo._pm_jobs.idComputer = dbo._pm_computers.id

GO


-- тестовые запросы

-- SELECT * FROM [_pm_printers]
-- SELECT * FROM [_pm_users]
-- SELECT * FROM [_pm_computers]
-- SELECT * FROM [_pm_jobs]

-- SELECT * FROM [view_jobs]