

<div class="main">


<h3>Text Search Settings</h3>

<cfoutput>
<form action="#buildURL(action = 'settings.search')#" method="post">

<table id="editpages" class="edittable highlight paginate">

<tr>
	<td>Search User Profiles</td>
	<td>
		<input type="checkbox" name="search_profile" value="1" <cfif rc.search_profile EQ 1>checked="checked"</cfif> />
	</td>	
</tr>

<tr>
	<td>Max results</td>
	<td>
		<input type="text" name="search_max" style="width:3em" class="text" value="#rc.search_max#" />
	</td>	
</tr>
<tr>
	<td>Letters to show</td>
	<td>
		<input type="text" name="search_letters" style="width:3em" class="text"  value="#rc.search_letters#" />
	</td>
</tr>	

<tr>
	<td>Show parent page</td>
	<td><input type="checkbox" name="search_parentpage" value="1" <cfif rc.search_parentpage EQ 1>checked="checked"</cfif> /></td>	
</tr>	

<tr>
	<td>Show tags</td>
	<td><input type="checkbox" name="search_tags" value="1"  <cfif rc.search_tags EQ 1>checked="checked"</cfif> /></td>	
</tr>	

<tr>
	<td>Show publish date</td>
	<td><input type="checkbox" name="search_publishdate" value="1" <cfif rc.search_publishdate EQ 1>checked="checked"</cfif> /></td>	
</tr>	

<tr>
	<td>Show rank</td>
	<td><input type="checkbox" name="search_rank" value="1" <cfif rc.search_rank EQ 1>checked="checked"</cfif> /></td>	
</tr>

</table>

	<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>

</form>


<p></p>


	<h3>Search Index</h3>
	<p>Rebuild Text search index. You may want do this after making lots of changes</p>


	<form action="#buildURL(action = 'settings.reindex')#" method="post">
		<button type="submit" name="submit">#application.GSAPI.i18n("plumacms/REINDEX")#</button>
	</form>
</cfoutput>


</div>
