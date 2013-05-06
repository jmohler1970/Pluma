

<cfcomponent extends="base">

<cfscript>
function init(fw) { variables.fw = fw; }


void function home (required struct rc) output="false"	{

	if (session.LOGINAPI.lstGroup != "")	{
		variables.fw.redirect(session.LOGINAPI.loginTarget, "all");	
		return;
		}

	
	if (cgi.request_method == "post")	{
	
		var stResult = session.LOGINAPI.dologin(rc.login, rc.password);
	
		if (stResult.result)	{
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

	this.AddERROR("PLUMACMS/FAILURE", [stResult.message]);

	variables.fw.redirect("login.home", "all");
	}


void function signout(required struct rc) output="false"	{
	session.LOGINAPI.dologout();
	
	
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
		
	
	<cfmail subject="Password Reset for #qryUser.FirstName# #qryUser.Lastname#" 
			from = "#application.stAdminSetting.Email.From#"
			to	 = "#rc.Email#">
Hello #qryUser.FirstName# #qryUser.Lastname#, 
			
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
