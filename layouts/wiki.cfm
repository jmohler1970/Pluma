<!---@ Description: This is used for public pages and not admin tools --->


<cfset request.layout = false><!--- Do not cascade --->



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


application.GSAPI.rc = rc;// has all the rc from controllers
plugin_content 	= application.GSAPI.get_plugin_content();
theme 			= application.GSAPI.get_theme();
template_file	= application.GSAPI.get_theme_template();





// Load ini --->
if (fileExists(expandpath("theme/#theme#/title.ini")))
	request.stTitle = application.GSAPI.load_ini("theme/#theme#/title.ini");


if (fileExists(expandpath("theme/#theme#/settings.ini")))
	request.stSettings = application.GSAPI.load_ini("theme/#theme#/settings.ini");



// Determine template --->





// security error
if (getItem() EQ "401" AND 
	fileExists(expandpath("theme/#theme#/401.cfm")))	{
	template_file = "401.cfm";
	
	application.GSAPI.exec_action("error-401");
	}
	
	
	
// not found error
if (getItem() EQ "404" AND 
	fileExists(expandpath("theme/#theme#/404.cfm")))	{
	template_file = "404.cfm";
	
	application.GSAPI.exec_action("error-404");
	}


// include the functions.cfi page if it exists within the theme
if (fileExists(expandpath("theme/#theme#/functions.cfi")))
	include "../theme/#theme#/functions.cfi";



// call pretemplate Hook
application.GSAPI.exec_action("index-pretemplate"); 


// include the template and template file set within theme.home and each page
if (!fileExists(expandpath("theme/#theme#/#template_file#")) || template_file == '') { template_file = "template.cfm"; }
include "../theme/#theme#/#template_file#";

// call posttemplate Hook
application.GSAPI.exec_action("index-posttemplate"); 
</cfscript>


