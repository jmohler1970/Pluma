


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
	this.stResults = {result = true, resultCode = 0, Message = ''};

	variables.QueryService = new query();
	variables.QueryService.setName("qryResult");
	
	variables.lstCol = "UserID,login,passhash,slug
      	,prefix,given,additional,family,suffix
      	,org, photo, url, email, title
      	,officetel, celltel, faxtel
      	,street, locality, region, code, country
      	,tz, note
		,lastLogin,pStatus
		,ExpirationDate,Groups,Active
      	,Deleted,DeleteDate,ModifyDate,ModifyBy,CreateDate,CreateBy"; // rather than using select *
</cfscript>




<cffunction name="getAll" returnType="query" >
	
	
	<cfquery name="local.qryUsers">
		SELECT	TOP 500 #variables.lstCol#
		FROM	dbo.vwUser WITH (NOLOCK)
		WHERE	Deleted = 0
		ORDER BY given, family
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


query function getBySlug(required string slug) output="no" 	{


	variables.QueryService.addParam(value = arguments.slug, cfsqltype="cf_sql_varchar");
	var result = variables.QueryService.execute(sql="SELECT  #variables.lstCol#  FROM dbo.vwUser WHERE Deleted = 0 AND slug = ?");
	
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

<!--- For defintion details see: http://microformats.org/wiki/hcard ---> 

<cffunction name="commit" returnType="struct"  hint="Does both insert and update">
	<cfargument name="UserID" required="true" type="string" hint="blank is valid and will create a new user">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">
	


	<cfscript>
	var homepath = "";
	
	param rc.prefix			= "";
	param rc.given			= "";
	param rc.additional		= "";
	param rc.family			= "";
	param rc.suffix			= "";
	
	param rc.org 			= "";
	param rc.photo 			= "";
	param rc.url 			= "";
	param rc.email 			= "";
	
	param rc.officetel		= "";
	param rc.celltel		= "";
	param rc.faxtel			= "";
	
	param rc.street			= "";
	param rc.locality 		= "";
	param rc.region			= "";
	param rc.code			= "";
	param rc.country		= "";
	param rc.tz				= "";	
	param rc.note			= "";

		
	
	// security
	param rc.groups 		= "";

	param rc.expirationdate = "";
	param rc.passhash 		= "skip";
	param rc.submit 		= "";
	</cfscript>		
			
	

	
<cfsavecontent variable="local.personname">
<cfoutput>
<vcard>

	
<fn><text>#rc.given# #rc.family#</text></fn>

<n>
	<cfif rc.prefix NEQ "">
		<prefix>#rc.prefix#</prefix>
	</cfif>
	<given>#rc.given#</given>
	
	<cfif rc.additional NEQ "">
		<additional>#rc.additional#</additional>
	</cfif>
	
	<family>#rc.family#</family>
	
	<cfif rc.suffix NEQ "">
		<suffix>#rc.suffix#</suffix>
	</cfif>	
</n>


<cfif rc.org NEQ "">
	<org><text>#rc.org#</text></org>
</cfif>

<cfif rc.photo NEQ "">
	<photo><uri>#rc.photo#</url></photo>
</cfif>

<cfif rc.url NEQ "">
	<url><uri>#rc.url#</uri></url>
</cfif>

<cfif rc.email NEQ "">
	<email><text>#rc.email#</text></email>
</cfif>

<cfif rc.officetel NEQ "">
	<tel>
		<parameters>
			<type><text>Office Phone</text></type>
		</parameters>
	
		<uri>#rc.officetel#</uri>
	</tel>
</cfif>

<cfif rc.celltel NEQ "">
	<tel>
		<parameters>
			<type><text>Mobile Phone</text></type>
		<parameters>
		<uri>#rc.celltel#</uri>
	</tel>	
</cfif>


<cfif rc.celltel NEQ "">
	<tel>
		<parameters>
			<type><text>FAX</text></type>
		<parameters>
		<uri>#rc.faxtel#</uri>
	</tel>	
</cfif>




<adr>
	<cfif rc.street NEQ "">
	<street>#rc.street#</street>
	</cfif>
	
	<cfif rc.locality NEQ "">
	<locality>#rc.locality#</locality>
	</cfif>
	
	<cfif rc.region NEQ "">
	<region>#rc.region#</region>
	</cfif>
	
	<cfif rc.code NEQ "">
	<code>#rc.code#</code>
	</cfif>
	
	<cfif rc.country NEQ "">
	<country>#rc.country#</country>
	</cfif>
</adr>


<cfif rc.tz NEQ "">
	<tz><text>#rc.tz#</text></tz>
</cfif>


<cfif rc.note NEQ "">
	<note>#rc.note#</note>
</cfif>

</vcard>

</cfoutput>	
</cfsavecontent>


	<cfif NOT isnumeric(arguments.userID)>
		<cfquery name="qryAdd">
		DECLARE @login nvarchar(50) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.login#">
		
		INSERT 
		INTO	dbo.Users (PersonName, login, slug, Modified, Created)
		OUTPUT inserted.userid
		VALUES (
			'',
			@login,
			
			dbo.udf_slugify(@login),
									
			dbo.udf_4jSuccess('Basic data was committed',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
			 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byuserID#">),
			
			dbo.udf_4jInfo(DEFAULT,DEFAULT,
			 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byuserID#">)
			)
		</cfquery>
	
	
		<cfset arguments.UserID = qryAdd.UserID>
	</cfif>
	
		
	<cfquery name="qryCommit">
		UPDATE	dbo.Users
		SET	PersonName 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#local.personname#">,
			
			
			expirationDate 	= <cfqueryparam CFSQLType="CF_SQL_DATE" value="#rc.expirationDate#">,
		
			
			<cfif rc.passhash EQ "">
				PassHash = NULL,
			<cfelseif NOT rc.passhash CONTAINS "skip">
				PassHash = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.passhash#">,
			</cfif>
		
		
			<cfif rc.submit CONTAINS "reactivate">
				DeleteDate = NULL,
			</cfif>
		
			<cfif rc.groups NEQ "">
				xmlGroup 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML({Group = rc.groups})#">,
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





	
	
<cffunction name="setProfile" output="no"  returnType="struct" hint="Internal information. Users CANNOT edit their own profile">
	<cfargument name="UserID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="ByUserID" required="true" type="string">	
	
	<cfquery>
	DECLARE @xmlProfile varchar(max) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'Profile')#">
	
	UPDATE	dbo.Users
	SET	xmlProfile 	= @xmlProfile,
		Modified 	= dbo.udf_4jInfo('Profile was set',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.ByUserID#">)
		 	
	WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
	AND		Deleted = 0
	AND		ISNULL(CONVERT(varchar(max), xmlProfile), '') <> @xmlProfile
	</cfquery>
	

	<cfreturn this.stResults>
</cffunction>	
	
	


<cffunction name="setLink" output="false" returntype="struct" hint="similar to User.linksave">
	<cfargument name="UserID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	
	
	
	<cfquery name="qryClearLink">
	DECLARE @xmlLink varchar(max) = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#this.encodeXML(rc)#">
	
	
	UPDATE	dbo.Users
	SET		xmlLink = @xmlLink,
		Modified = dbo.udf_4jInfo('Link has been updated',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
			
	WHERE	Deleted = 0
	AND		UserID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.userid#">
	AND		CONVERT(varchar(max), xmlLink) <> @xmlLink
	</cfquery>
	
	
	
	
	<cfreturn this.stResults>
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



<cffunction name="getProfile" output="no"  returnType="query">
	<cfargument name="UserID" required="true" type="string">
	
	
	<cfquery name="local.qryResult">
		SELECT  title, type, message
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlProfile)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
		AND		type IS NOT NULL
		ORDER BY Position
	</cfquery>


	<cfreturn local.qryResult>	
</cffunction>


<cffunction name="getstProfile" output="no"  returnType="struct">
	<cfargument name="UserID" required="true" type="string">

	<cfset local.qryResult = this.getProfile(arguments.UserID)>

	<cfset var stResult = {}>

	<cfloop query="local.qryResult">
		<cfset stResult[type] = message>
	</cfloop>
	
	<cfreturn stResult>
</cffunction>



<cffunction name="getLink" output="no"  returnType="query">
	<cfargument name="UserID" required="true" type="string">


	<cfquery name="local.qryResult">
		SELECT	UserID, [type], href, title, message, Position
		FROM	dbo.Users
		CROSS APPLY dbo.udf_xmlRead(xmlLink)
		WHERE	UserID = <cfqueryparam cfsqltype="CF_SQL_varchar" value="#arguments.userid#">
		AND		Deleted = 0
	</cfquery>

	<cfreturn local.qryResult>
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
	
	var oresult = variables.QueryService.execute(sql="SELECT given, family FROM dbo.vwUser WHERE Deleted = 0 AND userid = ?");
	
	var result = oresult.getResult();
	
	return result.given & " " & result.family;
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
 
