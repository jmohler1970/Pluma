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
	
	<table class="vcard cleantable">
	<tbody>
	<tr>
	  <td><b>Company</b></td>
	  <td><input type="text" name="company" class="text" style="width:250px;" value=""></td>
	</tr>
	<tr>
	  <td><b>Title</b></td>
	  <td><input type="text" name="title" class="text" style="width:250px;" value=""></td>
	</tr>
	
	<tr>
	  <td><b>Work Address</b></td>
	  <td><input type="text" name="work_address" class="text" style="width:250px;" value=""><br>
	  <span>Street Name</span></td>
	</tr>
	<tr>
	  <td></td>
	  <td>
	    <table class="cleantable" style="width:260px;padding:0;margin:0;"><tbody><tr>
	    	<td style="padding-left:0px;"><input type="text" name="work_city" class="text" style="width:130px;" value=""><br><span>City</span></td>
	    	<td><input type="text" name="work_state" class="text" style="width:20px;" value=""><br><span>State</span></td>
	    	<td><input type="text" name="work_postal_code" class="text" style="width:55px;" value=""><br><span>Postal Code</span></td>
	  	</tr></tbody></table>
	  </td>
	</tr>
	<tr>
	  <td><b>Email Address</b></td>
	  <td><input type="text" name="email" class="text" style="width:250px;" value=""></td>
	</tr>
	<tr>
	  <td><b>Office Phone</b></td>
	  <td><input type="text" name="office_tel" class="text" style="width:150px;" value=""></td>
	
	</tr>
	<tr>
	  <td><b>Mobile Phone</b></td>
	  <td><input type="text" class="text" name="cell_tel" style="width:150px;" value=""></td>
	</tr>
	<tr>
	  <td><b>Fax Number</b></td>
	  <td><input type="text" class="text" name="fax_tel" style="width:150px;" value=""></td>
	</tr>
	</tbody>
	</table>


</cffunction>


</cfcomponent>
