

<cfcomponent extends="base">

<cfscript>
function init(fw) { variables.fw = fw; }


struct function before(required struct rc) output="false" {

	

	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("settings.settings", "all");
		}


	rc.qryAllPages = application.IOAPI.get_page_parent();
	 			
	return rc;
	}
	
	
void function home(required struct rc) output="false" {

	
	param rc.nodeID = "";
	
	if (isnumeric(rc.nodeID))	{
		
		rc.qryArchive = application.IOAPI.get_archive({NodeID = rc.NodeID});
		
		return;
		}

	
	rc.qryArchive = application.IOAPI.get_archive({Kind = "Page"});
	}	


void function edit(required struct rc) output="false" {
	
	param rc.nodearchiveid = "";
	
	rc.qryArchive = application.IOAPI.get_archive_details(rc.nodearchiveid);
	}	


void function restore(required struct rc) output="false"	{

	param rc.nodeArchiveID = "";

	stResult = application.IOAPI.restore_Archive(rc.nodeArchiveID);
	
	if (stResult.result)	{
		this.addSuccess("ER_HASBEEN_REST", [rc.nodeArchiveID]);
		}
	else	{
		this.addError("ER_REQ_PROC_FAIL");
		}	
	
	
	variables.fw.redirect("backups.home", "all");
	}



void function delete(required struct rc) output="false"	{

	param rc.nodeArchiveID = "";

	stResult = application.IOAPI.delete_Archive(rc.nodeArchiveID);
	
	if (stResult.result)	{
		this.addSuccess("ARCHIVE_DELETED");
		}
	else	{
		this.addError("IS_MISSING", [rc.nodeArchiveID]);
		}	
	
	
	variables.fw.redirect("backups.home", "all");
	}


void function history(required struct rc) output="false" {
	
	param rc.nodeID = "";
	
	if (not isnumeric(rc.nodeID))	{
		
		this.addError("PAGE_NOTEXIST");
		
		variables.fw.redirect("backups.home", "all");
		}
	
	
	
	rc.qryArchive = application.IOAPI.get_Archive({NodeID = rc.NodeID});
	}	
	
	

/* Data as in datafile */
void function importdata(required struct rc) output="false"	{

	rc.currentfolder = application.GSBACKUPSPATH;



	if (NOT DirectoryExists(rc.CurrentFolder))	{ DirectoryCreate(rc.CurrentFolder); }


	rc.qryDirectory = DirectoryList(rc.CurrentFolder, "false", "query");
	}	
	

void function deletedata(required struct rc) output="false"	{

	
	var target = application.GSBACKUPSPATH & listlast(rc.name, "/"); //to protect from attacks
	
	
	if (FileExists(target))	{
	
			FileDelete(target);
			
			this.AddSuccess("ER_FILE_DEL_SUC");
			}
	
	else	{
		this.AddError("NOT_FOUND", [rc.name]);
		}
		
	
	
	
	variables.fw.redirect("backups.importdata", "all");
	}		
	
	
void function process(required struct rc) output="false" {	


	try	{

		fileupload(application.GSBACKUPSPATH, "csv", "*/*", rc.nameconflict);
	
		targetname = cffile.serverfile;
					
		targetname = replace(targetname,",","_","all");	// files with commas are problematic
			
			
		filemove("#application.GSBACKUPSPATH##cffile.serverfile#","#application.GSBACKUPSPATH##targetname#");
		
	
		} // end try
		catch (any err) {
			this.AddError(ERR_CANNOT_DELETE, [err.message]); 
			}



	
	variables.fw.redirect("backups.importdata", "all");
	}
</cfscript>	
	




