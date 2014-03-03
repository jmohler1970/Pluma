/* This creates all the tables, functions, and views to run the site */
/* For: MS SQL 2008 and above */


/* Users has to be created early because there are FK relationships to it */

CREATE TABLE [dbo].[Users](
	[UserID] 		[int] IDENTITY(1,1) NOT NULL,
	[login] 		[nvarchar](80) NULL,
	[passhash] 		[char](10) NULL,
	[PersonName]	[xml] NULL,					/* rfc6351 */
	[slug] 			[nvarchar](50) NOT NULL,
	
	
	[pStatus] 		[nvarchar](50) NOT NULL,
	[lastLogin] 	[smalldatetime] NULL,
	[ExpirationDate] [date] NULL,
	
	[xmlProfile] 	[xml] NULL,		/* Non searchable things about user, order matters */
	[xmlLink] 		[xml] NULL,		/* Links to things that interest user */
	[xmlPref] 		[xml] NULL,		/* User setable config for internal use */
	[xmlGroup] 		[xml] NULL,		/* Security */
	
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


CREATE TABLE [dbo].[DataLog](
	[DataLogID] 	[bigint] IDENTITY(1,1) NOT NULL,
	[Kind] 			[nvarchar](40) NOT NULL,
	[Created] 		[xml] NULL,

 CONSTRAINT [PK_DataLog] PRIMARY KEY CLUSTERED 
(
	[DataLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO




CREATE TABLE [dbo].[Node](
	[NodeID] 		[int] IDENTITY(1,1) NOT NULL,
	[Kind] 			[nvarchar](40) NOT NULL,			/* Page and other things */

	[xmlData] 		[xml] NULL,							/* From getSimple */
	[xoxoLink] 		[xml] NOT NULL DEFAULT "",			
	[xoxoConf] 		[xml] NULL,
	
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	[Modified] 		[xml] NULL,
	[Created] 		[xml] NULL,
	[DataSize]  AS (isnull(datalength([xmlData]),(0))) PERSISTED,
 CONSTRAINT [PK_Node] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO




ALTER TABLE [dbo].[Node]  WITH NOCHECK ADD  CONSTRAINT [FK_Node_Node] FOREIGN KEY([ParentNodeID])
REFERENCES [dbo].[Node] ([NodeID])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[Node] NOCHECK CONSTRAINT [FK_Node_Node]
GO



CREATE TABLE [dbo].[NodeArchive](
	[NodeArchiveID] [bigint] IDENTITY(1,1) NOT NULL,
	[VersionDate] 	[smalldatetime] NOT NULL,
	[NodeID] 		[int] NOT NULL,
	[xmlData] 		[xml] NULL,
	[xmlConf] 		[xml] NULL,
	[xmlLink] 		[xml] NULL,
	
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	[Modified] 		[xml] NULL,
	[Created] 		[xml] NULL,
	[DataSize]  AS (isnull(datalength([xmlData]),(0))) PERSISTED,
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






CREATE TABLE [dbo].[Pref](
	[Pref] 		[nvarchar](50) NOT NULL,
	[xmlPref] 	[xml] NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] [smalldatetime] NULL,
	[Modified] 	[xml] NULL,
	[Created] 	[xml] NOT NULL,
 CONSTRAINT [PK_Pref] PRIMARY KEY CLUSTERED 
(
	[Pref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[Traffic](
	[TrafficID] 	[bigint] IDENTITY(1,1) NOT NULL,
	[Subsystem] 	[nvarchar](15) NULL,
	[Section] 		[nvarchar](15) NOT NULL,
	[Item] 			[nvarchar](50) NOT NULL,
	[url_vars] 		[xml] NULL,
	[isPost] 		[bit] NOT NULL,
	[Referer] 		[nvarchar](max) NULL,
	[Agent] 		[nvarchar](max) NULL,
	[OS]  			AS ([dbo].[udf_OS]([agent])) PERSISTED,
	[Browser]		AS ([dbo].[udf_browser]([agent])) PERSISTED,
	[isBot]  		AS (case when [Agent] like '%bot%' then (1) else (0) end) PERSISTED NOT NULL,
	[http_accept_language] [nvarchar](max) NULL,
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




