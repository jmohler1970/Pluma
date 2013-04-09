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
	
	
	<cfif isNull(xmlGeoLocation)>
	
	
		<cftry>
			<cfhttp url="#variables.geo#/#arguments.remote_addr#">
		
			<cfset xmlGeoLocation = cfhttp.fileContent>
						
			<cfcatch><!---<cfdump var="#cfcatch#">---></cfcatch>
		</cftry>
		
		<cfif cfhttp.statusCode EQ 200>
			<cfset cachePut("ipcache#arguments.remote_addr#", xmlGeoLocation, CreateTimeSpan(1, 0, 0, 0))>	
		<cfelse>	
			<cfset cachePut("ipcache#arguments.remote_addr#", "", CreateTimeSpan(0, 1, 0, 0))>	
			
			<cfset xmlGeoLocation = "">
		</cfif>		
	</cfif>
	

	<cfscript>
	param arguments.action.subsystem = "";
	param arguments.action.section = "";
	param arguments.action.item = "";
	
	
	
	var strUrl_vars = "";
	
	for (keyName in arguments.url_vars)	{
		if (keyName != "action")
			strUrl_vars &= "<#keyName#>#arguments.url_vars[keyName]#</#keyName#>";
		}
			

	
	local.ormTraffic = entityNew("TrafficLoad", {
			SubSystem	= arguments.action.SubSystem == "" ? JavaCast("null", "") : this.stripHTML(arguments.action.SubSystem),
			Section 	= this.stripHTML(arguments.action.Section),
			Item 		= this.stripHTML(arguments.action.Item),
			isPost		= arguments.isPost,
			http_accept_Language = arguments.http_accept_language,
			
			Agent		= stripHTML(arguments.http_user_agent),
						
			Referer		= arguments.http_referer	== "" ? JavaCast("null", "") : stripHTML(arguments.http_referer),
			
			xmlGeoLocation = xmlGeoLocation,
								
			
			url_vars	= strUrl_vars //no comma
			});
			
	EntitySave(local.ormTraffic); // Commit may actually happen later
	</cfscript>
			
	
	<cfreturn variables.stResults>
</cffunction>		

<cfscript>
variables.stResults = {result = true, resultCode = 0, Message = ''};


// Traffic
string function stripHTML(str) output="false" {
	return REReplaceNoCase(arguments.str,"<[^>]*>","","ALL");
	}
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

