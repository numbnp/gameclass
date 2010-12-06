

ALTER TABLE [_pm_printers] ADD [Alias] varchar(255) DEFAULT('')

GO


ALTER TABLE [_pm_users] ADD [Alias] varchar(255) DEFAULT('')

GO


ALTER TABLE [_pm_computers] ADD [Alias] varchar(255) DEFAULT('')

GO


CREATE TABLE _pm_time_bookmarks (
  [id] [int] IDENTITY (1, 1) NOT NULL ,
  [dt] [datetime], 
  [desc] varchar(255) COLLATE Cyrillic_General_CI_AS 
) ON [PRIMARY] 

GO


ALTER TABLE [dbo].[_pm_time_bookmarks] WITH NOCHECK ADD 
  CONSTRAINT [PK__pm_time_bookmarks] PRIMARY KEY  CLUSTERED 
  (
    [id]
  )  ON [PRIMARY] 

GO



SET IDENTITY_INSERT _pm_reports ON

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (1000, 8, 'By Docs', 'По документам', 0, 1, 'SELECT
   [_pm_users].name as [user],
   [_pm_jobs].doc as [doc],
   sum ([_pm_jobs].ppages) as pages
 FROM [_pm_jobs]
 INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter
 INNER JOIN [_pm_users] ON [_pm_users].id = [_pm_jobs].idUser
 WHERE
  ([_pm_jobs].IsDelete = 0) and
  ([_pm_jobs].dt >= %TIME-START%) and
  ([_pm_jobs].dt <= %TIME-STOP%)
 GROUP BY
 [_pm_users].name, [_pm_jobs].doc
 ORDER BY
  3 DESC')

SET IDENTITY_INSERT _pm_reports OFF


GO


INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(1000, 'user', 120, 'User', 'Пользователь', 0, 1, 0)
 
GO


INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(1000, 'doc', 240, 'Document', 'Документ', 0, 1, 1)
 
GO


INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(1000, 'pages', 100, 'Pages', 'Страницы', 1, 1, 2)
 
GO


UPDATE dbo.[_pm_reports]
SET [SQL] = 'SELECT [_pm_printers].name  AS [printer], [_pm_printers].alias  AS [alias], Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages], Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes]
FROM [_pm_jobs]
INNER JOIN [_pm_printers]
ON [_pm_printers].id = [_pm_jobs].idPrinter
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_printers].name, [_pm_printers].alias
ORDER BY Sum(Convert(float, [_pm_jobs].ppages)) DESC , Sum(Convert(float, [_pm_jobs].pbytes)) DESC'
WHERE [id] = 16

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(16, 'alias', 120, 'Alias', 'Псевдоним', 0, 0, 0)

GO


UPDATE dbo.[_pm_reports]
SET [SQL] = 'SELECT [_pm_users].name AS [user], [_pm_users].alias AS [alias], Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages], Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes]
FROM [_pm_jobs]
INNER JOIN [_pm_users]
ON [_pm_users].id = [_pm_jobs].idUser
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_users].name, [_pm_users].alias
ORDER BY Sum(Convert(float, [_pm_jobs].ppages)) DESC , Sum(Convert(float, [_pm_jobs].pbytes)) DESC'
WHERE [id] = 17

GO


INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(17, 'alias', 120, 'Alias', 'Псевдоним', 0, 0, 0)

GO


UPDATE dbo.[_pm_reports]
SET [SQL] = 'SELECT [_pm_computers].ip AS [ip], [_pm_computers].name AS [name], [_pm_computers].alias AS [alias], Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages], Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes] FROM [_pm_jobs] 
INNER JOIN [_pm_computers] ON [_pm_computers].id = [_pm_jobs].idComputer
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY [_pm_computers].ip, [_pm_computers].name, [_pm_computers].alias
ORDER BY Sum(Convert(float, [_pm_jobs].ppages)) DESC , Sum(Convert(float, [_pm_jobs].pbytes)) DESC'
WHERE [id] = 18

GO


INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(18, 'name', 120, 'Name', 'Имя', 0, 0, 0)

GO


INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(18, 'alias', 120, 'Alias', 'Псевдоним', 0, 0, 0)

GO


