/* Creates all triggers */
/* For: MS SQL 2008 and above */




CREATE TRIGGER [dbo].[Node_update] 
   ON  [dbo].[Node]
   for UPDATE

AS 
BEGIN
	INSERT INTO dbo.NodeArchive ([NodeID]
      ,[ParentNodeID]
	  ,[root]
	  ,[primaryRecord]
	  ,[Slug]
      ,[xmlTitle]
      ,[Kind]
      ,[strData]
      ,[xmlData]
      ,[xmlConf]
      ,[xmlLink]
      ,[xmlTaxonomy]
      ,[xmlSecurity]
      ,[ExpirationDate]
      ,[pinned]
      ,[pStatus]
      ,[cStatus]
      ,[StartDate]
      ,[CommentMode]
      ,[StationaryPad]
      ,[SortOrder]
      ,[NoDelete]
      ,[DeleteDate]
      ,[Modified]
      ,[Created])
	SELECT [deleted].[NodeID]
      ,[deleted].[ParentNodeID]
	  ,[deleted].[root]
      ,[deleted].[primaryRecord]
      ,[deleted].[Slug]
      ,[deleted].[xmlTitle]
      ,[deleted].[Kind]
      ,[deleted].[strData]
      ,[deleted].[xmlData]
      ,[deleted].[xmlConf]
      ,[deleted].[xmlLink]
      ,[deleted].[xmlTaxonomy]
      ,[deleted].[xmlSecurity]
      ,[deleted].[ExpirationDate]
      ,[deleted].[pinned]
      ,[deleted].[pStatus]
      ,[deleted].[cStatus]
      ,[deleted].[StartDate]
      ,[deleted].[CommentMode]
      ,[deleted].[StationaryPad]
      ,[deleted].[SortOrder]
      ,[deleted].[NoDelete]
      ,[deleted].[DeleteDate]
      ,[deleted].[Modified]
      ,[deleted].[Created]
      
	FROM  [deleted] LEFT JOIN dbo.Node
	ON  [deleted].NodeID = dbo.Node.NodeID
	WHERE CONVERT(varchar(max), deleted.Modified) <> CONVERT(varchar(max), dbo.Node.Modified)



    -- Insert statements for trigger here

END
GO