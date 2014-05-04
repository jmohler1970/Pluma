

<!---
Preferences are stResult[pref][type].*

They are selected via stResult[pref]

--->



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
	
	<cfset local.stResult = {}>

		
	<cfquery name="local.qryPref">
		SELECT 	Pref, [type], /*title, href, rel,*/  message
		FROM	dbo.Pref WITH (NOLOCK)
		CROSS APPLY dbo.udf_xoxoRead(xmlPref, DEFAULT)
		WHERE	Deleted = 0
		ORDER BY Pref
	</cfquery>

	
	<cfloop query="local.qryPref">
		
		<cfscript>
		if (not structKeyExists(local.stResult, Pref))
			local.stResult[pref] =  {};		
		
			
		local.stResult[pref][type] = message;
		</cfscript>

	</cfloop>
	

	
	<cfreturn local.stResult>
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
		DECLARE @type varchar(40) =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.type#">
	
		UPDATE	dbo.Pref
		SET 	xmlPref.modify('delete /ul/li/b[.=sql:variable("@type")]')
		WHERE	pref 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pref#">
		AND		Deleted = 0
	</cfquery> 


	<cfreturn true>
</cffunction>



<cffunction name="typeexists" returnType="boolean" output="false">
	<cfargument name="Pref" 	required="true" type="string">
	<cfargument name="type" required="true" type="string">

	<cfquery name="local.qryType">
		DECLARE @type varchar(40) =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.type#">
	
		SELECT	Pref
		FROM	dbo.Pref WITH (NOLOCK)
		WHERE	pref 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pref#">
		AND		Deleted = 0
		AND		xmlPref.exist('/ul/li/b[.=sql:variable("@type")]') = 1
	</cfquery> 

	<cfif local.qryType.Pref EQ "">
		<cfreturn false>
	</cfif>
	<cfreturn true>	
	
</cffunction>




<cffunction name="commit" output="false"  returnType="string" hint="">
	<cfargument name="Pref" 		required="true" type="string">
	<cfargument name="Data" 		required="true" type="struct">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="ByUserID" 	required="true" type="string">	

	<cfscript>
	if (structKeyExists(arguments.Data, "new"))	{
		arguments.Data[arguments.Data.new_title] = arguments.Data.New;
		
		StructDelete(arguments.Data, "new_title");
		StructDelete(arguments.Data, "new");
		}
	</cfscript>

	

	<cfquery>
		DECLARE @Source TABLE (
			Pref varchar(40) NOT NULL PRIMARY KEY CLUSTERED,
			xmlPref 	xml,
			Modified 	xml,
			Created 	xml 
			)
		
		INSERT 
		INTO	@Source
		SELECT  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.Pref#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#this.encodeXML(arguments.data)#">,
				dbo.udf_4jSuccess('Preferences Saved',
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
					<cfqueryparam CFSQLType="CF_SQL_integer" value="#arguments.byUserID#">
					),
				dbo.udf_4jInfo('Created',
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
					<cfqueryparam CFSQLType="CF_SQL_integer" value="#arguments.byUserID#">
        			)	
		
		
		MERGE	dbo.Pref
		USING	@Source AS Source
		ON		dbo.Pref.Pref = Source.Pref
		
		WHEN MATCHED AND CONVERT(nvarchar(max), dbo.Pref.xmlPref) <> CONVERT(nvarchar(max), Source.xmlPref)	THEN 
			UPDATE 
			SET xmlPref = Source.xmlPref, Modified = Source.Modified, DeleteDate = NULL
		WHEN NOT MATCHED 	THEN 
			INSERT (Pref, 		 Created) 
			VALUES (Source.Pref, Source.Created)
		;	
	</cfquery>
	
	
	<cfreturn "">
</cffunction>	 

</cfcomponent>

