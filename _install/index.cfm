
<html>
<head>
	<title>Install Database</title>
</head>

<body> 	



<cfset installdir = getDirectoryFromPath(GetCurrentTemplatePath()) & "mssql\">


<cfdirectory directory="#installdir#" name="qryFiles" filter="*.sql">


<cfparam name="form.schema" default="dbo">
<cfparam name="form.createschema" default="0">



<form action="index.cfm" method="post">
<table>
<tr>
	<td>Datasource</td><td><input type="text" name="datasource" value="plumacms"></td>
</tr>	
	
<tr>	
	<cfoutput>
		<td>Schema</td><td><input type="text" name="schema" value="#form.schema#"></td>
		<td><input type="checkbox" name="createschema" value="1" /> Create Schema
	</cfoutput>
</tr>	
	
	
	
	<cfoutput query="qryFiles">
<tr>	
	<td>	<input type="checkbox" name="processfile" value="#name#" 
		<cfif name CONTAINS "drop" OR name CONTAINS "data">
		
		<cfelse>
			<!---checked--->
		</cfif>
	</td>
	<td> #name#</td>
</tr>	
	
	</cfoutput>
</table>	
	
	
	<button type="submit" name="submit" value="preview">Preview</button>
	<button type="submit" name="submit" value="install">Create database</button>
</form>	



<cfif cgi.request_method EQ "post">

	<cfif form.createschema>
	
		<cfquery dataSource="#form.datasource#">
			CREATE SCHEMA <cfqueryparam CFSQLType="cf_sql_varchar" value="#form.schema#"> AUTHORIZATION [dbo]
		
		</cfquery>	
	
	
		<!---
		<cfquery dataSource="#form.datasource#">
			CREATE SCHEMA [#form.schema#] AUTHORIZATION [dbo]
		
		</cfquery>
		--->	
	</cfif>



	<cfloop index="i" list="#form.processfile#">

		<cffile action="read" file="#installdir#/#i#" variable="sqlfile">

		
		<cfset cleansql =	replacelist(sqlfile, "dbo", form.schema)>

		<cfoutput> 	
		<p style="background : silver;">Processing: <tt>#i#</tt> ...</p>
		</cfoutput>	


		<cfif form.submit EQ "preview">
		<pre>
			<cfoutput>#xmlformat(cleansql)#</cfoutput>
		</pre>
		</cfif>

		<cfif form.submit EQ "install">
		<cfquery datasource="#form.datasource#" > 	
			#preservesinglequotes(cleansql)#
		</cfquery>		
		</cfif>
	</cfloop>	


</cfif>



</body>
</html>

