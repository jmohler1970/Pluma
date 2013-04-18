


<cfparam name="rc.silent" default="0">


<cfif rc.silent><cfsetting showDebugOutput="No"><cfoutput>#trim(body)#</cfoutput><cfexit></cfif>


<cfif getItem() EQ "Error">
<html>
<head>
	<title>Error</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>



	<body class="body"><cfoutput>#body#</cfoutput>
	</body>
</html>
	<cfexit>
</cfif>



<!--- Process plugin_content --->
<cfscript>
plugin_content 	= application.GSAPI.get_plugin_content();
theme 			= application.GSAPI.get_theme();
theme_template 	= application.GSAPI.get_theme_template();
</cfscript>


<!--- Process Theme --->
<cfif fileExists(expandpath("theme/#theme#/functions.cfi"))>
	
	<cfinclude template="../../theme/#theme#/functions.cfi">
</cfif>


<!--- Load ini --->
<cfif fileExists(expandpath("theme/#theme#/title.ini"))>
	<cfset request.stTitle = application.GSAPI.loadini("theme/#theme#/title.ini")>
</cfif>

<cfif fileExists(expandpath("theme/#theme#/settings.ini"))>
	<cfset request.stSettings = application.GSAPI.loadini("theme/#theme#/settings.ini")>
</cfif>



<!--- Determine template --->

<cfscript>




// security error
if (getItem() EQ "401" AND 
	fileExists(expandpath("theme/#theme#/401.cfm")))
	theme_template = "401.cfm";
	
// not found error
if (getItem() EQ "404" AND 
	fileExists(expandpath("theme/#theme#/404.cfm")))
	theme_template = "404.cfm";
	
</cfscript>




<cfif not fileExists(expandpath("theme/#theme#/#theme_template#"))>
	<cfset theme_template = "template.cfm">
</cfif>	


<cfinclude template="../../theme/#theme#/#theme_template#">



<cfset request.layout = false><!--- Do not cascade --->

