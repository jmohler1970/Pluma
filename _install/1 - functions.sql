/* This creates all SQL functions scalar functions, then table valued functions */
/* For: MS SQL 2008 and above */


/* These are related to the dbo.Traffic table */



create function [dbo].[udf_OS](@Agent nvarchar(max)) 
	
	returns varchar(max)
WITH SCHEMABINDING	
as
begin
	DECLARE @OS varchar(max)
	
	SET @OS = case 
		when @Agent like '%Windows NT 6.2%' 	then 'Windows 8' 
		when @Agent like '%Windows NT 6.1%' 	then 'Windows 7' 
		when @Agent like '%Windows NT 6.0%' 	then 'Windows Vista' 
		when @Agent like '%Windows NT 5.1%' 	then 'Windows XP' 
		when @Agent like '%Windows NT%' 		then 'Windows NT (Unknown Version)' 
		when @Agent like '%Windows%' 			then 'Windows (Unknown Version)' 
		
		when @Agent like '%iPad%' 		then 'iPad' 
		when @Agent like '%iPhone%' 	then 'iPhone' 
		when @Agent like '%iPod%' 		then 'iPod' 
		when @Agent like '%Mac OS X%' 	then 'Mac OS X'
		 
		when @Agent like '%Android%' 	then 'Android' 
		when @Agent like '%Linux%' 	then 'Linux' 
		else 'Unknown OS' end
	

	RETURN @OS
end

GO




create function [dbo].[udf_Browser](@Agent nvarchar(max)) 
	
	returns varchar(max)
WITH SCHEMABINDING	
as
begin
	DECLARE @Browser varchar(max)

	SET @Browser  = case 
		when @Agent like '%MSIE 10%' 	then 'Internet Explorer 10' 
		when @Agent like '%MSIE 9%' 	then 'Internet Explorer 9' 
		when @Agent like '%MSIE 8%' 	then 'Internet Explorer 8' 
		when @Agent like '%MSIE 7%' 	then 'Internet Explorer 7' 
		when @Agent like '%MSIE 6%'		then 'Internet Explorer 6' 
		when @Agent like '%MSIE%' 		then 'Internet Explorer (Unknown Version)' 
		when @Agent like '%Firefox/20%' then 'Firefox 20' 
		when @Agent like '%Firefox/19%' then 'Firefox 19' 
		when @Agent like '%Firefox/18%' then 'Firefox 18' 
		when @Agent like '%Firefox/17%' then 'Firefox 17' 
		when @Agent like '%Firefox/16%' then 'Firefox 16' 
		when @Agent like '%Firefox/15%' then 'Firefox 15' 
		when @Agent like '%Firefox/14%' then 'Firefox 14' 
		when @Agent like '%Firefox/13%' then 'Firefox 13' 
		when @Agent like '%Firefox/12%' then 'Firefox 12' 
		when @Agent like '%Firefox/11%' then 'Firefox 11' 
		when @Agent like '%Firefox/10%' then 'Firefox 10' 
		when @Agent like '%Firefox/9%' 	then 'Firefox 9' 
		when @Agent like '%Firefox/8%' 	then 'Firefox 8' 
		when @Agent like '%Firefox/6%' 	then 'Firefox 6' 
		when @Agent like '%Firefox/5%' 	then 'Firefox 5' 
		when @Agent like '%Firefox/4%' 	then 'Firefox 4' 
		when @Agent like '%Firefox/3%' 	then 'Firefox 3' 
		when @Agent like '%Firefox%' 	then 'Firefox (Other)' 
		when @Agent like '%Chrome%' 	then 'Chrome' 
		when @Agent like '%Safari%' 	then 'Safari' 
		when @Agent like '%Gecko%' 		then 'Other Gecko' 
		when @Agent like '%opera%' 		then 'Opera' 
		when @Agent like '%GoogleBot%' 	then 'GoogleBot' 
		when @Agent like '%bot%' 		then 'Bot (Other)' 
		when @Agent like '%spider%' 	then 'Bot (Other Spider)'
		else 'Unknown' end

	RETURN @Browser
end

GO




CREATE FUNCTION [dbo].[udf_getCity](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/City)[1]', 'nvarchar(max)')
END


GO



CREATE FUNCTION [dbo].[udf_getCountryName](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/CountryName)[1]', 'nvarchar(max)')
END
GO






CREATE FUNCTION [dbo].[udf_getRegionName](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/RegionName)[1]', 'nvarchar(max)')
END
GO






CREATE FUNCTION [dbo].[udf_getRemote_addr](@var xml) 
  RETURNS varchar(15)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/Ip)[1]', 'varchar(15)')
END
GO


/* Misc functions */





