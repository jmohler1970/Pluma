/* This creates all the tables, functions, and views to run the site */


ALTER TABLE [dbo].[LoginLog] DROP CONSTRAINT [FK_LoginLog_Users]
GO

ALTER TABLE [dbo].[LoginLog] DROP CONSTRAINT [DF_LoginLog_createDate]
GO

DROP TABLE [dbo].[LoginLog]
GO



CREATE TABLE [dbo].[LoginLog](
	[LoginLogID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[loginStatus] [varchar](20) NOT NULL,
	[remote_addr] [varchar](40) NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_LoginLog] PRIMARY KEY CLUSTERED 
(
	[LoginLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[LoginLog] ADD  CONSTRAINT [DF_LoginLog_createDate]  DEFAULT (getdate()) FOR [createDate]
GO

ALTER TABLE [dbo].[LoginLog]  WITH CHECK ADD  CONSTRAINT [FK_LoginLog_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO

ALTER TABLE [dbo].[LoginLog] CHECK CONSTRAINT [FK_LoginLog_Users]
GO



ALTER TABLE [dbo].[Node] DROP CONSTRAINT [FK_Node_Node]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_NoDelete]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_StationaryPad]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_cStatus]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_pinned]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_xmlTitle]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_Slug]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_Primary]
GO

ALTER TABLE [dbo].[Node] DROP CONSTRAINT [DF_Node_root]
GO

DROP TABLE [dbo].[Node]
GO



CREATE TABLE [dbo].[Node](
	[NodeID] [int] IDENTITY(1,1) NOT NULL,
	[ParentNodeID] [int] NULL,
	[root] [bit] NOT NULL,
	[PrimaryRecord] [bit] NOT NULL,
	[Slug] [varchar](50) NULL,
	[xmlTitle] [xml] NOT NULL,
	[Kind] [varchar](40) NOT NULL,
	[strData] [varchar](max) NULL,
	[xmlData] [xml] NULL,
	[xmlConf] [xml] NULL,
	[xmlLink] [xml] NULL,
	[xmlTaxonomy] [xml] NULL,
	[xmlSecurity] [xml] NULL,
	[ExpirationDate] [smalldatetime] NULL,
	[pinned] [bit] NOT NULL,
	[pStatus] [varchar](50) NOT NULL,
	[cStatus] [bit] NOT NULL,
	[StartDate] [smalldatetime] NULL,
	[CommentMode] [varchar](30) NULL,
	[StationaryPad] [bit] NOT NULL,
	[SortOrder] [smallint] NULL,
	[NoDelete] [bit] NOT NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] [smalldatetime] NULL,
	[Modified] [xml] NULL,
	[Created] [xml] NULL,
	[DataSize]  AS (((((((((((((isnull(datalength([ParentNodeID]),(0))+isnull(datalength([xmlTitle]),(0)))+isnull(datalength([Kind]),(0)))+isnull(datalength([strData]),(0)))+isnull(datalength([xmlConf]),(0)))+isnull(datalength([xmlLink]),(0)))+isnull(datalength([xmlTaxonomy]),(0)))+isnull(datalength([xmlSecurity]),(0)))+isnull(datalength([ExpirationDate]),(0)))+isnull(datalength([SortOrder]),(0)))+isnull(datalength([Pinned]),(0)))+isnull(datalength([pStatus]),(0)))+isnull(datalength([cStatus]),(0)))+isnull(datalength([StartDate]),(0))) PERSISTED,
 CONSTRAINT [PK_Node] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_root]  DEFAULT ((0)) FOR [root]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_Primary]  DEFAULT ((0)) FOR [PrimaryRecord]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_Slug]  DEFAULT ('') FOR [Slug]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_xmlTitle]  DEFAULT ('') FOR [xmlTitle]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_pinned]  DEFAULT ((0)) FOR [pinned]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_cStatus]  DEFAULT ((0)) FOR [cStatus]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_StationaryPad]  DEFAULT ((0)) FOR [StationaryPad]
GO

ALTER TABLE [dbo].[Node] ADD  CONSTRAINT [DF_Node_NoDelete]  DEFAULT ((0)) FOR [NoDelete]
GO

