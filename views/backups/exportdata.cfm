

<div class="main">

<h3>Export Data</h3>


<cfoutput>
<form action="#buildURL(action='.exportdata')#" method="post" class="anondata">
</cfoutput>

<p class="clearfix">
	<label>Page</label>


		<select name="ExportNodeID"  class="text autowidth">
			<option value=""> -- Pick One</option>
			
			<cfoutput query="rc.qryAllPages">
				<option value="#NodeID#">#xmlformat(Title)#</option>
			</cfoutput>
			
		</select>
</p>


	
<cfoutput>	
	<button type="submit" name="submit" class="submit">Export</button>
</cfoutput>

</form>




<cfif rc.slug NEQ "">
<div class="edit-nav clearfix">
	<cfoutput>
	<a href="/backups/#rc.slug#.xml" accesskey="d" target="_blank"><em>D</em>ownload</a>
	</cfoutput>
</div>	
</cfif>




</div>