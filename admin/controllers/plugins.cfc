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
	
	
	<cfset application.GSAPI.loadplugins()>
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
	
	

