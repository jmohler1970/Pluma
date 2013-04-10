/* This destroys all created db objects. It does it the reverse order from the create operations */

/* Indexes */
DROP INDEX [IX_xmlPersonName] ON [dbo].[Users]
GO

DROP INDEX [IX_xmlTitle] ON [dbo].[Node]
GO

DROP FULLTEXT CATALOG [FTC_Node]
GO


/* Tiggers, I mean Triggers */
DROP TRIGGER [dbo].[Node_update]
GO

/* Stored procedures */
DROP PROCEDURE [dbo].[usp_TrafficReferer]
GO

DROP PROCEDURE [dbo].[usp_TrafficOrganic]
GO

DROP PROCEDURE [dbo].[usp_TrafficCountry]
GO

DROP PROCEDURE [dbo].[usp_TrafficOS]
GO

DROP PROCEDURE [dbo].[usp_TrafficDetails]
GO

/* Views */
DROP VIEW [dbo].[vwNode]
GO


DROP VIEW [dbo].[vwNodeSort]
GO

DROP VIEW [dbo].[vwUser]
GO


/* Tables */
ALTER TABLE [dbo].[LoginLog] DROP CONSTRAINT [FK_LoginLog_Users]
GO

ALTER TABLE [dbo].[LoginLog] DROP CONSTRAINT [DF_LoginLog_createDate]
GO

DROP TABLE [dbo].[LoginLog]
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



ALTER TABLE [dbo].[Pref] DROP CONSTRAINT [DF_Pref_xmlPref]
GO

DROP TABLE [dbo].[Pref]
GO


ALTER TABLE [dbo].[Traffic] DROP CONSTRAINT [DF_Traffic_CreateDate]
GO

DROP TABLE [dbo].[Traffic]
GO


DROP TABLE [dbo].[Users]
GO

/* Scalar Functions */
DROP FUNCTION [dbo].[udf_OS]
GO


DROP FUNCTION [dbo].[udf_Browser]
GO


DROP FUNCTION [dbo].[udf_getCity]
GO


DROP FUNCTION [dbo].[udf_getCountryName]
GO


DROP FUNCTION [dbo].[udf_getRegionName]
GO


DROP FUNCTION [dbo].[udf_getRemote_addr]
GO


DROP FUNCTION [dbo].[udf_4jDebug]
GO


DROP FUNCTION [dbo].[udf_4jError]
GO


DROP FUNCTION [dbo].[udf_4jFatal]
GO


DROP FUNCTION [dbo].[udf_4jInfo]
GO


DROP FUNCTION [dbo].[udf_4jSuccess]
GO


DROP FUNCTION [dbo].[udf_4jTicket]
GO


DROP FUNCTION [dbo].[udf_4jWarn]
GO


DROP FUNCTION [dbo].[udf_Slugify]
GO


DROP FUNCTION [dbo].[udf_StripHTML]
GO


DROP FUNCTION [dbo].[udf_xmlToStr]
GO


/* Table Value Functions */ 
DROP FUNCTION [dbo].[udf_4jRead]
GO


DROP FUNCTION [dbo].[udf_calendar]
GO


DROP FUNCTION [dbo].[udf_taxonomyRead]
GO


DROP FUNCTION [dbo].[udf_titleRead]
GO


DROP FUNCTION [dbo].[udf_xmlRead]
GO


