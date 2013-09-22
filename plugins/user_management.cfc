<cfcomponent>

<cfscript>
thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");



function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
	'PlumaCMS user management Language',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'Supports UI for management of multiple users. If this is shutdown PlumaCMS allows all users to access site.',
	'',
	'',
	'icon-heart');
	
	application.GSAPI.add_filter("content", "user_management", "profile");
	
	application.GSAPI.add_action("settings-user-extras", "settings_user_extras",["user_management"]);
	
	}	
</cfscript>



<cffunction name="profile" output="false">
	<cfargument name="strIn" type="string" required="true">
	<cfargument name="rc" type="struct" required="true">
	



	<cfreturn strIn>
</cffunction>




<cffunction name="settings_user_extras">
	<cfargument name="rc" type="struct" required="true">
	
	<cfscript>
	param rc.stUser = {};
	
	param rc.stUser.profile_license 	= "";
	param rc.stUser.profile_credential	= "";
	param rc.stUser.profile_association = "";
	param rc.stUser.profile_achievement = "";
	param rc.stUser.profile_otherinterest	= "";
	
	
	param rc.stUser.profile_stars 		= 0;
	var maxstars = 2;
	if (rc.stUser.profile_stars > maxstars OR not isnumeric(rc.stUser.profile_stars))
		rc.stUser.profile_stars = maxstars;
	</cfscript>
	

	
	<cfoutput>


	<!--- This fits inside of an outer table --->	
	<tr>
		<td><b>Stars</b></td>
		<td>
		<cfloop from="0" to="#maxstars#" index="i">
			

			<input type="radio" name="profile_stars" value="#i#" <cfif rc.StUser.profile_stars EQ i>checked="checked"</cfif> /> #repeatstring("&##9733;", i)# <cfif i EQ 0><i>None</i></cfif>
			<br />
		</cfloop> 
		</td>
	</tr>
	
	
	<tr>
		<td style="text-align : right;">Licenses</td>
		<td>
			<input name="profile_license_title" type="hidden" value="Licenses" />
		
			<textarea name="profile_license" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.profile_license)#</textarea>
		</td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Credentials</td>
		<td>
			<input name="profile_credential_title" type="hidden" value="Credentials" />
		
			<textarea name="profile_credential" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.profile_credential)#</textarea>
		</td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Associations</td>
		<td>
			<input name="profile_association_title" type="hidden" value="Associations" />
				
			<textarea name="profile_association" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.profile_association)#</textarea>
		</td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Achievements</td>
		<td>
			<input name="profile_achievement_title" type="hidden" value="Achievements" />
				
			<textarea name="profile_achievement" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.profile_achievement)#</textarea>
		</td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Other Interests</td>
		<td>
			<input name="profile_otherinterest_title" type="hidden" value="Other Interests" />
				
			<textarea name="profile_otherinterest" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.profile_otherinterest)#</textarea>
		</td>
	</tr>
	

	</cfoutput>

</cffunction>


</cfcomponent>
