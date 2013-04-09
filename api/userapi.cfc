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

	this.UserID 	= ''; 
	this.firstname 	= 'Welcome';
	this.lastname 	= 'Guest';
	this.homepath 	= "";
	this.lstGroup	= "";
	this.qryUser = QueryNew("Email");
	this.login = 'Unknown';
	//this.LoginTarget = 'login.suspend';
	
	// settings
	this.stSettings 		= this.loadini("services/login.ini");
	
	
	this.wsUser = CreateObject("webservice", replacelist(this.stSettings.ws.users, "~", "http://" & cgi.server_name));
	}




query function get_system_admin() output="false"	{

	return this.wsUser.getAll();
	}
		

query function get_recent_login() output="false"	{

	return this.wsUser.getRecentLogin();
	}
		


		


query function get(string userid=session.LOGINAPI.UserID) output="false"	{

	return this.wsUser.getOne(arguments.userid);
	}
	
</cfscript>


<cffunction name="get_all" returnType="query" access="remote">


	<cfreturn this.wsUser.getAll()>
</cffunction>



<cfscript>
struct function set(required string userid, required struct rc) output="false"	{

	

	result = this.wsUser.commit(arguments.userid, arguments.rc, cgi.remote_addr, session.LOGINAPI.userID);
	
	return {result = result};
	}

struct function set_password(required string userid, required string password) output="false"	{

	result = this.wsUser.commitpassword(arguments.userid, arguments.password, cgi.remote_addr, session.LOGINAPI.userID);
	
	return {result = result};
	}


	
struct function set_security(required string userid, required struct rc) output="false"	{

	result = this.wsUser.commitsecurity(arguments.userid, arguments.rc, cgi.remote_addr, session.LOGINAPI.userID);
	
	return {result = result};
	}

	
string function reset_password_by_email(required string email) output="false"	{

	return this.wsUser.resetPasswordByEmail(arguments.email, cgi.remote_addr);
	}


boolean function at_least_one_user() output="false"	{

	return this.wsUser.atLeastOneUser();
	}			
	
</cfscript>
	
</cfcomponent>

