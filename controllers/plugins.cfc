

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
	
		variables.fw.redirect("plugins.settings", "all");
		}
	
		
	rc.qryLinkCategory 	= application.IOAPI.get_All_By_Extra("Facet", "Page_LinkCategory", "title");
	

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
	
		<cfset this.AddInfo("plumacms/plugins_saved")>
	
		<cfset application.IOAPI.load_plugins()>
	</cfif>
	
	
</cffunction> 

	

</cfcomponent>
	
	

