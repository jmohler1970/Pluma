


<cfcomponent hint="Manages Preferences" output="false" extends="base">


<cffunction name="getStatus" output="false"  returnType="string" hint="Is this object ready to read and write data">

	

	<cftry>
		<cfset this.get()>
		
		<cfreturn "OK">

		<cfcatch />
	</cftry>
	
	<cfreturn "ER_REQ_PROC_FAIL">
</cffunction>

 


<cffunction name="get" output="false"  returnType="struct" hint="loads all preferences into a single structure">
	
	<cfset var stResult = {}>

		
	<cfquery name="local.qryPref">
		SELECT 	Pref, CASE WHEN id = '' THEN 'default' ELSE id END AS id, title, href, rel, message
		FROM	dbo.Pref WITH (NOLOCK)
		CROSS APPLY dbo.udf_xmlRead(xmlPref)
		WHERE	Deleted = 0
		AND		id IS NOT NULL
		ORDER BY Pref
	</cfquery>

	
	<cfloop query="local.qryPref">
		
		<cfscript>
		if (not structKeyExists(stResult, Pref))
			stResult[pref] =  {};		
		
			
		stResult[pref][id] = message;
		</cfscript>

	</cfloop>
	

	
	<cfreturn stResult>
</cffunction>	



<cffunction name="delete" output="false"  returnType="boolean" hint="clears out single part of xml. No long term prunning is done">
	<cfargument name="pref" type="string" required="true">
	<cfargument name="type" type="string" required="true" hint="individual row to remove from xml">
	
	<cfif arguments.pref EQ "All">
		<cfquery>
		DELETE
		FROM 	dbo.Pref
		</cfquery> 
	
		<cfreturn true>
	</cfif>
	
	
	
	<cfquery>
		DECLARE @category varchar(40) =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.type#">
	
		UPDATE	dbo.Pref
		SET 	xmlPref.modify('delete /ul/li[.=sql:variable("@category")]')
		WHERE	pref 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pref#">
		AND		Deleted = 0
	</cfquery> 


	<cfreturn true>
</cffunction>


<cffunction name="catgoryexists" returnType="boolean" output="false">
	<cfargument name="Pref" 	required="true" type="string">
	<cfargument name="category" required="true" type="string">

	<cfquery name="qryType">
		DECLARE @category varchar(40) =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.type#">
	
		SELECT	Pref
		FROM	dbo.Pref WITH (NOLOCK)
		WHERE	pref 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pref#">
		AND		Deleted = 0
		AND		xmlPref.exist('/ul/li[.=sql:variable("@category")]') = 1
	</cfquery> 

	<cfif qryType.Pref EQ "">
		<cfreturn false>
	</cfif>
	<cfreturn true>	
	
</cffunction>




<cffunction name="commit" output="false"  returnType="string" hint="">
	<cfargument name="Pref" 		required="true" type="string">
	<cfargument name="rc" 			required="true" type="struct">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="ByUserID" 	required="true" type="string">	

	

	<cfquery>
		DECLARE @myPref  varchar(40) 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.Pref#">
		DECLARE @xmlPref varchar(max)	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#this.encodeXML(rc, arguments.Pref)#">
		
	
		IF NOT EXISTS(SELECT 1 FROM dbo.Pref WHERE Pref = @myPref)
    		INSERT 
    		INTO dbo.Pref (Pref, Created)
        	VALUES (@MyPref,
        		dbo.udf_4jInfo('Created',
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
					<cfqueryparam CFSQLType="CF_SQL_integer" value="#arguments.byUserID#">
        			)
        		)
        		
		
		UPDATE	dbo.Pref
		SET 	xmlPref 	= @xmlPref,
				DeleteDate 	= NULL,
				Modified 	= dbo.udf_4jSuccess('Preferences Saved',
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
					<cfqueryparam CFSQLType="CF_SQL_integer" value="#arguments.byUserID#">
					)
		WHERE	Pref 	= @myPref
		AND		CONVERT(varchar(max), xmlPref) <> @xmlPref
	</cfquery>
	
	
	<cfreturn "">
</cffunction>	 

</cfcomponent>

