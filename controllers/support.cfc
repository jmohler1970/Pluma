
<cfcomponent extends="base">

<cfscript>
function init(fw) { 
	variables.fw = fw; 
	}


void function before(required struct rc) output="false"	{



	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("settings.settings", "all");
		}


	}

</cfscript>	


<cffunction name="preview" output="false">
	<cfargument name="rc" required="true" type="struct">
	
	<cfparam name="rc.category" default="">
	<cfparam name="rc.link_back" default="">
	<cfparam name="rc.senddata" default="0">
	
	
	<cfif cgi.request_method EQ "Post" AND rc.sendData EQ 1>
		<cfparam name="rc.registrationdata" default="">
		
		<cfmail from="anon@site.com" to="support@webworldinc.com" subject="Pluma Registration">
			#rc.registrationdata#
		</cfmail>
	
		<cfset this.AddMessage("Thank you for registering.")>
		
		<cfset variables.fw.redirect("support.home", "all")>
		
		<cfreturn>
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
	


</cffunction>


	

<cfscript>
void function jour(required struct rc) output="false"	{

	param rc.Kind = "Login";

	rc.qryRecentLogin = application.IOAPI.get_log(rc.Kind);
	}



void function item(required struct rc) output="false"	{
		

	rc.qryDBInfo 	= application.IOAPI.get_db_schema();
	}
	

void function health(required struct rc) output="false"	{
	
	rc.qryKind 			= application.IOAPI.get_kind_count();
	
	rc.stSiteInfo = application.IOAPI.get_site_info();

	}

	
	
</cfscript>
</cfcomponent>	
	