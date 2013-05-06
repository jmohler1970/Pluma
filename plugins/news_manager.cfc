

<cfcomponent>

<cfscript>


thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{
	this.stPlugin_info = 
	application.GSAPI.register_plugin(thisFile, 
	'Event Manager',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'A event plugin for Pluma CMS. Creates calendar of upcoming events',
	'',
	'',
	'icon-calendar');
	
	
	application.GSAPI.add_action("pages_sidebar", "createSideMenu", ["?plugin=news_manager", "Event Manager", "news_manager"]);
	application.GSAPI.add_action("pages_sidebar", "createSideMenu", ["?plugin=news_manager&plx=edit", "Create New Event", "news_manager_add"]);

	}	
</cfscript>



<cffunction name="summary" returnType="struct">

	<cfset variables.qryEvent 	= application.IOAPI.get_All("Event", 1, "ExpirationDate DESC")>
	
	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="event/summary.cfi">
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
		<cfinclude template="news_manager/edit.cfi">
	</cfsavecontent>
</cfcase>

<cfcase value="delete">
	
	<cfscript>
		var nodeK = {NodeID = rc.NodeID , Kind = "Event"};

		variables.stResult = application.IOAPI.delete(NodeK);
	
		rc.qryEvent 		= application.IOAPI.get_event("Event");
	</cfscript>

	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="news_manager/settings.cfi">
	</cfsavecontent>
</cfcase>

<cfdefaultcase> 
	<cfsavecontent variable="variables.stResult.content">
		<cfinclude template="news_manager/settings.cfi">
	</cfsavecontent>
</cfdefaultcase>
</cfswitch>


		
	<cfreturn variables.stResult>
</cffunction>


</cfcomponent>

