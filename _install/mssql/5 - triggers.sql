/* Creates all triggers */
/* For: MS SQL 2008 and above */




CREATE TRIGGER [dbo].[Node_update] 
   ON  [dbo].[Node]
   for UPDATE

AS 
BEGIN
	INSERT INTO dbo.NodeArchive ([NodeID]
      ,[Kind]
      ,[xmlData]
      ,[xmlConf]
      ,[xmlLink]
      ,[DeleteDate]
      ,[Modified]
      ,[Created])
	SELECT [deleted].[NodeID]
      ,[deleted].[Kind]
      ,[deleted].[xmlData]
      ,[deleted].[xmlConf]
      ,[deleted].[xmlLink]
      ,[deleted].[DeleteDate]
      ,[deleted].[Modified]
      ,[deleted].[Created]
      
	FROM  [deleted] LEFT JOIN dbo.Node
	ON  [deleted].NodeID = dbo.Node.NodeID
	WHERE CONVERT(varchar(max), deleted.Modified) <> CONVERT(varchar(max), dbo.Node.Modified)



    -- Insert statements for trigger here

END
GO