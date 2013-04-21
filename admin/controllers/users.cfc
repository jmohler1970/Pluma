

<cfcomponent output="false" extends="base" > 
<cfscript>
function init(fw) { variables.fw = fw; }


struct function before(required struct rc) output="false"	{



	

	param rc.plugin = "";
	param rc.userid = "";


	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "Settings")	{
	
		variables.fw.redirect("users.settings", "all");
		}
	




	return rc;
	}


void function home(required struct rc) output="false"	{
	

	rc.qryUser 	= application.USERAPI.get_all();
	}


	
void function edit(required struct rc) output="false"	{

	
	
	
	// Post
	if (cgi.request_method == "post")	{
		
		application.USERAPI.set(rc.UserID, rc);
			 
		
		this.AddMessage("User &quot;#rc.firstname# #rc.lastname#&quot; saved");
		}
	
	// All
	rc.qryUser =  application.USERAPI.get(rc.UserID);
	
	rc.qryNode = application.IOAPI.get_all_by_userID("Any", rc.UserID, "CreateDate DESC");
	
	if (rc.qryUser.UserID == "" AND isnumeric(rc.UserID))	{
	
		this.AddMessage("User could not be loaded. There are no matching records for this userid","Error");
	
		variables.fw.redirect("users.home", "all");
		}
	
	}	
	




// Make it handle a list
void function delete(required struct rc) output="false"	{

	param rc.userid = "";
	
	if (not isnumeric(rc.userid))	{
	
		this.AddMessage("This is an invalid UserID.", "Error");
		variables.fw.redirect("users.home", "all");
		}
	
		
	application.LOGINAPI.delete(rc.UserID);
	
	
	// Results
	this.AddMessage("User deleted.");

	variables.fw.redirect("users.home", "all");
	}
	

void function jour(required struct rc) output="false"	{

	
	rc.qryRecentLogin = application.USERAPI.get_recent_login();
	}



void function renew(required struct rc) output="false"	{
	
	var stResult = application.USERAPI.renew(rc.userid);

	this.AddMessage(stResult.message);

	variables.fw.redirect("users.edit", "all");
	}



</cfscript>



</cfcomponent>

