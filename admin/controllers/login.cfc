<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->

<cfcomponent extends="base">

<cfscript>
function init(fw) { variables.fw = fw; }


void function home (required struct rc) output="false"	{

	if (session.LOGINAPI.lstGroup != "")	{
		variables.fw.redirect("pages.home", "all");	
		return;
		}

	
	if (cgi.request_method == "post")	{
	
		var stResult = session.LOGINAPI.dologin(rc.login, rc.password);
	
		if (stResult.result)	{
			this.AddMessage("You successfully logged in"); 
	
			variables.fw.redirect("pages.home", "all");
			return;
			}
		else	{
			this.AddMessage(stResult.message);
			}	
			
		}	
	// End post
	
	}


void function impersonate(required struct rc) output="false"	{
	
	var stResult = session.LOGINAPI.doImpersonate(rc.userid);
	
	if (stResult.result)	{
		this.AddMessage("Impersonate successful"); 
	
		variables.fw.redirect("pages.home", "all");
		return;
		}

	this.AddMessage(stResult.message, "Error");

	variables.fw.redirect("login.home", "all");
	}


void function signout(required struct rc) output="false"	{
	session.LOGINAPI.dologout();
	
	this.AddMessage("Come again soon");
	
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
		this.AddMessage("Email address must contain an @", "Error");
		
		variables.fw.redirect("login.email", "all");	
		return;
		}
	
	var qryUser = session.LOGINAPI.get_by_email(rc.email); 
	

	
	
	
	if (qryUser.recordcount == 0)	{
		this.AddMessage("Your info could not be found with this email. Try a different email", "Error");
		
		variables.fw.redirect("login.email", "all");
		return;
		}
	
	/*
	if (qryUser.uStatus == 'suspended')	{
		this.AddMessage("Your account has been administratively suspended. You are not allowed to login", "Warning");
		
		variables.fw.redirect("login.home", "all");
		return;
		}

		
	if (qryUser.uStatus == 'pending')	{
		this.AddMessage("Your account is still pending approval. You are not allowed to login", "Warning");
		
		variables.fw.redirect("login.home", "all");
		return;
		}
	*/
	
	if (qryUser.ExpirationDate > now())	{
		this.AddMessage("Your account has expired. You are not allowed to login", "Warning");
		
		variables.fw.redirect("login.home", "all");
		return;
		}
	
	
	
	if (qryUser.Login == "")	{
		this.AddMessage("Your account was setup as read only. Please contract the site administrator to upgrade your account", "Warning");
		
		variables.fw.redirect("login.home", "all");
		return;
		}
	
	// Really going to reset
	NewPassword = application.USERAPI.reset_password_by_Email(rc.email);
	
	
	//this.AddMessage(SerializeJSON(qryUser), "Debug");
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
	
		<cfset this.AddMessage(newPassword, "Debug")>
		
	<cfset this.AddMessage("Your login information info has been sent to you. Check your email in a few minutes and try logging in again")>
		
	
		
	<cfset variables.fw.redirect("login.home", "all")>

</cffunction>





</cfcomponent>
