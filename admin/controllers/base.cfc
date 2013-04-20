

<cfcomponent hint="Provides common functionality">


<cfscript>

void function after(required struct rc) output="false" {

	

	if (session.LOGINAPI.isPasswordBlank())	{
		var target = variables.fw.buildURL("profile.home");
	
		var strMessage = "Don&apos;t forget to <a href='#target#'>change your password</a> from that random generated one you have now...";
		
		this.AddMessage(strMessage, "Error");
		}
		
	var qryRootDir = DirectoryList(application.GSROOTPATH, false, "query", '_*');
	
	for (var i = 1; i <= qryRootDir.recordcount; i++)	{
		
		this.AddMessage("Installation directory <tt>#qryRootDir.name[i]#</tt> was found. This directory should be removed after the system has been successfully installed.", "Error");
				
		}		
		

	}




variables.CRLF = Chr(13) & Chr(10);
variables.NotifyKind = "Unknown";



// 0 -> Info, 1 -> Warning, 2 -> Error, 3 -> Fatal, -1 -> Debug (not normally shown)

void function addMessage(required string message, string priority = "Info") output="false" access="package"    {

	param session.qryMessageQueue = QueryNew("Priority,Message", "integer,varchar");
	
	var NumericPriority = 0;
	
	switch(arguments.priority)	{
		case "Fatal" : NumericPriority = "3"; break;
		case "Error" : NumericPriority = "2"; break;
		case "Warning" : NumericPriority = "1"; break;
		case "Debug" : NumericPriority = "-1"; break;
		}


	QueryAddRow(session.qryMessageQueue);
	QuerySetCell(session.qryMessageQueue, "Priority", NumericPriority);
	QuerySetCell(session.qryMessageQueue, "Message", trim(arguments.message));
	
		
	this.notifyAdmin(arguments.message, numericPriority);
	}



void function settings(required struct rc) output="false" {
	
	param rc.Plugin 	= "";
	param rc.Plx 		= "settings";
	param rc.content 	= "This plugin did not load data";
	param rc.message 	= "";
	param rc.NodeID 	= ""; //by default create a new item
	param rc.UserID 	= session.LOGINAPI.UserID;
	
	if (rc.Plugin == "")	{
		this.AddMessage("You must chose a plugin in order to update its settings.", "Error");
		
		variables.fw.redirect('.home', "all");
		return;	
		}
	
	var stPlugin = application.GSAPI.run_plugin(rc.Plugin, "settings", rc);

	StructAppend(rc, stPlugin);
	
	if (rc.message != "")	{
		this.AddMessage(rc.message, rc.priority);
		}
	
		// run any custom actions
	if (cgi.request_method == "POST")	{
				
		//this.AddMessage(rc.message);
		}



	}
</cfscript>


<cffunction name="notifyAdmin" returnType="struct" access="package">
	<cfargument name="Message" required="true" type="string">
	<cfargument name="Level" required="false" type="numeric" default="3">

	<cfscript>
	var stResult = {result = true, resultCode = 0, message = ""};
	
	
	if (NOT structKeyExists(request, "stNotif"))	{
	
		stResult.message = "Notification has not been setup at all";
		stResult.result = false;
		return stResult;
		}
	
	
	if (NOT structKeyExists(request.stNotif, "Level"))	{
	
		stResult.message = "Notification level has not been set";
		stResult.result = false;
		return stResult;
		}
	
	if (request.stNotif.level > arguments.Level)	{
	
		stResult.message = "This message not is severe enough to send notification";
		stResult.result = false;
		return stResult;
		}
	
	
	var combinedEmail = "";
	if (structKeyExists(request.stNotif, "email"))
		combinedEmail &= request.stNotif.email;
		
	if (structKeyExists(request.stNotif, "SysAdminEmail"))
		combinedEmail &= request.stNotif.SysAdminEmail;
	
	if (combinedEmail == "")	{
		
		stResult.message = "There are no target email addresses";
		stResult.result = false;
		return stResult;
		}
		
	
	if (NOT structKeyExists(request.stNotif, "Subject"))	{
	
		stResult.message = "Subject has not been set";
		stResult.result = false;
		return stResult;
		}	
		
	
	if (NOT structKeyExists(request.stMeta, "Email"))	{
	
		stResult.message = "From needs to be set on the basic setting page";
		stResult.result = false;
		return stResult;
		}		
		
	</cfscript>


	<cfmail to	= "#combinedEmail#" 
		from		= "#request.stMeta.Email#" 
		subject 	= "#request.stNotif.subject#">  
This message level #arguments.level# was sent by an automatic mailer:
= = = = = = = = = = = = = = = = = = = = = = = = = = = 
#arguments.message#
= = = = = = = = = = = = = = = = = = = = = = = = = = = 
Action was done by: #session.LOGINAPI.getLoginName()# 
	</cfmail>

	<cfreturn stResult>
</cffunction>





</cfcomponent>
 
