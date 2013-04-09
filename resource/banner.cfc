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


<cfcomponent hint="Manages Banners" extends="node">


<cffunction name="getImpressions" returnType="numeric" output="false" access="remote">
	<cfargument name="NodeID"  required="true" type="numeric">
	<cfargument name="when"  required="false" type="string" default="">
	<cfargument name="clickthrough" required="false" default="0" type="boolean">
	
	<cfset var qryImpressions = "">
	
	<cfquery name="qryImpressions">
		SELECT ISNULL(COUNT(NodeID), 0) AS BannerCount
		FROM	dbo.BannerTraffic
		WHERE	NodeID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.NodeID#">
		
		<cfswitch expression="#arguments.when#">
		<cfcase value="week">
			AND CreateDate > DateAdd(dd, -7, getDate())
		</cfcase>
		<cfcase value="month">
			AND CreateDate > DateAdd(mm, -1, getDate())
		</cfcase>
		</cfswitch>
		
		
		<cfif arguments.clickthrough>
			AND	clickthrough = 1
		</cfif>
	</cfquery>
	
	<cfreturn qryImpressions.BannerCount>
</cffunction>



<cffunction returnType="string" name="savebulk" output="false" access="remote">
	<cfargument name="attr" type="struct" required="true">
	<cfargument name="UserID" type="numeric" required="true">
	
	<cfset var i = "">
	<cfset var currentPath = "">
	<cfset var qryBanner = "">
	
	<cfset message="">
	
	<cfloop index="i" list="#arguments.attr.bannerid#">
	
		<cfscript>
		rc = {};
		
		if (NOT isDate(evaluate('attr.startDate_#i#')))
		
			message &= "#evaluate('attr.startDate_#i#')# is not a valid date.";
		
		else if (NOT isDate(evaluate('attr.expirationDate_#i#')))
		
			message &= "#evaluate('attr.expirationDate_#i#')# is not a valid date.";
		
		else	{
			ormBanner = EntityLoadByPK("Node", i);
				
		
			if (evaluate("attr.pstatus_#i#") == "Delete")
				ormBanner.setDeleteDate(now());	
				
			
			else	{
			
				ormBanner.setpStatus(evaluate("attr.pstatus_#i#"));
				ormBanner.setStartDate(evaluate("attr.startdate_#i#"));
				ormBanner.setExpirationDate(evaluate("attr.expirationdate_#i#"));
				ormBanner.setModifyBy(arguments.UserID);
				ormBanner.setModifyDate(now());
				EntitySave(ormBanner);
				
								
				rc.src 	= stData.src;
				rc.href = evaluate("attr.href_#i#");
				
			
				this.XMLSave(i, rc, arguments.userid);
				}
			}


		</cfscript>
	</cfloop>
	

	<cfreturn message>
</cffunction>


<cffunction name="getBanner" output="false" returntype="query" access="remote">
	<cfargument name="timeframe" required="true" type="string">		
	<cfargument name="isAdvertiser" required="true" type="boolean">
	<cfargument name="UserID" required="true" type="string">
			
			
	<cfquery name="local.qryBanner">
		SELECT 	*
		FROM 	dbo.vwNode
		WHERE	Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Banner">
		AND		Deleted = 0
		
		<cfswitch expression="#arguments.timeframe#">
		<cfcase value="Future">
			AND		StartDate > getDate()
		</cfcase>
		<cfcase value="Past">
			AND		ExpirationDate < getDate()
		</cfcase>
		<cfcase value="Reject">
			AND		pStatus = 'Reject'
		</cfcase>
		<cfdefaultcase>
			AND		StartDate <= getDate()
			AND		ExpirationDate >= getDate()
		</cfdefaultcase>
		</cfswitch>
		
		<cfif arguments.isAdvertiser>
			AND CONVERT(varchar(20), OwnerID) = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.UserID#"> 
		</cfif>
		
		ORDER BY	StartDate
	</cfquery>

			
	<cfreturn local.qryBanner>
</cffunction>


<cffunction name="getForPage" output="false" returntype="query" access="remote">
	<cfargument name="Extra" required="true" type="string">
	<cfargument name="Needed" required="true" type="numeric">
		
	<cfargument name="remote_addr" required="true" type="string">		
			
	<cfquery name="local.qryBanner">
		SELECT 	TOP #int(arguments.Needed)# NodeID, title, src
		FROM 	dbo.vwNode
		WHERE	Kind 		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Banner">
		AND		Deleted 	= 0
		
		AND		Extra = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#attributes.Extra#">
		AND		StartDate <= getDate()
		AND		ExpirationDate >= getDate()
		ORDER BY	NewID()
	</cfquery>
	
	
	<cfloop query="local.qryBanner">
		<cfset this.doClick(NodeID, 0, arguments.remote_addr)>
	</cfloop>

			
	<cfreturn local.qryBanner>
</cffunction>


<cffunction name="doClick"	 output="false" access="remote" returnType="string">
	<cfargument name="NodeID" required="true" type="string">
	<cfargument name="clickthrough" required="true" type="string">
	<cfargument name="remote_addr" required="true" type="string">
	
	
	<cfif not isnumeric(arguments.NodeID)>
		<cfreturn "">
	</cfif>
	

<cfquery name="qryBanner">
	SELECT	xmlData.value('href[1]', 'varchar(max)') AS href
	FROM 	dbo.Node
	WHERE	deleted = 0
	AND		NodeID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.NodeID#">
</cfquery>

	<cfscript>
	if (qryBanner.recordcount == 0)	{
		return "";
		}


	ormBannerTraffic = EntityNew("BannerTraffic", {NodeID = arguments.NodeID, ClickThrough = arguments.clickthrough, remote_addr = arguments.remote.addr});
	EntitySave(ormTraffic);
		
		return qryBanner.href;
	</cfscript>

</cffunction>	
		

</cfcomponent>
 

	