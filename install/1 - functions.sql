/* This creates all SQL functions scalar functions, then table valued functions */


/* These are related to the dbo.Traffic table */

/****** Object:  UserDefinedFunction [dbo].[udf_OS]    Script Date: 4/8/2013 9:28:19 PM ******/
DROP FUNCTION [dbo].[udf_OS]
GO


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



/****** Object:  UserDefinedFunction [dbo].[udf_OS]    Script Date: 4/8/2013 9:28:19 PM ******/
DROP FUNCTION [dbo].[udf_Browser]
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



/****** Object:  UserDefinedFunction [dbo].[udf_getCity]    Script Date: 4/9/2013 6:19:00 PM ******/
DROP FUNCTION [dbo].[udf_getCity]
GO


CREATE FUNCTION [dbo].[udf_getCity](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/City)[1]', 'varchar(50)')
END


GO


/****** Object:  UserDefinedFunction [dbo].[udf_getCountryName]    Script Date: 4/9/2013 6:19:27 PM ******/
DROP FUNCTION [dbo].[udf_getCountryName]
GO


CREATE FUNCTION [dbo].[udf_getCountryName](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/CountryName)[1]', 'varchar(50)')
END
GO



/****** Object:  UserDefinedFunction [dbo].[udf_getRegionName]    Script Date: 4/9/2013 6:21:05 PM ******/
DROP FUNCTION [dbo].[udf_getRegionName]
GO




CREATE FUNCTION [dbo].[udf_getRegionName](@var xml) 
  RETURNS varchar(50)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/RegionName)[1]', 'varchar(50)')
END
GO



/****** Object:  UserDefinedFunction [dbo].[udf_getRemote_addr]    Script Date: 4/9/2013 6:21:39 PM ******/
DROP FUNCTION [dbo].[udf_getRemote_addr]
GO



CREATE FUNCTION [dbo].[udf_getRemote_addr](@var xml) 
  RETURNS varchar(15)
  with schemabinding
   AS 
BEGIN 
   RETURN @var.value('(/Response/Ip)[1]', 'varchar(15)')
END
GO




/****** Object:  UserDefinedFunction [dbo].[udf_4jDebug]    Script Date: 4/9/2013 6:23:12 PM ******/
DROP FUNCTION [dbo].[udf_4jDebug]
GO


/* Debug */
create function [dbo].[udf_4jDebug](@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<msg:message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end

GO





/****** Object:  UserDefinedFunction [dbo].[udf_4jError]    Script Date: 4/9/2013 6:24:19 PM ******/
DROP FUNCTION [dbo].[udf_4jError]
GO

/* Error */
create function [dbo].[udf_4jError](@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<msg:message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO



/****** Object:  UserDefinedFunction [dbo].[udf_4jFatal]    Script Date: 4/9/2013 6:24:47 PM ******/
DROP FUNCTION [dbo].[udf_4jFatal]
GO



create function [dbo].[udf_4jFatal](@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<msg:message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end

GO




/****** Object:  UserDefinedFunction [dbo].[udf_4jInfo]    Script Date: 4/9/2013 6:25:26 PM ******/
DROP FUNCTION [dbo].[udf_4jInfo]
GO


create function [dbo].[udf_4jInfo](@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO



/****** Object:  UserDefinedFunction [dbo].[udf_4jSuccess]    Script Date: 4/9/2013 6:25:48 PM ******/
DROP FUNCTION [dbo].[udf_4jSuccess]
GO



/* Success */
create function [dbo].[udf_4jSuccess](@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO



/****** Object:  UserDefinedFunction [dbo].[udf_4jTicket]    Script Date: 4/9/2013 6:26:18 PM ******/
DROP FUNCTION [dbo].[udf_4jTicket]
GO


/* Debug */
create function [dbo].[udf_4jTicket](@title nvarchar(max), @ip varchar(max), @ticket nvarchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<msg:message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ticket 	{sql:variable("@ticket")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO



/****** Object:  UserDefinedFunction [dbo].[udf_4jWarn]    Script Date: 4/9/2013 6:27:13 PM ******/
DROP FUNCTION [dbo].[udf_4jWarn]
GO



/* Warn */
create function [dbo].[udf_4jWarn](@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
	returns xml
as
begin
	DECLARE @xmlResult xml = CONVERT(xml, '<msg:message />')
	
	DECLARE @datetime datetime = getDate()

	DECLARE @by varchar(max)
		
	SELECT 	@by = Firstname + ' ' + LastName
	FROM 	dbo.vwUser WITH (NOLOCK)
	WHERE	UserID = @userid

	SET @xmlResult.modify('insert attribute by 		{sql:variable("@by")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute ip 		{sql:variable("@ip")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute title	{sql:variable("@title")} into (/message)[1]')
	SET @xmlResult.modify('insert attribute date 	{sql:variable("@datetime")} into (/message)[1]')
	

	RETURN @xmlResult
end
GO


/* Misc functions */


/****** Object:  UserDefinedFunction [dbo].[udf_Slugify]    Script Date: 4/9/2013 6:30:14 PM ******/
DROP FUNCTION [dbo].[udf_Slugify]
GO



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




/****** Object:  UserDefinedFunction [dbo].[udf_StripHTML]    Script Date: 4/9/2013 6:31:26 PM ******/
DROP FUNCTION [dbo].[udf_StripHTML]
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


/****** Object:  UserDefinedFunction [dbo].[udf_xmlToStr]    Script Date: 4/9/2013 6:32:06 PM ******/
DROP FUNCTION [dbo].[udf_xmlToStr]
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

