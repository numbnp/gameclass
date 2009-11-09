

DELETE FROM [_pm_filters_conditions]

GO

DELETE FROM [_pm_filters]

GO

DELETE FROM [_pm_reports_columns]

GO 

DELETE FROM [_pm_reports] 

GO

SET IDENTITY_INSERT _pm_reports ON

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (1, 0, 'Print', 'Печать', 1, 1, '')


INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (2, 0, 'Service Reports', 'Служебные отчеты', 1, 1, '')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (3, 0, 'Users Reports', 'Пользовательские отчеты', 1, 1, '')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (4, 1, 'Summary', 'Суммарный отчет', 0, 1, 'SELECT Sum([_pm_jobs].tpages) AS [sum-tpages], Sum([_pm_jobs].ppages) AS [sum-ppages], Sum([_pm_jobs].tbytes) AS [sum-tbytes], Sum([_pm_jobs].pbytes) AS [sum-pbytes],
Sum(CASE [_pm_printers].is_cost_details 
  WHEN 0 THEN 
    CASE [_pm_jobs].isduplex 
	WHEN 0 THEN     
	  CASE [_pm_jobs].iscolor
	    WHEN 0 THEN [_pm_printers].cost* [_pm_jobs].ppages
	    ELSE [_pm_printers].cost_color* [_pm_jobs].ppages
          END       
	ELSE 
	  CASE [_pm_jobs].iscolor
	    WHEN 0 THEN [_pm_printers].cost_duplex* [_pm_jobs].ppages
	    ELSE [_pm_printers].cost_duplex_color* [_pm_jobs].ppages
          END       
    END
  ELSE
    [_pm_printers].cost* [_pm_jobs].ppages
  END) AS [sum-cost]
FROM [_pm_jobs] 
INNER JOIN [_pm_printers] ON  ([_pm_printers].id = [_pm_jobs].idPrinter)
WHERE ([_pm_jobs].IsDelete = 0) AND ([_pm_jobs].dt >= %TIME-START%) AND ([_pm_jobs].dt <= %TIME-STOP%)');


INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (5, 1, 'Details Report', 'Детальный отчет', 0, 1, 'SELECT [_pm_jobs].*, [_pm_computers].name as [comp],[_pm_computers].ip as [ip],[_pm_printers].name as [printer], [_pm_users].name as [user],
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
WHERE ([_pm_jobs].IsDelete = 0) AND ([_pm_jobs].dt >= %TIME-START%) AND ([_pm_jobs].dt <= %TIME-STOP%)')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (6, 2, 'Warnings', 'Предупреждения', 0, 1, 'SELECT * FROM [_pm_messages] 
WHERE (category=' + '''' + 'warnings' + '''' + ') AND (%TIME-START% <= [_pm_messages].dt) AND ([_pm_messages].dt <= %TIME-STOP%)')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (7, 2, 'Errors', 'Ошибки', 0, 1, 'SELECT * FROM [_pm_messages] 
WHERE (category=' + '''' + 'errors' + '''' + ') AND (%TIME-START% <= [_pm_messages].dt) AND ([_pm_messages].dt <= %TIME-STOP%)')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (8, 1, 'Resources Statistic', 'Статистика по ресурсам', 1, 1, '')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (9, 1, 'Time Statistic', 'Временная статистика', 1, 1, '')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (10, 9, 'By Weekdays', 'По дням недели', 0, 1, 'SELECT Sum([_pm_jobs].ppages) AS [Sum-ppages], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], DATEPART(weekday, [_pm_jobs].dt) AS [dt_days], DATENAME(weekday, [_pm_jobs].dt) AS [Weekday]
FROM [_pm_jobs] 
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY DATEPART(weekday, [_pm_jobs].dt), DATENAME(weekday, [_pm_jobs].dt)
ORDER BY DATEPART(weekday, [_pm_jobs].dt)')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (11, 9, 'By Days', 'По числам', 0, 1, 'SELECT Sum([_pm_jobs].ppages) AS [Sum-ppages], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], CONVERT(char(12), [_pm_jobs].dt, 106) AS [Date] 
FROM [_pm_jobs] 
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY CONVERT(char(12), [_pm_jobs].dt, 106)
ORDER BY CONVERT(char(12), [_pm_jobs].dt, 106) DESC')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (12, 9, 'By Weeks', 'По неделям', 0, 1, 'SELECT DISTINCT Year([_pm_jobs].dt) as [Year], DATENAME(week, [_pm_jobs].dt) AS [Week], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], Sum([_pm_jobs].ppages) AS [Sum-ppages] 
FROM [_pm_jobs] 
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY Year([_pm_jobs].dt), DATENAME(week, [_pm_jobs].dt) 
ORDER BY Year([_pm_jobs].dt) DESC, DATENAME(week, [_pm_jobs].dt) DESC')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (13, 9, 'By Months', 'По месяцам', 0, 1, 'SELECT DISTINCT Year([_pm_jobs].dt) as [Year], DATENAME(month, [_pm_jobs].dt) AS [Month], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], Sum([_pm_jobs].ppages) AS [Sum-ppages] 
FROM [_pm_jobs] 
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY Year([_pm_jobs].dt), DATENAME(month, [_pm_jobs].dt)  
ORDER BY Year([_pm_jobs].dt) DESC, DATENAME(month, [_pm_jobs].dt) DESC')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (14, 9, 'By Quarters', 'По кварталам', 0, 1, 'SELECT Year([_pm_jobs].dt) as [Year], DATEPART(quarter, [_pm_jobs].dt) AS [Quarter], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], Sum([_pm_jobs].ppages) AS [Sum-ppages]
FROM [_pm_jobs] WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY Year([_pm_jobs].dt), DATEPART(quarter, [_pm_jobs].dt)
ORDER BY Year([_pm_jobs].dt) DESC, DATEPART(quarter, [_pm_jobs].dt) DESC')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (15, 9, 'By Years', 'По годам', 0, 1, 'SELECT DISTINCT YEAR([_pm_jobs].dt) AS [year], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], Sum([_pm_jobs].ppages) AS [Sum-ppages]
FROM [_pm_jobs]
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY YEAR([_pm_jobs].dt)
ORDER BY YEAR([_pm_jobs].dt)')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (16, 8, 'By Printers', 'По принтерам', 0, 1, 'SELECT [_pm_printers].name  AS [printer], Sum([_pm_jobs].ppages) AS [Sum-ppages], Sum([_pm_jobs].pbytes) AS [Sum-pbytes] 
FROM [_pm_jobs] 
INNER JOIN [_pm_printers]  
ON [_pm_printers].id = [_pm_jobs].idPrinter
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY [_pm_printers].name 
ORDER BY Sum([_pm_jobs].ppages) DESC , Sum([_pm_jobs].pbytes) DESC')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (17, 8, 'By Users', 'По пользователям', 0, 1, 'SELECT [_pm_users].name AS [user], Sum([_pm_jobs].ppages) AS [Sum-ppages], Sum([_pm_jobs].pbytes) AS [Sum-pbytes] 
FROM [_pm_jobs] 
INNER JOIN [_pm_users] 
ON [_pm_users].id = [_pm_jobs].idUser
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY [_pm_users].name 
ORDER BY Sum([_pm_jobs].ppages) DESC , Sum([_pm_jobs].pbytes) DESC')


INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (18, 8, 'By Computers', 'По компьютерам', 0, 1, 'SELECT [_pm_computers].ip AS [ip], Sum([_pm_jobs].ppages) AS [Sum-ppages], Sum([_pm_jobs].pbytes) AS [Sum-pbytes] FROM [_pm_jobs] 
INNER JOIN [_pm_computers] ON [_pm_computers].id = [_pm_jobs].idComputer
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY [_pm_computers].ip
ORDER BY Sum([_pm_jobs].ppages) DESC , Sum([_pm_jobs].pbytes) DESC')


INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (19, 8, 'By Users / Printers', 'По пользователям / принтерам', 0, 1, 'SELECT [_pm_printers].name AS [printer], [_pm_users].name  AS [user], Sum([_pm_Jobs].pbytes) AS [Sum-pbytes], Sum([_pm_jobs].ppages) AS [Sum-ppages]
FROM [_pm_users] 
INNER JOIN ([_pm_printers] 
INNER JOIN [_pm_jobs] 
ON [_pm_printers].id = [_pm_jobs].idPrinter) 
ON [_pm_users].id = [_pm_jobs].idUser
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_printers].name, [_pm_users].name')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (20, 8, 'By Computers / Printers', 'По компьютерам / принтерам', 0, 1, 'SELECT [_pm_computers].ip AS [ip], [_pm_printers].name AS [printer], Sum([_pm_jobs].ppages) AS [Sum-ppages], Sum([_pm_jobs].pbytes) AS [Sum-pbytes]
FROM [_pm_printers] 
INNER JOIN ([_pm_computers] 
INNER JOIN [_pm_jobs] 
ON [_pm_computers].id = [_pm_jobs].idComputer) 
ON [_pm_printers].id = [_pm_jobs].idPrinter
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_computers].ip, [_pm_printers].name')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (22, 2, 'Information', 'Информация', 0, 1, 'SELECT * FROM [_pm_messages] 
WHERE (category=' + '''' + 'info' + '''' + ') AND (%TIME-START% <= [_pm_messages].dt) AND ([_pm_messages].dt <= %TIME-STOP%)')

INSERT INTO [_pm_reports]([id], [idParent], [name_enu], [name_ru], [isFolder], 
    [isReadOnly], [SQL])
