


<div class="main">

	<cfoutput>
	<h3>#application.GSAPI.i18n("tag_summary")#</h3>
	
	<table  class="edittable highlight paginate">
	

	<thead>
	<tr>
		<th>#application.GSAPI.i18n("tag_name")#</th>
		<th>#application.GSAPI.i18n("tags")#</th>
		<th style="text-align : right;">#application.GSAPI.i18n("page_count")#</th>
		<th style="text-align : right;">#application.GSAPI.i18n("tag_rank")#</th>
	</tr>
	</thead>
	</cfoutput>
	
	<cfoutput query="rc.qryTags">
	<tr>

		<td>#Tags#</td>
		
		<td><a href="#application.GSAPI.get_site_root()#index.cfm/tag/#tagslug#" rel="tooltip" title="This leaves the tools area">./index.cfm/tag/#tagslug#</a></td>
		<td style="text-align : right;">#LSNumberFormat(TagCount)#</td>
		<td style="text-align : right;">#taglevel#</td>
		

	</tr>
	</cfoutput>
	</table>

<cfoutput>
	<p><i><b>#rc.qryTags.recordcount#</b> #application.GSAPI.i18n("total_tags")#</i></p>
</cfoutput>

	
</div>	


