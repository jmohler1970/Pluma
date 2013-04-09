

/****** Object:  Table [dbo].[Pref]    Script Date: 3/24/2013 12:10:58 PM ******/
DROP TABLE [dbo].[Pref]
GO

/****** Object:  Table [dbo].[Pref]    Script Date: 3/24/2013 12:10:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE 
TABLE [dbo].[Pref](
	[Pref] 			[varchar](50) 	NOT NULL,
	[xmlPref] 		[xml] 			NOT NULL,
	[Deleted]  AS (case when [DeleteDate] IS NULL then (0) else (1) end),
	[DeleteDate] 	[smalldatetime] NULL,
	[Modified] 		[xml] 			NOT NULL,
	[Created] 		[xml] 			NOT NULL,

CONSTRAINT [PK_Pref] PRIMARY KEY CLUSTERED 
	(
		[Pref] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

