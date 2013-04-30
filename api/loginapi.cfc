

<cfcomponent extends="base">



<cfscript>
variables.stResults = {result = true, key = 0, Message = ''};


void function Init() output="false" {

	this.UserID 	= -1; 
	this.firstname 	= 'Welcome';
	this.lastname 	= 'Guest';
	this.homepath 	= "";
	this.lstGroup	= "";
	this.qryUser = QueryNew("Email");
	this.login = 'Unknown';
	this.LoginTarget = 'pages.home';
	
	
	this.wsNode = CreateObject(application.stSettings.storage.node);
	this.wsUser = CreateObject(application.stSettings.storage.users);
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
		stResult.key = "FILL_IN_REQ_FIELD";
	
		return stresult;
		}
	
	var passhash = arguments.password == "" ? "" : left(hash(arguments.password), 10);
	
	
	
	this.qryUser = this.wsUser.getUserByLogin(arguments.login, passhash);
	
		
	if (this.qryUser.recordcount == 0)	{
		
	
		this.wsNode.addlog("Login", "Invalid Password", cgi.remote_addr, arguments.login);
	
		variables.stResult.result = false;
		variables.stResult.key = "Login_failed";
	
		return variables.stResult;
		}
	
	
	
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



	return variables.stResults;
	</cfscript>

</cffunction>

			
<cfscript>

boolean function checkSecurity(required string subsection, required string section, required string item) output="false" {
	
	
	// impersonate always runs
	if (arguments.section == "Login" AND arguments.item == "impersonate")	{ return true; }

	if (NOT isDefined("application.stSettings.Security.#arguments.section#"))	{ return true; }
		
	var arGroupNeeded = ListToArray(evaluate("application.stSettings.Security.#arguments.section#"));	
		
	if (arGroupNeeded[1] == "something" AND this.lstGroup != "")	{ return true; }
		
	
	for (var i = 1; i <= ArrayLen(arGroupNeeded); i++)	{	
		if (ListFindNoCase(this.lstGroup, arGroupNeeded[i]) != 0)	{ return true; }
		}
	
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

