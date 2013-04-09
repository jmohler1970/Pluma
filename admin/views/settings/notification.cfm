<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->

<div class="main">
	<h3>Notifications</h3>




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



	<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
	
	</cfoutput>	
	
</form>
	
<p></p>	
	
<p>Notifications send an email to the recipients whenever data has been updated.</p>	
	
	
</div>
