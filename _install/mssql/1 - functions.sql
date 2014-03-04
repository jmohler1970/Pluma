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






CREATE FUNCTION [dbo].[udf_getCity](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/City)[1]', 'nvarchar(max)')
END





CREATE FUNCTION [dbo].[udf_getCountryName](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/CountryName)[1]', 'nvarchar(max)')
END







CREATE FUNCTION [dbo].[udf_getRegionName](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/RegionName)[1]', 'nvarchar(max)')
END







CREATE FUNCTION [dbo].[udf_getRemote_addr](@var xml) 
  RETURNS varchar(15)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/Ip)[1]', 'varchar(15)')
END



/* Support for getSimple operations */

/*
Description: Extracts out all columns from the getSimple field

*/


create function dbo.udf_getSimpleRead(@getSimple xml)
	returns @tblgetSimple TABLE
	(
    -- Columns returned by the function
    pubdate 		datetime 	  	NULL,		
	title			nvarchar(80)	NULL,
	slug			nvarchar(80)	NULL, /* this is changed so that we don't have a variable collision */
	meta			nvarchar(max)	NULL,
	metad			nvarchar(max)	NULL,
	menu			nvarchar(80)	NULL,
	menuOrder		int				NULL,
	menuStatus		nvarchar(80)	NULL,
	template		nvarchar(80)	NULL,
	parent			nvarchar(80)	NULL,
	content			nvarchar(max)	NULL,
	private			bit,
	author			nvarchar(80)	NULL
	)
	AS
	
BEGIN
	INSERT INT @tblgetSimple
	
	SELECT 		
		Tbl.Col.value('pubdate', 		'datetime') AS pubdate,
		Tbl.Col.value('title', 			'nvarchar(80)') AS title,
		Tbl.Col.value('url', 			'nvarchar(80)') AS slug,
		Tbl.Col.value('meta', 			'nvarchar(max)') AS meta,
		Tbl.Col.value('metad', 			'nvarchar(max)') AS metad,
		Tbl.Col.value('menu', 			'nvarchar(80)') AS menu,
		Tbl.Col.value('menuOrder',		'int') 			AS menuOrder,
		Tbl.Col.value('menuStatus', 	'nvarchar(80)') AS menuStatus,
		Tbl.Col.value('template', 		'nvarchar(80)') AS template,
		Tbl.Col.value('parent', 		'nvarchar(80)') AS parent,
		Tbl.Col.value('content', 		'nvarchar(max)') AS content,
		Tbl.Col.value('private', 		'bit') AS private,
		Tbl.Col.value('author', 		'nvarchar(80)') AS author
		
	FROM   @xmlData.nodes('item') Tbl(Col)	

	RETURN
END	




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



CREATE FUNCTION dbo.udf_dateformat (@dtDate date)
returns varchar(max) AS
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






/* Flatten group */
create function [dbo].[udf_xmlToStr](@xmlData xml) 
	
	returns varchar(max)
as
begin
	DECLARE @strGroup varchar(max)

	
	SELECT @strGroup = ISNULL( @strGroup + ',', '' ) + tbl.Col.value('var[1]', 'varchar(max)' )  
	FROM @xmlData.nodes('/ul/li') tbl(Col) 
	
	RETURN @strGroup
end



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




