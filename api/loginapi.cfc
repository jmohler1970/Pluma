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
variables.stResults = {result = true, resultCode = 0, Message = ''};


void function Init() output="false" {

	this.UserID 	= -1; 
	this.firstname 	= 'Welcome';
	this.lastname 	= 'Guest';
	this.homepath 	= "";
	this.lstGroup	= "";
	this.qryUser = QueryNew("Email");
	this.login = 'Unknown';
	this.LoginTarget = 'pages.home';
	
	// settings
	this.stSettings 		= this.loadini("services/login.ini");
	
	
	this.wsUser = CreateObject("webservice", replacelist(this.stSettings.ws.users, "~", "http://" & cgi.server_name));
	}


string function isPasswordBlank() output="false" {

	var qryUser = this.wsUser.getOne(this.UserID);

	
	return (qryUser.login != "" AND qryUser.passhash) == "" ? 1 : 0;
	}



string function getEmail() output="false" {

	return this.wsUser.getOne(this.UserID).email;
	}


string function getLoginName() output="false" {

	return trim(this.firstname & " " & this.lastname);
	}


string function dologout() output="false" {

	/* The session could have already been timed out */
	if (this.UserID != "")
		this.wsUser.addlog(this.UserID, "Logout", cgi.remote_addr);
	
	this.Init();
	}


query function get_by_email(required string email) output="false" {

	return this.wsUser.getByEmail(arguments.email);
	}



</cfscript>


<cffunction name="doImpersonate" output="false" returnType="struct">
	<cfargument name="userid" required="true" type="string">


	<cfscript>
	if (not isnumeric(arguments.userid))	{
		stResult.result = false;
		stResult.message = "Invalid UserID";
	
		return false;
		}
	
	
	if (not this.adhocSecurity('System'))	{
	
		stResult.result = false;
		stResult.message = "Not Authorized";
	
		return false;
		}
	
			
	
	this.qryUser = this.wsUser.getOne(arguments.userid);
	
	return this.doSetup();
	</cfscript>

</cffunction>



<cffunction name="dologin" output="false" returnType="struct">
	<cfargument name="login" required="true" type="string">
	<cfargument name="password" required="true" type="string">
	
	<cfscript>
	
	if (arguments.Login == "")	{
	
		stResult.result = false;
		stResult.message = "Blank username. Try again";
	
		return stresult;
		}
	
	var passhash = arguments.password == "" ? "" : left(hash(arguments.password), 10);
	
	
	
	this.qryUser = this.wsUser.getUserByLogin(arguments.login, passhash);
	
	return this.doSetup();
	</cfscript>
</cffunction>	
	
		
<cffunction name="doSetup" output="no" returnType="struct">

	<!--- Return data --->
	<!---
	Success
	Fail:No account exists
	Fail:No password - impersonate can do this. Do login intercepts.
	Fail:Bad password
	Fail:Account status is not confirmed
	Fail:No permissions have been granted
	Fail:Expired
	Fail:Deleted
	--->



	<cfscript>
	
	
	
	if (this.qryUser.recordcount == 0)	{
		this.wsUser.addlog(this.qryUser.UserID, "Failure", cgi.remote_addr);
	
		variables.stResult.result = false;
		variables.stResult.message = "Login failed: Bad username or password. Try again";
	
		return variables.stResult;
		}
		

	/*	
	if (this.qryUser.uStatus != "Confirmed")	{
	
		variables.stResult.result = false;
		variables.stResult.message = "Login failed: User account status is currently #this.qryUser.uStatus#.";
	
		return variables.stResult;
		}	
	*/
	
	
	// Group concerns
	this.lstGroup 	= this.qryUser.Groups;
			
	
	if (this.lstGroup == "")	{
	
		variables.stResult.result = false;
		variables.stResult.message = "Login failed: No permissions have been granted.";
	
		return variables.stResult;
		}
	
	
	if (isDate(this.qryUser.ExpirationDate))	{
		if (this.qryUser.ExpirationDate < now())	{
	
			variables.stResult.result = false;
			variables.stResult.message = "Login failed: Account has expired.";
	
			return variables.stResult;
			}			
		}
	
		
	if (this.qryUser.Deleted)	{
	
		variables.stResult.result = false;
		variables.stResult.message = "Login failed: Account has deleted."; // we never want to see you again
	
		return variables.stResult;
		}

	
	this.UserID 	= this.qryUser.UserID;
	this.firstname 	= this.qryUser.firstName;
	this.lastname 	= this.qryUser.lastName;
	this.homepath	= this.qryUser.HomePath;
	this.login		= this.qryUser.Login;
		

	
	
		
	// Now do profile
	this.stProfile = this.wsUser.getProfile(this.UserID);
	this.stProfile.createDate = this.qryUser.createDate;
	
	
	this.wsUser.setLastLogin(this.UserID, cgi.remote_addr);
	
	this.wsUser.addlog(this.UserID, "Success", cgi.remote_addr);


	return variables.stResults;
	</cfscript>

</cffunction>

			
<cfscript>

boolean function checkSecurity(required string subsection, required string section, required string item) output="false" {
	
	
	

	if (NOT isDefined("application.st#arguments.subSection#Setting.Security.#arguments.section#"))	{ return true; }
		
	var arGroupNeeded = ListToArray(evaluate("application.st#arguments.subSection#Setting.Security.#arguments.section#"));	
		
	if (arGroupNeeded[1] == "something" AND this.lstGroup != "")	{ return true; }
		
	
	for (var i = 1; i <= ArrayLen(arGroupNeeded); i++)	{	
		if (ListFindNoCase(this.lstGroup, arGroupNeeded[i]) != 0)	{ return true; }
		}
	
	//this.debugmessage = "You do not have permission to see this. You have: #this.lstGroup)# need: #GroupNeeded#";

	
	return false;
	}

	
	
boolean function isReplyable(required any ormNode) output="false"	{

	switch (arguments.ormNode.getCommentMode())	{
		case "members + public" :
			return true;
			break;	
		
		case "members" :
			return isnumeric(this.userid) ? true : false;	
		
			break;
			
		case "my group" :
			return StructKeyExists(this.stGroup, arguments.ormNode.getGroup()) ? true : false;			
		
			break;	
		
		case "myself" :
			return arguments.ormNode.getOwnerID() == this.userID ? true : false;
		
			break;
		}
		
	return false;
	}	

	
	

boolean function adhocSecurity(required string role) output="false" {
	
	if (ListFindNoCase(this.lstGroup, "System"))
		return true;
		
	return ListFindNoCase(this.lstGroup, arguments.role);
	}	
</cfscript>	



	
</cfcomponent>

