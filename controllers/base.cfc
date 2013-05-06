

<cfcomponent hint="Provides common functionality">


<cfscript>





variables.CRLF = Chr(13) & Chr(10);
variables.NotifyKind = "Unknown";

/* Action caused hard error. page may not fully render */
void function addFatal(required key, array placeholdervalues = []) output="false" access="package"	{
	
	var message = application.GSAPI.i18n(key, arguments.placeholdervalues);
	
	this.addMessage(message, "Fatal");
			
	}

/* Action could not complete expected operation. Expected values were missing? */
void function addError(required key, array placeholdervalues = []) output="false" access="package"	{
	
	var message = application.GSAPI.i18n(key, arguments.placeholdervalues);
	
	this.addMessage(message, "Error");
			
	}

/* Action completed but maybe data was strange. Use should make sure this is what was really wanted  */
void function addWarning(required key, array placeholdervalues = []) output="false" access="package"	{
	
	var message = application.GSAPI.i18n(key, arguments.placeholdervalues);
	
	this.addMessage(message, "Warning");
	}

/* Action completed without reservation */
void function addSuccess(required key, array placeholdervalues = []) output="false" access="package"	{
	
	var message = application.GSAPI.i18n(key, arguments.placeholdervalues);
	
	this.addMessage(message, "Success");
	}


/* User should be made aware of this */
void function addInfo(required key, array placeholdervalues = []) output="false" access="package"	{
	
	var message = application.GSAPI.i18n(key, arguments.placeholdervalues);
	
	this.addMessage(message);
	}



// 0 -> Info, 1 -> Warning, 2 -> Error, 3 -> Fatal, -1 -> Debug (not normally shown)

void function addMessage(required string message, string priority = "Info") output="false" access="package"    {

	param session.qryMessageQueue = QueryNew("Priority,Message", "integer,varchar");
	
	var NumericPriority = 0;
	
	switch(arguments.priority)	{
		case "Fatal" : NumericPriority = "4"; break;
		case "Error" : NumericPriority = "3"; break;
		case "Warning" : NumericPriority = "2"; break;
		case "Success" : NumericPriority = "1"; break;
		/* Info */
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
		this.AddError("API_ERR_MISSINGPARAM");
		
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
	
		stResult.Key = "PLUMACMS/Notif_NOT_SETUP";
		stResult.result = false;
		return stResult;
		}
	
	
	if (NOT structKeyExists(request.stNotif, "Level"))	{
	
		stResult.key = "PLUMACMS/Notif_NOT_SETUP";
		stResult.result = false;
		return stResult;
		}
	
	if (request.stNotif.level > arguments.Level)	{
	
		stResult.key = "DISABLED";
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
	
		stResult.key = "PLUMACMS/NOTIF_NO_Subject";
		stResult.result = false;
		return stResult;
		}	
		
	
	if (NOT structKeyExists(request.meta, "Email") OR trim(request.meta.Email) == "")	{
	
		stResult.key = "PLUMACMS/MISSING_FROM";
		stResult.result = false;
		return stResult;
		}		
	</cfscript>

	
	<cftry>
	<cfmail to	= "#combinedEmail#" 
		from		= "#request.meta.Email#" 
		subject 	= "#request.stNotif.subject#">  
This message level #arguments.level# was sent by an automatic mailer:
= = = = = = = = = = = = = = = = = = = = = = = = = = = 
#arguments.message#
= = = = = = = = = = = = = = = = = = = = = = = = = = = 
Action was done by: #session.LOGINAPI.getLoginName()# 
	</cfmail>
	<cfcatch>
		<cfset this.AddError("PLUMACMS/UNABLE_TO_SEND_EMAIL", [request.meta.Email])>
	</cfcatch>
	</cftry>


	<cfreturn stResult>
</cffunction>


<cfscript>
void function after(required struct rc) output="false" {

	

	if (session.LOGINAPI.isPasswordBlank())	{
		var target = variables.fw.buildURL("profile.home");
	
		var strMessage = "Don&apos;t forget to <a href='#target#'>change your password</a> from that random generated one you have now...";
		
		this.AddError("PLUMACMS/FAILURE", [strMessage]);
		}
		
	var qryRootDir = DirectoryList(application.GSROOTPATH, false, "query", '_*');
	
	for (var i = 1; i <= qryRootDir.recordcount; i++)	{
		
		this.addInfo("plumacms/installation_directory", [qryRootDir.name[i]]);
		}		
	}
</cfscript>


</cfcomponent>
 
