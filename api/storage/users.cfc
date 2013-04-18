


<cfcomponent hint="Gets Users">


<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "">

	<cftry>
		<cfset this.get()>
		
		<cfreturn "">

		<cfcatch />
	</cftry>
	
	<cfreturn "Unable to query preferences DB">
</cffunction>



<cfscript>
	variables.stResults = {result = true, resultCode = 0, Message = ''};

	variables.QueryService = new query();
	variables.QueryService.setName("qryResult");
	
	variables.lstCol = "UserID,login,passhash
      	,firstname,middlename,lastname,postfix
		,homepath,lastLogin
		,ExpirationDate
		,email,comments,Groups,Active
      	,Deleted,DeleteDate,ModifyDate,ModifyBy,CreateDate,CreateBy"; // rather than using select *
</cfscript>




<cffunction name="getAll" returnType="query" access="remote">
	
	
	<cfquery name="local.qryUsers">
		SELECT	TOP 500 #variables.lstCol#
		FROM	dbo.vwUser WITH (NOLOCK)
		WHERE	Deleted = 0
		ORDER BY firstname, lastname
	</cfquery>
	
	<cfreturn local.qryUsers>
</cffunction> 


<cffunction name="getByEmail" output="no" access="remote" returnType="query">	{
	<cfargument name="email" required="true" type="string">
	
	<cfquery name="local.qryUsers">
		SELECT	TOP 1 #variables.lstCol#
		FROM	dbo.vwUser WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.email#">
		AND		email <> ''
	</cfquery>
	
	<cfreturn local.qryUsers>
</cffunction>	



<cfscript>
query function getByGroup(required string group) output="no" access="remote"	{


	return this.getMatchlist("", arguments.group, "", 0, 0);
	}
</cfscript>
	




<cffunction name="passwordReset" output="no" access="remote" returnType="void">
	<cfargument name="userid" required="true" type="numeric">		
	<cfargument name="passhash" required="true" type="string">		
	<cfargument name="byUserID" required="true" type="string">
	<cfargument name="remote_addr" required="true" type="string">
	
	

	<cfquery>
	UPDATE	dbo.Users
	SET		PassHash = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.passhash#">,
		Modified = dbo.udf_4jInfo('Password was reset',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_integer" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>
	
	<cfreturn true>

</cffunction>	


<cffunction name="resetviaEmail" output="no" access="remote" returnType="string">
	<cfargument name="email" required="true" type="string">
	<cfargument name="remote_addr" required="true" type="string">
	
	<cfscript>
		var objPassword = CreateObject("component", "password");
		var newPassword = objPassword.generatePassword();	
	</cfscript>

	
	<cfquery>
	UPDATE	dbo.Users
	SET		PassHash = left(hash(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#newpassword#">), 10),
		Modified = dbo.udf_4jInfo('Password was reset via Email',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">, 
			DEFAULT)
			
	WHERE	email = <cfqueryparam cfsqltype="CF_SQL_integer" value="#arguments.email#">
	AND		Deleted = 0
	</cfquery>
	
	
	<cfreturn newpassword>
</cffunction>		
	


<cffunction name="getUserByLogin" output="no" access="remote" returnType="query">
	<cfargument name="login" required="true" type="string">		
	<cfargument name="passhash" required="true" type="string">
	
	

	<cfquery name="qryUser">
		SELECT  #variables.lstCol# 
		FROM 	dbo.vwUser 
		WHERE 	Deleted 	= 0 
		AND 	login 		= <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.login#">
		
		<cfif passhash EQ "">
			AND		passhash IS NULL
		<cfelse>
			AND 	passhash = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.passhash#">
		</cfif>
		
	</cfquery>
		
	<cfreturn qryUser>
</cffunction>	



<cfscript>

/*** Individual functions ***/
query function getOne(required string userid) output="no" access="remote"	{

	variables.QueryService.addParam(value = arguments.userID, cfsqltype="cf_sql_varchar");
		
	var result = variables.QueryService.execute(sql="SELECT #variables.lstCol# FROM dbo.vwUser WHERE Deleted = 0 AND userid = ?");
	
	if (result.getResult().recordcount == 1)
		return result.getResult();
	
	// Create blank row
	var qryBlank = QueryNew(variables.lstCol);
	QueryAddRow(qryBlank);
	
	return qryBlank;
	}


query function getUserByUserHomeAsQuery(required string userhome) output="no" access="remote"	{


	variables.QueryService.addParam(value = arguments.userhome, cfsqltype="cf_sql_varchar");
	var result = variables.QueryService.execute(sql="SELECT  #variables.lstCol#  FROM dbo.vwUser WHERE Deleted = 0 AND homepath = ?");
	
	return result.getResult();
	}

</cfscript>


<cffunction name="setLastLogin" output="no" access="remote" returnType="boolean">
	<cfargument name="userid" required="true" type="numeric">		
	<cfargument name="remote_addr" required="true" type="string">
	
	

	<cfquery>
	UPDATE	dbo.Users
	SET		LastLogin = getDate(),
		Modified = dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_integer" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>
		
	<cfreturn true>
</cffunction>	




<!--- Login tracking --->

<cffunction returnType="void" name="addLog" output="no" access="remote" >
	<cfargument  name="UserID" required="true">
	<cfargument  name="LoginStatus" required="true">
	<cfargument  name="Remote_addr" required="true">

	<cfquery>
		INSERT
		INTO	dbo.LoginLog (UserID, LoginStatus, remote_addr)
		VALUES (
			<cfif isnumeric(arguments.userid)>
				<cfqueryparam cfsqltype="CF_SQL_integer" value="#arguments.userid#">,
			<cfelse>	
				NULL,
			</cfif>
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.loginstatus#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">	
			)
	</cfquery>
</cffunction>


<cffunction  name="getRecentLogin" output="no" access="remote" returnType="query">


	<cfquery name="local.qryRecentLogin">
		SELECT   TOP 100 LoginLog.UserID, LoginStatus, LoginLog.CreateDate, Firstname, Lastname, email
		FROM     dbo.LoginLog LEFT OUTER JOIN dbo.vwUser
			ON dbo.LoginLog.userID = dbo.vwUser.UserID
    	WHERE    LoginLog.CreateDate > DateAdd(d, -1, getDate())
		ORDER BY CreateDate DESC
	</cfquery>
	
	<cfreturn local.qryRecentLogin>
</cffunction>





<!--- read write functions here --->



<cffunction name="commit" returnType="boolean" access="remote" hint="Does both insert and update">
	<cfargument name="UserID" required="true" type="string" hint="blank is valid and will create a new user">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">
	


	<cfscript>
	var homepath = "";
	
	
	param rc.firstName		= "";
	param rc.middleName		= "";
	param rc.lastName		= "";
	
	param rc.postfix 		= "";
	param rc.comments 		= "";
	
	// security
	param rc.group 		= "";

	param rc.expirationdate = "";
	param rc.passhash 	= "skip";
	param rc.submit 	= "";
	</cfscript>		
			
	

	
<cfsavecontent variable="local.personname">
<cfoutput>
<PersonName xmlns="http://ns.hr-xml.org/2007-04-15">
	<GivenName>#trim(rc.firstname)#</GivenName>
	<cfif rc.middleName NEQ "">
		<MiddleName>#rc.middleName#</MiddleName>
	</cfif>
	<FamilyName>#trim(rc.lastname)#</FamilyName>
	<cfif rc.postfix NEQ "">
		<Affix type="qualification">#trim(rc.postfix)#</Affix>
	</cfif>
</PersonName>
</cfoutput>	
</cfsavecontent>


	<cfif NOT isnumeric(arguments.userID)>
		<cfquery name="qryAdd">
		INSERT 
		INTO	dbo.Users (PersonName, Email, Comments, Modified, Created)
		OUTPUT inserted.userid
		VALUES (
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#local.personname#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.email#">,
						
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.comments#" null="#IIF(rc.Comments EQ "", 1, 0)#">,
			dbo.udf_4jSuccess('Basic data was committed',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
			 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byuserID#">),
			
			dbo.udf_4jInfo(DEFAULT,DEFAULT,
			 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byuserID#">)
			)
		</cfquery>
	
	
		<cfset arguments.UserID = qryAdd.UserID>
	</cfif>
	
		
	<cfquery>
		UPDATE	dbo.Users
		SET		PersonName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#local.personname#">,
			Email 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.email#">,
			Comments 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.comments#" null="#IIF(rc.Comments EQ "", 1, 0)#">,
			
			login		 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.rc.login#">,
			expirationDate 	= <cfqueryparam CFSQLType="CF_SQL_DATE" value="#rc.expirationDate#">,
		
			
			<cfif rc.passhash EQ "">
				PassHash = NULL,
			<cfelseif NOT rc.passhash CONTAINS "skip">
				PassHash = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.passhash#">,
			</cfif>
		
		
			<cfif rc.submit CONTAINS "reactivate">
				DeleteDate = NULL,
			</cfif>
		
			<cfif rc.group NEQ "">
				xmlGroup 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML({Group = rc.group})#">,
			</cfif>
			
			
			
			
			Modified = dbo.udf_4jSuccess('Basic data was committed',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
			 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byuserID#">)
				 	
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_integer" value="#arguments.userid#">
		AND		Deleted = 0
	</cfquery>
	


	<cfreturn true>
</cffunction> 




<cffunction name="encodeXML" output="no" access="remote" returnType="string">
	<cfargument name="rc" required="true" type="struct">



	<cfscript>
	var xmlData = "";
	
	
	for (var MyFormField in rc)	{
			
		if (ListFindNoCase("action,submit,fieldnames,href", MyFormField) == 0)	{
			if (evaluate("rc.#MyFormField#") != "")	{
				
				var href = "";
				
				if (isDefined("rc.#myFormField#_href"))	{							
					var href_field = xmlFormat(evaluate("arguments.rc.#MyFormField#"));
					
					href = 'href="#href_field#"';							
					}								
													
													
				xmlData &= '<data type="#lcase(MyFormField)#" #href#>' & xmlFormat(evaluate("arguments.rc.#MyFormField#")) & '</data>';
				}
			}
		}
	</cfscript>
	
	<cfreturn xmlData>
</cffunction>

	
	
<cffunction name="setProfile" output="no" access="remote" returnType="boolean">
	<cfargument name="UserID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">	
	
	<cfquery>
	UPDATE	dbo.Users
	SET		email 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.rc.email#">,
		xmlProfile 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc)#">,
		Modified 	= dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>
	

	<cfreturn true>	
</cffunction>	
	
	
<cffunction name="setContact" output="no" access="remote" returnType="boolean">
	<cfargument name="UserID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">		
	
	
		
	<cfquery>
	UPDATE	dbo.Users
	SET		email 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.rc.email#">,
		xmlContact	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc)#">,
		Modified 	= dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>	
		

	
	<cfreturn true>	
</cffunction>	
	


<cffunction name="encodeXMLPersonal" output="no" access="remote" returnType="boolean">
	<cfargument name="UserID" required="true" type="string">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">	
	


	
	<cfquery>
	UPDATE	dbo.Users
	SET	xmlLink	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc)#">,
		Modified 	= dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>	
	

	<cfreturn true>	
</cffunction>



<cffunction name="encodeXMLPref" output="no" access="remote" returnType="boolean">
	<cfargument name="UserID" required="true" type="string">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">		
	


	<cfquery>
	UPDATE	dbo.Users
	SET	xmlPref	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc)#">,
		Modified 	= dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>	
	

	<cfreturn true>	
</cffunction>



<cffunction name="getProfile" output="no" access="remote" returnType="struct">
	<cfargument name="UserID" required="true" type="string">
	
	
	<cfquery name="local.qryResult">
		SELECT 	xmlProfile, type, message
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlProfile)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
		AND		type IS NOT NULL
	</cfquery>

	<cfset var stResult = {keyphoto = ""}>

	<cfloop query="local.qryResult">
		
		<cfif not structKeyExists(stResult, "st#Pref#")>
			<cfset setVariable ("stResult.st#pref#", {})>
		</cfif>
		
		<cfset setVariable("stResult.st#Pref#.#Type#", message)>
	</cfloop>


	<cfreturn stResult>	
</cffunction>


<cffunction name="getContact" output="no" access="remote" returnType="struct">
	<cfargument name="UserID" required="true" type="string">
	
	
	<cfquery name="local.qryResult">
		SELECT 	xmlContact, type, message
		FROM	dbo.Users
		CROSS JOIN dbo.udf_xmlRead(xmlContact)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
		AND		type IS NOT NULL
	</cfquery>

	<cfset var stResult = {organization = "", address = "", city = "", stateprovince = "", postalcode = ""}>

	<cfloop query="local.qryResult">
		
		<cfif not structKeyExists(stResult, "st#Pref#")>
			<cfset setVariable ("stResult.st#pref#", {})>
		</cfif>
		
		<cfset setVariable("stResult.st#Pref#.#Type#", message)>
	</cfloop>


	<cfreturn stResult>	
</cffunction>




<cffunction name="getPersonal" output="no" access="remote" returnType="query">
	<cfargument name="UserID" required="true" type="string">


	<cfquery name="local.qryResult">
		SELECT	xmlLink, type, message
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlLink)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
	</cfquery>


	<cfset var stResult = {}>

	<cfloop query="local.qryResult">
		
		<cfif not structKeyExists(stResult, "st#Pref#")>
			<cfset setVariable ("stResult.st#pref#", {})>
		</cfif>
		
		<cfset setVariable("stResult.st#Pref#.#Type#", message)>
	</cfloop>


	<cfreturn qryResult>
</cffunction>	
	
	
<cffunction name="getPref" output="no" access="remote" returnType="struct">
	<cfargument name="UserID" required="true" type="string">


	<cfquery name="local.qryResult">
		SELECT	xmlPref, type, message
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlPref)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
	</cfquery>


	<cfset var stResult = {}>

	<cfloop query="local.qryResult">
		
		<cfif not structKeyExists(stResult, "st#Pref#")>
			<cfset setVariable ("stResult.st#pref#", {})>
		</cfif>
		
		<cfset setVariable("stResult.st#Pref#.#Type#", message)>
	</cfloop>


	<cfreturn qryResult>
