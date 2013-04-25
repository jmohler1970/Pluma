



<cfoutput>
<table class="table">
<tr>
	<td style="text-align : right;"><big>#rc.stPluginCount.All#</big></td>
	<td>Pages</td>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'pstatus=approved')###find">#rc.stPluginCount.Approved#</a></big></td>
	<td style="color : green;">Approved</td>
</tr>
<tr>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'withaction=1')###find">#rc.stPluginCount.pseudo_FACount#</a></big></td>
	<td>Pages associated with actions</td>
	<td style="text-align : right;"><big><a href="#buildurl(action= 'page.home', querystring = 'pstatus=pending')###find">#rc.stPluginCount.Pending#</a></big></td>
	<td style="color : orange;">Pending</td>
</tr>

<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'pstatus=reject')###find">#rc.stPluginCount.Rejected#</a></big></td>
	<td style="color : red;">Rejected</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'cstatus=0')###find">#rc.stPluginCount.pseudo_Draft#</a></big></td>
	<td>Drafts</td>

</tr>
</table>
</cfoutput>


