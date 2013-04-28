

<cfcomponent>

<cfset variables.geo = "http://freegeoip.net/xml">


<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "">

	<cftry>
		<cfset this.get()>
		
		<cfreturn "">

		<cfcatch />
	</cftry>
	
	<cfreturn "Unable to query preferences DB">
</cffunction>
		


<cffunction name="add" returnType="struct" access="remote">
	<cfargument name="action" type="struct">
	
	<cfargument name="ispost" type="boolean" default="0">
	<cfargument name="http_user_agent" type="string" default="#cgi.http_user_agent#">
	<cfargument name="remote_addr" type="string" default="#cgi.remote_addr#">
	<cfargument name="http_accept_language" type="string" default="#cgi.http_accept_language#">
	<cfargument name="http_referer" type="string" default="#cgi.http_referer#" >
	<cfargument name="url_vars" type="struct" required="true">
	

		

	<cfset var xmlGeoLocation = cacheGet("ipcache#arguments.remote_addr#")>
	
	
	<cfif isNull(xmlGeoLocation) OR len(xmlGeoLocation) EQ 0 >
		
	
		<cftry>
			<cfhttp url="#variables.geo#/#arguments.remote_addr#">
		
			<cfset xmlGeoLocation = cfhttp.fileContent>
			
			<cfcatch><cfset cachestatus = cfcatch.message><!---<cfdump var="#cfcatch#">---></cfcatch>
		</cftry>
		
		
		<cfif cfhttp.statusCode CONTAINS "200">
			<cfset cachePut("ipcache#arguments.remote_addr#", xmlGeoLocation, CreateTimeSpan(1, 0, 0, 0))>	
		<cfelse>	
			<cfset cachePut("ipcache#arguments.remote_addr#", "", CreateTimeSpan(0, 1, 0, 0))>	
			
			<cfset xmlGeoLocation = "">
		</cfif>	
	</cfif>
	
	
	

	<cfscript>
	xmlGeoLocation = REreplace(xmlGeoLocation, '[^\x00-\x7F]', '?', 'all');
	
	
	if (xmlGeoLocation == "")	{
		xmlGeoLocation = '<Response><Ip>#arguments.remote_addr#</Ip></Response>';
		}



	param arguments.action.subsystem = "";
	param arguments.action.section = "";
	param arguments.action.item = "";
	
	
	
	var strURL_vars = "";
	
	for (keyName in arguments.url_vars)	{
		if (keyName != "action")
			strUrl_vars &= "<#keyName#>#arguments.url_vars[keyName]#</#keyName#>";
		}
	</cfscript>
	
	
	<cftry>		
	<cfquery>
		INSERT 
		INTO Traffic(SubSystem, Section, Item, isPost, http_accept_language, agent, referer, xmlGeoLocation, url_vars)
		VALUES (
			dbo.udf_StripHTML(<cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.action.SubSystem#">),
			dbo.udf_StripHTML(<cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.action.Section#">),
			dbo.udf_StripHTML(<cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.action.Item#">),
			<cfqueryparam CFSQLType="cf_sql_bit" 	value="#arguments.isPost#">,
			<cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.http_accept_language#">,
			<cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.http_user_agent#">,
			<cfqueryparam CFSQLType="cf_sql_varchar" value="#arguments.http_referer#">,
			<cfqueryparam CFSQLType="cf_sql_varchar" value="#xmlGeoLocation#">,
			<cfqueryparam CFSQLType="cf_sql_varchar" value="#strURL_vars#">
			)
	</cfquery>		
			
	<cfcatch />		
	</cftry>		
	
	<cfreturn variables.stResults>
</cffunction>		

<cfscript>
variables.stResults = {result = true, resultCode = 0, Message = ''};


// Traffic
</cfscript>


<!--- New Summary --->
<cffunction name="getTrafficDetails" returnType="query" access="remote" output="no">
	<cfargument name="filter" required="true" type="struct">

	<!---
	Filterformat:
	startDate
	endDate
	mode
	server_name
	--->
	
	<cfparam name="filter.server_name" default=""><!--- needed for referer --->
	<cfparam name="filter.mode" default="">
	
	<cfset var smallServerName = replacelist(filter.server_name, 'www.', '')>
	
	<cfif filter.mode EQ "referer">
		
		<cfstoredproc procedure="usp_TrafficReferer">
 	  		<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.startDate#">
   			<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.endDate#">
			<cfprocparam type = "IN" CFSQLType="cf_sql_varchar" value="#smallServerName#">
	
			<cfprocresult name="qryTrafficReferer">
   		</cfstoredproc>
	
		<cfreturn qryTrafficReferer>
	</cfif>
	
		
	<cfif filter.mode EQ "organic">
		
		<cfstoredproc procedure="usp_TrafficOrganic">
 	  		<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.startDate#">
   			<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.endDate#">
	
			<cfprocresult name="qryTrafficOrganic">
   		</cfstoredproc>
	
		<cfreturn qryTrafficOrganic>
	</cfif>
	
	
	
	<cfif filter.mode EQ "country">
		<cfstoredproc procedure="usp_TrafficCountry">
 	  		<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.startDate#">
   			<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.endDate#">
	
			<cfprocresult name="qryTrafficCountry" />
   		</cfstoredproc>
	
		<cfreturn qryTrafficCountry>
	
	</cfif>
	
	
	
	<cfif filter.mode EQ "os">

		<cfstoredproc procedure="usp_TrafficOS">
 	  		<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.startDate#">
   			<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.endDate#">
   		
	
			<cfprocresult name="qryTrafficOS" />
   		</cfstoredproc>
	
		<cfreturn qryTrafficOS>
	</cfif>
	
	
	
	<cfstoredproc procedure="usp_TrafficDetails">
   		<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.startDate#">
   		<cfprocparam type = "IN" CFSQLType="cf_sql_date" value="#filter.endDate#">
   		
	
		<cfprocresult name="qryTrafficDetails" />
   	</cfstoredproc>
	

	<cfreturn qryTrafficDetails>
</cffunction>


<cffunction name="getLastHits" access="remote" output="false" returntype="query">
	<cfargument name="mode" required="true" type="string">
	<cfargument name="servername" required="true" type="string">

	<cfset var smallServerName = replacelist(arguments.servername, 'www.', '')>


	<cfquery name="qryLastHits">
		SELECT TOP 20 CreateDate, SubSystem, Section, Item, OS, Browser, agent, Referer,
			url_vars.value('(search)[1]', 'nvarchar(max)')  AS Search,
			url_vars.value('(tags)[1]', 'nvarchar(max)')  AS Tags
				
		FROM 	dbo.Traffic
		WHERE	1 = 1
		<cfswitch expression="#arguments.mode#">
		<cfcase value="bot">
			AND	isBot = 1
		</cfcase>
			
		<cfcase value="search">
			AND	url_vars.exist('.[search]') = 1
		</cfcase>
	
		<cfcase value="organic">
			AND	Referer IS NOT NULL
			AND	NOT Referer LIKE <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#smallServerName#%">
			AND	Referer LIKE '%q=%'
		</cfcase>
		
		<cfcase value="referer">
			AND	Referer IS NOT NULL
			AND	NOT Referer LIKE <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#smallServerName#%">
			AND	NOT Referer LIKE '%q=%'
		</cfcase>
		
		<cfdefaultcase>
			AND	isBot = 0
		</cfdefaultcase>
		</cfswitch>
						
		ORDER BY CreateDate DESC
	</cfquery> 

	
	<cfreturn qryLastHits>
</cffunction> 



</cfcomponent>

