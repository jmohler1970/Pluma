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



/* Debug */
create function [dbo].[udf_4jDebug](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message type=''debug''>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
	
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END	

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end

GO



/* Error */
create function [dbo].[udf_4jError](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message type=''error''>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
	
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO





create function [dbo].[udf_4jFatal](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message type=''fatal''>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
	
	
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end

GO





create function [dbo].[udf_4jInfo](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message type=''info''>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO






/* Success */
create function [dbo].[udf_4jSuccess](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
		
	END

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO



/* Debug */
create function [dbo].[udf_4jTicket](@message nvarchar(max), @ip varchar(max), @ticket nvarchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message type=''ticket''>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
		
	END
	
	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ticket 	{sql:variable("@ticket")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO



/* Warn */
create function [dbo].[udf_4jWarn](@message nvarchar(max), @ip varchar(max), @userid varchar(max)=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, ('<message type=''warning''>' + @message + '</message>'))
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max) = @userid
		
	IF ISNUMERIC(@userid) = 1
	BEGIN	
		SELECT 	@by = Firstname + ' ' + LastName
		FROM 	dbo.vwUser WITH (NOLOCK)
		WHERE	UserID = @userid
	END
	
	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
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

/* Table valued functions */



create function [dbo].[udf_4jRead](@Message xml) 
	
	returns @tblmessage TABLE
(
    -- Columns returned by the function
    [by] 			nvarchar(40) NULL,
    [datetime]		datetime NULL, 
    [message]		nvarchar(max) NULL,
    [type]			nvarchar(10),
    [ticket]		nvarchar(10) NULL,
    [ip]			nvarchar(40) NULL,
    
    
    [htmlby] 		nvarchar(70) NULL,
    [htmlmessage]	nvarchar(max) NULL,
    [sort4j]			tinyint NULL
    
    
)
AS 
BEGIN
	INSERT INTO @tblmessage
	
	SELECT [by], [datetime], [message], 
		
		CASE
			WHEN [type] IS NULL AND [DateTime] IS NOT NULL THEN 'success'
			ELSE [type]
		END AS [type],
		
		[ticket], [ip],
	
		[by] + ' on ' + CONVERT(varchar(20), [datetime], 100) AS htmlBy,
	
		
		'<b>' + 
	
		CASE 
			WHEN [type] IS NULL AND [DateTime] IS NOT NULL THEN 'Success'
			ELSE LEFT(UPPER([type]), 1) + Right(LOWER([type]), LEN([type]) - 1) 
		END 
						
		+
		CASE 
			WHEN message is NULL THEN '</b>'
			ELSE ':</b> ' + message
		
		END
		AS htmlMessage,
		
		CASE 
			WHEN [type] = 'fatal'	THEN 90
			WHEN [type] = 'error'	THEN 80
			WHEN [type] = 'warn' 	THEN 70
			WHEN [type] = 'info' 	THEN 60
			WHEN [type] IS NULL	AND [DateTime] IS NOT NULL THEN 60		/* Success, and is the same as info */
			WHEN [type] = 'debug' 	THEN 50
			ELSE	NULL
		END
		AS sort4j 
	FROM (
		SELECT 	@Message.value('(/message/@by)[1]', 'nvarchar(40)') AS [by],
			@Message.value('(/message/@date)[1]', 	'datetime') 	AS [datetime],
			@Message.value('(/message)[1]', 		'nvarchar(max)') AS [message], 
			@Message.value('(/message/@type)[1]', 	'nvarchar(10)') AS [type],
			@Message.value('(/message/@ip)[1]', 	'nvarchar(40)') AS [ip],
			@Message.value('(/message/@ticket)[1]', 'nvarchar(10)')	AS [ticket]
		) A
	
			
	RETURN
END
GO






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




/* Taxonomy Read */
create function [dbo].[udf_taxonomyRead](@xmlData xml) 
	
	returns @tblTaxonomy TABLE
	(
    -- Columns returned by the function
    [tags] 			nvarchar(max) NULL,
    [menu] 			nvarchar(max) NULL,
    [menustatus]	nvarchar(max) NULL,
    [menusort]		nvarchar(max) NULL
   )

as
begin
	

	DECLARE @strTags varchar(max)

	
	SELECT @strTags = ISNULL( @strTags + ',', '' ) + x.y.value('.', 'varchar(max)' )  
	FROM @xmlData.nodes('/tags') x(y) 
	

	INSERT 
	INTO @tblTaxonomy(tags, menu, menustatus, menusort)
	VALUES (
		@strTags, 
		@xmlData.value('/menu[1]', 				'nvarchar(max)'),
		@xmlData.value('/menu[1]/@status', 		'nvarchar(max)'),
		@xmlData.value('/menu[1]/@sortorder', 	'nvarchar(max)')
		)

	
	RETURN 
end
GO





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
	


	SELECT 	@xmlTitle.value('(/extra)[1]',		'nvarchar(max)') AS [Extra],
			@xmlTitle.value('(/title)[1]',		'nvarchar(max)') AS [title],
			@xmlTitle.value('(/subtitle)[1]', 	'nvarchar(max)') AS [subtitle], 
			@xmlTitle.value('(/description)[1]','nvarchar(max)') AS [description],
			@xmlTitle.value('(/isbn)[1]',		'nvarchar(max)') AS [isbn]
	
			
	RETURN
END
GO





/* User Data */
create function [dbo].[udf_xmlRead](@xmlData xml) 
	
	returns @tblmessage TABLE
(
    -- Columns returned by the function
    [href] 			nvarchar(max) NULL,
    [rel] 			nvarchar(40) NULL,
    [title]			nvarchar(max) NULL,
    [type]			nvarchar(40),
    [position]		int NULL,
    [message]		nvarchar(max) NULL    
)
as
begin
	INSERT INTO @tblMessage
	
	SELECT  
       Tbl.Col.value('@href', 	'nvarchar(max)') 	AS href,  
       Tbl.Col.value('@rel', 	'nvarchar(40)')		AS rel,  
       Tbl.Col.value('@title', 	'nvarchar(max)')	AS title,
       Tbl.Col.value('@type', 	'nvarchar(40)')		AS [type],
       Tbl.Col.value('@position', 'int')			AS position,
       Tbl.Col.value('.', 		'nvarchar(max)')	AS message

	FROM   @xmlData.nodes('/data') Tbl(Col)
	ORDER BY position, type, message
	


	RETURN
end

GO



