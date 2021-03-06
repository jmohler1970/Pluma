
<div class="main">
	<h3 class="floated">Notifications</h3>


	<div class="edit-nav clearfix">
		<cfoutput>							
		<a href="#rc.xa.notification_test#">#application.GSAPI.i18n("PLUMACMS/TEST")#</a>
		</cfoutput>
	</div>

<cfoutput>
<form action="#rc.xa.notification#" method="post" class="anondata">
</cfoutput>


			
		<p class="clearfix">
			<label>Message Level</label>
			<cfoutput>
				<select name="notif.level">
					<option value="3" <cfif rc.notif.level EQ "3">selected="selected"</cfif> >Fatal</option>
					<option value="2" <cfif rc.notif.level EQ "2">selected="selected"</cfif> >Error</option>
					<option value="1" <cfif rc.notif.level EQ "1">selected="selected"</cfif> >Warning</option>
					<option value="0" <cfif rc.notif.level EQ "0">selected="selected"</cfif> >Info</option>
					<option value="-1" <cfif rc.notif.level EQ "-1">selected="selected"</cfif> >Debug</option>
				</select>
			</cfoutput>
		</p>

		
		<p class="clearfix">
			<label>Subject</label>
		
			<cfoutput>
				<input type="text" name="notif.subject" class="text" placeholder="Subject of email" value="#xmlformat(rc.notif.subject)#" />
			</cfoutput>
		</p>
		
		<b>To:</b>
		<table>
		<cfoutput query="request.qrySystemAdmin">
			<tr>
				<td><input type="checkbox" name="notif.sysAdminEmail" value="#email#" 
					<cfif listFind(rc.notif.SysAdminEmail, email) NEQ 0>checked="checked"</cfif>
					<cfif email EQ "">disabled="disabled"</cfif>
					/></td>
				<td>#given# #family#</td>
				<td>#email#</td>
			</tr>
		</cfoutput>
		</table>


		
		
		<cfoutput>
	
		<p class="clearfix">
			<label>CC:</label>
			<br />
				<input type="text" class="text" name="notif.email" placeholder="john.smith@example.org" value="#xmlformat(rc.notif.email)#" />
		
		</p>


	<h3 class="floated">	
		<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
	</h3>
	

	
	</cfoutput>	
	
</form>
	
<div class="clear"></div>
	
<p>Notifications send an email to the recipients whenever data has been updated.</p>	
	
	
</div>
