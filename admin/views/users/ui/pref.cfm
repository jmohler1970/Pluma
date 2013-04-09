<!---
Copyright © 2012 James Mohler

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



<cfoutput query="rc.qryUser">

<cfform action="#BuildURL(action = 'users.pref', querystring = 'UserID=#rc.UserID#')#" method="post">

	<legend>Preferences</legend>


	<div class="control-group">
		<label class="control-label" for="membershiptype">Membership type</label>
	    <div class="controls">
	 	
		<select name="membershiptype" class="input-medium">
			<option></option>
			<cfloop index="ii" list="#application.stAdminSetting.Node.lstmembershiptype#">
				<cfoutput>
					<option value="#ii#" <cfif membershiptype EQ ii>selected</cfif>>#ii#</option>
				</cfoutput>
			</cfloop>
		</select>
	    </div>
	</div>


	
<div class="control-group">
	<label class="control-label" for="stars">Stars</label>
		<div class="controls">
			<cfmodule template="stars.cfm" stars = "#stars#" />
		
	   </div>
</div>



	<div class="control-group">
		<label class="control-label" for="php">Personal Page</label>
	    <div class="controls">
	 	 <select name="PHP" class="input-medium">
			<option value="Public"		<cfif PHP EQ "Public">selected</cfif>>Public</option>
			<option value="Community"	<cfif PHP EQ "Community">selected</cfif>>Community Only</option>
			<option value="Private"		<cfif PHP EQ "Private">selected</cfif>>Private</option>
		</select>
	    </div>
	</div>



	<div class="control-group">
		<label class="control-label" for="php">Default Blog Mode</label>
	    <div class="controls">
	 	
		<select name="commentmode" class="input-medium">
			<cfloop index="ii" list="#application.stAdminSetting.Node.lstcommentmode#">
				<cfoutput>
					<option value="#ii#" <cfif commentMode EQ ii>selected</cfif>>#ii#</option>
				</cfoutput>
			</cfloop>
		</select>
	    </div>
	</div>


	<div class="form-actions">
		#strButtons#
	</div>

</cfform>

</cfoutput>