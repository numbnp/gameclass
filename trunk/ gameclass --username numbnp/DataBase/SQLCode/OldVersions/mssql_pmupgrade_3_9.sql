IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

ALTER TABLE [_pm_printers] DROP CONSTRAINT [DF__pm_printers_cost]
ALTER TABLE [_pm_printers] DROP CONSTRAINT [DF__pm_printers_cost_color]
ALTER TABLE [_pm_printers] DROP CONSTRAINT [DF__pm_printers_cost_duplex]
ALTER TABLE [_pm_printers] DROP CONSTRAINT [DF__pm_printers_cost_duplex_color]
ALTER TABLE [_pm_printers] DROP CONSTRAINT [DF__pm_printers_is_cost_details]

CREATE TABLE [_pm_formats]  (
 [Format] CHAR( 64 ) COLLATE Cyrillic_General_CI_AS NOT NULL ,
 [Height] INT NOT NULL DEFAULT 0 ,
 [Width] INT NOT NULL DEFAULT 0 ,
 [comment] TEXT NOT NULL DEFAULT ''
) ON [PRIMARY]

CREATE TABLE [_pm_costs]  (
 [Format] CHAR( 64 ) COLLATE Cyrillic_General_CI_AS NOT NULL ,
 [idPrinter] INT NOT NULL ,
 [BW]  money NOT NULL DEFAULT 1 ,
 [Color] money NOT NULL DEFAULT 1 ,
 [DuplexBW] money NOT NULL DEFAULT 1 ,
 [DuplexColor] money NOT NULL DEFAULT 1 
) ON [PRIMARY]
END
GO 



IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

ALTER TABLE [_pm_printers] DROP COLUMN [is_cost_details]
ALTER TABLE [_pm_printers] DROP COLUMN [cost]
ALTER TABLE [_pm_printers] DROP COLUMN [cost_color]
ALTER TABLE [_pm_printers] DROP COLUMN [cost_duplex]
ALTER TABLE [_pm_printers] DROP COLUMN [cost_duplex_color]

ALTER TABLE [dbo].[_pm_formats] WITH NOCHECK ADD 
  CONSTRAINT [PK__pm_formats] PRIMARY KEY  CLUSTERED 
  (
    [format]
  )  ON [PRIMARY] 

ALTER TABLE [dbo].[_pm_costs] WITH NOCHECK ADD 
  CONSTRAINT [PK__pm_costs] PRIMARY KEY  CLUSTERED 
  (
    [format], [idPrinter]
  )  ON [PRIMARY] 

END
GO 

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

INSERT INTO [_pm_formats] ( [format] ) VALUES ('#10 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('#11 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('#12 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('#14 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('#9 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('10X14 inch') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('11X17 inch') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('12X11 inch') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('6 3/4 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A2') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A3') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A3 Extra') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A3 Extra Transverse') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A3 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A3 Transverse') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A4') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A4 Extra') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A4 Plus') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A4 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A4 Small') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A4 Transverse') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A5') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A5 Extra') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A5 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A5 Transverse') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A6') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('A6 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B4') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B4 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B4 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B5') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B5 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B5 Extra') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B5 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B6 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B6 Extra') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('B6 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('C Sheet') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('C3 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('C4 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('C5 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('C6 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('C65 Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('D Sheet') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('DL Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Double Japanese Postcard') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Double Japanese Postcard Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('E Sheet') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Executive') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Folio') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('German Legal Fanfold') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('German Std Fanfold') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Italy Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Chou #3') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Chou #3 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Chou #4') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Chou #4 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Kaku #2') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Kaku #2 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Kaku #3') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope Kaku #3 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope You #4') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Envelope You #4 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Japanese Postcard Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Ledger') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('LEGAL') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('LETTER') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Letter Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Letter Small') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Monarch Envelope') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Note') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC 16K') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC 16K Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC 32K') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC 32K (Big)') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC 32K (Big) Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC 32K Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #1') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #1 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #10') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #10 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #2') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #2 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #3') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #3 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #4') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #4 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #5') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #5 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #6') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #6 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #7') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #7 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #8') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #8 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #9') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('PRC Envelope #9 Rotated') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Quarto') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Statement') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('SuperA_A4') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('SuperB_A3') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Tabloid') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('Unknown') 
INSERT INTO [_pm_formats] ( [format] ) VALUES ('US Std Fanfold') 
END
GO                           


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

UPDATE [_pm_jobs] SET [format]='A4' WHERE [format]=''

ALTER TABLE [dbo].[_pm_jobs] ADD
  CONSTRAINT [FK__pm_jobs_format_fkey] FOREIGN KEY ( [format] ) 
    REFERENCES [dbo].[_pm_formats] ( [format] )

ALTER TABLE [dbo].[_pm_costs] ADD 
  CONSTRAINT [FK__pm_costs__pm_formats] FOREIGN KEY ( [format] ) 
    REFERENCES [dbo].[_pm_formats] ( [format] ),
  CONSTRAINT [FK__pm_costs__pm_printers] FOREIGN KEY ( [idPrinter] ) 
    REFERENCES [dbo].[_pm_printers] ( [id] )

UPDATE [_pm_reports_columns] SET isGeneralColumn = 0
WHERE field = 'sum-pbytes'
END
GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

UPDATE [_pm_reports]
SET [SQL] = 'SELECT Sum(Convert(float, [_pm_jobs].tpages)) AS [sum-tpages],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [sum-ppages],
    Sum(Convert(float, [_pm_jobs].tbytes)) AS [sum-tbytes],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-cost]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE ([_pm_jobs].IsDelete = 0) AND ([_pm_jobs].dt >= %TIME-START%) AND ([_pm_jobs].dt <= %TIME-STOP%)
