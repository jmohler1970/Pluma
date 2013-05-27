
<cfcomponent extends="org.corfield.framework">


<cfscript>
	// Either put the org folder in your webroot or create a mapping for it!
	
	this.name 			= "PlumaCMS_0647";
	this.datasource		= "PlumaCMS";
	this.customTagPaths = GetDirectoryFromPath(getBaseTemplatePath()); 
	this.scriptProtect 	= "url, cookie";
	this.sessionManagement = true;
	this.googlemapkey 	= "Replace me";
		
	// FW/1 - configuration:
	variables.framework = {
		home 		= 'main.home', 
		baseURL 	= 'useCgiScriptName',
		generateSES = true, 
		SESomitindex = false
		};
		
	variables.framework.routes = [
		{ "/login/impersonate"	= "/login/impersonate"},
		{ "/login" 				= "/login/home"},
		{ "/forgot" 			= "/login/email"},
		{ "/logout" 			= "/login/signout"},
		
		/* make admin pages work as expected */
		{ "/settings/search" 	= "/settings/search"},
		{ "/settings/feedback" 	= "/settings/feedback"},
		

		// content
		{ "/id/:id" 			= "/main/home/id/:id"},
		{ "/id" 				= "/main/home/slug/404"},
		
		
		{ "/main/tag" 			= "/main/home/slug/tag"},
		{ "/main/archive" 		= "/main/home/slug/archive"},
		{ "/main/profile" 		= "/main/home/slug/profile"},
		{ "/main/search" 		= "/main/home/slug/search"},
		{ "/main/error" 		= "/main/error"},
		{ "/main/:id" 			= "/main/home/slug/:id"},

		
		// taxonomy
		{ "/tag/:id" 			= "/main/home/slug/tag/tag/:id"},
		{ "/tag" 				= "/main/home/slug/tag"},
		{ "/archive/:id/:id2" 	= "/main/home/slug/archive/archiveyear/:id/archivemonth/:id2"},
		{ "/archive/:id" 		= "/main/home/slug/archive/archiveyear/:id"},
		{ "/archive" 			= "/main/home/slug/archive"},
		{ "/profile/:id" 		= "/main/home/slug/profile/profile/:id"},
		{ "/profile" 			= "/main/home/slug/profile"},
		{ "/search/:id" 		= "/main/home/slug/search/search/:id"},
		{ "/search" 			= "/main/home/slug/search"},
		{ "/feedback" 			= "/main/home/slug/feedback"}
				

					
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
 	
	application.IOAPI 	= createobject("component", "api.ioapi");
	application.USERAPI = createobject("component", "api.userapi");
	application.GSAPI 	= createobject("component", "api.gsapi"); 	
		
	application.stSettings 	= application.IOAPI.load_ini("api/config.ini");
		

	
	
	
	}


void function setupSession()	{
	
	session.LOGINAPI = createobject("component", "api.loginapi"); 
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

	

	application.IOAPI.Init();
	application.USERAPI.Init();
	application.GSAPI.Init();


	// reset then override
	StructAppend(request, application.stSettings);
	application.IOAPI.load_pref();
	
	
	
	// Languages
	param request.Meta.language = "en_US";
	param request.Meta.Root = application.GSAPI.suggest_site_path();
	
	application.GSAPI.loadTab = buildURL('load.settings');
	application.GSAPI.i18n_merge();	
	
	request.arPlugins 	= [];
	application.IOAPI.load_plugins();
	
	
	
	// before all security
	application.GSAPI.exec_action("common", "", rc);
	
	

	/* Does at least one user exist, if not run install */
	if (not application.USERAPI.at_least_one_user())	{
		application.GSAPI.addWarning("NO_USER");
	
		//location("#application.GSAPI.get_site_root()#index.cfm/install/home", "no");
		}	
	
	 	

	

	

	if (session.LOGINAPI.checkSecurity(getSubSystem(), getSection(), getItem()) == 0)	{
		// Note: if you are on a public page, you pass security and there is no redirect --->
		location("#application.GSAPI.get_site_root()#index.cfm/login?key=Login_Expired", "no");
		
		return;
		} 
	
		
	// No theme setup	
	if (getSection() == "main" and application.GSAPI.get_theme() == "")	{
		
	
		location("#application.GSAPI.get_site_root()#index.cfm/login?key=No_Theme", "no");
		
		return;
		}	
		

	if (isnumeric(rc.id))	{
		StructAppend(request.stIOR, application.IOAPI.get_bundle({NodeID = rc.id, Kind = ""}));
		
		return;
		}

	
		
	StructAppend(request.stIOR, application.IOAPI.get_bundle({Slug = rc.slug}));
	}

</cfscript>

	



<cfscript>

void function onMissingView()	{
	
	if (request.err.uselog)	{
		application.IOAPI.add_log("404", "Invalid requested page: <tt>#getSection()#.#getItem()#</tt>");			
		}


	location("#application.GSAPI.find_url('404')#", "no");	
	}


</cfscript>


</cfcomponent>