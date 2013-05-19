


<cfimport prefix="ui" taglib="ui">




<cfsavecontent variable="strButtons">
<cfoutput query="rc.qryUser">

	
	<cfif isnumeric(UserID)><!--- This will be blank if userid is numeric, but there is no such user --->
<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
		  	
			
	<cfelse>
		<button type="submit">#application.GSAPI.i18n('Add')#</button>
	</cfif>  
	
</cfoutput>	
</cfsavecontent> 


<div class="main">

	
<cfif rc.qryUser.Groups EQ "" AND isnumeric(rc.userid)>
	<div class="error">
  	
  		<b>Warning!</b> User does not have any access to any groups. This person cannot login.
	</div>	
</cfif>


<cfoutput>	
<cfif isnumeric(rc.UserID)>	
	<h3 class="floated">#application.GSAPI.i18n('plumacms/Edit_user')#</h3>
<cfelse>
	<h3 class="floated">#application.GSAPI.i18n('plumacms/Add_user')#</h3>
</cfif>


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
	<p>
		<b>#application.GSAPI.i18n("label_userName")#</b>
		<br />
	    <input type="text" name="login" class="text" value="#login#" maxLength="25" 
	    
	    <cfif isnumeric(rc.UserID)>
	    	readonly="readonly"
	    </cfif>
	    />
	</p>
	
		
		
	</div>
	
	<div class="rightsec">
	
	<p>
		<b>#application.GSAPI.i18n("label_email")#</b>
		<br />
		<input type="text" name="email" class="text" value="#email#" maxLength="80"  />
	</p>
	
</div>





	<div class="clear"></div>






<div class="leftsec">
  <p>
    <b>#application.GSAPI.i18n("USER_MANAGEMENT/PERMISSION")#</b>
    <br />
       <select name="group" class="text">
       <cfloop index="ii" list="#Application.stSettings.Group.lstAccess#">
        <option value="#ii#" <cfif ii EQ groups>selected="selected"</cfif>>#ii#</option>
      </cfloop>
    </select>
 
  </p>
</div>  
  
 
<div class="rightsec"> 



	<p>
		<b>#application.GSAPI.i18n("USER_MANAGEMENT/EXPIRATION")#</b>
		<br />
		  	<cfset application.IOAPI.showDatePicker("expirationDate", ExpirationDate, "text autowidth")>

	</p>
</div>



	<div class="clear"></div>
		<p class="inline" ><input name="show_htmleditor" id="show_htmleditor" type="checkbox" value="1" checked /> &nbsp;<label for="show_htmleditor" ><b>Enable the HTML editor</b></label></p>
		
		<cfif isnumeric(rc.UserID)>		
			<p style="margin:0px 0 5px 0;font-size:12px;color:##999;">#application.GSAPI.i18n('only_new_password')#</p>
		</cfif>
		
<div class="leftsec">

	<p class="clearfix">
		<b>#application.GSAPI.i18n("plumacms/label_firstname")#</b>
		
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
		<b>#application.GSAPI.i18n("plumacms/label_lastname")#</b>
		
       	<cfinput type="text" name="lastname" class="text" required="yes" value="#lastname#" maxLength="50" message="Last name is required" />
	</p>
	
	
</div>

	
	<div class="clear"></div>
	<p>
		<b>#application.GSAPI.i18n('plumacms/USER_BIO')#</b>
		<br />
		<cftextarea name="comments" richtext="true" height="400" width="740">#comments#</cftextarea>
	</p>
	
	
	<div class="clear"></div>	
	
	<div class="leftsec">
			
		<p>
			<label for="sitepwd">#application.GSAPI.i18n('new_password')#</label>
			<input autocomplete="off" class="text" id="sitepwd" name="sitepwd" type="password" value="" />
		</p>
	</div>
	<div class="rightsec">
		<p>
			<label for="sitepwd_confirm">#application.GSAPI.i18n('confirm_password')#</label>
			<input autocomplete="off" class="text" id="sitepwd_confirm" name="sitepwd_confirm" type="password" value="" />
		</p>
	</div>

	<div class="edit-nav clearfix">	
	
		
		#strButtons#

		<cfif isnumeric(rc.UserID)>
			
			<a class="delconfirm" href="#buildURL(action = 'users.delete', querystring = 'UserID=#rc.UserID#')#" accesskey="D"> <em>D</em>elete</a>
		</cfif>
	</div>
	
	</cfform>



<cfif isnumeric(rc.UserID)>
	<p class="backuplink" >
		#application.GSAPI.i18n("LAST_SAVED", [modifyby])# #application.IOAPI.std_date(modifyDate)#
	</p>
</cfif>

</cfoutput>



</div>




