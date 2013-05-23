
<cfcomponent extends="base">

<cfscript>
function init(fw) { 
	variables.fw = fw; 
	}


void function before(required struct rc) output="false"	{



	param rc.plugin = "";
	param rc.plx = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("support.settings", "all");
		}


	}

</cfscript>	


	

<cfscript>
void function jour(required struct rc) output="false"	{

	param rc.clear = 0;
	param rc.Kind = "Login";

	if (rc.clear == 1)	{
		application.IOAPI.clear_log(rc.Kind);

		application.GSAPI.exec_action("logfile-delete", "", rc);
		
		this.addWarning("MSG_HAS_BEEN_CLR", [rc.Kind]);		
		}

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
	