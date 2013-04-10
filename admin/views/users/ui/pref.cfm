


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