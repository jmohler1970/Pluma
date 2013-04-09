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

<cfcomponent extends="plugin">

<cfscript>
this.EntryCount = 8;

thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{
this.register_plugin(thisFile, 
	'Bootswatch Theme',
	'0.1',
	'James Mohler',
	'http:http://bootswatch.com',
	'Setting for bootswatch CMS themes.',
	'theme',
	'',
	'icon-cog');
	
	
this.add_action("theme_sidebar", "createSideMenu", ["?plugin=bootswatch", "Bootswatch Theme Settings"]);
	}
		
</cfscript>


<cffunction name="settings" returnType="struct">
	


	
<cfswitch expression="#rc.plx#">
<cfdefaultcase>

	<cfscript>
	
	
	if (cgi.request_method == "POST")	{
		
		result = application.IOAPI.set_pref("Bootswatch", rc);
		
		variables.stResult.message = "Settings for Bootswatch saved";
		}
	
	StructAppend(rc, application.IOAPI.get_pref("Bootswatch"));
		
	param rc.Bootswatch_css = "";
	param rc.Bootswatch_backgroundColor = "";
	param rc.Bootswatch_backgroundImage = "";
	param rc.Bootswatch_backgroundRepeat = "no-repeat";
	param rc.Bootswatch_backgroundAttachment = 0;
	

	var background = application.GSTHEMESPATH & "bootswatch/assets/background/";
	rc.qryBackground = DirectoryList(background,"false","query", "*.*", "name");

	var css = application.GSTHEMESPATH & "bootswatch/css/";
	rc.qryCSS = DirectoryList(css,"false","query", "subtheme*.css", "name");
	</cfscript>




	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="bootswatch/settings.cfm">
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	

	<cfreturn variables.stResult>
</cffunction>




</cfcomponent>
