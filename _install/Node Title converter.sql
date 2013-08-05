	
	
UPDATE dbo.Node
SET xmlTitle = '<ul class="xoxo">'
		+ '<li><b>Extra</b> <var>' + ISNULL(Node2.xmlTitle.value('(/extra)[1]',		'nvarchar(max)'), '') + '</var></li>'
		+ '<li><b>Title</b> <var>' + ISNULL(Node2.xmlTitle.value('(/title)[1]',		'nvarchar(max)'), '') + '</var></li></ul>'	


FROM	dbo.Node
INNER JOIN dbo.Node AS Node2
ON dbo.Node.NodeID = Node2.NodeID	
	