VALUES (23, 9, 'By Hours', 'По часам', 0, 1, 'SELECT DISTINCT DATEPART(hour, [_pm_jobs].dt) AS [hour], Sum([_pm_jobs].pbytes) AS [Sum-pbytes], Sum([_pm_jobs].ppages) AS [Sum-ppages] 
FROM [_pm_jobs] 
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%)) 
GROUP BY DATEPART(hour, [_pm_jobs].dt) 
ORDER BY DATEPART(hour, [_pm_jobs].dt)')

SET IDENTITY_INSERT _pm_reports OFF

GO

SET IDENTITY_INSERT _pm_reports_columns ON

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(1, 5, 'dt', 100, 'Date/Time', 'Дата/время', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(2, 5, 'jid', 60, 'Number', 'Номер', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(3, 5, 'printer', 100, 'Printer', 'Принтер', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(4, 5, 'user', 100, 'User', 'Пользователь', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(5, 5, 'ip', 100, 'Computer', 'Компьютер', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(6, 5, 'doc', 120, 'Document', 'Документ', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(7, 5, 'tbytes', 60, 'Total Bytes', 'Всего байт', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(8, 5, 'pbytes', 60, 'Printed Bytes', 'Напечатано байт', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(9, 5, 'tpages', 60, 'Total Pages', 'Всего страниц', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(10, 5, 'ppages', 60, 'Printed Pages', 'Напечатано страниц', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(11, 5, 'iscolor', 60, 'Color', 'Цвет', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(12, 16, 'printer', 60, 'Printer', 'Принтер', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(13, 16, 'sum-pbytes', 60, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(14, 16, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(15, 17, 'user', 200, 'User', 'Пользователь', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(16, 17, 'sum-pbytes', 60, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(17, 17, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(18, 18, 'ip', 200, 'IP', 'IP', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(19, 18, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(20, 18, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(21, 19, 'printer', 100, 'Printer', 'Принтер', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(22, 19, 'user', 120, 'User', 'Пользователь', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(23, 19, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(24, 19, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(25, 20, 'ip', 120, 'IP', 'IP', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(26, 20, 'printer', 120, 'Printer', 'Принтер', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(27, 20, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(28, 20, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(29, 10, 'Weekday', 200, 'Weekday', 'День недели', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(30, 10, 'Sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(31, 10, 'Sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(32, 11, 'Date', 200, 'Date', 'Дата', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(33, 11, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(34, 11, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(35, 13, 'Month', 200, 'Month', 'Месяц', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(36, 13, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(37, 13, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(38, 15, 'year', 200, 'Year', 'Год', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(39, 15, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(40, 15, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(41, 23, 'hour', 100, 'Hour', 'Час', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(42, 23, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(43, 23, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(44, 12, 'week', 200, 'Week', 'Неделя', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(45, 12, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(46, 12, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(47, 14, 'year', 100, 'Year', 'Годы', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(48, 14, 'quarter', 100, 'Quarter', 'Квартал', 0, 1, 1)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(49, 14, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(50, 14, 'sum-ppages', 100, 'Pages', 'Страницы', 1, 1, 2)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(51, 5, 'isduplex', 40, 'Duplex', 'Дуплекс-печать', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(52, 5, 'format', 40, 'Format', 'Формат', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(53, 5, 'isOk', 40, 'Status', 'Статус', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(54, 4, 'sum-pbytes', 100, 'Printed Bytes', 'Распечатанные байты', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(55, 4, 'sum-ppages', 100, 'Printed Pages', 'Распечатанные страницы', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(56, 4, 'sum-tbytes', 100, 'Total Bytes', 'Всего байт', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(57, 4, 'sum-tpages', 100, 'Total Pages', 'Всего страниц', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(58, 5, 'cost', 60, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(59, 4, 'sum-cost', 60, 'Cost', 'Стоимость', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(60, 6, 'dt', 60, 'Date/Time', 'Дата/время', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(61, 6, 'text', 120, 'Description', 'Описание', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(62, 6, 'code', 60, 'Code', 'Код', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(63, 7, 'dt', 60, 'Date/Time', 'Дата/время', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(64, 7, 'text', 120, 'Description', 'Описание', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(65, 7, 'code', 60, 'Code', 'Код', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(66, 22, 'dt', 60, 'Date/Time', 'Дата/время', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(67, 22, 'text', 120, 'Description', 'Описание', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(68, 22, 'code', 60, 'Code', 'Код', 0, 0, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(69, 12, 'year', 60, 'Year', 'Год', 0, 1, 0)

INSERT INTO [_pm_reports_columns] ([id], [idReport], [field], [defwidth], [text_enu], [text_ru], [AggregateFunc], 
    [isGeneralColumn], [ChartRole])
VALUES(70, 13, 'year', 60, 'Year', 'Год', 0, 1, 0)


SET IDENTITY_INSERT _pm_reports_columns OFF

GO