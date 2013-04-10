


<tbody id="change2">
<cfoutput query="rc.qryMatchList">
<tr>
	<td>#Kind#</td>
	<td style="text-align : right;"><a href="#BuildURL(action = '.edit', querystring = 'NodeID=#NodeID#')#">#NodeID#</a></td>
	<td>#htmleditformat(title)#</td>
	<td>#slug#</td>
	<td>#pStatus#</td>
	
	<td style="text-align : center;">
	<cfif slug NEQ "">
		<a href="#buildURL(action = 'traffic.details', querystring = 'slud=#rc.slug#')#"><i class="icon-road"></i></a>
	</cfif>
	</td>
	
	<td>#group#</td>
	<td style="text-align : center;">
		#ModifyBy# @ #application.GSAPI.stdDate(ModifyDate)#
	</td>
	<td>
		<div class="btn-group">
			<a class="btn" 
				href="/index.cfm/page/#NodeID#" 
				rel="tooltip" title="This leaves the tools area"><i class="icon-share-alt"></i> View</a>
			<a class="btn btn-success" 
				href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#NodeID#')#"><i class="icon-pencil"></i> Edit</a>
		
		</div>
	</td>	
</tr>
</cfoutput>
<cfif rc.qryMatchList.recordcount EQ 0>
<tr>
	<td colspan="8"><i>Sorry, no matches</i></td>
</tr>
</cfif>
</tbody>