
<cfoutput>


<div class="main">

	<h3 class="floated">#application.GSAPI.i18n("PLUMACMS/Error404_settings")#</h3>


	<div class="edit-nav clearfix">
		<a href="#rc.xa.error404#" target="_blank" accesskey="v">#application.GSAPI.i18n("SIDE_VIEW_LOG")#</a>
	
		<a href="#rc.xa.missing#">#application.GSAPI.i18n("PLUMACMS/TEST")#</a>
	</div>




<form action="#rc.xa.error404#" method="post">



	<h2>#application.GSAPI.i18n("LOG")#</h2>
	
	
	<p>
		<input type="checkbox" name="err.uselog" value="1" <cfif rc.err.uselog>checked="checked"</cfif> />
		
		<b>#application.GSAPI.i18n("PLUMACMS/USELOG")#</b>
	</p>
	
	
	<h2>#application.GSAPI.i18n("PLUMACMS/SEND_EMAIL")#</h2>
	
	<p>
		<b>#application.GSAPI.i18n("PLUMACMS/SUBJECT")#</b>
		<br />
		<input type="text" name="err.subject" class="text" placeholder="Who wrote this" value="#xmlformat(rc.err.subject)#" />
	</p>


	
	<b>#application.GSAPI.i18n("PLUMACMS/TO")#</b>
</cfoutput>	
		<table>
		<cfoutput query="request.qrySystemAdmin">
			<tr>
				<td><input type="checkbox" name="err.sysAdminEmail" value="#email#" 
					<cfif listFind(rc.err.SysAdminEmail, email) NEQ 0>checked = "checked"</cfif>
					<cfif email EQ "">disabled="disabled"</cfif>
					/>
				</td>
				<td>#given# #family#</td>
				<td>#email#</td>
			</tr>
		</cfoutput>
		</table>

		<cfoutput>
		<p>
			<b>#application.GSAPI.i18n("PLUMACMS/ADDITIONAL_EMAIL")#</b>
			<br />
				<input type="text" class="text" name="err.Email" placeholder="john.smith@example.org" value="#xmlformat(rc.err.Email)#" />
			
		</p>
		
		

		<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
	</cfoutput>	

</form>


</div>
