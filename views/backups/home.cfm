


<div class="main">


<cfoutput>
	<h3 class="floated">#application.GSAPI.i18n("page_backups")#</h3>
	
	
<div class="edit-nav clearfix">
	<a href="##" id="filtertable" accesskey="r">#application.GSAPI.i18n("filter")#</a>
</div>	

<div id="filter-search" style="display : none; ">
	<form>
		<input type="text" autocomplete="off" class="text" id="q" 
			placeholder="#application.GSAPI.strip_tags(application.GSAPI.i18n("filter"))#..." /> 
		&nbsp; <a href="#buildurl('.home')#" class="cancel">#application.GSAPI.i18n("cancel")#</a>
	</form>
</div>

</cfoutput>

<table id="editpages" class="edittable highlight paginate">
<cfoutput query="rc.qryArchive" group="shortdate">

<thead>
<tr>
	<td>
		<h2>#application.IOAPI.std_date(ShortDate)#</h2>
	</td>
	
	
	
	<td colspan="3">
		<div class="edit-nav clearfix">	
		<a class="delconfirm" 
			href="#buildURL(action='.home', querystring='clear=#shortdate#&NodeID=#rc.nodeID#')#"
			title="#application.GSAPI.i18n("API_CONFIRM")#">#application.GSAPI.i18n("ASK_DELETE")#</a>
		</div>	 
	</td>

	


<tr>

	<th>#application.GSAPI.i18n("TITLE")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("archive_date")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("plumacms/changed_by")#</th>
</tr>
</thead>

<tbody>
<cfoutput>
	<tr>
	
		<td <cfif Root>style="text : bold;"</cfif> title="#application.GSAPI.find_url(slug)#" class="pagetitle">#Title#
			<cfif title EQ "">#application.GSAPI.i18n("plumacms/no_title")#</cfif>
		</td>
		
		<td style="text-align : right;">
			<span>	
			<a href="#buildurl(action='.edit', querystring='nodearchiveid=#nodearchiveid#')#">
			#application.IOAPI.std_date(VersionDate)# @
			#LSTimeFormat(VersionDate)#
			</a>
			</span> 
		</td>
		
		<td style="text-align : right;"><span>#ModifyBy#</span></td>
		
		<td <cfif Root>style="text : bold;"</cfif> class="delete">
			<a class="delconfirm"
				href="#buildURL(action = 'backups.delete', querystring = 'NodeArchiveID=#NodeArchiveID#')#" rel="tooltip" 
				title="#application.GSAPI.i18n("PLUMACMS/SURE_LONG", ["this archive"])#">&times;</a>
		
		</td>
	</tr>
</cfoutput>
</tbody>
	
</cfoutput>

</table>	


<cfoutput>
	<p><em><b>#rc.qryArchive.recordcount#</b> #application.GSAPI.i18n("PAGE_BACKUPS")#</em></p>
</cfoutput>


</div>

