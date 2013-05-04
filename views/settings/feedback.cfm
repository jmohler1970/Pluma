
<div class="main">

	<h3 class="floated">Feedback Forms</h3>
	
	<cfexit>	
	
	
	<div class="edit-nav clearfix">
		<cfoutput>							
			<a href="#buildURL(action='home.feedback')#" target="_blank">#application.GSAPI.i18n("PLUMACMS/TEST")#</a>
		</cfoutput>
	</div>


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
		
		
		<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
</cfoutput>	
</form>

	
</div>

	