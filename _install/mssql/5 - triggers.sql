/* Creates all triggers */
/* For: MS SQL 2008 and above */




CREATE TRIGGER [dbo].[Node_update] 
   ON  [dbo].[Node]
   for UPDATE

AS 
BEGIN
	INSERT INTO dbo.NodeArchive ([NodeID]
      ,[Kind]
      ,[gsData]
      ,[xoxoConf]
      ,[xoxoLink]
      ,[DeleteDate]
      ,[ModifyDate]
      ,[ModifyBy]
      ,[CreateDate]
      ,[CreateBy]
      )
      
	SELECT [deleted].[NodeID]
      ,[deleted].[Kind]
      ,[deleted].[gsData]
      ,[deleted].[xoxoConf]
      ,[deleted].[xoxoLink]
      ,[deleted].[DeleteDate]
      ,[deleted].[ModifyDate]
      ,[deleted].[ModifyBy]
      ,[deleted].[CreateDate]
      ,[deleted].[CreateBy]
      
	FROM  [deleted] LEFT JOIN dbo.Node
	ON  [deleted].NodeID = dbo.Node.NodeID
	WHERE deleted.ModifyDate <> dbo.Node.ModifyDate



    -- Insert statements for trigger here

END
