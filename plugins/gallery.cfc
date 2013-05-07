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

	}
		
</cfscript>

<cffunction name="settings" returnType="struct">

	<cfreturn {}>
</cffunction>


</cfcomponent>