create function [dbo].[udf_Slugify](@str nvarchar(max)) returns nvarchar(max) as
begin
    declare @IncorrectCharLoc int
    set @str = replace(replace(lower(@str),'.','-'),'''','')

    -- remove non alphanumerics:
    set @IncorrectCharLoc = patindex('%[^0-9a-z -]%',@str)
    while @IncorrectCharLoc > 0
    begin
        set @str = stuff(@str,@incorrectCharLoc,1,' ')
        set @IncorrectCharLoc = patindex('%[^0-9a-z -]%',@str)
    end

    -- replace all spaces with dashes
    set @str = replace(@str,' ','-')

    -- remove consecutive dashes:
    while charindex('--',@str) > 0
    begin
        set @str = replace(@str, '--', '-')
    end

    -- remove leading dashes
    while charindex('-', @str) = 1
    begin
        set @str = RIGHT(@str, len(@str) - 1)
    end

    -- remove trailing dashes
    while len(@str) > 0 AND substring(@str, len(@str), 1) = '-'
    begin
        set @str = LEFT(@str, len(@str) - 1)
    end
return @str
end

GO





CREATE FUNCTION [dbo].[udf_StripHTML] (@HTMLText VARCHAR(MAX))
RETURNS VARCHAR(MAX) AS
BEGIN
    DECLARE @Start INT
    DECLARE @End INT
    DECLARE @Length INT
    SET @Start = CHARINDEX('<',@HTMLText)
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
    SET @Length = (@End - @Start) + 1
    WHILE @Start > 0 AND @End > 0 AND @Length > 0
    BEGIN
        SET @HTMLText = STUFF(@HTMLText,@Start,@Length,'')
        SET @Start = CHARINDEX('<',@HTMLText)
        SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
        SET @Length = (@End - @Start) + 1
    END
    RETURN LTRIM(RTRIM(@HTMLText))
END
GO


CREATE FUNCTION dbo.udf_dateformat (@dtDate date)
returns varchar(max()) AS
BEGIN
	DECLARE @result varchar(Max) = 
		CASE DATEPART(weekday,@dtDate)
			WHEN 1 THEN 'Sunday, '
			WHEN 2 THEN 'Monday, '
			WHEN 3 THEN 'Tuesday, '
			WHEN 4 THEN 'Wednesday, '
			WHEN 5 THEN 'Thursday, '
			WHEN 6 THEN 'Friday, '
			WHEN 7 THEN 'Saturday, '
		END
	
		+ CONVERT(varchar(max), @dtDate, 7)

	SET @result = 
		CASE 
			WHEN @dtDate = CONVERT(date, getDate()) THEN 'Today'
			WHEN @dtDate = DATEADD(dd, -1, CONVERT(date, getDate())) THEN 'Yesterday'
			ELSE @result
		END	
		
	RETURN @result		
END
GO





/* Flatten group */
create function [dbo].[udf_xmlToStr](@xmlData xml) 
	
	returns varchar(max)
as
begin
	DECLARE @strGroup varchar(max)

	
	SELECT @strGroup = ISNULL( @strGroup + ',', '' ) + x.y.value('.', 'varchar(max)' )  
	FROM @xmlData.nodes('/data') x(y) 
	
	RETURN @strGroup
end
GO


/* XOXO functions */

/* the stuff between the tags disappears on tvf */

/*
<ul class="xoxo">
	<li><b>Debug</b>: <var>My wonderful message goes here</var> by <address>Mi Nahme <tt>@ 127.0.0.1</tt></address> on <time>1/1/2014</time> <cite>IM-326589</cite></li>
</ul>
*/


/* Debug */
create function [dbo].[udf_4jDebug](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	
	DECLARE @by varchar(max) = @userid
	
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END	
	
	SET @xmlResult = '<ul class="xoxo"><li><b>Debug</b>:' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
	

	RETURN CONVERT(xml, @xmlResult)
end

GO



/* Error */
create function [dbo].[udf_4jError](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
	
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult = '<ul class="xoxo"><li><b>Error</b>:' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
		

	RETURN CONVERT(xml, @xmlResult)
end
GO





create function [dbo].[udf_4jFatal](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	
	DECLARE @by varchar(max) = @userid
	
	
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult = '<ul class="xoxo"><li><b>Fatal</b>:' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
	

	RETURN CONVERT(xml, @xmlResult)
end

GO





create function [dbo].[udf_4jInfo](@message nvarchar(max)='', @ip varchar(max)=NULL, @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult = '<ul class="xoxo"><li><b>Info</b>:' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
	
	

	RETURN CONVERT(xml, @xmlResult)
end
GO






/* Success */
create function [dbo].[udf_4jSuccess](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
		
	END


	
	SET @xmlResult = '<ul class="xoxo"><li><b>Success</b>:' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
	

	RETURN CONVERT(xml, @xmlResult)
end
GO



/* Debug */
create function [dbo].[udf_4jTicket](@message nvarchar(max), @ip varchar(max), @ticket nvarchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	


	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
		
	END
	
	SET @xmlResult = '<ul class="xoxo"><li><b>Ticket</b> (<code>' + @ticket + '</code>)' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
	

	RETURN CONVERT(xml, @xmlResult)
end
GO



/* Warn */
create function [dbo].[udf_4jWarn](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult nvarchar(max) = ''
	

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = given + ' ' + family
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	
	SET @xmlResult = '<ul class="xoxo"><li><b>Warning</b>:' 
		+ '<var>' + @message + '</var>'
		+ ' by <address>' + @by + ' <tt>' + @ip + '</tt></address>'
		+ ' on <time>' + CONVERT(varchar(40), getDate(), 100) + '</time>'
		+ '</li></ul>'
	
	

	RETURN CONVERT(xml, @xmlResult)
end
GO




/* Table valued functions */






create function [dbo].[udf_calendar](@sDate date, @eDate date) 
	
	returns @tblDate TABLE
(
   
    [CalendarDate]	date
)
AS 
BEGIN


DECLARE @cDate As Date

SET @cDate = @sDate
WHILE @cDate < @eDate
BEGIN
    INSERT INTO @tblDate (CalendarDate) VALUES (@cDate)
    SET @cDate=DATEADD(day, 1, @cDate)
END

RETURN

END
GO


/*
DECLARE @someData xml = '
<ul class="xoxo">
	<!-- Menu control -->
	<li><b>Tag</b> <var>Cats</var></li>
	<li><b>Tag</b> <var>Dogs</var></li>
	<li data-position="4" data-status="whatever"><b>Menu</b> <var>Animals</var></li>
</ul>
'

SELECT *
FROM dbo.udf_taxonomyRead(@someData)

*/




/* Taxonomy Read */
create function [dbo].[udf_taxonomyRead](@xmlData xml) 

	returns @tblTaxonomy TABLE
	(
    -- Columns returned by the function
    [tags] 			nvarchar(max) NULL,
    [tagSlugs] 		nvarchar(max) NULL,
    [menu] 			nvarchar(max) NULL,
    [menustatus]	nvarchar(max) NULL,
    [menusort]		nvarchar(max) NULL
   )

as
begin


	DECLARE @strTags varchar(max)
	DECLARE @strTagSlugs varchar(max)



	SELECT 	@strTags 		= ISNULL( @strTags + ',', '' ) 		+ 				  Tbl.Col.value('var[1]', 'nvarchar(max)' ),
			@strTagSlugs 	= ISNULL( @strTagSlugs + ',', '' ) 	+ dbo.udf_Slugify(Tbl.Col.value('var[1]', 'nvarchar(max)' ))
	
	FROM   	@xmlData.nodes('/ul/li') Tbl(Col)
	WHERE	Tbl.Col.value('b[1]', 				'nvarchar(max)') = 'Tag'



	INSERT 
	INTO @tblTaxonomy(tags, tagSlugs, menu, menustatus, menusort)
	SELECT
		@strTags,
		@strTagSlugs, 
		Tbl.Col.value('var[1]', 				'nvarchar(max)'),
		Tbl.Col.value('@data-status[1]', 		'nvarchar(max)'),
		Tbl.Col.value('@data-position[1]', 		'nvarchar(max)')
		
	
	FROM	@xmlData.nodes('/ul/li') Tbl(Col)
	WHERE	Tbl.Col.value('b[1]', 				'nvarchar(max)') = 'Menu'


	RETURN 
end
GO


/*

DECLARE xmlTitle xml = '

<ul class="xoxo">
	<li><b>Extra</b> <var>Cats</var></li>
	<li><b>Title</b> <var>Dogs</var></li>
	<li><b>Subtitle</b> <var>Animals</var></li>
	<li><b>Description</b> <var>Fun with animals</var></li>
	<li><b>ISBN</b> <var>1659-326-3265874</var></li>
</ul>
'

SELECT *
FROM udf_titleRead(xmltitle)
*/



create function [dbo].[udf_titleRead](@xmlTitle xml) 
	
	returns @tblTitle TABLE
(
    -- Columns returned by the function
    [extra]			nvarchar(max) NULL,
	[title]			nvarchar(max) NULL,
	[subtitle]		nvarchar(max) NULL,
	[description]	nvarchar(max) NULL,
	[isbn]			nvarchar(max) NULL
)
AS 
BEGIN
	INSERT INTO @tblTitle
	


	SELECT 	@xmlTitle.value('(/ul/li[b="Extra"]/var)[1]',		'nvarchar(max)') AS [Extra],
			@xmlTitle.value('(/ul/li[b="Title"]/var)[1]',		'nvarchar(max)') AS [title],
			@xmlTitle.value('(/ul/li[b="Subtitle"]/var)[1]', 	'nvarchar(max)') AS [subtitle], 
			@xmlTitle.value('(/ul/li[b="Description"]/var)[1]',	'nvarchar(max)') AS [description],
			@xmlTitle.value('(/ul/li[b="ISBN"]/var)[1]',		'nvarchar(max)') AS [isbn]
	
			
	RETURN
END
GO


/* rotate */






/*
Link Sample:

DECLARE @xml xml = '
<ul class="xoxo">
	<li><a href="black.htm" title="cat">This is about black cats</a></li>

	<li><a href="chihuahua.htm" title="dog">We prefer Chihuahuas</a></li>
</ul>'

SELECT * 
FROM dbo.udf_xoxoRead(@xml)


*/
