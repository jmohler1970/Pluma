

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value= 'start'>


</cfcase>

<cfcase value="end">

<table align="center" cellspacing="0" cellpadding="0" class="teamtable" border="0">
<thead>
<tr>
	<th class="stat" style="width : 20px">&nbsp;</th>
	<th class="stat">Name</th>
	<th class="stat">Stars</th>
	<th class="stat">Email</th>
	<th class="stat">Last Login</th>
	
	<th class="stat">Personal Home Page</th>
	<th class="stat">View<br />Profile</th>
	
	<th class="stat" style="width : 20px">&nbsp;</th>
	<th class="stat" style="width : 60px">&nbsp;</th>
</tr>
</thead>

<tbody>


</tbody>

<tfoot>
<tr>
	<td>Actions</td>
	<td>
	<select>
		<option>Add a month</option>
		<option>Add a year</option>
		<option>Add three years</option>
			
	</select>
	</td>
</tr>
</tfoot>
</table>

</cfcase>
</cfswitch>