


<div class="main">


<cfoutput>
	<h3>#application.GSAPI.i18n("bak_management")#</h3>
</cfoutput>


<cfoutput query="rc.qryArchive" group="shortdate">
<h2>#application.IOAPI.std_date(ShortDate)#</h2>

<table class="edittable highlight paginate">
<thead>
<tr>
	
	<th>#application.GSAPI.i18n("plumacms/page_action")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("archive_date")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("plumacms/changed_by")#</th>
</tr>
</thead>

<tbody>
<cfoutput>
	<tr>
		<td <cfif Root>style="text : bold;"</cfif> class="pagetitle">
			<a href="#buildurl(action='.edit', querystring='nodearchiveid=#nodearchiveid#')#">#Title#
			<cfif title EQ "">#application.GSAPI.i18n("plumacms/no_title")#</cfif>
			</a>
		</td>
		
		<td style="text-align : right;">	
			#application.IOAPI.std_date(VersionDate)# @
			#LSTimeFormat(VersionDate)# 
		</td>
		
		<td style="text-align : right;">#ModifyBy#</td>
		
		<td <cfif Root>style="text : bold;"</cfif> class="delete">
		<cfif NoDelete EQ 0>	
			<a href="#buildURL(action = 'backups.delete', querystring = 'NodeArchiveID=#NodeArchiveID#')#" rel="tooltip" title="Delete Archive">&times;</a>
		</cfif>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>	
</cfoutput>
	


<cfif rc.qryArchive.recordcount EQ 0>
	<p class="alert">#application.GSAPI.i18n("plumacms/no_history")# </p>
</cfif>

</div>

