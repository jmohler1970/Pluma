<cfcomponent>

<cfscript>


thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{

this.stPlugin_info =
	application.GSAPI.register_plugin(thisFile, 
		'Gallery',
		'0.1',
		'James Mohler',
		'',
		'Settings for Gallery',
		'theme',
		'',
		'icon-cog');
	
		application.GSAPI.add_action('nav-tab', 'createNavTab', ["?plugin=gallery", "Gallery/TAB", "gallery"]);
		
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery", "GALLERY/OVERVIEW_HEADER", "gallery"]);
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery&plx=edit", "GALLERY/CREATE_GALLERY", "gallery"]);
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery&plx=options", "GALLERY/SETTINGS", "gallery"]);	
	}
		
</cfscript>

<cffunction name="settings" returnType="struct">

	<cfreturn {}>
</cffunction>


</cfcomponent>

