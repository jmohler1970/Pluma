

<cfcomponent extends="base">


<cfscript>
function init(fw) { 
	variables.fw = fw; 
	variables.Kind = "Unknown";
	
		
	}
	
struct function before(required struct rc) output="false" {

	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("settings.settings", "all");
		}
	
		
	rc.qryLinkCategory 	= application.IOAPI.get_All_By_Extra("Facet", "Page_LinkCategory", "title");
	
	//rc.qrySlug 			= application.IOAPI.getMatchlist("Page", "", "Any", "Any", "Any", false, true);

	return rc;

	}
	
	
void function starthome(required struct rc) output="false" {
	

	
	param rc.filter = "";
	param rc.kind = "";
	param rc.group = "";
	param rc.pstatus = "";
	param rc.commentmode = "";
	param rc.recent = "";
	param rc.withaction = "";
	}

</cfscript>	
	

<cffunction name="home" output="false">
	<cfargument name="rc" type="struct" required="true">



	
	
	<cfif cgi.request_method EQ "post">

		<cfset application.IOAPI.set_pref("Plugin", rc)>
	
		<cfset this.AddMessage("Plugins were updated.")>
	</cfif>
	
	
	<cfset application.IOAPI.load_plugins()>
</cffunction> 

	
<cfscript>	


void function startedit(required struct rc) output="false" {
	
	param rc.Kind = "";
	var OriginalKind = rc.Kind;
	
	var NodeK = {NodeID = rc.NodeID, Kind = rc.Kind}; // one of these has to be present
	
	StructAppend(rc, application.IOAPI.get_bundle(NodeK));
	
	
	if (rc.Kind == "")	{
		rc.Kind = OriginalKind;
		}

	if (rc.Kind == "")	{
		this.AddMessage("Could not load node and could not create blank template");
	
		// variables.fw.redirect("admin:plugins.home", "all");
		}
		
	// Load common options. Common options are only displayed if plugin wants to	
	//rc.commonOption = this.doCommonOption(rc.NodeID, rc);
	}
	
	
	



void function matchlist(required struct rc) output="false" {

	param rc.kind = "Any";
	param rc.filter = "";
	param rc.group = "";
	param rc.pstatus = "";
	param rc.commentmode = "";
	param rc.recent = false;
	param rc.withaction = false;
	
	
	rc.qryMatchlist = application.IOAPI.getMatchlist(rc.Kind, rc.filter, rc.group, rc.pstatus, rc.commentmode, rc.recent, rc.withaction);	
	}

	
</cfscript>	
	

	



</cfcomponent>
	
	

