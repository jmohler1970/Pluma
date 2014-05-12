

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
<cfoutput query="request.qryPlugins">

<tr>
	<td nowrap="nowrap">
		<input type="radio" name="plugin_status.#listfirst(filename, '.')#" value="1" 
			<cfif enabled>checked="checked"</cfif> /> #application.GSAPI.i18n("Enable")#
		&nbsp; &nbsp;
		<input type="radio" name="plugin_status.#listfirst(filename, '.')#" value="0" 
			<cfif NOT enabled>checked="checked"</cfif> /> #application.GSAPI.i18n("Disable")#
			
		
	
	</td>


	<td nowrap="nowrap">#Name#</td>
	<td>#Description#<br />
		<b>#application.GSAPI.i18n("PLUGIN_VER")# #Version#</b> - 
		#application.GSAPI.i18n("AUTHOR")#: <a href="#author_url#" target="_blank">#author#</a>
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
	<i><cfoutput><b>#request.qryPlugins.recordcount#</b> #application.GSAPI.i18n("plugins_installed")#.</cfoutput></i>
</p>




</div>
