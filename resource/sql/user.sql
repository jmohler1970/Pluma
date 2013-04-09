USE [PlumaCMS]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 3/24/2013 1:29:10 PM ******/
DROP TABLE [dbo].[Users]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 3/24/2013 1:29:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Users](
	[UserID] 		[int] IDENTITY(1,1) NOT NULL,
	[login] 		[varchar](80) 	NULL,
	[passhash] 		[char](10) 		NULL,
	[PersonName] 	[xml](DOCUMENT [dbo].[PersonName]) NULL,
	[homepath] 		[varchar](50) 	NULL,
	[email] 		[varchar](100) 	NULL,
	[comments] 		[varchar](max)	SPARSE 	NULL,
	[lastLogin] 	[smalldatetime] NULL,
	[uStatus] 		[varchar](20) 	NOT NULL,
	[ExpirationDate] [date] 		NULL,
	[xmlAbout] 		[xml] 			NULL,		/* about this person page */
	[xmlProfile] 	[xml] 			NULL,		/* profile page */
	[xmlContact]	[xml] 			NULL,		/* Address, phone */ 
	[xmlLink] 		[xml] 			NULL,		/* Favorite links */
	[xmlPref] 		[xml] 			NULL,		/* Preferences */
	
	[xmlGroup] 		[xml] 			NOT NULL,	/* Security */
	[PrefGroup] 	[varchar](30) 	NULL,
	[Active] 		[int] 			NOT NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	[Modified] 		[xml] 			NULL,
	[Created] 		[xml] 			NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




USE [PlumaCMS]
GO

/****** Object:  View [dbo].[vwUser]    Script Date: 3/24/2013 1:45:42 PM ******/
DROP VIEW [dbo].[vwUser]
GO

/****** Object:  View [dbo].[vwUser]    Script Date: 3/24/2013 1:45:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[vwUser] 
AS
WITH XMLNAMESPACES (DEFAULT 'http://ns.hr-xml.org/2007-04-15')
SELECT   dbo.Users.UserID, login, passhash, 
		PersonName.value('(/PersonName/GivenName)[1]', 'nvarchar(max)') AS firstname,
		PersonName.value('(/PersonName/MiddleName)[1]', 'nvarchar(max)') AS middlename,
		PersonName.value('(/PersonName/FamilyName)[1]', 'nvarchar(max)') AS lastname,
		PersonName.value('(/PersonName/Affix)[1]', 'nvarchar(max)') AS postfix,

		homepath, 
	
		
		lastLogin, uStatus, 
		ExpirationDate, xmlAbout, xmlProfile, xmlContact, xmlLink,  
        email, comments, 
		Groups,
		xmlGroup, Active,
		PrefGroup, Deleted, DeleteDate, 
		
		M.Datetime AS ModifyDate, M.[By] AS ModifyBy, C.[By] AS CreateDate, M.[Datetime] AS CreateBy,

		xmlPref.value('(/data/@type="php")[1]', 'nvarchar(max)') AS PHP,
		xmlPref.value('(/data/@type="stars")[1]', 'nvarchar(max)') AS Stars,
		xmlPref.value('(/data/@type="membershiptype")[1]', 'nvarchar(max)') AS Membershiptype,
		xmlPref.value('(/data/@type="commentmode")[1]', 'nvarchar(max)') AS CommentMode,
		xmlPref.value('(/data/@type="personalstatus")[1]', 'nvarchar(max)') AS PersonalStatus



FROM         dbo.Users WITH (NOLOCK)
	LEFT JOIN dbo.vwGroup ON dbo.Users.UserID = dbo.vwGroup.UserID
CROSS APPLY dbo.udf_4jRead(Modified)	M
CROSS APPLY dbo.udf_4jRead(Created)		C







GO

