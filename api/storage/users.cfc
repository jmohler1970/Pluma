


<cfcomponent hint="Gets Users">


<cffunction name="getStatus" output="false"  returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "OK">

	<cftry>
		<cfset this.get()>
		
		<cfreturn "OK">

		<cfcatch />
	</cftry>
	
	<cfreturn "ER_REQ_PROC_FAIL">
</cffunction>



<cfscript>
	variables.stResults = {result = true, resultCode = 0, Message = ''};

	variables.QueryService = new query();
	variables.QueryService.setName("qryResult");
	
	variables.lstCol = "UserID,login,passhash
      	,firstname,middlename,lastname,postfix
		,homepath,lastLogin,pStatus
		,ExpirationDate
		,email,comments,Groups,Active
      	,Deleted,DeleteDate,ModifyDate,ModifyBy,CreateDate,CreateBy"; // rather than using select *
</cfscript>




<cffunction name="getAll" returnType="query" >
	
	
	<cfquery name="local.qryUsers">
		SELECT	TOP 500 #variables.lstCol#
		FROM	dbo.vwUser WITH (NOLOCK)
		WHERE	Deleted = 0
		ORDER BY firstname, lastname
	</cfquery>
	
	<cfreturn local.qryUsers>
</cffunction> 


<cffunction name="getByEmail" output="no"  returnType="query">	
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
query function getByGroup(required string group) output="no" 	{


	return this.getMatchlist("", arguments.group, "", 0, 0);
	}
</cfscript>
	




<cffunction name="passwordReset" output="no"  returnType="void">
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


<cffunction name="resetviaEmail" output="no"  returnType="string">
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
	


<cffunction name="getUserByLogin" output="no"  returnType="query">
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



<cffunction name="getOne" output="no"  returnType="query">
	<cfargument name="userid" required="true" type="string">		
	
	

	<cfquery name="qryUser">
		SELECT  #variables.lstCol# 
		FROM 	dbo.vwUser 
		WHERE 	Deleted 	= 0 
		AND 	UserID		= <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	</cfquery>
	
	<cfscript>
	if (qryUser.recordcount == 1)
		return qryUser;
	
	// Create blank row
	var qryBlank = QueryNew(variables.lstCol);
	QueryAddRow(qryBlank);
	
	return qryBlank;
	</cfscript>
</cffunction>	


<cfscript>


query function getUserByUserHomeAsQuery(required string userhome) output="no" 	{


	variables.QueryService.addParam(value = arguments.userhome, cfsqltype="cf_sql_varchar");
	var result = variables.QueryService.execute(sql="SELECT  #variables.lstCol#  FROM dbo.vwUser WHERE Deleted = 0 AND homepath = ?");
	
	return result.getResult();
	}

</cfscript>


<cffunction name="setLastLogin" output="no"  returnType="boolean">
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







<!--- read write functions here --->



