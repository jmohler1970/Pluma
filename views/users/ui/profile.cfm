

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value="start">

<cfscript>

param attributes.showpermissions = 0;
param attributes.deletelink = '';
</cfscript>


</cfcase>
<cfcase value="end">

	
	<cfset inner = thisTag.GeneratedContent>
	
	<cfset thisTag.GeneratedContent = "">
	
	
<cfoutput query="attributes.rc.qryUser">

<cfform action="#attributes.action#" method="post">
	<input type="hidden" name="userid" value="#userid#" />


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
	
	<div class="leftsec">

	<p class="inline clearfix">
		<label class="control-label" for="pstatus">#application.GSAPI.i18n("keep_private")#</label>
	   
	       	<select name="pstatus"  class="text autowidth">
			<cfloop index="ii" list="#application.stSettings.Node.lstpstatus#">
				<option value="#ii#" <cfif ii EQ pStatus>selected</cfif>>#ii#</option>
			</cfloop>
			</select>
	</p>


</div>

<cfelse>	
	<input type="hidden" name="group" 			value="#groups#" />
	<input type="hidden" name="expirationDate" 	value="#expirationdate#" />
	<input type="hidden" name="pstatus" 		value="#pstatus#" />

</cfif>



	<div class="clear"></div>
	
<div id="link_window" style="display : none;">		
	<cfoutput>#application.GSAPI.exec_action("settings-user-extras", "", attributes.rc)#</cfoutput>
	

	<div class="clear"></div>
	

	#inner#
</div>
	


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
	
		
		<h3 class="floated" id="submit_line">
		<span>	
			<button type="submit" name="submit" value="profile">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
		</span>
		</h3>	
	
	
		<cfif attributes.deletelink NEQ "" AND isnumeric(UserID)>
			
				<a class="delconfirm" href="#attributes.deletelink#" accesskey="D"> <em>D</em>elete</a>
		</cfif>
	</div>
</cfform>

</cfoutput>


</cfcase>
</cfswitch>






