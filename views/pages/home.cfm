

<!--- Yes this goes before class="main" --->
<cfoutput>#application.GSAPI.exec_action("pages-main")#</cfoutput>
<div class="main">


<cfoutput>
<h3 class="floated">#application.GSAPI.i18n("page_management")#</h3>



<div class="edit-nav clearfix">
	<a href="##" id="filtertable" accesskey="r">#application.GSAPI.i18n("filter")#</a>
	
	<a href="##" id="show-characters" accesskey="u">#application.GSAPI.i18n("toggle_status")#</a>
</div>	



<div id="filter-search" style="display : none; ">
	<form>
		<input type="text" autocomplete="off" class="text" id="q" 
			placeholder="#application.GSAPI.strip_tags(application.GSAPI.i18n("filter"))#..." /> 
		&nbsp; <a href="#buildurl('.home')#" class="cancel">#application.GSAPI.i18n("cancel")#</a>
	</form>
</div>


</cfoutput>			


<cfoutput>
<table id="editpages" class="edittable highlight paginate">
<tr>
	<th>#application.GSAPI.i18n("page_title")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("date")#</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
</cfoutput>



<tbody>
<cfoutput query="rc.qryAllPages">
<tr id="tr-#slug#">
	<td <cfif Root>style="text : bold;"</cfif> class="pagetitle">
		<cfloop from="1" to="#level#" index="i">
			<span>&nbsp; &nbsp; &mdash; &nbsp; &nbsp; </span>
		</cfloop>
	
	
		<cfif Kind EQ "Page">
			<a href="#BuildURL(action = 'pages.edit', querystring = 'NodeID=#NodeID#')#"
			title="#application.GSAPI.i18n("editpage_title")#"><cfif Root><b>#xmlformat(title)#</b><cfelse>#xmlformat(title)#</cfif> 
			<cfif title EQ "">#application.GSAPI.i18n("plumacms/notitle")#</cfif></a>
		<cfelse>
			<a title="Edit Page" href="#BuildURL(action = 'plugins.edit', querystring = 'NodeID=#NodeID#')#"><cfif Root><b>#xmlformat(title)#</b><cfelse>#xmlformat(title)#</cfif>
			<cfif title EQ "">#application.GSAPI.i18n("plumacms/notitle")#</cfif>
			</a>
		</cfif>
		
		<span class="showstatus toggle" style="display : none;">
			<cfif Root><sup>[#application.GSAPI.i18n("homepage_subtitle")#]</sup></cfif>	
			<cfif MenuStatus EQ 1><sup>[#application.GSAPI.i18n("menuitem_subtitle")#]</sup></cfif>
			<cfif pStatus NEQ "Public"><sup>[#application.GSAPI.i18n("private_subtitle")#]</sup></cfif>
			
		</span>
	</td>

	<td style="text-align : right;"><span>#application.IOAPI.std_date(ModifyDate)#</span></td>
	<td class="secondarylink">
	
		<a href="#application.GSAPI.find_url(slug)#" rel="tooltip" 
			title="#application.GSAPI.i18n("viewpage_title")#" target="_blank"><cfif Root><b>##</b><cfelse>##</cfif></a>
	
	</td>	
	<td class="delete">
		<cfif NoDelete EQ 0>	
			<a class="delconfirm" href="#buildURL(action = 'pages.delete', querystring = 'NodeID=#NodeID#')#" rel="tooltip"
				title="#application.GSAPI.i18n("delete_file")#" id="delete-#slug#">&times;</a>
		</cfif>
	</td>
</tr>
</cfoutput>
<cfif rc.qryAllPages.recordcount EQ 0>
<tr>
	<td colspan="8"><i>Sorry, no matches</i></td>
</tr>
</cfif>
</tbody>



</table>


<cfoutput>
	<p><i><b>#rc.qryAllPages.recordcount#</b> #application.GSAPI.i18n("total_pages")#</i></p>
</cfoutput>


</div>
