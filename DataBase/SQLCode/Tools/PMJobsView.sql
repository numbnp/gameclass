USE GameClass
GO

DROP VIEW dbo.jobs
GO


CREATE VIEW dbo.jobs AS SELECT dbo._pm_jobs.*, RTRIM(dbo._pm_computers.ip) AS [ip], dbo._pm_printers.name AS [printer], dbo._pm_users.name AS [user], case dbo._pm_jobs.isOk when 0 then 'Error' when 1 then 'Ok!' end AS [status] FROM  dbo._pm_jobs INNER JOIN dbo._pm_printers ON dbo._pm_jobs.idPrinter = dbo._pm_printers.id INNER JOIN dbo._pm_computers ON dbo._pm_jobs.idComputer = dbo._pm_computers.id INNER JOIN dbo._pm_users ON dbo._pm_jobs.idUser = dbo._pm_users.id
GO