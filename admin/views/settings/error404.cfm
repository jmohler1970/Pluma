

<div class="main">

<h3>404 Error Settings</h3>

<cfoutput>
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
		
		

		<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
	</cfoutput>	

</form>


</div>
