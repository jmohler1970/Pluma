
<cfcomponent extends="plugin">

<cfscript>
this.EntryCount = 8;

thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{
this.register_plugin(thisFile, 
	'Innovation Theme',
	'0.1',
	'James Mohler',
	'http://webworldinc.com',
	'Setting for Innovation theme.',
	'theme',
	'',
	'icon-cog');
	
	
this.add_action("theme_sidebar", "createSideMenu", ["?plugin=innovation", "Innovation Theme Settings"]);
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
	</cfscript>




	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="innovation/settings.cfm">
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	

	<cfreturn variables.stResult>
</cffunction>




</cfcomponent>
