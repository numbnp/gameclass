if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__pm_jobs__pm_computers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[_pm_jobs] DROP CONSTRAINT FK__pm_jobs__pm_computers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__pm_filters_conditions__pm_filters]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[_pm_filters_conditions] DROP CONSTRAINT FK__pm_filters_conditions__pm_filters
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__pm_jobs__pm_printers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[_pm_jobs] DROP CONSTRAINT FK__pm_jobs__pm_printers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__pm_filters__pm_reports]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[_pm_filters] DROP CONSTRAINT FK__pm_filters__pm_reports
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__pm_reports_columns__pm_reports]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[_pm_reports_columns] DROP CONSTRAINT FK__pm_reports_columns__pm_reports
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__pm_jobs__pm_users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[_pm_jobs] DROP CONSTRAINT FK__pm_jobs__pm_users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_advices]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_advices]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_computers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_computers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_computersGroups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_computersGroups]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_filters]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_filters]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_filters_conditions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_filters_conditions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_jobs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_jobs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_messages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_messages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_printers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_printers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_reports]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_reports]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_reports_columns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_reports_columns]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_pm_users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_pm_users]
GO

CREATE TABLE [dbo].[_pm_advices] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[text] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[link] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[linktype] [int] NOT NULL ,
	[category] [int] NOT NULL ,
	[linktext] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[languageId] [int] NOT NULL ,
	[isDelete] [tinyint] NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_computers] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[ip] [char] (64) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[idComputersGroup] [int] NOT NULL ,
	[comment] [text] COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_computersGroups] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[comment] [text] COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_filters] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[comment] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[idReport] [int] NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_filters_conditions] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idFilter] [int] NOT NULL ,
	[field] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[condition] [char] (16) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[value] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[operation] [char] (32) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL ,
	[comment] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_jobs] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idPrinter] [int] NOT NULL ,
	[idUser] [int] NOT NULL ,
	[idComputer] [int] NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[jid] [int] NOT NULL ,
	[doc] [varchar] (1024) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[tbytes] [int] NOT NULL ,
	[tpages] [int] NOT NULL ,
	[pbytes] [int] NOT NULL ,
	[ppages] [int] NOT NULL ,
	[copies] [int] NOT NULL ,
	[isColor] [tinyint] NOT NULL ,
	[isDuplex] [tinyint] NOT NULL ,
	[format] [char] (64) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isDelete] [tinyint] NOT NULL ,
	[isOk] [tinyint] NOT NULL ,
	[comment] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL ,
	[isVisible] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_messages] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[dt] [datetime] NOT NULL ,
	[text] [varchar] (8000) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[code] [int] NOT NULL ,
	[category] [varchar] (64) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[comment] [varchar] (8000) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_printers] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[cost] [money] NOT NULL ,
	[cost_color] [money] NOT NULL ,
	[cost_duplex] [money] NOT NULL ,
	[cost_duplex_color] [money] NOT NULL ,
	[is_cost_details] [tinyint] NOT NULL ,
	[comment] [text] COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_reports] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idParent] [int] NOT NULL ,
	[name_enu] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[name_ru] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isFolder] [tinyint] NOT NULL ,
	[isReadOnly] [tinyint] NOT NULL ,
	[SQL] [text] COLLATE Cyrillic_General_CI_AS NULL ,
	[comment] [text] COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[isDelete] [tinyint] NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_reports_columns] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[idReport] [int] NOT NULL ,
	[field] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[defwidth] [int] NOT NULL ,
	[comment] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[text_enu] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[text_ru] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[AggregateFunc] [int] NOT NULL ,
	[isGeneralColumn] [tinyint] NOT NULL ,
	[ChartRole] [int] NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[_pm_users] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[comment] [text] COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved1] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved2] [varchar] (255) COLLATE Cyrillic_General_CI_AS NOT NULL ,
	[reserved3] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[_pm_advices] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_advices] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_computers] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_computers] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_computersGroups] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_computersGroups] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_filters] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_filters] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_filters_conditions] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_filters_conditions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_jobs] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_jobs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_messages] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_messages] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_printers] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_printers] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_reports] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_reports] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_reports_columns] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_reports_columns] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_users] WITH NOCHECK ADD 
	CONSTRAINT [PK__pm_users] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[_pm_advices] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_advices_text] DEFAULT ('') FOR [text],
	CONSTRAINT [DF__pm_advices_link] DEFAULT ('') FOR [link],
	CONSTRAINT [DF__pm_advices_linktype] DEFAULT (0) FOR [linktype],
	CONSTRAINT [DF__pm_advices_category] DEFAULT (0) FOR [category],
	CONSTRAINT [DF__pm_advices_linktext] DEFAULT ('') FOR [linktext],
	CONSTRAINT [DF__pm_advices_languageId] DEFAULT (0) FOR [languageId],
	CONSTRAINT [DF__pm_advices_isDelete] DEFAULT (0) FOR [isDelete],
	CONSTRAINT [DF__pm_advices_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_advices_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_advices_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_computers] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_computers_name] DEFAULT ('') FOR [name],
	CONSTRAINT [DF__pm_computers_ip] DEFAULT ('127.0.0.1') FOR [ip],
	CONSTRAINT [DF__pm_computers_idComputersGroup] DEFAULT (0) FOR [idComputersGroup],
	CONSTRAINT [DF__pm_computers_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_computers_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_computers_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_computers_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_computersGroups] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_computersGroups_name] DEFAULT ('') FOR [name],
	CONSTRAINT [DF__pm_computersGroups_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_computersGroups_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_computersGroups_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_computersGroups_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_filters] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_filters_name] DEFAULT ('') FOR [name],
	CONSTRAINT [DF__pm_filters_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_filters_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_filters_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_filters_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_filters_conditions] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_filters_conditions_field] DEFAULT ('') FOR [field],
	CONSTRAINT [DF__pm_filters_conditions_condition] DEFAULT ('=') FOR [condition],
	CONSTRAINT [DF__pm_filters_conditions_value] DEFAULT ('') FOR [value],
	CONSTRAINT [DF__pm_filters_conditions_operation] DEFAULT ('AND') FOR [operation],
	CONSTRAINT [DF__pm_filters_conditions_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_filters_conditions_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_filters_conditions_reserved3] DEFAULT (0) FOR [reserved3],
	CONSTRAINT [DF__pm_filters_conditions_comment] DEFAULT ('') FOR [comment]
