
<div class="main">
<cfoutput> 
	<h3 class="floated">Backup of '<em>#rc.qryArchive.slug#</em>'</h3>


	


		<div class="edit-nav" >

			
			<a href="#buildURL(action = 'backups.restore', querystring = 'NodeArchiveID=#rc.NodeArchiveID#')#" rel="tooltip"  accesskey="r"><em>R</em>estore</a>			 
			 
			<a href="#buildURL(action = 'backups.delete', querystring = 'NodeArchiveID=#rc.NodeArchiveID#')#" rel="tooltip" title="Delete Archive" id="delback" accesskey="d" class="delconfirm noajax" ><em>D</em>elete</a>
		

			<div class="clear"></div>
		</div>
	 </cfoutput>
		

<cfform>

	<cfoutput query="rc.qryArchive">		
	<table class="simple highlight" >
		<tr><td class="title" >Page Title:</td><td><b>#title#</b> </td></tr>
		<tr>
			<td class="title" >Backup of:</td>
			<td>
			<a target="_blank" href="#application.GSAPI.get_site_root()#index.cfm/main/#slug#">#application.GSAPI.get_site_root()#index.cfm/main/#slug#</a>
			</td>
		</tr>
		<tr>
			<td class="title" >Date:</td>
			<td>#application.GSAPI.std_date(VersionDate)# @
			#LSTimeFormat(VersionDate)# </td>
		</tr>
		<tr><td class="title" >Tags &amp; Keywords:</td><td><em>#tags#</em></td></tr>
		
		<tr><td class="title" >Menu Text:</td><td>#menu#</td></tr>
		<tr><td class="title" >Priority:</td><td>#menusort#</td></tr>
		<tr><td class="title" >Add this page to the menu</td><td>#yesnoformat(menustatus)#</td></tr>
	</table>


	<cftextarea name="strData" richtext="true" toolbar="Basic"  height="500" width="740">#strData#</cftextarea>


	</cfoutput>
</cfform>


</div>