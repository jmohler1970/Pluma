

<cfcomponent>

<cfscript>
this.EntryCount = 8;

thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{

this.stPlugin_info =
	application.GSAPI.register_plugin(thisFile, 
		'Bootswatch Theme',
		'0.1',
		'James Mohler',
		'http:http://bootswatch.com',
		'Setting for bootswatch CMS themes.',
		'theme',
		'',
		'icon-cog');
	
	
	application.GSAPI.add_action("theme_sidebar", "createSideMenu", ["?plugin=bootswatch", "BOOTSWATCH/SIDEBAR", "bootswatch"]);
	
	}
		
</cfscript>


<cffunction name="settings" returnType="struct">
	


	
<cfswitch expression="#rc.plx#">
<cfdefaultcase>

	<cfscript>
	
	
	if (cgi.request_method == "POST")	{
		
		result = application.IOAPI.set_pref("Bootswatch", rc);
		
		application.IOAPI.load_pref();
		
		variables.stResult.message = "Settings for Bootswatch saved";
		
		}
	
	StructAppend(rc, application.IOAPI.get_pref("Bootswatch"));
		
	param rc.Bootswatch_css = "";
	param rc.Bootswatch_backgroundColor = "";
	param rc.Bootswatch_backgroundImage = "";
	param rc.Bootswatch_backgroundRepeat = "no-repeat";
	param rc.Bootswatch_backgroundAttachment = 0;
	

	var background = application.GSTHEMESPATH & "bootswatch/assets/background/";
	rc.qryBackground = DirectoryList(background,"false","query", "*.*", "name");

	var css = application.GSTHEMESPATH & "bootswatch/css/";
	rc.qryCSS = DirectoryList(css,"false","query", "subtheme*.css", "name");
	</cfscript>




	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="bootswatch/settings.cfm">
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	

	<cfreturn variables.stResult>
</cffunction>




</cfcomponent>
