

<cfcomponent extends="base">

<cfscript>
function init(fw) { variables.fw = fw; }


void function home (required struct rc) output="false"	{

	if (ArrayLen(session.LOGINAPI.arGroup > 0)	{
		variables.fw.redirect(session.LOGINAPI.loginTarget, "all");	
		return;
		}

	
	if (cgi.request_method == "post")	{
	
		if (rc.login == "" or rc.password == "")	{
			this.AddError("FILL_IN_REQ_FIELD");
			return;				
			}
	
	
		application.GSAPI.exec_action("successful-login-start", "", rc);
	
		var stResult = session.LOGINAPI.dologin(rc.login, rc.password);
	
		if (stResult.result)	{
			application.GSAPI.exec_action("successful-login-end", "", rc);
		
			// No special message shown 
	
			variables.fw.redirect(session.LOGINAPI.loginTarget, "all");
						
			return;
			}
		else	{
			this.AddError(stResult.key);


			}	
			
		}
			
	// End post
	
	}


void function impersonate(required struct rc) output="false"	{
	

	try	{
	var stResult = session.LOGINAPI.doImpersonate(rc.userid);
	}
	catch (any e) { 
		this.ERROR("PLUMACMS/FAILURE", [e.message]);
		
		return;
		}
	
	
	if (stResult.result)	{
		this.AddSuccess("PLUMACMS/Impersonate_success", [rc.userid]); 
	
		variables.fw.redirect(session.LOGINAPI.loginTarget, "all");
		return;
		}

	this.AddERROR(stResult.key);

	variables.fw.redirect("login.home", "all");
	}


void function signout(required struct rc) output="false"	{
	session.LOGINAPI.dologout();
	
	application.GSAPI.exec_action("logout", "", rc);
	
	
	variables.fw.redirect("login.home", "all");
	}


void function email(rc) output="false"	{

	if (cgi.request_method == "post")	{
		this.emailresults(rc);
		}
	}

</cfscript>



<cffunction name="emailresults" hint="this will work with get. This enables testing">
	<cfargument name="rc" required="true" type="struct">
	
		
	<cfscript>
	param rc.email = "";
	
	
	var results = "";
	var newPassword = "";
	
	
	if (NOT rc.Email CONTAINS "@")	{
	
		this.addWarning("WARN_EMAILINVALID");
		
		variables.fw.redirect("login.email", "all");	
		return;
		}
	
	var qryUser = session.LOGINAPI.get_by_email(rc.email); 
	

	
	
	
	if (qryUser.recordcount == 0)	{
			
		
		this.addError("EMAIL_ERROR");
		
		variables.fw.redirect("login.email", "all");
		return;
		}
	
	
	if (qryUser.ExpirationDate > now())	{
		this.addError("PLUMACMS/EXPIRED");
		

		variables.fw.redirect("login.home", "all");
		return;
		}
	
	
	
	// Really going to reset
	NewPassword = application.USERAPI.reset_password_by_Email(rc.email);
	</cfscript>	
		
	
	<cfmail subject="Password Reset for #qryUser.given# #qryUser.family#" 
			from = "#application.stAdminSetting.Email.From#"
			to	 = "#rc.Email#">
Hello #qryUser.given# #qryUser.family#, 
			
A password reset was requested for your user account on the #application.stAdminSetting.Email.sitename# system.

You can now login with the following credentials:
			
Login: #qryUser.Login# 
Password: #newpassword#
				
If you still have trouble logging into our site, then contact us at: #application.stAdminSetting.Email.from#

If you did not request this password reset, let us known.

Best Regards,
Pluma CMS Customer Support
</cfmail>
	
	
	<cfset this.addInfo("ER_NEW_PWD_SENT")>

	
		
	<cfset variables.fw.redirect("login.home", "all")>
</cffunction>





</cfcomponent>