<cffunction name="commit" returnType="struct"  hint="Does both insert and update">
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
		INTO	dbo.Users (PersonName, login, Email, Comments, Modified, Created)
		OUTPUT inserted.userid
		VALUES (
			'',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.login#">,
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
		SET	PersonName 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#local.personname#">,
			Email 			= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.email#">,
			Comments 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.comments#" null="#IIF(rc.Comments EQ "", 1, 0)#">,
			
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
	
	
	<cfset variables.stResults.UserID = arguments.UserID>


	<cfreturn variables.stResults>
</cffunction> 




<cffunction name="encodeXML" output="no"  returnType="string">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="filter" required="true" type="string">
	



	<cfscript>
	var xmlData = "";
	
	
	for (var MyFormField in rc)	{
			
		if (ListFindNoCase("action,submit,fieldnames,href", MyFormField) == 0)	{
			if (MyFormField CONTAINS arguments.filter)	{
				
				var href = "";
				
				if (isDefined("rc.#myFormField#_href"))	{							
					var href_field = xmlFormat(arguments.rc[MyFormField]);
					
					href = 'href="#href_field#"';							
					}								
													
													
				xmlData &= '<data type="#lcase(MyFormField)#" #href#>' & xmlFormat(arguments.rc[MyFormField]) & '</data>';
				}
			}
		}
	</cfscript>
	
	<cfreturn xmlData>
</cffunction>

	
	
<cffunction name="setProfile" output="no"  returnType="boolean" hint="Internal information. Users CANNOT edit their own profile">
	<cfargument name="UserID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">	
	
	<cfquery>
	UPDATE	dbo.Users
	SET	xmlProfile 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Profile')#">,
		Modified 	= dbo.udf_4jInfo('Profile was set',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	AND		xmlProfile <> <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Profile')#">
	</cfquery>
	

	<cfreturn true>	
</cffunction>	
	
	
	
<cffunction name="setContact" output="no"  returnType="boolean" hint="How to get in touch with this person. Users can edit">
	<cfargument name="UserID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">		
	
	
		
	<cfquery>
	UPDATE	dbo.Users
	SET	xmlContact	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Contact')#">,
		Modified 	= dbo.udf_4jInfo('Contact info Changed',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	AND		xmlContact <> <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Contact')#">
	</cfquery>	
		

	
	<cfreturn true>	
</cffunction>


	


<cffunction name="setPersonal" output="no"  returnType="boolean" hint="Things that are not covered above. Users can edit">
	<cfargument name="UserID" required="true" type="string">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">	
	


	
	<cfquery>
	UPDATE	dbo.Users
	SET	xmlLink	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Personal')#">,
		Modified 	= dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
		 	
	WHERE	UserID 		= <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		xmlPersonal	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Personal')#">,
	AND		Deleted = 0
	</cfquery>	
	

	<cfreturn true>	
</cffunction>



<cffunction name="renew" output="no"  returnType="boolean">
	<cfargument name="UserID" required="true" type="string">
	<cfargument name="expiration" required="true" type="string">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">		
	


	<cfquery name="qryUpdate">
	UPDATE	dbo.Users
	SET		expirationDate	= 
		<cfif arguments.expiration EQ "renew">
			CASE WHEN  expirationDate IS NULL THEN DateAdd(yy, 1, getDate())
			ELSE	DateAdd(yy, 1, expirationDate)
			END,
		<cfelse>
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.expiration#" null="#IIF(expiration EQ "", 1, 0)#">,
		</cfif>
		Modified 	= dbo.udf_4jInfo('User logged in',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.userID#">)
	OUTPUT inserted.UserID
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	</cfquery>	
	
	<cfif qryUpdate.recordcount EQ 0>
		<cfreturn false>
	</cfif>

	<cfreturn true>	
</cffunction>



<cffunction name="getProfile" output="no"  returnType="struct">
	<cfargument name="UserID" required="true" type="string">
	
	
	<cfquery name="local.qryResult">
		SELECT 	xmlProfile, type, message
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlProfile)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
		AND		type IS NOT NULL
	</cfquery>

	<cfset var stResult = {}>
	
	<cfloop query="local.qryResult">
		<cfset stResult[type] = message>
	</cfloop>


	<cfreturn stResult>	
</cffunction>


<cffunction name="getContact" output="no"  returnType="struct">
	<cfargument name="UserID" required="true" type="string">
	
	
	<cfquery name="local.qryResult">
		SELECT 	xmlContact, type, message
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlContact)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
		AND		type IS NOT NULL
	</cfquery>

	<cfset var stResult = {}>

	<cfloop query="local.qryResult">
		<cfset stResult[type] = message>
	</cfloop>


	<cfreturn stResult>	
</cffunction>




<cffunction name="getPersonal" output="no"  returnType="struct">
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
		<cfset stResult[type] = message>
	</cfloop>


	<cfreturn stResult>
</cffunction>	
	
	
<cffunction name="getPref" output="no"  returnType="struct">
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
		
	
		<cfset stResult[type] = message>
	</cfloop>


	<cfreturn stResult>
</cffunction>			
	




	
<cfscript>	
string function getFullName(required numeric UserID) output="no" 	{


	variables.QueryService.addParam(value = arguments.userID, cfsqltype="cf_sql_integer");
	
	var oresult = variables.QueryService.execute(sql="SELECT firstname, lastname FROM dbo.vwUser WHERE Deleted = 0 AND userid = ?");
	
	var result = oresult.getResult();
	
	return result.firstname & " " & result.lastname;
	}
</cfscript>



<cffunction name="delete" output="no"  returnType="boolean">
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
	


<cffunction name="existsUsername" returntype="boolean" output="no" >
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



<cffunction name="atLeastOneUser" returntype="boolean" output="no" >
	
	
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
 