'
WHERE [id] = 4

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_jobs].*,
    [_pm_computers].name as [comp],
    [_pm_computers].ip as [ip],
    [_pm_computers].alias as [computer_alias],
    [_pm_printers].name as [printer],
    [_pm_printers].alias as [printer_alias],
    [_pm_users].name as [user],
    [_pm_users].alias as [user_alias],
    CASE [_pm_jobs].isduplex
        WHEN 0 THEN
            CASE [_pm_jobs].iscolor
                WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
            END
        ELSE
            CASE _pm_jobs.iscolor
                WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
            END
    END AS [cost]
FROM (((([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
INNER JOIN [_pm_users] ON [_pm_users].id = [_pm_jobs].idUser)
INNER JOIN [_pm_computers] ON [_pm_computers].id = [_pm_jobs].idComputer)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE ([_pm_jobs].IsDelete = 0) AND ([_pm_jobs].dt >= %TIME-START%) AND ([_pm_jobs].dt <= %TIME-STOP%)
'
WHERE [id] = 5

UPDATE [_pm_reports]
SET [SQL] = 'SELECT DATEPART(weekday, [_pm_jobs].dt) AS [dt_days],
    DATENAME(weekday, [_pm_jobs].dt) AS [Weekday],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY DATEPART(weekday, [_pm_jobs].dt), DATENAME(weekday, [_pm_jobs].dt)
ORDER BY DATEPART(weekday, [_pm_jobs].dt)
'
WHERE [id] = 10

UPDATE [_pm_reports]
SET [SQL] = 'SELECT CONVERT(char(12), [_pm_jobs].dt, 106) AS [Date],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY CONVERT(char(12), [_pm_jobs].dt, 106)
ORDER BY CONVERT(char(12), [_pm_jobs].dt, 106) DESC
'
WHERE [id] = 11

UPDATE [_pm_reports]
SET [SQL] = 'SELECT DISTINCT Year([_pm_jobs].dt) as [Year],
    DATENAME(week, [_pm_jobs].dt) AS [Week],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY Year([_pm_jobs].dt), DATENAME(week, [_pm_jobs].dt) 
ORDER BY Year([_pm_jobs].dt) DESC, DATENAME(week, [_pm_jobs].dt) DESC
'
WHERE [id] = 12

UPDATE [_pm_reports]
SET [SQL] = 'SELECT DISTINCT Year([_pm_jobs].dt) as [Year],
    DATENAME(month, [_pm_jobs].dt) AS [Month],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY Year([_pm_jobs].dt), DATENAME(month, [_pm_jobs].dt)  
ORDER BY Year([_pm_jobs].dt) DESC, DATENAME(month, [_pm_jobs].dt) DESC
'
WHERE [id] = 13

UPDATE [_pm_reports]
SET [SQL] = 'SELECT Year([_pm_jobs].dt) as [Year],
    DATEPART(quarter, [_pm_jobs].dt) AS [Quarter],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY Year([_pm_jobs].dt), DATEPART(quarter, [_pm_jobs].dt)
ORDER BY Year([_pm_jobs].dt) DESC, DATEPART(quarter, [_pm_jobs].dt) DESC
'
WHERE [id] = 14

UPDATE [_pm_reports]
SET [SQL] = 'SELECT DISTINCT YEAR([_pm_jobs].dt) AS [year],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY YEAR([_pm_jobs].dt)
ORDER BY YEAR([_pm_jobs].dt)
'
WHERE [id] = 15

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_printers].name  AS [printer],
    [_pm_printers].alias  AS [alias],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_printers].name, [_pm_printers].alias
ORDER BY Sum(Convert(float, [_pm_jobs].ppages)) DESC , Sum(Convert(float, [_pm_jobs].pbytes)) DESC
'
WHERE [id] = 16

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_users].name AS [user],
    [_pm_users].alias AS [alias],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM ((([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
INNER JOIN [_pm_users] ON [_pm_users].id = [_pm_jobs].idUser)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_users].name, [_pm_users].alias
ORDER BY Sum(Convert(float, [_pm_jobs].ppages)) DESC , Sum(Convert(float, [_pm_jobs].pbytes)) DESC
'
WHERE [id] = 17

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_computers].ip AS [ip],
    [_pm_computers].name AS [name],
    [_pm_computers].alias AS [alias],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM ((([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
INNER JOIN [_pm_computers] ON [_pm_computers].id = [_pm_jobs].idComputer)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_computers].ip, [_pm_computers].name, [_pm_computers].alias
ORDER BY Sum(Convert(float, [_pm_jobs].ppages)) DESC , Sum(Convert(float, [_pm_jobs].pbytes)) DESC
'
WHERE [id] = 18

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_printers].name AS [printer],
    [_pm_printers].alias AS [printer_alias],
    [_pm_users].name AS [user],
    [_pm_users].alias AS [user_alias],
    Sum(Convert(float, [_pm_Jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM ((([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
INNER JOIN [_pm_users] ON [_pm_users].id = [_pm_jobs].idUser)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_printers].name, [_pm_printers].alias, [_pm_users].name, [_pm_users].alias
'
WHERE [id] = 19

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_computers].ip AS [ip],
    [_pm_computers].alias AS [computer_alias],
    [_pm_printers].name AS [printer],
    [_pm_printers].alias AS [printer_alias],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM ((([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
INNER JOIN [_pm_computers] ON [_pm_computers].id = [_pm_jobs].idComputer)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY [_pm_computers].ip, [_pm_computers].alias, [_pm_printers].name, [_pm_printers].alias
'
WHERE [id] = 20

UPDATE [_pm_reports]
SET [SQL] = 'SELECT DISTINCT DATEPART(hour, [_pm_jobs].dt) AS [hour],
    Sum(Convert(float, [_pm_jobs].pbytes)) AS [Sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) AS [Sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM (([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE (([_pm_jobs].isdelete = 0) AND (%TIME-START% <= [_pm_jobs].dt) AND ([_pm_jobs].dt <= %TIME-STOP%))
GROUP BY DATEPART(hour, [_pm_jobs].dt) 
ORDER BY DATEPART(hour, [_pm_jobs].dt)
'
WHERE [id] = 23

UPDATE [_pm_reports]
SET [SQL] = 'SELECT [_pm_users].name as [user],
    [_pm_jobs].doc as [doc],
    Sum(Convert(float, [_pm_jobs].pbytes)) as [sum-pbytes],
    Sum(Convert(float, [_pm_jobs].ppages)) as [sum-ppages],
    Sum(Convert(float,
        CASE [_pm_jobs].isduplex
            WHEN 0 THEN
                CASE [_pm_jobs].iscolor
                    WHEN 0 THEN IsNull([_pm_costs].BW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].Color, 0) * [_pm_jobs].ppages
                END
            ELSE
                CASE _pm_jobs.iscolor
                    WHEN 0 THEN IsNull([_pm_costs].DuplexBW, 0) * [_pm_jobs].ppages
                    ELSE IsNull([_pm_costs].DuplexColor, 0) * [_pm_jobs].ppages
                END
        END
    )) AS [sum-costs]
FROM ((([_pm_jobs]
INNER JOIN [_pm_formats] ON [_pm_formats].Format = [_pm_jobs].format)
INNER JOIN [_pm_printers] ON [_pm_printers].id = [_pm_jobs].idPrinter)
INNER JOIN [_pm_users] ON [_pm_users].id = [_pm_jobs].idUser)
LEFT JOIN [_pm_costs]
    ON (([_pm_jobs].Format = [_pm_costs].format) AND
    ([_pm_jobs].idPrinter = [_pm_costs].idPrinter))
WHERE ([_pm_jobs].IsDelete = 0) AND ([_pm_jobs].dt >= %TIME-START%) AND ([_pm_jobs].dt <= %TIME-STOP%)
GROUP BY [_pm_users].name, [_pm_jobs].doc
ORDER BY SUM([_pm_jobs].ppages) DESC
'
WHERE [name_enu] = 'By Docs'
END
GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 10, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 11, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 12, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 13, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 14, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 15, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 16, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 17, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 18, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 19, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 20, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( 23, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

DECLARE @id INT
SELECT @id=[id] FROM [_pm_reports] WHERE [name_enu] = 'By Docs'

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( @id, 'sum-costs', 100, 'Cost', 'Стоимость', 1, 1, 0)

INSERT INTO [_pm_reports_columns] ( [idReport] , [field] , [defwidth] , [text_enu] , [text_ru] , [AggregateFunc] , 
    [isGeneralColumn] , [ChartRole] )
VALUES( @id, 'sum-pbytes', 100, 'Bytes', 'Байты', 1, 0, 0)
END
GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[_pm_registry]') AND OBJECTPROPERTY(ID, N'IsUserTable') = 1)
BEGIN

DECLARE @id INT
SELECT @id=[id] FROM [_pm_reports] WHERE [name_enu] = 'By Docs'

UPDATE [_pm_reports_columns] SET [field] = 'sum-ppages'
WHERE ( [idreport] = @id ) AND ( [field] = 'Pages' );

CREATE TABLE [dbo].[_pm_registry] (
  [id] [int] IDENTITY (1, 1) NOT NULL ,
  [name] [varchar] (255) NOT NULL ,
  [value] [varchar] (255) NOT NULL , 
        [comment] [varchar] (255) NULL 
) ON [PRIMARY]

END
GO

UPDATE [dbo].[_pm_registry]
SET [value] = '3,09' 
WHERE [name] = 'version'
GO
