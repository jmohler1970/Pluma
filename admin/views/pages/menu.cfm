


<div class="main">

<cfoutput>
	<h3>#application.GSAPI.get_string("menu_manager")#</h3>
</cfoutput>



<cfform action="#buildurl(action = '.menu')#" name="myFrm">

<table class="edittable highlight paginate">

<cfoutput>
<thead>
<tr>
	<th>#application.GSAPI.get_string("sort")#</th>
	<th>#application.GSAPI.get_string("menu_text")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("page_title")#</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
</thead>
</cfoutput>


<cfoutput query="rc.qryMenu">
	<input type="hidden" name="processNodeID" value="#NodeID#" />

<tr>
	<td style="width : 60px;">
		<select class="text" style="width : 60px"  name="menusort_#NodeID#">
			<option value="">-</option>
			
			<cfloop from="1" to="20" index="i">
				<option value="#i#" <cfif menusort EQ i>selected="selected"</cfif>>#i#</option>	
			</cfloop>
		</select>
	</td>
	
	
	<td>#Menu#</td>
	<td style="text-align : right;"><i>#Title#</i></td>
	
	
	

	<td class="secondarylink">
		<a href="#application.GSAPI.get_site_root()#index.cfm/main/#slug#" rel="tooltip" title="View Page" target="_blank"><cfif Root><b>##</b><cfelse>##</cfif></a>
	</td>
</tr>
</cfoutput>
</table>




<cfif rc.qryMenu.recordcount GT 0>
	<cfoutput>
		<button type="submit">#application.GSAPI.get_string("save_menu_order")#</button>
	</cfoutput>
</cfif>

</cfform>



</div>



