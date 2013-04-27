
<cfcomponent>

<cfscript>
thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");



function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
	'Anonymous Data',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'Shows registration form on support page',
	'',
	'',
	'icon-heart');


	application.GSAPI.add_action("support_sidebar", "createSideMenu", ["?plugin=anonymous_data", "Traffic Tracker"]);
	}	
</cfscript>


<cffunction name="settings" returnType="struct">
	<cfargument name="rc" required="true" type="struct">	



<cfswitch expression="#rc.plx#">
<cfcase value="preview">
	
	

	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="anonymous_data/preview.cfm">
	</cfsavecontent>
</cfcase>

<cfdefaultcase>

		
	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="anonymous_data/home.cfm">
	
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	

</cffunction>
	

</cfcomponent>
