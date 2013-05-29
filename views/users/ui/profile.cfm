

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value="start">

<cfscript>

param attributes.showpermissions = 0;
param attributes.deletelink = '';



</cfscript>


</cfcase>
<cfcase value="end">

	
	
<cfoutput query="attributes.qryUser">

<cfform action="#attributes.action#" method="post">


<div class="leftsec">
	<p>
		<b>#application.GSAPI.i18n("label_userName")#</b>
		<br />
	    <cfinput type="text" name="login" class="text" value="#login#" maxLength="25" readonly="readonly"  />
	</p>
</div>

	<div class="rightsec">
	
	<p>
		<b>#application.GSAPI.i18n("label_email")#</b>
		<br />
		<cfinput type="text" name="email" class="text" value="#email#" maxLength="80"  />
	</p>
</div>


<cfif attributes.showpermissions>

	<div class="leftsec">
		<p>
	    	<b>#application.GSAPI.i18n("USER_MANAGEMENT/PERMISSION")#</b>
			<br />
			<select name="groups" class="text">
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

<cfelse>	
	<input type="hidden" name="group" 			value="#groups#" />
	<input type="hidden" name="expirationDate" 	value="#expirationdate#" />
	

</cfif>


<div class="leftsec">

	<p class="clearfix">
		<b>#application.GSAPI.i18n("plumacms/label_firstname")#</b>
		<br />
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
		<br />
       	<cfinput type="text" name="lastname" class="text" required="yes" value="#lastname#" maxLength="50" message="Last name is required" />
	</p>
	
	
</div>




	<div class="clear"></div>
	
	
	<cfoutput>#application.GSAPI.exec_action("settings-user-extras")#</cfoutput>
	
	
	
	<p>
		<b>#application.GSAPI.i18n('plumacms/USER_BIO')#</b>
		<br />
		<cftextarea name="comments" richtext="true" height="400" width="740">#comments#</cftextarea>
	</p>


	<p style="margin:0px 0 5px 0;font-size:12px;color:##999;">#application.GSAPI.i18n('only_new_password')#</p>
	

		
	<div class="leftsec">
			<p><label for="sitepwd">#application.GSAPI.i18n('new_password')#</label>
			<input autocomplete="off" class="text" id="sitepwd" name="sitepwd" type="password" value="" /></p>
	</div>
	<div class="rightsec">
			<p><label for="sitepwd_confirm">#application.GSAPI.i18n('confirm_password')#</label>
			<input autocomplete="off" class="text" id="sitepwd_confirm" name="sitepwd_confirm" type="password" value="" /></p>
	</div>
	
	<div class="clear"></div>	

	<div class="edit-nav clearfix">	
	

		<button type="submit" name="submit" value="profile">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
	
	
		<cfif attributes.deletelink NEQ "" AND isnumeric(UserID)>
			
				<a class="delconfirm" href="#attributes.deletelink#" accesskey="D"> <em>D</em>elete</a>
		</cfif>
	</div>


</cfform>

</cfoutput>


</cfcase>
</cfswitch>