GO

ALTER TABLE [dbo].[_pm_jobs] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_jobs_jid] DEFAULT (0) FOR [jid],
	CONSTRAINT [DF__pm_jobs_doc] DEFAULT ('') FOR [doc],
	CONSTRAINT [DF__pm_jobs_tbytes] DEFAULT (0) FOR [tbytes],
	CONSTRAINT [DF__pm_jobs_tpages] DEFAULT (0) FOR [tpages],
	CONSTRAINT [DF__pm_jobs_pbytes] DEFAULT (0) FOR [pbytes],
	CONSTRAINT [DF__pm_jobs_ppages] DEFAULT (0) FOR [ppages],
	CONSTRAINT [DF__pm_jobs_copies] DEFAULT (1) FOR [copies],
	CONSTRAINT [DF__pm_jobs_isColor] DEFAULT (0) FOR [isColor],
	CONSTRAINT [DF__pm_jobs_isDuplex] DEFAULT (0) FOR [isDuplex],
	CONSTRAINT [DF__pm_jobs_isDelete] DEFAULT (0) FOR [isDelete],
	CONSTRAINT [DF__pm_jobs_isOk] DEFAULT (1) FOR [isOk],
	CONSTRAINT [DF__pm_jobs_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_jobs_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_jobs_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_jobs_reserved3] DEFAULT (0) FOR [reserved3],
	CONSTRAINT [DF__pm_jobs_isVisible] DEFAULT (1) FOR [isVisible]
GO

