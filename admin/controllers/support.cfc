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

<cfcomponent extends="base">

<cfscript>
function init(fw) { 
	variables.fw = fw; 
	}


void function before(required struct rc) output="false"	{



	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("settings.settings", "all");
		}


	}
	
	
void function register() output="false"	{


	}
</cfscript>	


<cffunction name="preview" output="false">
	<cfargument name="rc" required="true" type="struct">
	
	<cfparam name="rc.category" default="">
	<cfparam name="rc.link_back" default="">
	<cfparam name="rc.senddata" default="0">
	
	
	<cfif cgi.request_method EQ "Post" AND rc.sendData EQ 1>
		<cfparam name="rc.registrationdata" default="">
		
		<cfmail from="anon@site.com" to="support@webworldinc.com" subject="Pluma Registration">
			#rc.registrationdata#
		</cfmail>
	
		<cfset this.AddMessage("Thank you for registering.")>
		
		<cfset variables.fw.redirect("support.home", "all")>
		
		<cfreturn>
	</cfif>	
	
	
	
	<cfset var stSiteInfo = application.IOAPI.get_site_info()>
	
<cfsavecontent variable="rc.registrationdata">
<cfoutput>
<p>
<b>Submitted</b> #now()#<br />
<b>Version:</b> #application.GSAPI.get_site_credits()#<br />
<b>Language:</b><br /> 
<b>Timezone:</b><br /> 
<b>ColdFusion:</b> #stSiteInfo.cfversion#<br />
<b>Data Nodes:</b><br />
<b>Domain name:</b>#cgi.server_name#<br />

<b>Category:</b>#rc.category#<br />
<b>Link Back:</b>#rc.link_back#
 
</p>
</cfoutput>	
</cfsavecontent>
	


</cffunction>


	

<cfscript>
void function item(required struct rc) output="false"	{
		

	rc.qryDBInfo 	= application.IOAPI.get_db_schema();
	}
	

void function health(required struct rc) output="false"	{
	
	rc.qryKind 			= application.IOAPI.get_kind_count();
	
	rc.stSiteInfo = application.IOAPI.get_site_info();

	}

	
	
</cfscript>
</cfcomponent>	
	