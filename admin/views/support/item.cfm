

<div class="main">

	<h3>Database Schema Documentation</h3>
	

<cfoutput query="rc.qryDBinfo" group="table_name">
	<h2>#table_schema#.#table_name#</h2>

<table>
<tbody>
<tr>

	<th style="width : 450px;">Column Name</th>
	<th style="width : 150px;">Data Type</th>
	<th>Is Nullable</th>
</tr>
<cfoutput>
<tr>
	<td>
	<cfif right(column_name, 2) EQ "ID">
		<b>#column_name#</b>
	<cfelse>
		#column_name#
	</cfif>
	</td>
	<td>#data_type#
	<cfswitch expression="#character_maximum_length#">
	<cfcase value=""></cfcase>
	<cfcase value="-1">(MAX)</cfcase>
	<cfdefaultcase>(#character_maximum_length#)</cfdefaultcase> 
	</cfswitch>
	</td>
	<td>
	<cfif is_nullable>
		Yes
	<cfelse>
		No
	</cfif>
	</td>
</tr>
</cfoutput>
</tbody>
</table>


</cfoutput>

	
</div>