

<cfoutput>
<table class="table table-condensed">

<tr style="margin-bottom : 1px solid beige;">
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'expired=0')###find"><cfoutput>#rc.stUserCount.All#</cfoutput></a></big></td>
	<td>All Users</td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring ='ustatus=confirmed')###find"><cfoutput>#rc.stUserCount.Confirmed#</cfoutput></a></big></td>
	<td style="color : green;">Approved</td>
</tr>
<tr style="margin-bottom : 1px solid beige;">
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'recent=1')###find"><cfoutput>#rc.stUserCount.pseudo_Recent#</cfoutput></a></big></td>
	<td>Recently Logged in</td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'uStatus=pending')###find"><cfoutput>#rc.stUserCount.Pending#</cfoutput></a></big></td>
	<td style="color : orange;">Pending</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'uStatus=rejected')###find"><cfoutput>#rc.stUserCount.Rejected#</cfoutput></a></big></td>
	<td style="color : red;">Rejected</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'expired=1')###find"><cfoutput>#rc.stUserCount.Expired#</cfoutput></a></big></td>
	<td>Expired</td>
</tr>
</table>
</cfoutput>
