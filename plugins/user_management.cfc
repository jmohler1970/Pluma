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
	
	param rc.stUser.contact_license 	= "";
	param rc.stUser.contact_credential	= "";
	param rc.stUser.contact_association = "";
	param rc.stUser.contact_achievement = "";
	param rc.stUser.contact_otherinterest	= "";
	
	
	param rc.stUser.contact_stars 		= 0;
	var maxstars = 2;
	if (rc.stUser.contact_stars > maxstars OR not isnumeric(rc.stUser.contact_stars))
		rc.stUser.contact_stars = maxstars;
	</cfscript>
	

	
	<cfoutput>



	<table>
	<tbody>
	<tr>
		<td><b>Stars</b></td>
		<td>
		<cfloop from="0" to="#maxstars#" index="i">
			

			<input type="radio" name="contact_stars" value="#i#" <cfif rc.StUser.contact_stars EQ i>checked="checked"</cfif> /> #repeatstring("&##9733;", i)# <cfif i EQ 0><i>None</i></cfif>
			<br />
		</cfloop> 
		</td>
	</tr>
	
	
	<tr>
		<td style="text-align : right;">Licenses</td>
		<td colspan="2"><textarea name="contact_license" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.contact_license)#</textarea></td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Credentials</td>
		<td colspan="2"><textarea name="contact_credential" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.contact_credential)#</textarea></td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Associations</td>
		<td colspan="2"><textarea name="contact_association" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.contact_association)#</textarea></td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Achievements</td>
		<td colspan="2"><textarea name="contact_achievement" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.contact_achievement)#</textarea></td>
	</tr>
	
	<tr>
		<td style="text-align : right;">Other Interests</td>
		<td colspan="2"><textarea name="contact_otherinterest" rows="3" cols="80" style="height : 40px;">#htmleditformat(rc.stUser.contact_otherinterest)#</textarea></td>
	</tr>
	

	</cfoutput>

</cffunction>


</cfcomponent>
