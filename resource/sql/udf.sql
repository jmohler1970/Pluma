USE [PlumaCMS]
GO

/****** Object:  XmlSchemaCollection [dbo].[GeoLocation]    Script Date: 3/26/2013 9:04:57 PM ******/
DROP XML SCHEMA COLLECTION  [dbo].[GeoLocation]
GO

/****** Object:  XmlSchemaCollection [dbo].[GeoLocation]    Script Date: 3/26/2013 9:04:57 PM ******/
CREATE XML SCHEMA COLLECTION [dbo].[GeoLocation] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<xsd:element name="Response" type="ResponseType" />
	<xsd:complexType name="ResponseType">
		<xsd:complexContent>
			<xsd:restriction base="xsd:anyType">
				<xsd:sequence>
					<xsd:element name="Ip" type="xsd:string" minOccurs="0" />
					<xsd:element name="CountryCode" type="xsd:string" minOccurs="0" />
					<xsd:element name="CountryName" type="xsd:string" minOccurs="0" />
					<xsd:element name="RegionCode" type="xsd:string" minOccurs="0" />
					<xsd:element name="RegionName" type="xsd:string" minOccurs="0" />
					<xsd:element name="City" type="xsd:string" minOccurs="0" />
					<xsd:element name="ZipCode" type="xsd:string" minOccurs="0" />
					<xsd:element name="Latitude" type="xsd:string" minOccurs="0" />
					<xsd:element name="Longitude" type="xsd:string" minOccurs="0" />
					<xsd:element name="MetroCode" type="xsd:string" minOccurs="0" />
				</xsd:sequence>
			</xsd:restriction>
		</xsd:complexContent>
	</xsd:complexType>
</xsd:schema>'
GO


/****** Object:  XmlSchemaCollection [dbo].[4jMsg]    Script Date: 3/26/2013 9:04:57 PM ******/
DROP XML SCHEMA COLLECTION  [dbo].[4jMsg]
GO

/****** Object:  XmlSchemaCollection [dbo].[GeoLocation]    Script Date: 3/26/2013 9:04:57 PM ******/
CREATE XML SCHEMA COLLECTION [dbo].[4jMsg] AS N'

<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	targetNamespace="http://wwi.com/4jMsg/3-26-2013"
    xmlns="uri:msg" >
	
	
	<xsd:element name="message">
    	
    	<xsd:complexType>
        	 
            <xsd:attribute name="by" />
            <xsd:attribute name="ip" />
            <xsd:attribute name="date" type="xsd:date" />
            <xsd:attribute name="type" />
            <xsd:attribute name="ticket" />
            <xsd:attribute name="title" />
            
      </xsd:complexType>

    </xsd:element>
</xsd:schema>'
GO






create function [dbo].[udf_4jRead](@Message xml) 
	
	returns @tblmessage TABLE
(
    -- Columns returned by the function
    [by] 			nvarchar(40) NULL,
    [ip] 			nvarchar(40) NULL,
    [datetime]		datetime NULL, 
    [message]		nvarchar(max) NULL,
    [type]			nvarchar(10),
    [ticket]		nvarchar(10) NULL,
    
    [htmlby] 		nvarchar(70) NULL,
    [htmlmessage]	nvarchar(max) NULL,
    [sort4j]			tinyint NULL
    
    
)
AS 
BEGIN
	INSERT INTO @tblmessage
	
	SELECT [by], [ip], [datetime], [message], 
		
		CASE
			WHEN [type] IS NULL AND [DateTime] IS NOT NULL THEN 'success'
			ELSE [type]
		END AS [type],
		
		[ticket], 
	
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
		SELECT 	
			@Message.value('(/message/@by)[1]', 	'nvarchar(40)') AS [by],
			@Message.value('(/message/@ip)[1]', 	'nvarchar(40)') AS [ip],
			@Message.value('(/message/@date)[1]', 	'datetime') 	AS [datetime],
			@Message.value('(/message/@title)[1]', 	'varchar(max)') AS [message], 
			@Message.value('(/message/@type)[1]', 	'varchar(10)') 	AS [type],
			@Message.value('(/message/@ticket)[1]', 'varchar(10)')	AS [ticket]
		) A
	
			
	RETURN
END
GO


