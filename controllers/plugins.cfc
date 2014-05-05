

<cfcomponent extends="base">


<cfscript>
function init(fw) { 
	variables.fw = fw; 
	variables.Kind = "Unknown";
	
		
	}
	
struct function before(required struct rc) output="false" {

	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "home")	{
	
		variables.fw.redirect("plugins.home", "all");
		}
	
		
	rc.qryLinkCategory 	= application.IOAPI.get_All("Page_LinkCategory", "title");
	

	return rc;

	}
	
	
void function starthome(required struct rc) output="false" {
	

	param rc.filter = "";
	param rc.kind = "";
	param rc.group = "";
	param rc.pstatus = "";
	param rc.commentmode = "";
	param rc.recent = "";
	param rc.withaction = "";
	
	application.GSAPI.exec_action("plugins-hook");
	}

</cfscript>	
	

<cffunction name="home" output="false">
	<cfargument name="rc" type="struct" required="true">



	
	
	<cfif cgi.request_method EQ "post">

		<cfset application.IOAPI.set_pref("Plugin", rc.plugin_status)>
	
		
		<cfset application.IOAPI.load_plugins()>
	
		<cfset this.AddSuccess("plumacms/plugins_saved")>
	</cfif>
	
	
</cffunction> 

	

</cfcomponent>
	
	

