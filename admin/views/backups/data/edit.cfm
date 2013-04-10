


	
<form action="#buildURL(action = '.load')###basic" method="post">

	<legend>Spreadsheet Preview</legend>




<table class="table table-condensed">
<thead>
<tr>
	<cfloop index="c" list="#rc.colList#">
		<cfoutput><th>#c#</th></cfoutput>
	</cfloop>
</tr>
</thead>

<cfoutput query="rc.qryData" startRow="2">
	<cfset variables.hadStuff = false>
	<cfsavecontent variable="row">
	<tr>
		
		<cfloop index="c" list="#rc.colList#">
			
			<cfif not variables.hadStuff and len(trim(rc.qryData[c][currentRow]))>
				<cfset variables.hadStuff = true>
			</cfif>
			
			<cfif isnumeric(rc.qrydata[c][currentRow]) OR rc.qryData[c][currentRow] CONTAINS "$">
				<td style="text-align : right">#rc.qrydata[c][currentRow]#</td>
			<cfelse>
				<td>#rc.qrydata[c][currentRow]#</td>
			</cfif>
			
		</cfloop>
		<td>
			<input type="checkbox" name="row" value="#currentrow#" checked="checked" />
		</td>
	</tr>
	</cfsavecontent>
	<cfif variables.hadStuff>#row#</cfif>		
	</cfoutput>
			
</table>


<div class="form-actions">
	

	<button type="submit" name="submit" class="btn btn-primary" value=""
	
	<cfif NOT rc.colList CONTAINS "SKU">
		disabled="disabled"
	</cfif>
	>SKU Import</button>
</div>	

	
</form>


<cfinclude template="ui/meta.cfm">

