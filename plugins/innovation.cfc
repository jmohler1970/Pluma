<!---
Copyright (C) 2013 James Mohler

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
	'Innovation Theme',
	'0.1',
	'James Mohler',
	'http://webworldinc.com',
	'Setting for Innovation theme.',
	'theme',
	'',
	'icon-cog');
	
	
this.add_action("theme_sidebar", "createSideMenu", ["?plugin=innovation", "Innovation Theme Settings"]);
	}
		
</cfscript>


<cffunction name="settings" returnType="struct">
	


	
<cfswitch expression="#rc.plx#">
<cfdefaultcase>

	<cfscript>
	
	
	if (cgi.request_method == "POST")	{
		
		result = application.IOAPI.set_pref("Innovation", rc);
		
		variables.stResult.message = "Settings for Innovation saved";
		}
	
	StructAppend(rc, application.IOAPI.get_pref("Innovation"));
		
	param rc.Innovation_facebook = "";
	param rc.Innovation_twitter = "";
	param rc.Innovation_linkedin = "";
	param rc.Innovation_stackoverflow = "";
	</cfscript>




	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="innovation/settings.cfm">
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	

	<cfreturn variables.stResult>
</cffunction>




</cfcomponent>
