

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


	param request.Theme.current = "";
	

	
	
	if (cgi.request_method == "Post")	{
		
		
		var result = application.IOAPI.set_pref("Theme", rc); // reload is automatic
				

		
		if (result == "")	{
			application.IOAPI.load_pref();
			this.addSuccess("THEME_CHANGED");
			}
					
		else
			this.addInfo("Error");
			
		} // end if
		
	
		
	}


void function endhome(required struct rc) output="false" {

		
	rc.qryTheme = DirectoryList(application.GSTHEMESPATH, false, "query");
	}	
	


void function edit(required struct rc) output="false" {

	param rc.theme_files = "template.cfm";

		
	rc.qryTemplates = DirectoryList(application.GSTHEMESPATH & application.GSAPI.get_theme(), false, "query");
	
	rc.strTemplate = FileRead(application.GSTHEMESPATH & application.GSAPI.get_theme() & "\" & rc.theme_files);
	}	




void function components(required struct rc) output="false"	{

	
	
	if (cgi.request_method == "POST")	{
	
		if (rc.components.new == "" and rc.components.new_title != "")	{
			this.addWarning("PLUMACMS/ISBLANK", ["Component Title"]);
			}

	

		application.GSAPI.exec_action('component-save', "", rc);
		
		var result = application.IOAPI.set_pref("Components", rc.Components);
				
	
		
		if (result == "")
			this.addSuccess("ER_COMPONENT_SAVE");
		else
			this.addError("Error");
	
		
			
		} // end if

	
	}	

void function endcomponents(required struct rc) output="false"	{

	application.IOAPI.load_pref(1); //resets all preferences
	

	rc.Components = application.IOAPI.get_pref("Components");
	}



void function delcomponents(required struct rc) output="false"	{

	param rc.pref = "";

	var result =	application.IOAPI.delete_pref("Components", rc.pref);
	
	application.IOAPI.load_pref(1); 

	if (result)	
		this.addSuccess("ER_HASBEEN_DEL", [rc.pref]);
	else
		this.addError("NOT_FOUND", [rc.pref]);
	
	

	variables.fw.redirect('theme.components', "all");	
	}
	
	


void function sitemap(required struct rc) output="false"	{
	
	
	rc.qryAllPages = application.IOAPI.get_all("Page", {}, "Menu");	
	
	if (rc.qryAllPages.recordcount == 0) {
		this.addWarning("PLUMACMS/ISEMPTY", ['Sitemap']);		
		}
	
	
	rc.xmlData = '<?xml version="1.0" encoding="utf-8"?>'
				& variables.crlf
				& '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
	
	for (var i = 1; i <= rc.qryAllPages.recordcount; i++)	{
		
				
		if (rc.qryAllPages.pStatus[i] == "public")	{
			
		
			rc.xmlData &= "<url>"  & variables.crlf;
			rc.xmlData &= "<loc>#application.GSAPI.find_url(rc.qryAllPages.slug[i])#</loc>" & variables.crlf;
			rc.xmlData &= "<changefreq>Weekly</changefreq>" & variables.crlf;
			rc.xmlData &= rc.qryAllPages.menustatus[i] == 1 ? "<priority>1.0</priority>" : "<priority>0.5</priority>";
			rc.xmlData &= variables.crlf;
			rc.xmlData &= "</url>" & variables.crlf;
			}
				
		} /* end for */
	
	rc.xmlData &= "</urlset>";
	
	param rc.refresh = 0;	
	
	if (rc.refresh)	{
	
		filewrite(application.GSROOTPATH & "sitemap.xml", rc.xmlData);
		this.addSuccess("SITEMAP_REFRESHED");
		}

	}
			
	

	
void function after(required struct rc) output="false" {	
	
	super.after(rc);
	
	rc.qryLinkCategory = application.IOAPI.get_All_By_Extra("Facet", "Page_LinkCategory", "title");
	
	}		
</cfscript>

</cfcomponent>
