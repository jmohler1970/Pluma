<cfcomponent>

<cfscript>
thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");



function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
	'PlumaCMS Support',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'Brings in Support tools and additional language strings.',
	'',
	'',
	'icon-heart');
	
	application.GSAPI.add_action("theme_sidebar", "createSideMenu", ["?plugin=plumacms", "Registration"]);
	application.GSAPI.add_action("support_sidebar", "createSideMenu", ["?plugin=plumacms&plx=contact", "Support Options"]);
	
	}	
</cfscript>


<cffunction name="settings" returnType="struct">
	<cfargument name="rc" required="true" type="struct">	



<cfswitch expression="#rc.plx#">
<cfcase value="contact">
	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="plumacms/contact.cfi">
	</cfsavecontent>
</cfcase>


<cfcase value="preview">
	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="plumacms/preview.cfi">
	</cfsavecontent>
</cfcase>

<cfdefaultcase>

		
	<cfsavecontent variable="variables.stResult.Content">
		
		
		<cfinclude template="plumacms/home.cfi">
	
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	

	<cfreturn variables.stResult>
</cffunction>
	

</cfcomponent>