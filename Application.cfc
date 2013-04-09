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

<cfcomponent extends="org.corfield.framework">


<cfscript>
	// Either put the org folder in your webroot or create a mapping for it!
	
	this.name 			= "Pluma_CMS0190";
	this.customTagPaths = GetDirectoryFromPath(getBaseTemplatePath()); 
	this.scriptProtect 	= "url, cookie";
	this.sessionManagement = true;
	this.googlemapkey 	= "ABQIAAAAM7WBPKVXehxfd19uHXWn2BR3hyaePP4Fq67BBIiFqEcv7oiJ1xQgrHCorqqETsRunESHOSr-dZ7UIg";
		
	// FW/1 - configuration:
	variables.framework = {
		home 		= 'home:main.home', 
		baseURL 	= 'useCgiScriptName',
		generateSES = true, 
		SESomitindex = false,
		UsingSubsystems = true
		};
		
	variables.framework.routes = [
		{ "/install" 		= "/admin:install/home"}, 
		{ "/login" 			= "/admin:login/home"},
		{ "/logout" 		= "/admin:login/signout"},

		// content
		{ "/id/:id" 		= "/main/home/id/:id"},
		{ "/id" 			= "/main/home/slug/404"},
		
		{ "/main/tag" 		= "/main/home/slug/tag"},
		{ "/main/archive" 	= "/main/home/slug/archive"},
		{ "/main/profile" 	= "/main/home/slug/profile"},
		{ "/main/search" 	= "/main/home/slug/search"},
		{ "/main/error" 	= "/main/error"},
		{ "/main/:id" 		= "/main/home/slug/:id"},

		
		// taxonomy
		{ "/tag/:id" 			= "/main/home/slug/tag/tag/:id"},
		{ "/tag" 				= "/main/home/slug/tag"},
		{ "/archive/:id/:id2" 	= "/main/home/slug/archive/archiveyear/:id/archivemonth/:id2"},
		{ "/archive/:id" 		= "/main/home/slug/archive/archiveyear/:id"},
		{ "/archive" 			= "/main/home/slug/archive"},
		{ "/profile/:id" 		= "/main/home/slug/profile/profile/:id"},
		{ "/profile" 			= "/main/home/slug/profile"},
		{ "/search/:id" 		= "/main/home/slug/search/search/:id"},
		{ "/search" 			= "/main/home/slug/search"}
				
				

					
		];

		
// end constructor


void function setupApplication() output="false"	{

		
	application.initialized			= now();
	
	
	var objAppFile = fileopen(expandpath('./Application.cfc'), 'read');
	
	application.GSVERSION = "Version 0.1.#right(year(objAppFile.lastmodified), 2)#.#month(objAppFile.lastmodified)#.#day(objAppFile.lastmodified)#";
fileclose(objAppFile);
	

	// Common variables and paths
 	application.GSAUTHOR			= "James Mohler and Web World Inc";
 	application.GSSITE_FULL_NAME	= "Pluma CMS";
 	application.GSSITE_LINK_BACK_URL= "http://www.webworldinc.com";
 	
 	
 	 	
 	application.GSROOTPATH 			= getdirectoryfrompath(getBaseTemplatePath());
 	application.GSPLUGINPATH 		= application.GSROOTPATH & "plugins/";
 	application.GSUSERSPATH 		= application.GSROOTPATH & "users/";
 	application.GSDATAPATH			= application.GSROOTPATH & "data/";
 	application.GSBACKUPSPATH		= application.GSROOTPATH & "backups/";
 	application.GSDATAUPLOADPATH	= application.GSROOTPATH & "data/uploads/";
 	application.GSDATADOWNLOADPATH	= application.GSROOTPATH & "data/downloads/";
 	application.GSTHUMBNAILPATH		= application.GSROOTPATH & "data/thumbs/";
 	application.GSTHEMESPATH		= application.GSROOTPATH & "theme/";
 	
 	// API	
	
	
	application.IOAPI 	= createobject("component", "api.ioapi");
	application.IOAPI.Init();
	application.USERAPI = createobject("component", "api.userapi");
	application.USERAPI.Init();
	application.GSAPI 	= createobject("component", "api.gsapi"); 	
	application.GSAPI.Init();
	

	
	application.stAdminSetting 	= application.IOAPI.loadini("admin/standard.ini");

	

	// plugins
	application.live_plugins = {};
	}


void function setupSession()	{
	
	session.LOGINAPI = createobject("component", "api.loginapi"); 
	session.LOGINAPI.Init();

	}
	
</cfscript>	

<cffunction name="setupRequest">	

	

<cfscript>
	param rc.id 	= "";
	param rc.nodeid = "" ; // Admin use only, use id for normal requests --->
	param rc.slug	= "home"; // There are slugs with blank no many objects that are not pages --->



	request.arPlugins 	= [];
	application.GSAPI.loadplugins();
	
	request.stIOR		= {};
	

	/* Does at least one user exist, if not run install */
	if (not application.USERAPI.at_least_one_user())	{
		//location("#application.GSAPI.get_site_root()#index.cfm/admin:install/home", "no");
		}	
	
	 	

	application.IOAPI.add_traffic(rc, getSubSystem(), getSection(), getItem());
	

	application.IOAPI.load_pref();
		
	

	if (session.LOGINAPI.checkSecurity(getSubSystem(), getSection(), getItem()) == 0)	{
		// Note: if you are on a public page, you pass security and there is no redirect --->
		location("#application.GSAPI.get_site_root()#index.cfm/login?message=Login Expired", "no");
		
		return;
		} 

	if (isnumeric(rc.id))	{
		StructAppend(request.stIOR, application.IOAPI.get_bundle({NodeID = rc.id, Kind = ""}));
		
		return;
		}

		
	StructAppend(request.stIOR, application.IOAPI.get_bundle({Slug = rc.slug}));


</cfscript>
</cffunction>	
	



<cfscript>

void function onMissingView()	{


	//location("/index.cfm/main/home/slug/404", "no");	
	}


</cfscript>


</cfcomponent>