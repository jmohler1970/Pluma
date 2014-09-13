
<cfcomponent extends="org.corfield.framework">

<cfscript>
	// Either put the org folder in your webroot or create a mapping for it!
	
	this.name 			= "PlumaCMS_316";
	this.datasource		= "PlumaCMS";
	this.customTagPaths = GetDirectoryFromPath(getBaseTemplatePath()); 
	this.scriptProtect 	= "url, cookie";
	this.sessionManagement = true;
	this.googlemapkey 	= "Replace me";
		
	// FW/1 - configuration:
	variables.framework = {
		home 		= 'wiki.home',
		error		= 'wiki.error', 
		baseURL 	= 'useCgiScriptName',
		generateSES = true, 
		SESomitindex = false,
		trace 		= isDebugMode()
		};
		
	variables.framework.routes = [
		{ "/login/impersonate"	= "/login/impersonate"},
		{ "/login" 				= "/login/home"},
		{ "/forgot" 			= "/login/email"},
		{ "/logout" 			= "/login/signout"},
		
		/* JSON routes */
		{ "/json/pref/:id"		= "/json/pref/pref/:id"},
				
		/* make admin pages work as expected */
		{ "/settings/search" 	= "/settings/search"},
		{ "/settings/feedback" 	= "/settings/feedback"},
		

		// content
		{ "/id/:id" 			= "/main/home/id/:id"},
		{ "/id" 				= "/main/home/slug/404"},
		
		
		{ "/wiki/tag" 			= "/wiki/home/slug/tag"},
		{ "/wiki/archive" 		= "/wiki/home/slug/archive"},
		{ "/wiki/profile" 		= "/wiki/home/slug/profile"},
		{ "/wiki/search" 		= "/wiki/home/slug/search"},
		{ "/wiki/error" 		= "/wiki/error"},
		{ "/wiki/:id" 			= "/wiki/home/slug/:id"},

		
		// taxonomy
		{ "/tag/:id" 			= "/wiki/home/slug/tag/tag/:id"},
		{ "/tag" 				= "/wiki/home/slug/tag"},
		{ "/archive/:id/:id2" 	= "/wiki/home/slug/archive/archiveyear/:id/archivemonth/:id2"},
		{ "/archive/:id" 		= "/wiki/home/slug/archive/archiveyear/:id"},
		{ "/archive" 			= "/wiki/home/slug/archive"},
		{ "/profile/:id" 		= "/wiki/home/slug/profile/profile/:id"},
		{ "/profile" 			= "/wiki/home/slug/profile"},
		{ "/search/:id" 		= "/wiki/home/slug/search/search/:id"},
		{ "/search" 			= "/wiki/home/slug/search"},
		{ "/feedback" 			= "/wiki/home/slug/feedback"}
				

					
		];

		
// end constructor


void function setupApplication() output="false"	{

		
	application.initialized			= now();
	
	
	var objAppFile = fileopen(expandpath('./Application.cfc'), 'read');
	
	application.GSVERSION = "Version 3.3.1.#right(year(objAppFile.lastmodified), 2)#.#month(objAppFile.lastmodified)#.#day(objAppFile.lastmodified)#";
fileclose(objAppFile);
	

	// Common variables and paths
 	application.GSAUTHOR			= "James Mohler and Web World Inc";
 	application.GSSITE_FULL_NAME	= "Pluma CMS";
 	application.GSSITE_LINK_BACK_URL= "http://www.webworldinc.com";
 	
 	
 	 	
 	application.GSROOTPATH 			= getdirectoryfrompath(getBaseTemplatePath());
 	application.GSBACKUPSPATH		= application.GSROOTPATH & "backups/";
 	application.GSDATAPATH			= application.GSROOTPATH & "data/";
 	application.GSDATADOWNLOADPATH	= application.GSROOTPATH & "data/downloads/";
 	application.GSDATAUPLOADPATH	= application.GSROOTPATH & "data/uploads/";
 	application.GSDATAOTHERPATH		= application.GSROOTPATH & "data/other/";
 	application.GSTHUMBNAILPATH		= application.GSROOTPATH & "data/thumbs/";
 	application.GSLANGPATH			= application.GSROOTPATH & "lang/";
 	application.GSPLUGINPATH 		= application.GSROOTPATH & "plugins/";
 	application.GSUSERSPATH 		= application.GSROOTPATH & "users/";
 	application.GSTHEMESPATH		= application.GSROOTPATH & "theme/";
 	
 	// API
 	
	application.IOAPI 	= new api.ioapi();
	application.stSettings 	= application.IOAPI.load_ini("api/config.ini");

	
	application.USERAPI = new api.userapi();
	application.GSAPI 	= new api.gsapi(); 	
	}


