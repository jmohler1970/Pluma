


<cfoutput>
<table class="table">
<tr>
	<td><big>#rc.stEventCount.All#</big></td>
	<td>Events</td>
	<td style="text-align : right;"><big>#rc.stEventCount.pseudo_Draft#</big></td>
	<td>Draft Events</td>
</tr>

<tr style="margin-bottom : 1px solid beige;">
	<td><big></big></td>
	<td></td>
	<td style="text-align : right;"><big>#rc.stEventCount.Approved#</big></td>
	<td style="color : green;">Published Events</td>
</tr>
<tr style="margin-bottom : 1px solid beige;">
	<td><big></big></td>
	<td></td>
	<td style="text-align : right;"><big>#rc.stEventCount.Pending#</big></td>
	<td style="color : orange;">Pending Events</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big>#rc.stEventCount.Rejected#</big></td>
	<td style="color : red;">Rejected Events</td>
</tr>
</table>
</cfoutput>

