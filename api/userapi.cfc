


<cfcomponent extends="base">

<cfscript>
variables.stResults = {result = true, key = 0, Message = ''};


void function Init() output="false" {

	this.UserID 	= ''; 
	this.given	 	= 'Welcome';
	this.family 	= 'Guest';
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
		


struct function get(string userid=session.LOGINAPI.UserID) output="false" hint="Data for one user"	{

	var qryUser = this.wsUser.getOne(arguments.userid);

	var stUser = {
		userid		= qryUser.userid, // we want blank if arguments.userid is not valid
		login		= qryUser.login,
		groups		= qryUser.groups,
		expirationdate = qryUser.expirationdate,
		pstatus		= qryUser.pStatus,
		
		prefix		= qryUser.prefix,
		given 		= qryUser.given,
		additional 	= qryUser.additional,
		family 		= qryUser.family,
		suffix 		= qryUser.suffix,
		
		org			= qryUser.org,
		title	 	= qryUser.title,
		photo	 	= qryUser.photo,
		url		 	= qryUser.url,
		email	 	= qryUser.email,
		officetel	= qryUser.officetel,
		celltel		= qryUser.celltel,
		faxtel		= qryUser.faxtel,
	
		// adr
		street		= qryUser.street,
		locality 	= qryUser.locality,
		region	 	= qryUser.region,
		code 		= qryUser.code,
		country		= qryUser.country,
		// adr
	
		tz			= qryUser.tz,
		note		= qryUser.note,
		
		modifyBy	= qryUser.modifyBy,
		modifyDate	= qryUser.modifyDate
		};


	return stUser;
	}


struct function get_profile(string userid=session.LOGINAPI.UserID) output="false"	{

	return this.wsUser.getProfile(arguments.userid);
	}



query function get_link(string userid=session.LOGINAPI.UserID) output="false"	{

	return this.wsUser.getLink(arguments.userid);
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
	

struct function set_profile(required string userid, required struct rc) output="false"	{

	

	result = this.wsUser.setProfile(arguments.userid, arguments.rc, cgi.remote_addr, session.LOGINAPI.userID);
	
	return result;
	}



struct function set_personal(required string userid, required struct rc) output="false"	{

	

	result = this.wsUser.setPersonal(arguments.userid, arguments.rc, cgi.remote_addr, session.LOGINAPI.userID);
	
	
	return result;
	}



struct function set_link(required string userid, required struct rc) output="false" hint="Stores an expected set of rc values. Fields are: linkcategory_[1-50], href_[1-50] (required), value_[1-50] (required), tooltip_[1-50], sortorder_[1-50]"	{

	

	result = this.wsUser.setLink(arguments.userid, arguments.rc, cgi.remote_addr, session.LOGINAPI.userID);
	
	
	return result;
	}

	
	

struct function set_password(required string userid, required string password) output="false"	{

	result = this.wsUser.commitPassword(arguments.userid, arguments.password, cgi.remote_addr, session.LOGINAPI.userID);
	
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

