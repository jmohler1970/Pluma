
<cfcomponent>

<cfscript>
this.EntryCount = 8;

thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
		'Innovation Theme',
		'0.1',
		'James Mohler',
		'http://webworldinc.com',
		'Setting for Innovation theme.',
		'theme',
		'',
		'icon-cog');
	
	
	application.GSAPI.add_action("theme_sidebar", "createSideMenu", ["?plugin=innovation", "Innovation Theme Settings", "innovation"]);
	
	application.GSAPI.register_style( 'innovation', '//fonts.googleapis.com/css?family=Yanone+Kaffeesatz');
	application.GSAPI.register_style( 'innovation', '~/theme/innovation/reset.css', 0.1);
	application.GSAPI.register_style( 'innovation', '~/theme/innovation/style.css', 0.1);
	application.GSAPI.register_script( 'innovation', '~/theme/innovation/jquery-2.0.0.min.js', 2.0, false, 1);
	}
		
</cfscript>


<cffunction name="settings" returnType="struct">
	


	
<cfswitch expression="#rc.plx#">
<cfdefaultcase>

	<cfscript>
	
	
	if (cgi.request_method == "POST")	{
		
		result = application.IOAPI.set_pref("Innovation", rc);
		
		variables.stResult.message = "Settings for Innovation saved";
		}
	
	StructAppend(rc, application.IOAPI.get_pref("Innovation"));
		
	param rc.Innovation_facebook = "";
	param rc.Innovation_twitter = "";
	param rc.Innovation_linkedin = "";
	param rc.Innovation_stackoverflow = "";
	
	param rc.Innovation_login 	= 0;
	param rc.Innovation_search 	= 0;
	param rc.Innovation_tags 	= 0;
	</cfscript>




	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="innovation/settings.cfm">
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	

	<cfreturn variables.stResult>
</cffunction>




</cfcomponent>