ALTER TABLE [dbo].[Node]  WITH NOCHECK ADD  CONSTRAINT [FK_Node_Node] FOREIGN KEY([ParentNodeID])
REFERENCES [dbo].[Node] ([NodeID])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Node] NOCHECK CONSTRAINT [FK_Node_Node]
GO


ALTER TABLE [dbo].[NodeArchive] DROP CONSTRAINT [DF_NodeArchive_NoDelete]
GO

ALTER TABLE [dbo].[NodeArchive] DROP CONSTRAINT [DF_NodeArchive_Slug]
GO

ALTER TABLE [dbo].[NodeArchive] DROP CONSTRAINT [DF_NodeArchive_primaryrecord]
GO

ALTER TABLE [dbo].[NodeArchive] DROP CONSTRAINT [DF_NodeArchive_root]
GO

ALTER TABLE [dbo].[NodeArchive] DROP CONSTRAINT [DF_NodeArchive_VersionDate]
GO

DROP TABLE [dbo].[NodeArchive]
GO


CREATE TABLE [dbo].[NodeArchive](
	[NodeArchiveID] [bigint] IDENTITY(1,1) NOT NULL,
	[VersionDate] [smalldatetime] NOT NULL,
	[NodeID] [int] NOT NULL,
	[parentNodeID] [int] NULL,
	[root] [bit] NOT NULL,
	[primaryRecord] [bit] NOT NULL,
	[slug] [varchar](50) NOT NULL,
	[xmlTitle] [xml] NOT NULL,
	[kind] [varchar](40) NOT NULL,
	[strData] [varchar](max) NULL,
	[xmlData] [xml] NULL,
	[xmlConf] [xml] NULL,
	[xmlLink] [xml] NULL,
	[xmlTaxonomy] [xml] NULL,
	[xmlSecurity] [xml] NULL,
	[expirationDate] [smalldatetime] NULL,
	[pinned] [bit] NOT NULL,
	[pStatus] [varchar](50) NOT NULL,
	[cStatus] [bit] NOT NULL,
	[StartDate] [smalldatetime] NULL,
	[CommentMode] [varchar](30) NULL,
	[StationaryPad] [bit] NOT NULL,
	[SortOrder] [smallint] NULL,
	[NoDelete] [bit] NOT NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] [smalldatetime] NULL,
	[Modified] [xml] NULL,
	[Created] [xml] NULL,
	[DataSize]  AS (((((((((((((isnull(datalength([ParentNodeID]),(0))+isnull(datalength([xmlTitle]),(0)))+isnull(datalength([Kind]),(0)))+isnull(datalength([strData]),(0)))+isnull(datalength([xmlConf]),(0)))+isnull(datalength([xmlLink]),(0)))+isnull(datalength([xmlTaxonomy]),(0)))+isnull(datalength([xmlSecurity]),(0)))+isnull(datalength([ExpirationDate]),(0)))+isnull(datalength([SortOrder]),(0)))+isnull(datalength([Pinned]),(0)))+isnull(datalength([pStatus]),(0)))+isnull(datalength([cStatus]),(0)))+isnull(datalength([StartDate]),(0))) PERSISTED,
 CONSTRAINT [PK_NodeArchive] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC,
	[NodeArchiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



ALTER TABLE [dbo].[NodeArchive] ADD  CONSTRAINT [DF_NodeArchive_VersionDate]  DEFAULT (getdate()) FOR [VersionDate]
GO

ALTER TABLE [dbo].[NodeArchive] ADD  CONSTRAINT [DF_NodeArchive_root]  DEFAULT ((0)) FOR [root]
GO

ALTER TABLE [dbo].[NodeArchive] ADD  CONSTRAINT [DF_NodeArchive_primaryrecord]  DEFAULT ((0)) FOR [primaryRecord]
GO

ALTER TABLE [dbo].[NodeArchive] ADD  CONSTRAINT [DF_NodeArchive_Slug]  DEFAULT ('') FOR [slug]
GO

ALTER TABLE [dbo].[NodeArchive] ADD  CONSTRAINT [DF_NodeArchive_NoDelete]  DEFAULT ((0)) FOR [NoDelete]
GO





ALTER TABLE [dbo].[Pref] DROP CONSTRAINT [DF_Pref_xmlPref]
GO

/****** Object:  Table [dbo].[Pref]    Script Date: 4/8/2013 9:25:01 PM ******/
DROP TABLE [dbo].[Pref]
GO



CREATE TABLE [dbo].[Pref](
	[Pref] [varchar](50) NOT NULL,
	[xmlPref] [xml] NOT NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] [smalldatetime] NULL,
	[Modified] [xml] NULL,
	[Created] [xml] NOT NULL,
 CONSTRAINT [PK_Pref] PRIMARY KEY CLUSTERED 
(
	[Pref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


ALTER TABLE [dbo].[Pref] ADD  CONSTRAINT [DF_Pref_xmlPref]  DEFAULT ('') FOR [xmlPref]
GO



ALTER TABLE [dbo].[Traffic] DROP CONSTRAINT [DF_Traffic_CreateDate]
GO

/****** Object:  Table [dbo].[Traffic]    Script Date: 4/8/2013 9:25:37 PM ******/
DROP TABLE [dbo].[Traffic]
GO


CREATE TABLE [dbo].[Traffic](
	[TrafficID] 	[bigint] IDENTITY(1,1) NOT NULL,
	[Subsystem] 	[varchar](15) NULL,
	[Section] 		[varchar](15) NOT NULL,
	[Item] 			[varchar](50) NOT NULL,
	[url_vars] 		[xml] NULL,
	[isPost] 		[bit] NOT NULL,
	[Referer] 		[varchar](max) NULL,
	[Agent] 		[varchar](max) NULL,
	[OS]  			AS ([dbo].[udf_OS]([agent])) PERSISTED,
	[Browser]		AS ([dbo].[udf_browser]([agent])) PERSISTED,
	[isBot]  		AS (case when [Agent] like '%bot%' then (1) else (0) end) PERSISTED NOT NULL,
	[http_accept_language] [varchar](max) NULL,
	[remote_addr]  	AS ([dbo].[udf_getRemote_addr](	[xmlGeoLocation])) 	PERSISTED,
	[CountryName]  	AS ([dbo].[udf_getCountryName](	[xmlGeoLocation])) 	PERSISTED,
	[RegionName]  	AS ([dbo].[udf_getRegionName](	[xmlGeoLocation])) 	PERSISTED,
	[City]  		AS ([dbo].[udf_getCity](		[xmlGeoLocation])) 	PERSISTED,
	[xmlGeoLocation] [xml] NOT NULL,
	[CreateDate] 	[smalldatetime] NOT NULL,
 CONSTRAINT [PK_Traffic] PRIMARY KEY CLUSTERED 
(
	[TrafficID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



ALTER TABLE [dbo].[Traffic] ADD  CONSTRAINT [DF_Traffic_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO


/****** Object:  Table [dbo].[Users]    Script Date: 4/9/2013 7:05:02 PM ******/
DROP TABLE [dbo].[Users]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 4/9/2013 7:05:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Users](
	[UserID] 		[int] IDENTITY(1,1) NOT NULL,
	[login] 		[varchar](80) NULL,
	[passhash] 		[char](10) NULL,
	[PersonName]	[xml] NULL,
	[homepath] 		[varchar](50) NULL,
	[email] 		[varchar](100) NULL,
	[comments] 		[varchar](max) SPARSE  NULL,
	[lastLogin] 	[smalldatetime] NULL,
	[ExpirationDate] [date] NULL,
	[xmlAbout] 		[xml] NULL,
	[xmlProfile] 	[xml] NULL,
	[xmlContact] 	[xml] NULL,
	[xmlLink] 		[xml] NULL,
	[xmlPref] 		[xml] NULL,
	[xmlGroup] 		[xml] NULL,
	[PrefGroup] 	[varchar](30) NULL,
	[Active]  AS (case when [DeleteDate] IS NULL AND ([ExpirationDate] IS NULL OR datediff(day,[ExpirationDate],getdate())<(0)) then (1) else (0) end),
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	[Modified] 		[xml] NULL,
	[Created] 		[xml] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO





