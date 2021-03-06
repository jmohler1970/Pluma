/* xoxo requires that the reader and vwUser be present before additional functions and views be built */


/*
DECLARE @someData xml = '
<ul class="xoxo">
	<!-- Menu control -->
	<li><b>Tag</b> <var>Cats</var></li>
	<li><b>Tag</b> <var>Dogs</var></li>
	<li data-position="4" data-status="whatever"><b>Menu</b> <var>Animals</var></li>

	<!-- List of links -->
	<li title="Click me" data-position="1"><b>Website</b>: 
		<a data-id="myid" rel="forward" href="http://www.webworldinc.com">This is a message</a></li>
	<li title="Click me"><b>ISBN</b> <var>1659-326-3265874</var></li>	
	
	<!-- Messages -->
	<li><b>Debug</b>: <var>My wonderful message goes here</var> By <address>Mi Nahme <tt>@ 127.0.0.1</tt></address> on <time>1/1/2014</time> <cite>IM-326589</cite></li>
</ul>
'

SELECT *
FROM dbo.udf_xoxoRead(@someData)


*/



/* User Data: this was designed around xoxo, but can be made to do much more */

/* @xml: 	raw data to be prompted */
/* @type: 	data to be filtered, this allows multiple types in a single xml */


create function [dbo].[udf_xoxoRead](@xmlData xml, @type varchar(40) = NULL) 
	
	returns @tblmessage TABLE
(
    -- Columns returned by the function
    [type] 			nvarchar(max) NULL,		/* type is shown (Plain)		*/
    [id] 			nvarchar(max) NULL,		/* id is not 					*/
    [position] 		int 		  NULL,		/* sort order over ride 		*/
    [status] 		nvarchar(max) NULL,		/* publish or security mode 	*/
    [href] 			nvarchar(max) NULL,		/* a tag 						*/
    [rel] 			nvarchar(max) NULL,		/* a tag 						*/
    [address]		nvarchar(max) NULL,		/* who person's name  			*/
    [tt]			nvarchar(max) NULL,		/* who as in ip 				*/
    [datetime]		datetime	  NULL,		/* when did this happen 		*/
    [cite]			nvarchar(max) NULL,		/* citation like a ticket # 	*/
    [title]			nvarchar(max) NULL,		/* overall tool tip 			*/
    [message]		nvarchar(max) NULL    	/* inside of a or var  (Plain	*/
)
as
begin
	INSERT INTO @tblMessage
	
	SELECT 
		ISNULL(Tbl.Col.value('b[1]', 				'nvarchar(max)'),
			'default')										 	AS [type],		/* It is expected that this could be loaded into a struct */  
       	Tbl.Col.value('(a[@data-id])[1]', 	'nvarchar(max)') 	AS [id],
       	Tbl.Col.value('@data-position','int') 					AS [position],
       	Tbl.Col.value('@data-status',		'nvarchar(max)') 	AS [status],
       	Tbl.Col.value('(a[@href])[1]',	 	'nvarchar(max)') 	AS [href],  
	 	Tbl.Col.value('(a[@rel])[1]', 		'nvarchar(max)')	AS [rel],
	 	Tbl.Col.value('address[1]', 		'nvarchar(max)') 	AS [address],
	 	Tbl.Col.value('(address/tt)[1]', 	'nvarchar(max)') 	AS [tt],
	 	Tbl.Col.value('time[1]', 			'datetime') 		AS [datetime],  
       	Tbl.Col.value('cite[1]', 			'nvarchar(max)') 	AS [cite],  
       	Tbl.Col.value('@title', 			'nvarchar(max)')	AS [title],
	 	ISNULL(Tbl.Col.value('var[1]', 		'nvarchar(max)'),
	 		Tbl.Col.value('a[1]', 			'nvarchar(max)'))	AS [message]
	 		

	FROM   @xmlData.nodes('/ul/li') Tbl(Col)
	
	WHERE	Tbl.Col.value('b[1]', 'nvarchar(max)') = @type OR @type IS NULL OR @type = '' 	

	RETURN
end






/*
Link Sample:

DECLARE @xml xml = '
<ul class="xoxo">
	<li data-position="3" data-status="approved" data-id="catinfo" title="This is about domestic cats">
		<b>Pets</b>: 
		<a href="black.htm" title="cat" rel="external">This is about black cats</a> 
		By <address>James Mohler <tt>1.1.1.1</tt></address>
		At <time>1/2/2015</time>
		Also see <cite>http://en.wikipedia.org/wiki/Felis</cite>
	</li>
	
	<li><b>Farm Animals</b></li>
	
	<li><b>Pets</b>: <var>Dog</var></li>	
	
	<li><a href="black.htm" title="cat">This is about black cats</a></li>

	<li><a href="chihuahua.htm" title="dog">We prefer Chihuahuas</a></li>
</ul>'

SELECT * 
FROM dbo.udf_xoxoRead(@xml)


*/



