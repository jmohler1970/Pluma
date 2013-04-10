
<div class="main">

	<h3>Feedback Forms</h3>
	


<cfoutput>
<form action="#buildURL(action = '.feedback')#" method="post">
</cfoutput>
	
	
		

	<p>
		<b>Subject</b>
		<br />
		<cfoutput>
			<input type="text" name="feedback_subject" class="text" placeholder="Who wrote this" value="#htmleditformat(rc.feedback_subject)#" />
		</cfoutput>
	</p>
	
	<b>To:</b>
		<table>
		<cfoutput query="request.qrySystemAdmin">
			<tr>
				<td><input type="checkbox" name="feedback_sysAdminEmail" value="#email#" 
					<cfif listFind(rc.feedback_SysAdminEmail, email) NEQ 0>checked="checked"</cfif>
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
				<input type="text" class="text" name="feedback_Email" placeholder="john.smith@example.org" value="#htmleditformat(rc.feedback_Email)#" />
			
		</p>
		
		
		<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
</cfoutput>	
</form>

	
</div>

	