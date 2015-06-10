
UPDATE dbo.[_pm_reports]
SET [SQL] = 'SELECT [_pm_jobs].*, [_pm_computers].name as [comp], [_pm_computers].ip as [ip], [_pm_computers].alias as [computer_alias], [_pm_printers].name as [printer], [_pm_printers].alias as [printer_alias], [_pm_users].name as [user], [_pm_users].alias as [user_alias],
CASE [_pm_printers].is_cost_details 
  WHEN 0 THEN 
    [_pm_printers].cost * [_pm_jobs].ppages
  ELSE
    CASE [_pm_jobs].isduplex 
  WHEN 0 THEN     
    CASE [_pm_jobs].iscolor
      WHEN 0 THEN [_pm_printers].cost * [_pm_jobs].ppages
      ELSE [_pm_printers].cost_color * [_pm_jobs].ppages
          END       
  ELSE 
    CASE [_pm_jobs].iscolor
      WHEN 0 THEN [_pm_printers].cost_duplex * [_pm_jobs].ppages
      ELSE [_pm_printers].cost_duplex_color  * [_pm_jobs].ppages
          END       
    END
  END AS [cost]
FROM [_pm_users] 
INNER JOIN ([_pm_printers] 
INNER JOIN ([_pm_computers] 
INNER JOIN [_pm_jobs] 
ON [_pm_computers].id = [_pm_jobs].idComputer) 
ON [_pm_printers].id = [_pm_jobs].idPrinter) 
ON [_pm_users].id = [_pm_jobs].idUser 
WHERE ([_pm_jobs].IsDelete = 0) AND ([_pm_jobs].dt >= %TIME-START%) AND ([_pm_jobs].dt <= %TIME-STOP%)'
WHERE [id] = 5

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(5, 'printer_alias', 120, 'Printer Alias', 'ѕсевдоним принтера', 0, 0, 0)

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(5, 'user_alias', 120, 'User Alias', 'ѕсевдоним пользовател€', 0, 0, 0)

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(5, 'computer_alias', 120, 'Computer Alias', 'ѕсевдоним компьютера', 0, 0, 0)

GO

UPDATE dbo.[_pm_reports]
SET [SQL] = 'SELECT [_pm_printers].name AS [printer], [_pm_printers].alias AS [printer_alias], [_pm_users].name AS [user], [_pm_users].alias AS [user_alias], Sum(Convert(float, [_pm_Jobs].pbytes)) AS [Sum-pbytes], Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages]
FROM [_pm_users] 
INNER JOIN ([_pm_printers] 
INNER JOIN [_pm_jobs] 
ON [_pm_printers].id = [_pm_jobs].idPrinter) 
ON [_pm_users].id = [_pm_jobs].idUser
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_printers].name, [_pm_printers].alias, [_pm_users].name, [_pm_users].alias'
WHERE [id] = 19

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(19, 'printer_alias', 120, 'Printer Alias', 'ѕсевдоним принтера', 0, 0, 0)

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(19, 'user_alias', 120, 'User Alias', 'ѕсевдоним пользовател€', 0, 0, 0)

GO

UPDATE dbo.[_pm_reports]
SET [SQL] = 'SELECT [_pm_computers].ip AS [ip], [_pm_computers].alias AS [computer_alias], [_pm_printers].name AS [printer],  [_pm_printers].alias AS [printer_alias], Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages], Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes]
FROM [_pm_printers] 
INNER JOIN ([_pm_computers] 
INNER JOIN [_pm_jobs] 
ON [_pm_computers].id = [_pm_jobs].idComputer) 
ON [_pm_printers].id = [_pm_jobs].idPrinter
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_computers].ip, [_pm_computers].alias, [_pm_printers].name, [_pm_printers].alias'
WHERE [id] = 20

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(20, 'printer_alias', 120, 'Printer Alias', 'ѕсевдоним принтера', 0, 0, 0)

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(20, 'computer_alias', 120, 'Computer Alias', 'ѕсевдоним компьютера', 0, 0, 0)

GO


ALTER TABLE [_pm_jobs] ADD [SPLFormat] varchar(64) DEFAULT('')

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(5, 'SPLFormat', 100, 'SPL Format', '‘ормат файла спулера', 0, 0, 0);

GO

ALTER TABLE [_pm_jobs] ADD [SPLFileName] varchar(255) DEFAULT('')

GO

INSERT INTO [_pm_reports_columns] ([idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(5, 'SPLFileName', 100, 'SPL File Name', '»м€ файла спулера', 0, 0, 0);

GO

