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
	
	application.GSAPI.add_action("settings-user-extras", "settings_user_extras",["user_management"]);
	
	}	
</cfscript>




<cffunction name="settings_user_extras">
	<cfargument name="rc" required="true" type="struct">
	
	<cfscript>
	param rc.stUser = {};
	param rc.stUser.firstname 			= "";
	param rc.stUser.lastname 			= "";
	param rc.stUser.postfix 			= "";
	
	
	param rc.stUser.contact_company 	= "";
	param rc.stUser.contact_title 		= "";
	param rc.stUser.contact_address 	= "";
	param rc.stUser.contact_city 		= "";
	param rc.stUser.contact_state 		= "";
	param rc.stUser.contact_postalcode 	= "";
	param rc.stUser.contact_email 		= "";
	param rc.stUser.contact_officetel 	= "";
	param rc.stUser.contact_celltel 	= "";
	param rc.stUser.contact_faxtel 		= "";
	
	param rc.stUser.contact_license 	= "";
	param rc.stUser.contact_credential	= "";
	param rc.stUser.contact_association = "";
	param rc.stUser.contact_achievement = "";
	param rc.stUser.contact_otherinterest	= "";
	
	
	param rc.stUser.contact_stars 		= "";
	var maxstars = 2;
	if (attributes.stars > maxstars OR not isnumeric(rc.stUser.contact_stars))
		rc.stUser.stars = maxstars;
	</cfscript>
	

	<h3>vCard</h3>
	
	<cfoutput>
	<table class="cleantable">
	<tbody>
	<tr>
	  <td style="width:33%"><b>First Name</b></td>
	  <td><input type="text" name="firstname" class="text" style="width:250px;" value="#htmleditformat(rc.stUser.firstname)#" /></td>
	</tr>
	<tr>
	  <td><b>Last Name</b></td>
	  <td><input type="text" name="lastname" class="text" style="width:250px;" value="#htmleditformat(rc.stUser.lastname)#" /></td>
	</tr>
	<tr>
	  <td><b>Credentials</b></td>
	  <td><input type="text" name="postfix" class="text" style="width:250px;" 	value="#htmleditformat(rc.stUser.postfix)#" /></td>
	</tr>
	<!--- above are pre wired --->
	
	<!--- below are not --->
	<tr>
		<td><b>Stars</b></td>
		<td>
		<cfloop from="0" to="#maxstars#" index="i">
			<cfset ii = i == 0 ? "" : i>
		

			<input type="radio" name="stars" value="#i#" <cfif attributes.stars EQ ii>checked="checked"</cfif> /> #repeatstring("&##9733;", i)# <cfif i EQ 0><i>None</i></cfif>
			<br />
		</cfloop> 
		</td>
	</tr>
	<tr>
	  <td><b>Company</b></td>
	  <td><input type="text" name="contact_company" class="text" style="width:250px;" value="#htmleditformat(rc.stUser.contact_company)#" /></td>
	</tr>
	<tr>
	  <td><b>Title</b></td>
	  <td><input type="text" name="contact_title" class="text" style="width:250px;" value="#htmleditformat(rc.stUser.contact_title)#"></td>
	</tr>
	
	<tr>
	  <td><b>Work Address</b></td>
	  <td><input type="text" name="contact_address" class="text" style="width:250px;" value="#htmleditformat(rc.stUser.contact_address)#"><br>
	  <span>Street Name</span></td>
	</tr>
	<tr>
	  <td></td>
	  <td>
	    <table class="cleantable" style="width:260px;padding:0;margin:0;"><tbody><tr>
	    	<td style="padding-left:0px;"><input type="text" name="contact_city" class="text" style="width:130px;" value="#htmleditformat(rc.stUser.contact_city)#"><br><span>City</span></td>
	    	<td><input type="text" name="contact_state" class="text" style="width:20px;" value="#htmleditformat(rc.stUser.contact_state)#"><br><span>State</span></td>
	    	<td><input type="text" name="contact_postalcode" class="text" style="width:55px;" value="#htmleditformat(rc.stUser.contact_postalcode)#"><br><span>Postal Code</span></td>
	  	</tr></tbody></table>
	  </td>
	</tr>

	<tr>
	  <td><b>Email Address</b></td><!--- this is in case you want to show another email --->
	  <td><input type="text" name="contact_email" class="text" style="width:250px;" value="#htmleditformat(rc.stUser.contact_email)#"></td>
	</tr>
	<tr>
	  <td><b>Office Phone</b></td>
	  <td><input type="text" name="contact_officetel" class="text" style="width:150px;" value="#htmleditformat(rc.stUser.contact_officetel)#"></td>
	</tr>
	
	<tr>
	  <td><b>Mobile Phone</b></td>
	  <td><input type="text" class="text" name="contact_celltel" style="width:150px;" value="#htmleditformat(rc.stUser.contact_celltel)#"></td>
	</tr>
	
	<tr>
	  <td><b>Fax Number</b></td>
	  <td><input type="text" class="text" name="contact_faxtel" style="width:150px;" value="#htmleditformat(rc.stUser.contact_faxtel)#"></td>
	</tr>
	<tr>
		<td colspan="2"><hr />
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
	
	
	</tbody>
	</table>

	</cfoutput>

</cffunction>


</cfcomponent>