void function setupSession()	{
	
	session.LOGINAPI = new api.loginapi(); 
	session.LOGINAPI.Init();
	}


void function setupRequest()	{


	param rc.id 	= "";  // This is used for page requests
	param rc.nodeid = "" ; // Admin use only, use id for normal requests --->
	param rc.slug	= "index"; // There are slugs with blank no many objects that are not pages --->
	
	rc._SubSystem  	= getSubSystem();
	rc._Section 	= getSection();
	rc._Item 		= getItem();
	
	request.stIOR		= {};

	

	application.IOAPI.Storage();
	application.USERAPI.Init();
	application.GSAPI.Init();
	application.GSAPI.rc = rc; // does not have anything from controllers


	// reset then override
	StructAppend(request, application.stSettings);
	application.IOAPI.load_pref();
	
	
	
	// Languages
	param request.Meta.language = "en_US";
	param request.Meta.Root = application.GSAPI.suggest_site_path();
	
	application.GSAPI.loadTab = buildURL('load.settings');
	application.GSAPI.i18n_merge();	
	
	// plugins
	request.arPlugins 	= [];
	application.IOAPI.load_plugins();
	
	
	
	// before all security
	application.GSAPI.exec_action("common");
	
	

	/* Does at least one user exist, if not run install */
	if (not application.USERAPI.at_least_one_user())	{
		application.GSAPI.addWarning("NO_USER");
	
		//location("#application.GSAPI.get_site_root()#index.cfm/install", "no");
		}	
	
	 	


	if (not session.LOGINAPI.checkSecurity(getSubSystem(), getSection(), getItem()))	{
		// Note: if you are on a public page, you pass security and there is no redirect --->
		location("#application.GSAPI.get_site_root()#index.cfm/login?key=Login_Expired", "no");
		
		return;
		} 
	
	
	// Don't run scaffold
	if (getSection() == "scaffold")	{
		location(application.GSAPI.get_site_root(), "no");
		}
		
				
	// No theme setup	
	if (getSection() == "main" && application.GSAPI.get_theme() == "")	{
		
		location("#application.GSAPI.get_site_root()#index.cfm/login?key=No_Theme", "no");
		
		return;
		}	
		

	if (isnumeric(rc.id))	{
		StructAppend(request.stIOR, application.IOAPI.get_bundle({NodeID = rc.id, Kind = ""}));
		
		return;
		}


	
	
	// default content	
	StructAppend(request.stIOR, application.IOAPI.get_bundle({Slug = rc.slug}));
	}

</cfscript>

	




<cffunction name="onMissingView" returntype="string" output="false">

	<cfif structKeyExists(rc, "response")>
		<cfsetting showDebugOutput="false">
		
		<cfset var response = getPageContext().getResponse()>
		<cfset response.setContentType("application.json")>
		
		<cfreturn serializeJSON(rc.response)>
	</cfif>

	
	<cfif isDefined("request.err.uselog") AND request.err.uselog>
		<cfset application.IOAPI.add_log("404", "Invalid requested page: <tt>#getSection()#.#getItem()#</tt>")>
	</cfif>


	<cfset location("#application.GSAPI.find_url('404')#", "no")>	
	

</cffunction>


</cfcomponent>