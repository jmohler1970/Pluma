


<cfimport prefix="ui" taglib="ui">




<cfsavecontent variable="strButtons">
<cfoutput query="rc.qryUser">

	
	<cfif isnumeric(UserID)><!--- This will be blank if userid is numeric, but there is no such user --->
<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
		  	
			
	<cfelse>
		<input type="submit" class="submit" value="Add" />
	</cfif>  
	
</cfoutput>	
</cfsavecontent> 


<div class="main">

	
<cfif rc.qryUser.Groups EQ "" AND isnumeric(rc.userid)>
	<div class="error">
  	
  		<b>Warning!</b> User does not have any access to any groups. This person cannot login.
	</div>	
</cfif>


	
<cfif isnumeric(rc.UserID)>	
	<h3 class="floated">Edit User</h3>
<cfelse>
	<h3 class="floated">New User</h3>
</cfif>

<cfoutput>
<div class="edit-nav clearfix">	
	
	<cfif isnumeric(rc.UserID)>
	
	
		<a href="#buildURL(action = 'login.impersonate', querystring = 'UserID=#rc.UserID#')#" accesskey="I"> <em>I</em>mpersonate</a>		
		

	</cfif>
</div>
</cfoutput>

<cfoutput query="rc.qryUser">

<cfform action="#BuildURL(action = 'users.edit', querystring = 'UserID=#rc.UserID#')#" method="post">




<cfif Deleted EQ 1>
	<div class="alert alert-error">
		<h4 class="alert-heading">Error</h4>
		<cfoutput><p>Deleted User</p></cfoutput>
	</div>
</cfif>

<div class="leftsec">

	<p class="clearfix">
		<b>First Name</b>
		
	    <cfinput type="text" name="firstname" class="text" required="yes" value="#firstname#" maxLength="50" message="First name is required" />

	</p>

<!---	
	<p>
		<b>Middle Name</b>
		<br />
		<cfinput type="text" name="middleName" maxLength="1" value="#middleName#" class="text" />
	</p>
--->	
</div>	

<div class="rightsec">	
	<p>
		<b>Last Name</b>
		
       	<cfinput type="text" name="lastname" class="text" required="yes" value="#lastname#" maxLength="50" message="Last name is required" />
	</p>
	
	
</div>

	<div class="clear"></div>






<div class="leftsec">
	<p>
		<b>Login</b>
		<br />
	    <cfinput type="text" name="login" class="text" value="#login#" maxLength="25" readonly="readonly"  />
	</p>
	
		
		
	</div>
	
	<div class="rightsec">
	
	<p>
		<b>Email</b>
		<br />
		<cfinput type="text" name="email" class="text" value="#email#" maxLength="80"  />
	</p>
	

	

	</div>

	<div class="clear"></div>
		<p class="inline" ><input name="show_htmleditor" id="show_htmleditor" type="checkbox" value="1" checked /> &nbsp;<label for="show_htmleditor" ><b>Enable the HTML editor</b></label></p>
		
		<cfif isnumeric(rc.UserID)>		
			<p style="margin:0px 0 5px 0;font-size:12px;color:##999;" >Only provide a password below if you want to change your current one:</p>
		</cfif>
		
	<div class="leftsec">
			<p><label for="sitepwd" >New Password:</label><input autocomplete="off" class="text" id="sitepwd" name="sitepwd" type="password" value="" /></p>
	</div>
	<div class="rightsec">
			<p><label for="sitepwd_confirm" >Confirm Password:</label><input autocomplete="off" class="text" id="sitepwd_confirm" name="sitepwd_confirm" type="password" value="" /></p>
	</div>
	
	<div class="clear"></div>
	<p>
		<b>#application.GSAPI.i18n('user_management/USER_BIO')#</b>
		<br />
		<cftextarea name="comments" richtext="true" height="400" width="740">#comments#</cftextarea>
	</p>
	

	  <h3 style="font-size:14px;">#application.GSAPI.i18n('user_management/PERM')#</h3>
	  
         <div class="perm_div"><label for="Pages">#application.GSAPI.i18n('user_management/PAGES')#</label>
         <input type="checkbox" id="Pages" name="Pages" value="no" />
         </div>
         
         <div class="perm_div"><label for="Edit">#application.GSAPI.i18n('user_management/EDIT')#</label>
         <input type="checkbox" id="Edit" name="Edit" value="no" />
         </div>

         <div class="perm_div"><label for="Files">#application.GSAPI.i18n('user_management/FILES')#</label>
         <input type="checkbox" id="Files" name="Files" value="no" />
         </div>

         <div class="perm_div"><label for="Theme">#application.GSAPI.i18n('user_management/THEME')#</label>
         <input type="checkbox" id="Theme" name="Theme" value="no" />
         </div>

         <div class="perm_div"><label for="Plugins">#application.GSAPI.i18n('user_management/PLUGINS')#</label>
         <input type="checkbox" id="Plugins" name="Plugins" value="no" />
         </div>

         <div class="perm_div"><label for="Backups">#application.GSAPI.i18n('user_management/BACKUPS')#</label>
         <input type="checkbox" id="Backups" name="Backups" value="no" />
         </div>
         
         <div class="perm_div"><label for="Support">#application.GSAPI.i18n('user_management/SUPPORT')#</label>
         <input type="checkbox" id="Support" name="Support" value="no" />
         </div>


         <div class="perm_div"><label for="Settings">#application.GSAPI.i18n('user_management/SETTINGS')#</label>
         <input type="checkbox" id="Settings" name="Settings" value="no" />
         </div>

         

         <div style="clear:both"></div>

         <div class="perm_select"><label for="userland">#application.GSAPI.i18n('user_management/LAND')#
         <a href="##" title="This is where you can set an alternate landing page the user will arrive at upon logging in">?</a></label>
         <select name="Landing" id="userland" class="text">
          <option value="" selected="selected"></option>
	      <option value="pages/home">Pages</option>
          <option value="theme/home">Theme</option>
          <option value="settings/home">Settings</option>
          <option value="support/home">Support</option>
          <option value="page/edit">Edit</option>
          <option value="plugins/home">Plugins</option>
          <option value="files/home">Upload</option>
          <option value="backups/home">Backups</option>
	      </select>
         </div>

         <div class="perm_div_2"><label for="Admin">#application.GSAPI.i18n('user_management/ADMIN')#</label>
        	 <input type="checkbox" id="Admin" name="Admin" value="no" />
         </div>
	
	
	
	<div class="clear"></div>	
	<p></p>

	<div class="edit-nav clearfix">	
	
		
		#strButtons#

		<cfif isnumeric(rc.UserID)>
	
			
			<a href="#buildURL(action = 'users.delete', querystring = 'UserID=#rc.UserID#')#" onclick="return confirm('Are you sure you want to deactivate this user?')" accesskey="D"> <em>D</em>elete</a>
		</cfif>
	</div>
	
	</cfform>


</cfoutput>



</div>




