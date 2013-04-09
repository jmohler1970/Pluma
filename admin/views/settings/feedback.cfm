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

	