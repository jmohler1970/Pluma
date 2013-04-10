

<cfcomponent output="false" extends="base" > 
<cfscript>
function init(fw) { variables.fw = fw; }


struct function before(required struct rc) output="false"	{



	param rc.plugin = "";
	param rc.userid = "";


	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "Settings")	{
	
		variables.fw.redirect("profile.settings", "all");
		}
	




	return rc;
	}

void function home(required struct rc) output="false"	{


	
	// Post
	if (cgi.request_method == "post")	{
			
		if (arguments.rc.sitepwd != "" AND arguments.rc.sitepwd == arguments.rc.sitepwd_confirm)	{
			arguments.rc.passhash = left(hash(rc.sitepwd), 10);
			
			this.AddMessage("Password has been updated.");
			
			
			}
	
		
		application.USERAPI.set(session.LOGINAPI.userid, arguments.rc);
		
	
		
		 
		
		this.AddMessage("User &quot;#arguments.rc.firstname# #arguments.rc.lastname#&quot; saved");
		}
	
	// All
	rc.qryUser = application.USERAPI.get();
	

	}	
	





</cfscript>
</cfcomponent>