<cffunction name="preview" output="no">
	<cfargument name="rc" required="true" type="struct">
	
	
	<cfscript>
	param rc.name = "";
	
	
	param rc.title = "";
	param rc.slug = "";
	param rc.tags = "";
	param rc.pstatus = "";
	param rc.menuStatus = 0;
	param rc.menu = "";
	param rc.menuorder = "";
	param rc.theme_template = "";
	param rc.parentslug = "";
	param rc.modifyby = "";
	
	param rc.strData = "";
	param rc.xmlData = "";



	</cfscript>
	
	
	
	
	<cfswitch expression="#listlast(rc.name, '.')#">
	<cfcase value="txt">
		<cfinclude template="backupfilter/text.cfi">
	</cfcase>
	<cfcase value="xml">
		<cfinclude template="backupfilter/native.cfi">
	</cfcase>
	<cfcase value="xls,xlsx">
		<cfinclude template="backupfilter/spreadsheet.cfi">
	</cfcase>
	<cfdefaultcase>
		<cfset this.AddWarning("API_ERR_BADMETHOD", [rc.name])>	
	</cfdefaultcase>
	
	</cfswitch>	
	

	<cfif cgi.request_method EQ "POST">
	
	
		<cfset result = application.IOAPI.set_XMLData({NodeID = rc.NodeID}, {xmlData = rc.xmlData})>

		<cfset this.AddInfo(result.key)>

		<cfset variables.fw.redirect("backup.import", "all")>
	</cfif>

</cffunction>



<cffunction name="exportdata" output="false">
	<cfargument name="rc" required="true" type="struct">

	<cfset rc.xmlResult = "">
	<cfset rc.slug = "">
	<cfparam name="rc.exportNodeID" default=""> 


	<cfif cgi.request_method EQ "POST" AND rc.exportNodeID NEQ "">
		<cfparam name="rc.NodeID" default="">
	
		<cfset var qryData = application.IOAPI.get({NodeID = rc.ExportNodeID, Kind = "Page"})>
		
		<cfif qryData.slug NEQ "">
		<cfwddx action="cfml2wddx" input="#qryData#" output="wddxData">
		
		<cfsavecontent variable="rc.xmlResult">
		
			<cfoutput query="qryData">
<?xml version="1.0" encoding="UTF-8"?>
<item>
	<pubDate>#DayofWeekAsString(DayOfWeek(modifyDate))#, 
					#LSDateFormat(modifyDate, "ddD Mmm YYYY")# #LSTimeFormat(modifyDate, "HH:mm:ss")# -0700
	</pubDate>
	<title><![CDATA[#title#]]></title>
	<url><![CDATA[#slug#]]></url>
	<meta><![CDATA[#tags#]]></meta>
	<metad><![CDATA[]]></metad>
	<menu><![CDATA[#menu#]]></menu>
	<menuOrder><![CDATA[#menusort#]]></menuOrder>
	<menuStatus><![CDATA[#menuStatus#]]></menuStatus>
	<template><![CDATA[#theme_template#]]></template>
	<parent><![CDATA[#parentslug#]]></parent>
	<content><![CDATA[#xmlFormat(strData)#]]></content>
	<private><![CDATA[]]></private>
	<author><![CDATA[#ModifyBy#]]></author>
</item>
			</cfoutput>
		</cfsavecontent>
	
	
		
		<cfscript>
		rc.slug = qryData.slug;
		
		var target = application.GSBACKUPSPATH & rc.slug & ".xml";
		
			if (FileExists(target))	{
		
				FileDelete(target);
				
				}
		</cfscript>
		
			<cffile action="write" file="#application.GSBACKUPSPATH##rc.slug#.xml" output="#trim(rc.xmlResult)#">
		
			<cfset Link = '<a href="/backups/#rc.slug#.xml" target="_blank"><tt>#rc.slug#.xml</tt></a>'> 
			<cfset this.addInfo("PLUMACMS/XML_CREATED", [link])>
		<cfelse>
			<cfset this.addError("NOT_FOUND")>
		</cfif>
		
	</cfif>

	<cfset variables.fw.redirect("backups.importdata", "all")>

</cffunction>




</cfcomponent>


