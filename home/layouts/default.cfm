<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->



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




<cfif fileExists(expandpath("theme/#theme#/#theme_template#")) >

	<cfinclude template="../../theme/#theme#/#theme_template#">

	<cfexit>
</cfif>



<!--- Normal output begins --->
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
	<meta charset="UTF-8" />


	<title>PlumaCMS - Welcome</title>
</head>	


<body>


<header>
  	<h1>Welcome To PlumaCMS</h1>
</header>

	
<article>		
	<cfoutput>#application.GSAPI.get_page_content()#</cfoutput>
</article>		

		

<footer>	
	<p>&copy; <cfoutput>#Year(Now())#</cfoutput> Developed by James Mohler and Web World Inc.</p>	
</footer>





</body>
</html>
<cfset request.layout = false><!--- Do not cascade --->

