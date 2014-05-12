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
	
	[Root] 			AS		(CASE WHEN Kind = 'Page' AND dbo.udf_GSslug(GSdata) = 'index' THEN 1 ELSE 0 END) PERSISTED,
	[Title]			AS		(dbo.udf_gsTitle(GSdata)) PERSISTED,		
	[Slug]			AS		(dbo.udf_gsSlug(GSdata)) PERSISTED,		
	[Parent]		AS		(dbo.udf_gsParent(GSdata)) PERSISTED,		
	
	
	[gsData] 		[xml] NULL,							/* From getSimple */
	[xoxoLink] 		[xml] NOT NULL DEFAULT '',			
	[xoxoConf] 		[xml] NULL,
	[DataSize]  	AS (isnull(datalength([GSdata]),(0))) PERSISTED,
	
	[Deleted]  		AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	
	[ModifyBy] 		varchar(50) NOT NULL DEFAULT '',
	[ModifyDate] 	datetime NOT NULL DEFAULT getDate(),
	
	[CreateBy] 		varchar(50) NOT NULL DEFAULT '',
	[CreateDate] 	datetime NOT NULL DEFAULT getDate(),
	
	
	
	
 CONSTRAINT [PK_Node] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO





CREATE TABLE [dbo].[NodeArchive](
	[NodeArchiveID] [bigint] IDENTITY(1,1) NOT NULL,
	[VersionDate] 	[smalldatetime] NOT NULL DEFAULT getDate(),
	[NodeID] 		[int] NOT NULL,
	[Kind] 			[nvarchar](40) NOT NULL,
	
	[Root] 			AS		(CASE WHEN Kind = 'Page' AND dbo.udf_GSslug(GSdata) = 'index' THEN 1 ELSE 0 END) PERSISTED,

	[gsData] 		[xml] NULL,
	[xoxoConf] 		[xml] NULL,
	[xoxoLink] 		[xml] NULL,
	[DataSize]  AS (isnull(datalength([gsData]),(0))) PERSISTED,


	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	
	[ModifyBy] 		varchar(50) NOT NULL,
	[ModifyDate] 	datetime NOT NULL,
	
	[CreateBy] 		varchar(50) NOT NULL,
	[CreateDate] 	datetime NOT NULL,
	
	
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
	[xoxoPref] 	[xml] NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] [smalldatetime] NULL,

	[ModifyBy] 		varchar(50) NOT NULL DEFAULT '',
	[ModifyDate] 	datetime NOT NULL DEFAULT getDate(),
	
	[CreateBy] 		varchar(50) NOT NULL DEFAULT '',
	[CreateDate] 	datetime NOT NULL DEFAULT getDate()
	
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




