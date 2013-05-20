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
application.GSAPI.exec_action("pre-header", '', rc); // before the template even runs


plugin_content 	= application.GSAPI.get_plugin_content();
theme 			= application.GSAPI.get_theme();
theme_template 	= application.GSAPI.get_theme_template();
</cfscript>


<!--- Process Theme --->
<cfif fileExists(expandpath("theme/#theme#/functions.cfi"))>
	
	<cfinclude template="../theme/#theme#/functions.cfi">
</cfif>


<!--- Load ini --->
<cfif fileExists(expandpath("theme/#theme#/title.ini"))>
	<cfset request.stTitle = application.GSAPI.load_ini("theme/#theme#/title.ini")>
</cfif>

<cfif fileExists(expandpath("theme/#theme#/settings.ini"))>
	<cfset request.stSettings = application.GSAPI.load_ini("theme/#theme#/settings.ini")>
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


<cfif fileExists(expandpath("theme/#theme#/#theme_template#"))>
	<cfinclude template="../theme/#theme#/#theme_template#">
	<cfexit>
</cfif>



<html>
<head> 
	<title>Error Loading Template</title>
</head>

<body>
	<cfdump var="#application#"> 
	
	<cfdump var="#request#">
</body>
</html>