INSERT
INTO	dbo.Journal(NodeID, Kind, Created)
VALUES (378, 'Faux', 
	dbo.udf_4jFatal('This all went very wrong', cgi.remote_addr, 1019)
	)


SELECT     TOP (200) JournalID, Kind, NodeID, journal.Message as x, Contents, CreateBy, CreateDate, Created, b.*
FROM         Journal
OUTER APPLY dbo.udf_4jRead(Created) b
ORDER BY JournalID DESC





SELECT     TOP (200) JournalID, Kind, NodeID, journal.Message as x, Contents, CreateBy, CreateDate, Created, b.*
FROM         Journal
OUTER APPLY dbo.udf_4jRead(Created) b
ORDER BY JournalID DESC


<cffunction name="addJournal">
	
	
	<cfquery>
		INSERT 
		INTO	dbo.Journal (Kind, NodeID, Created)
		VALUES	('Faux', 2, udf_4jInfo('something happenned' ,1019))
	</cfquery>



</cffunction>









/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_message4]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jFatal]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jError]
GO


/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jWarn]
GO


/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jInfo]
GO


/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jSuccess]
GO


/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jDebug]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_message4]    Script Date: 3/17/2013 10:56:17 PM ******/
DROP FUNCTION [dbo].[udf_4jTicket]
GO





create function dbo.udf_4jFatal(@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
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


/* Error */
create function dbo.udf_4jError(@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
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



/* Warn */
create function dbo.udf_4jWarn(@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
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



/* Info */
create function dbo.udf_4jInfo(@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
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


/* Success */
create function dbo.udf_4jSuccess(@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
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


/* Debug */
create function dbo.udf_4jDebug(@title nvarchar(max), @ip varchar(max), @userid int=NULL) 
	
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


/* Debug */
create function dbo.udf_4jTicket(@title nvarchar(max), @ip varchar(max), @ticket nvarchar(max), @userid int=NULL) 
	
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



/*
FATAL	Severe errors that cause premature termination. Expect these to be immediately visible on a status console.
ERROR	Other runtime errors or unexpected conditions. Expect these to be immediately visible on a status console.
WARN	Use of deprecated APIs, poor use of API, 'almost' errors, other runtime situations that are undesirable or unexpected, but not necessarily "wrong". Expect these to be immediately visible on a status console.
INFO	Interesting runtime events (startup/shutdown). Expect these to be immediately visible on a console, so be conservative and keep to a minimum.
DEBUG	Detailed information on the flow through the system. Expect these to be written to logs only.
*/


dbo.udf_4jFatal(	@message, @userid)		/* should not commit to Created or Modified */
dbo.udf_4jError(	@message, @userid)		/* should not commit to Created or Modified */
dbo.udf_4jWarn( 	@message, @userid)		/* should not commit to Created or Modified */
dbo.udf_4jInfo( 	@message, @userid)		/* should not commit to Created or Modified */
dbo.udf_4jSuccess(	@message, @userid)		/* should commit */
dbo.udf_4jDebug(	@message, @userid)		/* should not commit to Created or Modified */
dbo.udf_4jTicket(	@message, @userid)		/* should not commit to Created or Modified */

-----
dbo.udf_4jRead(@xml)


/*
<follow  	href="#href#">#xmlformat(title)#</follow>
<contact 	type="#type#">#xmlformat(city)#</contact>
<profile 	type="#type#">#xmlformat(profile)#</contact>
<pref 		type="#type#">#xmlformat(profile)#</contact>
<config position="#i#">#xmlformat(evaluate('rc.config#i#'))#</config>
category= "#xmlformat(rc.linkcategory)#" 
				href	= "#xmlformat(trim(rc.href))#"
				<cfif isDefined("rc.tooltip")>
					tooltip	= "#xmlformat(trim(rc.tooltip))#"
				</cfif> 
				
				<cfif isDefined("rc.sortorder")>
					sortorder = "#xmlformat(trim(rc.sortorder))#"
				</cfif>

Change to:

<data href="#href#" rel="#rel#" title="#title#" type="#type#" position="#position#">#xmlformat(data)#</data>
*/

-- href: like html
-- rel: like html
-- title: like html
-- type: internal use
-- position: sort order or order to load array, sorted. Integer
-- . : Data


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







