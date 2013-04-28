


<cfimport prefix="ui" taglib="ui">


<div class="main">


<cfoutput>
<h3 class="floated">#application.GSAPI.i18n("user_management/title")#</h3>
</cfoutput>

<script type="text/javascript">
	function toggleFilter()	{
				
		isSet = showFilter.style.display;
		
		showFilter.style.display = isSet == "" ?  "none" : "";
		}
</script>


<cfoutput>
<div class="edit-nav clearfix">
	<a href="##" id="filtertable" accesskey="r">#application.GSAPI.i18n("filter")#</a>
	
	<a href="##" id="show-characters" accesskey="u">#application.GSAPI.i18n("toggle_status")#</a>
</div>



<div id="filter-search" style="display: none; ">
	<form>
		<input type="text" autocomplete="off" class="text" id="q" placeholder="filter..." /> &nbsp; <a href="#buildurl('.home')#" class="cancel">#application.GSAPI.i18n("cancel")#</a>
	</form>
</div>
		
</cfoutput>



<table id="editpages" class="edittable highlight paginate">

<cfoutput>
<thead>
<tr>
	<th>#application.GSAPI.i18n("label_username")#</th>
	<th>#application.GSAPI.i18n("label_email")#</th>
	<th>Permission</th>
	<th>#application.GSAPI.i18n("USER_LAST_LOGIN")#</th>
	<th>#application.GSAPI.i18n("expiration")#</th>
	<th>&nbsp;</th>
	<th>#application.GSAPI.i18n("renew")#</th>
	<th>&nbsp;</th>
</tr>
</thead>
</cfoutput>


<tbody>

<cfoutput query="rc.qryUser">
<tr>


	<td class="pagetitle">
		<a href="#buildURL(action = 'users.edit', querystring = 'UserID=#UserID#')#">
		<cfif groups CONTAINS "system">
		<b>
			#firstname# #lastname#
			<cfif firstname EQ "" AND lastname EQ ""><i>None</i></cfif>
		</b>
		<cfelse>
			#firstname# #lastname#
			<cfif firstname EQ "" AND lastname EQ ""><i>None</i></cfif>
		</cfif>
		
			
		#postfix#
		</a>
	
		<cfif groups NEQ "">
		<span class="showstatus toggle" style="display : none;">
			<sup>[#groups#]</sup>	
		</span>
		</cfif>
	
		 
		
		<cfif isDate(CreateDate) AND DateDiff("d", CreateDate, now()) LT 30>
			<b style="color : green;">New!</b>
		</cfif>
	</td>
	

	<td><a href="mailto:#email#">#Email#</a></td>
	<td>#groups#</td>
	<td><cfif isDate(lastLogin)>#application.IOAPI.std_date(lastLogin)#</cfif></td>
	<td><cfif isDate(ExpirationDate)>#application.IOAPI.std_date(ExpirationDate)#<cfelse><i>Never</i></cfif></td>
	
	
	
	<td class="secondarylink">
		
			<cfif NOT active OR homepath NEQ "">
			<a
				href="/index.cfm/profile/#homepath#" 
				rel="tooltip" title="View profile page. This leaves the tools area">##</a>
			</cfif>
	</td>
		
	<td>	
		<a href="#buildURL(action = 'users.renew', querystring = 'UserID=#UserID#')#">Add 1 Year</a>
	</td>	
		
	<td class="delete">	
		<cfif NOT groups CONTAINS "system">	
			<a href="#buildURL(action = 'users.delete', querystring = 'UserID=#UserID#')#" onclick="return alert('Are you sure you want to delete this?')">&times;</a>
		</cfif>			
	</td>

</tr>
</cfoutput>
</tbody>


</table>



<cfoutput>
	<p><i><b>#rc.qryUser.recordcount#</b> total users</i></p>
</cfoutput>


</div>








