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


thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{
	this.register_plugin(thisFile, 
	'Event Manager',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'A event plugin for Pluma CMS. Creates calendar of upcoming events',
	'',
	'',
	'icon-calendar');
	
	
	this.add_action("pages_sidebar", "createSideMenu", ["?plugin=event", "Event Manager"]);
	this.add_action("pages_sidebar", "createSideMenu", ["?plugin=event&plx=edit", "Create New Event"]);
	
	this.add_action("plugin_content", "createSelectMenu", ["event_summary", "Event Summary"]);
	}	
</cfscript>



<cffunction name="summary" returnType="struct">

	<cfset variables.qryEvent 	= application.IOAPI.get_All("Event", 1, "ExpirationDate DESC")>
	
	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="event/content/summary.cfm">
	</cfsavecontent>
	
	<cfreturn variables.stResult>
</cffunction>





<cffunction name="settings" returnType="struct">
<cfscript>
	param rc.filter = "";

	rc.qryEvent 		= application.IOAPI.get_event("Event");

</cfscript>


<cfswitch expression="#rc.plx#">
<cfcase value="edit">

	
	<cfscript>
	var nodeK = {NodeID = rc.NodeID , Kind = "Event"};
	
	if (cgi.request_method == "post")	{
	
					
		variables.stResult = application.IOAPI.set(NodeK, rc);
		nodeK.NodeID = variables.stResult.NodeID;
		application.IOAPI.set_conf(NodeK, rc);
		}

	
	
	
	StructAppend(rc, application.IOAPI.get_bundle(NodeK));
	</cfscript>


	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="event/edit.cfm">
	</cfsavecontent>
</cfcase>

<cfcase value="delete">
	
	<cfscript>
		var nodeK = {NodeID = rc.NodeID , Kind = "Event"};

		variables.stResult = application.IOAPI.delete(NodeK);
	
		rc.qryEvent 		= application.IOAPI.get_event("Event");
	</cfscript>

	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="event/settings.cfm">
	</cfsavecontent>
</cfcase>

<cfdefaultcase> 
	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="event/settings.cfm">
	</cfsavecontent>
</cfdefaultcase>
</cfswitch>

	<cfset this.add_action("plugins_sidebar", "createSideMenu", ["?plugin=event&plx=edit", "Add/Edit Event"])>
		
	<cfreturn variables.stResult>
</cffunction>


</cfcomponent>

