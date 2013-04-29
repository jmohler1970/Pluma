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
	
	application.GSAPI.add_action("plugins_sidebar", "createSideMenu", ["?plugin=plumacms", "Registration"]);
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

	<cfparam name="rc.category" default="">
	<cfparam name="rc.link_back" default="">
	<cfparam name="rc.senddata" default="0">
	
	
	<cfif cgi.request_method EQ "Post" AND rc.sendData EQ 1>
		<cfparam name="rc.registrationdata" default="">
		
		<cfmail from="anon@site.com" to="james@webworldinc.com" subject="Pluma Registration">
			#rc.registrationdata#
		</cfmail>
	
		<cfsavecontent variable="variables.stResult.Content">
			<h3>Success</h3>
			
			<p>Thank you for registering!</p>
		</cfsavecontent>
	
		<cfreturn variables.stResult>
	</cfif>	
	
	
	
	<cfset var stSiteInfo = application.IOAPI.get_site_info()>
	
<cfsavecontent variable="rc.registrationdata">
<cfoutput>
<p>
<b>Submitted</b> #now()#<br />
<b>Version:</b> #application.GSAPI.get_site_credits()#<br />
<b>Language:</b><br /> 
<b>Timezone:</b><br /> 
<b>ColdFusion:</b> #stSiteInfo.cfversion#<br />
<b>Data Nodes:</b><br />
<b>Domain name:</b>#cgi.server_name#<br />

<b>Category:</b>#rc.category#<br />
<b>Link Back:</b>#rc.link_back#
 
</p>
</cfoutput>	
</cfsavecontent>


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
	
	
<cffunction name="preview" output="false">
	<cfargument name="rc" required="true" type="struct">
	

	


</cffunction>	
	

</cfcomponent>