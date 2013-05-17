


<cfcomponent extends="base">

<cfscript>
variables.stResults = {result = true, key = 0, Message = ''};


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
	this.stSettings 		= this.load_ini("api/config.ini");
	
	
	this.wsUser = CreateObject(application.stSettings.storage.users);
	}




query function get_system_admin() output="false"	{

	return this.wsUser.getAll();
	}
		


query function get(string userid=session.LOGINAPI.UserID) output="false"	{

	return this.wsUser.getOne(arguments.userid);
	}
	
</cfscript>


<cffunction name="get_all" returnType="query" >


	<cfreturn this.wsUser.getAll()>
</cffunction>



<cfscript>
struct function set(required string userid, required struct rc) output="false"	{

	

	result = this.wsUser.commit(arguments.userid, arguments.rc, cgi.remote_addr, session.LOGINAPI.userID);
	
	return result;
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


boolean function renew(required string userid, string expirationDate) output="false"	{

	return this.wsUser.renew(arguments.userID, arguments.expirationDate, cgi.remote_addr, session.LOGINAPI.userID);
	}


boolean function delete(required string userid) output="false"	{

	return this.wsUser.delete(arguments.userID, cgi.remote_addr, session.LOGINAPI.userID);
	}
	
</cfscript>
	
</cfcomponent>