</cffunction>			
	




	
<cfscript>	
string function getFullName(required numeric UserID) output="no" access="remote"	{


	variables.QueryService.addParam(value = arguments.userID, cfsqltype="cf_sql_integer");
	
	var oresult = variables.QueryService.execute(sql="SELECT firstname, lastname FROM dbo.vwUser WHERE Deleted = 0 AND userid = ?");
	
	var result = oresult.getResult();
	
	return result.firstname & " " & result.lastname;
	}
</cfscript>



<cffunction name="delete" output="no" access="remote" returnType="boolean">
	<cfargument name="userid" required="true" type="numeric">		
	<cfargument name="byUserID" required="true" type="string">
	<cfargument name="remote_addr" required="true" type="string">
	
	
	
	<cfquery>
	UPDATE	dbo.Users
	SET		DeleteDate = getDate(),
		Modified = dbo.udf_4jInfo('User was deleted',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_integer" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>
	
	<cfreturn true>

</cffunction>	
	


<cffunction name="existsUsername" returntype="boolean" output="no" access="remote">
	<cfargument name="username" required="true" type="string">
	
	

	<cfquery name="qryExists">
		SELECT	UserID
		FROM	dbo.Users WITH (NOLOCK)
		WHERE	login	= <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.username#">
	</cfquery>
	
	<cfif qryExists.recordcount EQ 0>
		<cfreturn false>
	</cfif>	
	
	<cfreturn true>	
</cffunction>



<cffunction name="atLeastOneUser" returntype="boolean" output="no" access="remote">
	
	
	<cfquery name="qryExists">
		SELECT	UserID
		FROM	dbo.Users WITH (NOLOCK)
		WHERE	Deleted = 0
	</cfquery>
	
	<cfif qryExists.recordcount EQ 0>
		<cfreturn false>
	</cfif>	
	
	<cfreturn true>	
</cffunction>



</cfcomponent>
 
