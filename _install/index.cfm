

<cfset installdir = getDirectoryFromPath(GetCurrentTemplatePath()) & "mssql\">


<cfdirectory directory="#installdir#" name="qryFiles" filter="*.sql">





<form action="index.cfm" method="post">
<table>
<tr>
	<td>Datasource</td><td><input type="text" name="datasource" value="plumacms"></td>
</tr>	
	
<tr>	
	<td>Schema</td><td><input type="text" name="schema" value="dbo"></td>
</tr>	
	
	
	<cfoutput query="qryFiles">
<tr>	
	<td>	<input type="checkbox" name="processfile" value="#name#" 
		<cfif name CONTAINS "drop" OR name CONTAINS "data">
		
		<cfelse>
			checked
		</cfif>
	</td>
	<td> #name#</td>
</tr>	
	
	</cfoutput>
</table>	
	
	
	<button type="submit">Create database</button>
</form>	



<cfif cgi.request_method EQ "post">

	<cfloop index="i" list="#form.processfile#">

		<cffile action="read" file="#installdir#/#i#" variable="sqlfile">


		<pre>
			#preservesinglequotes(replace(sqlfile, "dbo", form.schema, "all" )#
		</pre>

		<!---	
		<cfquery> 	
			#preservesinglequotes(replace(sqlfile, "dbo", form.schema, "all" )#
		</cfquery>		
		--->	
	</cfloop>	


</cfif>

