
<div class="main">
	<h3 class="floated">Notifications</h3>


	<div class="edit-nav clearfix">
		<cfoutput>							
		<a href="#buildURL(action='settings.notificationtest')#"> Test</a>
		</cfoutput>
	</div>

<cfoutput>
<form action="#buildURL(action = '.notification')#" method="post" class="anondata">
</cfoutput>


			
		<p class="clearfix">
			<label>Message Level</label>
			<cfoutput>
				<select name="notif_level">
					<option value="3" <cfif rc.notif_level EQ "3">selected="selected"</cfif> >Fatal</option>
					<option value="2" <cfif rc.notif_level EQ "2">selected="selected"</cfif> >Error</option>
					<option value="1" <cfif rc.notif_level EQ "1">selected="selected"</cfif> >Warning</option>
					<option value="0" <cfif rc.notif_level EQ "0">selected="selected"</cfif> >Info</option>
					<option value="-1" <cfif rc.notif_level EQ "-1">selected="selected"</cfif> >Debug</option>
				</select>
			</cfoutput>
		</p>

		
		<p class="clearfix">
			<label>Subject</label>
		
			<cfoutput>
				<input type="text" name="notif_subject" class="text" placeholder="Subject of email" value="#htmleditformat(rc.notif_subject)#" />
			</cfoutput>
		</p>
		
		<b>To:</b>
		<table>
		<cfoutput query="request.qrySystemAdmin">
			<tr>
				<td><input type="checkbox" name="notif_sysAdminEmail" value="#email#" 
					<cfif listFind(rc.notif_SysAdminEmail, email) NEQ 0>checked="checked"</cfif>
					/></td>
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
	
		<p class="clearfix">
			<label>CC:</label>
			<br />
				<input type="text" class="text" name="notif_email" placeholder="john.smith@example.org" value="#htmleditformat(rc.notif_email)#" />
		
		</p>


	<h3 class="floated">	
		<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
	</h3>
	

	
	</cfoutput>	
	
</form>
	
<p></p>	
	
<p>Notifications send an email to the recipients whenever data has been updated.</p>	
	
	
</div>
