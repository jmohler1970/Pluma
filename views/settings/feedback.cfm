
<cfoutput>							
<div class="main">

	<h3 class="floated">#application.GSAPI.i18n("PLUMACMS/FEEDBACK_SETTINGS")#</h3>
	

	
	
	<div class="edit-nav clearfix">
			<a href="#rc.xa.feedback_test#" target="_blank">#application.GSAPI.i18n("PLUMACMS/TEST")#</a>
		
	</div>


<form action="#rc.xa.feedback#" method="post">
</cfoutput>
		
		

	<p>
		<b>Subject</b>
		<br />
		<cfoutput>
			<input type="text" name="feedback.subject" class="text" placeholder="Who wrote this" value="#xmlformat(rc.feedback.subject)#" />
		</cfoutput>
	</p>
	
	<b>To:</b>
		<table>
		<cfoutput query="request.qrySystemAdmin">
			<tr>
				<td><input type="checkbox" name="feedback.sysAdminEmail" value="#email#" 
					<cfif listFind(rc.feedback.SysAdminEmail, email) NEQ 0>checked="checked"</cfif>
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
			<b>Additional Email</b>
			<br />
				<input type="text" class="text" name="feedback.Email" placeholder="john.smith@example.org" value="#xmlformat(rc.feedback.Email)#" />
			
		</p>
		
		
		<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
</cfoutput>	
</form>

	
</div>

	