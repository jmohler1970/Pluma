/* This destroys all created db objects. It does it the reverse order from the create operations */
/* For: MS SQL 2008 and above */

/* Indexes */
DROP INDEX [IX_xmlPersonName] ON [dbo].[Users]


DROP FULLTEXT CATALOG [FTC_Node]


/* Tiggers, I mean Triggers */
DROP TRIGGER [dbo].[Node_update]


/* Stored procedures */
DROP PROCEDURE [dbo].[usp_TrafficReferer]


DROP PROCEDURE [dbo].[usp_TrafficOrganic]


DROP PROCEDURE [dbo].[usp_TrafficCountry]


DROP PROCEDURE [dbo].[usp_TrafficOS]


DROP PROCEDURE [dbo].[usp_TrafficDetails]


/* Views except xoxo */
DROP VIEW [dbo].[vwNode]



DROP VIEW [dbo].[vwNodeSort]





/* Tables */
ALTER TABLE [dbo].[LoginLog] DROP CONSTRAINT [FK_LoginLog_Users]


ALTER TABLE [dbo].[LoginLog] DROP CONSTRAINT [DF_LoginLog_createDate]


DROP TABLE [dbo].[LoginLog]




ALTER TABLE [dbo].[Node] DROP CONSTRAINT [FK_Node_Node]


DROP TABLE [dbo].[Node]




ALTER TABLE [dbo].[NodeArchive] DROP CONSTRAINT [DF_NodeArchive_NoDelete]



DROP TABLE [dbo].[NodeArchive]




ALTER TABLE [dbo].[Pref] DROP CONSTRAINT [DF_Pref_xmlPref]


DROP TABLE [dbo].[Pref]



ALTER TABLE [dbo].[Traffic] DROP CONSTRAINT [DF_Traffic_CreateDate]


DROP TABLE [dbo].[Traffic]



DROP TABLE [dbo].[Users]


/* Scalar Functions */
DROP FUNCTION [dbo].[udf_OS]



DROP FUNCTION [dbo].[udf_Browser]



DROP FUNCTION [dbo].[udf_getCity]



DROP FUNCTION [dbo].[udf_getCountryName]



DROP FUNCTION [dbo].[udf_getRegionName]



DROP FUNCTION [dbo].[udf_getRemote_addr]



DROP FUNCTION [dbo].[udf_getSimpleRead]




DROP FUNCTION [dbo].[udf_4jDebug]



DROP FUNCTION [dbo].[udf_4jError]


DROP FUNCTION [dbo].[udf_4jFatal]



DROP FUNCTION [dbo].[udf_4jInfo]



DROP FUNCTION [dbo].[udf_4jSuccess]



DROP FUNCTION [dbo].[udf_4jTicket]



DROP FUNCTION [dbo].[udf_4jWarn]



DROP FUNCTION [dbo].[udf_Slugify]



DROP FUNCTION [dbo].[udf_StripHTML]



DROP FUNCTION [dbo].[udf_xmlToStr]



/* Table Value Functions */ 
DROP FUNCTION [dbo].[udf_calendar]



DROP FUNCTION [dbo].[udf_taxonomyRead]



/* XOXO views and functions */
DROP VIEW [dbo].[vwUser]



DROP FUNCTION [dbo].[udf_xoxoRead]


