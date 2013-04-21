

<cfcomponent extends="base">

<cfscript>
function init(fw) { 
	variables.fw = fw; 
	variables.Kind = "Menu";
	}


void function before(required struct rc) output="false"	{
	

	
	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("theme.settings", "all");
		}


	}
	
	




void function home(required struct rc) output="false" {

	param rc.plugin = "";


	param request.stTheme.current = "";
	

	
	
	if (cgi.request_method == "Post")	{
		
		
		var result = application.IOAPI.set_pref("Theme", rc); // reload is automatic
				

		
		if (result == "")
			this.AddMessage("Theme settings updated.");
		else
			this.AddMessage(result);
			
		} // end if
		
	
		
	}


void function endhome(required struct rc) output="false" {

		
	rc.qryTheme = DirectoryList(application.GSTHEMESPATH, false, "query");
	}	
	
	

void function components(required struct rc) output="false"	{

	param rc.components_new = "";
	param rc.title = "";
	
	
	if (cgi.request_method == "POST")	{
	
		if ("rc.components_new" != "" and rc.title != "")	{
			
			
			//setVariable("rc.Components_#rc.title#", rc.components_new);
			
			StructDelete(rc, rc.components_new);
			}
	
			
		
		var result = application.IOAPI.set_pref("Components", rc);
				
		
		
		
		
		if (result != "")
			this.AddMessage(result, "Error");
		else
			this.AddMessage("Component <code>#htmleditformat(rc.title)#</code> has been updated.");
		
			
		} // end if

	
	}	

void function endcomponents(required struct rc) output="false"	{

	application.IOAPI.load_pref(1); //resets all preferences
	
	rc.stComponents = application.IOAPI.get_pref("Components");
	rc.arComponents = StructSort(application.IOAPI.get_pref("Components"),"textnocase");
	}



void function delcomponents(required struct rc) output="false"	{

	param rc.pref = "";

	var result =	application.IOAPI.delete_pref("Components", rc.pref);
	
	application.IOAPI.load_pref(1); 

	if (result)	
		this.AddMessage("Component <code>#htmleditformat(rc.pref)#</code> was deleted");
	else
		this.AddMessage("Component <code>#htmleditformat(rc.pref)#</code> could not be found", "Error");
	

	variables.fw.redirect('theme.components', "all");	
	}
	
	


this.EntryCount = 8;


void function sitemap(required struct rc) output="false"	{

	param rc.submit = "";
	param rc.siteMapID = "";
	param rc.entrycount = 0;

	rc.siteroot = "http://#cgi.http_host##cgi.script_name#/";
	var target = GetDirectoryFromPath(GetBaseTemplatePath()) & "/sitemap.xml";
			

	if (cgi.request_method == "Post")	{
	
		if (rc.submit EQ "Delete")	{
			application.IOAPI.delete_node(rc.SiteMapID);
			
			if (fileexists(target))	{
				filedelete(target);
				this.AddMessage("File was deleted");				
				}
			
			
			return;
			}
	
		rc.xmlData = "";
	
		for (var i = 1; i <= this.entrycount; i++)	{
			var loc = ""; 		if (isDefined("rc.loc_#i#")) 			{ loc = evaluate("rc.loc_#i#"); }
			var changefreq = ""; if (isDefined("rc.changefreq_#i#")) 	{ changefreq = evaluate("rc.changefreq_#i#"); }
			var priority = ""; 	if (isDefined("rc.priority_#i#")) 		{ priority = evaluate("rc.priority_#i#"); }
		
				
			if (changefreq != "exclude")	{
				rc.xmlData &= "<url>"  & variables.crlf;
				rc.xmlData &= "<loc>#xmlformat(loc)#</loc>" & variables.crlf;
				rc.xmlData &= "<changefreq>#changefreq#</changefreq>" & variables.crlf;
				rc.xmlData &= "<priority>#LSNumberformat(priority, "9.9")#</priority>" & variables.crlf;
				rc.xmlData &= "</url>" & variables.crlf;
				}
				
			} /* end for */
	
		
		rc.Kind = "Sitemap";
	
		var stResult  = application.IOAPI.set_node(rc.SiteMapID, rc);
	
		rc.SiteMapID = stResult.NodeID;
	
		var stResult = application.IOAPI.set_node_XML(rc.SiteMapID, rc);
		
		/* Do write operation */
		var strSiteMap = '<?xml version="1.0" encoding="utf-8"?>'
			& variables.crlf
			& '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' 
			& variables.crlf
			& rc.xmlData 
			& variables.crlf
			& '</urlset>';
			
		strSiteMap = replace(strSiteMap, "<loc>", "<loc>#rc.siteroot#", "all");	
		
		
	
		
		filewrite(target, strSiteMap);
			
	
		this.AddMessage(stResult.message);
		} /* end post */


	
	}
	

void function endsitemap(required struct rc) output="false"	{
	

	
	rc.qryNode = application.IOAPI.get({NodeID = "max", Kind = "Sitemap" });
	
		
	rc.qrySiteMap = application.IOAPI.get_site_map(rc.qryNode.NodeID, this.entryCount); 
	
	
	
	if (rc.qryNode.Kind == "Sitemap") 
		rc.sitemapid = rc.qryNode.NodeID; 
	}
			
	

	
void function after(required struct rc) output="false" {	
	
	super.after(rc);
	
	rc.qryLinkCategory = application.IOAPI.get_All_By_Extra("Facet", "Page_LinkCategory", "title");
	
	}		
</cfscript>

</cfcomponent>
