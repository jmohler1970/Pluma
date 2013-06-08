
<cfoutput>							
<div class="main">

	<h3 class="floated">#application.GSAPI.i18n("PLUMACMS/FEEDBACK_SETTINGS")#</h3>
	

	
	
	<div class="edit-nav clearfix">
			<a href="#buildURL(action='home.feedback')#" target="_blank">#application.GSAPI.i18n("PLUMACMS/TEST")#</a>
		
	</div>


<form action="#buildURL(action = '.feedback')#" method="post">
</cfoutput>
	
	
		

	<p>
		<b>Subject</b>
		<br />
		<cfoutput>
			<input type="text" name="feedback_subject" class="text" placeholder="Who wrote this" value="#xmlformat(rc.feedback_subject)#" />
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
				<td>#given# #family#</td>
				<td>#email#</td>
			</tr>
		</cfoutput>
		</table>

		
		<cfoutput>
		<p>
			<b>Additional Email</b>
			<br />
				<input type="text" class="text" name="feedback_Email" placeholder="john.smith@example.org" value="#xmlformat(rc.feedback_Email)#" />
			
		</p>
		
		
		<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
</cfoutput>	
</form>

	
</div>

	