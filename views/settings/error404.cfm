
<cfoutput>


<div class="main">

	<h3 class="floated">#application.GSAPI.i18n("PLUMACMS/Error404_settings")#</h3>


	<div class="edit-nav clearfix">
		<a href="#buildURL(action='home.missing')#">#application.GSAPI.i18n("PLUMACMS/TEST")#</a>
	</div>




<form action="#buildURL(action = '.error404')#" method="post">
</cfoutput>


	<p>
		<b>Subject</b>
		<br />
		<cfoutput>
			<input type="text" name="err_subject" class="text" placeholder="Who wrote this" value="#htmleditformat(rc.err_subject)#" />
		</cfoutput>
	</p>
	
	<b>To:</b>
		<table>
		<cfoutput query="request.qrySystemAdmin">
			<tr>
				<td><input type="checkbox" name="err_sysAdminEmail" value="#email#" 
					<cfif listFind(rc.err_SysAdminEmail, email) NEQ 0>checked = "checked"</cfif>
					<cfif email EQ "">disabled="disabled"</cfif>
					/>
				</td>
				<td>
					#firstname# #lastname#
				</td>
				<td>
				#email#
				</td>
			</tr>
		</cfoutput>
		</table>

		<cfoutput>
		<p>
			<b>Additional Email</b>
			<br />
				<input type="text" class="text" name="err_Email" placeholder="john.smith@example.org" value="#htmleditformat(rc.err_Email)#" />
			
		</p>
		
		

		<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
	</cfoutput>	

</form>


</div>
