

<div class="main">

<h3>Recent Logins</h3>



<table class="edittable highlight paginate">
<thead>
<tr>
	<th></th>
	<th>Name</th>
	<th>Email</th>
	<th>Date</th>
	<th>Result</th>
</tr>
</thead>
<tbody>
<cfoutput query="rc.qryRecentLogin">
<tr>
	<td>#userID#</td>
	<td>#Firstname# #lastname#</td>
	<td>#Email#</td>
	<td>#LSDateFormat(CreateDate)# @ #LSTimeFormat(CreateDate)#</td>
	<td>#LoginStatus#</td>
</tr>
</cfoutput>
</tbody>
</table>



<cfoutput>
	<p><i><b>#rc.qryRecentLogin.recordcount#</b> recent logins</i></p>
</cfoutput>

</div>