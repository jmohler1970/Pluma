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


<cfcomponent hint="Manages Preferences" output="false">


<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	

	<cftry>
		<cfset this.get()>
		
		<cfreturn "">

		<cfcatch />
	</cftry>
	
	<cfreturn "Unable to query preferences DB">
</cffunction>

 


<cffunction name="get" output="false" access="remote" returnType="struct" hint="loads all preferences into a single structure">
	
	<cfquery name="local.qryPref">
		SELECT 	Pref, type, message
		FROM	dbo.Pref
		CROSS APPLY dbo.udf_xmlRead(xmlPref)
		WHERE	Deleted = 0
		AND		type IS NOT NULL
	</cfquery>

	<cfset var stResult = {}>

	<cfloop query="local.qryPref">
		
		<cfscript>
		if (not structKeyExists(stResult, "st#Pref#"))
			setVariable ("stResult.st#pref#", {});		
		
		
		mytype = type == "" ? "default" : type;
		
		
		setVariable("stResult.st#Pref#.#myType#", message);
		</cfscript>

	</cfloop>
	
	<cfreturn stResult>
</cffunction>	



<cffunction name="delete" output="false" access="remote" returnType="boolean" hint="clears out single part of xml. No long term prunning is done">
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
		DECLARE @myType varchar(40) =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.type#">
	
		UPDATE	dbo.Pref
		SET 	xmlPref.modify('delete /data[@type=sql:variable("@myType")]')
		WHERE	pref 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pref#">
		AND		Deleted = 0
	</cfquery> 


	<cfreturn true>
</cffunction>


<cffunction name="commit" output="false" access="remote" returnType="string" hint="">
	<cfargument name="Pref" 		required="true" type="string">
	<cfargument name="rc" 			required="true" type="struct">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="ByUserID" 	required="true" type="string">	

	
	
	<cfscript>
	if (arguments.pref == "")	{
		return "<b>Error:</b> pref was not specified. Preferences were not saved";
		}
	
	var xmlPref = "";
	
			
	for (var i in arguments.rc)	{
	
			
		if (ListFindNoCase("action,submit,fieldnames", i) == 0 AND listfirst(i, "_") == arguments.Pref)	{
		
			var shortField = listrest(i, "_");
	
				
			if (shortField == "new")	{
				param arguments.rc.new_title = "";
				
				shortField = reReplace(arguments.rc.new_title, "[^a-z0-9]_", "", "all");
				
				
				if (shortField == "" AND arguments.rc.new_title != "")	{
					return "A valid key could not be created from &quot;#htmlEditFormat(arguments.rc.new_title)#&quot;";
					}
				}
	
			if (shortField != "")	{
				xmlPref &= '<data type="#lcase(shortfield)#">#xmlformat(evaluate("rc.#i#"))#</data>';
				}
		
			} // end if
		} // end for
	
	
	</cfscript>


	<cfquery>
		DECLARE @myPref varchar(40) =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.Pref#">
	
	
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
		SET 	xmlPref = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#xmlPref#">,
				DeleteDate = NULL,
				Modified = dbo.udf_4jSuccess('Preferences Saved',
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
					<cfqueryparam CFSQLType="CF_SQL_integer" value="#arguments.byUserID#">
					)
		WHERE	Pref 	= @myPref
		
	</cfquery>
	
	
	<cfreturn "">
</cffunction>	 

</cfcomponent>