ALTER TABLE [dbo].[_pm_messages] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_messages_text] DEFAULT ('') FOR [text],
	CONSTRAINT [DF__pm_messages_code] DEFAULT (0) FOR [code],
	CONSTRAINT [DF__pm_messages_category] DEFAULT ('info') FOR [category],
	CONSTRAINT [DF__pm_messages_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_messages_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_messages_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_messages_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_printers] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_printers_name] DEFAULT ('') FOR [name],
	CONSTRAINT [DF__pm_printers_cost] DEFAULT (1) FOR [cost],
	CONSTRAINT [DF__pm_printers_cost_color] DEFAULT (0.1) FOR [cost_color],
	CONSTRAINT [DF__pm_printers_cost_duplex] DEFAULT (0.1) FOR [cost_duplex],
	CONSTRAINT [DF__pm_printers_cost_duplex_color] DEFAULT (0.1) FOR [cost_duplex_color],
	CONSTRAINT [DF__pm_printers_is_cost_details] DEFAULT (1) FOR [is_cost_details],
	CONSTRAINT [DF__pm_printers_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_printers_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_printers_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_printers_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_reports] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_reports_idParent] DEFAULT (0) FOR [idParent],
	CONSTRAINT [DF__pm_reports_name_enu] DEFAULT ('report_') FOR [name_enu],
	CONSTRAINT [DF__pm_reports_name] DEFAULT ('report_') FOR [name_ru],
	CONSTRAINT [DF__pm_reports_isFolder] DEFAULT (1) FOR [isFolder],
	CONSTRAINT [DF__pm_reports_isReadOnly] DEFAULT (0) FOR [isReadOnly],
	CONSTRAINT [DF__pm_reports_SQL] DEFAULT ('') FOR [SQL],
	CONSTRAINT [DF__pm_reports_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_reports_isDelete] DEFAULT (0) FOR [isDelete],
	CONSTRAINT [DF__pm_reports_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_reports_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_reports_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_reports_columns] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_reports_columns_field] DEFAULT ('') FOR [field],
	CONSTRAINT [DF__pm_reports_columns_defwidth] DEFAULT (10) FOR [defwidth],
	CONSTRAINT [DF__pm_reports_columns_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_reports_columns_text_enu] DEFAULT ('') FOR [text_enu],
	CONSTRAINT [DF__pm_reports_columns_text] DEFAULT ('') FOR [text_ru],
	CONSTRAINT [DF__pm_reports_columns_AggregateFunc] DEFAULT (0) FOR [AggregateFunc],
	CONSTRAINT [DF__pm_reports_columns_isGeneralColumn] DEFAULT (0) FOR [isGeneralColumn],
	CONSTRAINT [DF__pm_reports_columns_ChartRole] DEFAULT (0) FOR [ChartRole],
	CONSTRAINT [DF__pm_reports_columns_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_reports_columns_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_reports_columns_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_users] WITH NOCHECK ADD 
	CONSTRAINT [DF__pm_users_name] DEFAULT ('') FOR [name],
	CONSTRAINT [DF__pm_users_comment] DEFAULT ('') FOR [comment],
	CONSTRAINT [DF__pm_users_reserved1] DEFAULT ('') FOR [reserved1],
	CONSTRAINT [DF__pm_users_reserved2] DEFAULT ('') FOR [reserved2],
	CONSTRAINT [DF__pm_users_reserved3] DEFAULT (0) FOR [reserved3]
GO

ALTER TABLE [dbo].[_pm_filters] ADD 
	CONSTRAINT [FK__pm_filters__pm_reports] FOREIGN KEY 
	(
		[idReport]
	) REFERENCES [dbo].[_pm_reports] (
		[id]
	)
GO

ALTER TABLE [dbo].[_pm_filters_conditions] ADD 
	CONSTRAINT [FK__pm_filters_conditions__pm_filters] FOREIGN KEY 
	(
		[idFilter]
	) REFERENCES [dbo].[_pm_filters] (
		[id]
	)
GO

ALTER TABLE [dbo].[_pm_jobs] ADD 
	CONSTRAINT [FK__pm_jobs__pm_computers] FOREIGN KEY 
	(
		[idComputer]
	) REFERENCES [dbo].[_pm_computers] (
		[id]
	),
	CONSTRAINT [FK__pm_jobs__pm_printers] FOREIGN KEY 
	(
		[idPrinter]
	) REFERENCES [dbo].[_pm_printers] (
		[id]
	),
	CONSTRAINT [FK__pm_jobs__pm_users] FOREIGN KEY 
	(
		[idUser]
	) REFERENCES [dbo].[_pm_users] (
		[id]
	)
GO

ALTER TABLE [dbo].[_pm_reports_columns] ADD 
	CONSTRAINT [FK__pm_reports_columns__pm_reports] FOREIGN KEY 
	(
		[idReport]
	) REFERENCES [dbo].[_pm_reports] (
		[id]
	)
GO

