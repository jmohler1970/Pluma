

<div class="main">


<h3>Text Search Settings</h3>

<cfoutput>
<form action="#rc.xa.search#" method="post">

<table id="editpages" class="edittable highlight paginate">

<tr>
	<td>Search User Profiles</td>
	<td>
		<input type="checkbox" name="search.profile" value="1" <cfif rc.search.profile>checked="checked"</cfif> />
	</td>	
</tr>

<tr>
	<td>Max results</td>
	<td>
		<input type="text" name="search.max" style="width:3em" class="text" value="#rc.search.max#" />
	</td>	
</tr>
<tr>
	<td>Letters to show</td>
	<td>
		<input type="text" name="search.letters" style="width:3em" class="text" value="#rc.search.letters#" />
	</td>
</tr>	

<tr>
	<td>Show parent page</td>
	<td><input type="checkbox" name="search.parentpage" value="1" <cfif rc.search.parentpage>checked="checked"</cfif> /></td>	
</tr>	

<tr>
	<td>Show tags</td>
	<td><input type="checkbox" name="search.tags" 		value="1" <cfif rc.search.tags>checked="checked"</cfif> /></td>	
</tr>	

<tr>
	<td>Show publish date</td>
	<td><input type="checkbox" name="search.publishdate" value="1" <cfif rc.search.publishdate>checked="checked"</cfif> /></td>	
</tr>	

<tr>
	<td>Show rank</td>
	<td><input type="checkbox" name="search.rank" 		value="1" <cfif rc.search.rank>checked="checked"</cfif> /></td>	
</tr>

</table>

	<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>

</form>


<p></p>


	<h3>Search Index</h3>
	<p>Rebuild Text search index. You may want do this after making lots of changes</p>


	<form action="#rc.xa.reindex#" method="post">
		<button type="submit" name="submit">#application.GSAPI.i18n("plumacms/REINDEX")#</button>
	</form>
</cfoutput>


</div>
