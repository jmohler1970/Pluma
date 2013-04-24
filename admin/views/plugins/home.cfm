

<div class="main">

<cfoutput>
<h3>#application.GSAPI.i18n("plugins_management")#</h3>
</cfoutput>


<cfoutput>
<form action="#buildURL(action = '.home')#" method="post">
</cfoutput>


<table class="table table-condensed table-striped table-hover">

<cfoutput>
<thead>
<tr>
	<th>#application.GSAPI.i18n("status")#</th>
	<th>#application.GSAPI.i18n("plugin_name")#</th>
	<th>#application.GSAPI.i18n("plugin_desc")#</th>
</tr>
</thead>
</cfoutput>

<tbody>
<cfoutput query="application.qryPlugins">

<tr>
	<td>
		<input type="radio" name="plugin_#listfirst(filename, '.')#" value="1" 
			<cfif enabled>checked="checked"</cfif> /> Enabled
		&nbsp; &nbsp;
		<input type="radio" name="plugin_#listfirst(filename, '.')#" value="0" 
			<cfif NOT enabled>checked="checked"</cfif> /> Disabled
			
		
	
	</td>


	<td nowrap="nowrap">#Name#</td>
	<td>#Description#<br />
		<b>Version #Version#</b> - Author: <a href="#author_url#" target="_blank">#author#</a>
	</td>
</tr>

</cfoutput>
</tbody>
</table>

<cfoutput>
	<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
</cfoutput>
</form>	
	

<p>
	<i><cfoutput><b>#application.qryPlugins.recordcount#</b> plugins installed</cfoutput></i>
</p>



</div>
