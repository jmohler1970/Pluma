

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value="start">

<cfscript>

	param attributes.showpermissions = 0;
	param attributes.deletelink = '';
	stUser = attributes.stUser;
	

	stB = {
		
		prefix			= "",
		given			= "",
		additional		= "",
		family			= "",
		suffix			= "",
	
	
		org			 	= "",
		title	 		= "",
		photo	 		= "",
		url		 		= "",
		email	 		= "",
		officetel		= "",
		celltel			= "",
		faxtel			= "",
	
	// adr
		street			= "",
		locality 		= "",
		region	 		= "",
		code 			= "",
		country			= "",
	// adr
	
		category		= "",
		note			= ""
	};
	
	
	// massive param
	StructAppend(stUser, stB, "no");
	
</cfscript>



</cfcase>
<cfcase value="end">

	
	<cfset inner = thisTag.GeneratedContent>
	
	<cfset thisTag.GeneratedContent = "">
	

	
<cfoutput>

<cfform action="#attributes.action#" method="post">
	<input type="hidden" name="userid" value="#stUser.userid#" />


<div class="leftsec">
	<p>
		<b>#application.GSAPI.i18n("label_userName")#</b>
		<br />
	    <cfinput type="text" name="login" class="text" value="#stUser.login#" maxLength="25" readonly="readonly"  />
	</p>
</div>

	<div class="rightsec">
	
	<p>
		<b>#application.GSAPI.i18n("label_email")#</b>
		<br />
		<cfinput type="text" name="email" class="text" value="#stUser.email#" maxLength="80"  />
	</p>
</div>


<cfif attributes.showpermissions>

	<div class="leftsec">
		<p>
	    	<b>#application.GSAPI.i18n("USER_MANAGEMENT/PERMISSION")#</b>
			<br />
			<select name="groups" class="text">
			<cfloop index="ii" list="#Application.stSettings.Group.lstAccess#">
	       		<option value="#ii#" <cfif ii EQ stUser.groups>selected="selected"</cfif>>#ii#</option>
		   	</cfloop>
		   	</select>
	 	</p>
	</div>  
	  
	 
	<div class="rightsec"> 
			
		<p>
			<b>#application.GSAPI.i18n("USER_MANAGEMENT/EXPIRATION")#</b>
			<br />
			  	<cfset application.IOAPI.showDatePicker("expirationDate", stUser.ExpirationDate, "text autowidth datepicker")>
		</p>
	</div>
	
	<div class="leftsec">

	<p class="inline clearfix">
		<label class="control-label" for="pstatus">#application.GSAPI.i18n("keep_private")#</label>
	   
	       	<select name="pstatus"  class="text autowidth">
			<cfloop index="ii" list="#application.stSettings.Node.lstpstatus#">
				<option value="#ii#" <cfif ii EQ stUser.pStatus>selected</cfif>>#ii#</option>
			</cfloop>
			</select>
	</p>


</div>

<cfelse>	
	<input type="hidden" name="group" 			value="#stUser.groups#" />
	<input type="hidden" name="expirationDate" 	value="#stUser.expirationdate#" />
	<input type="hidden" name="pstatus" 		value="#stUser.pstatus#" />

</cfif>



	<div class="clear"></div>
	



	<h3>hCard</h3>
	
	
	<table class="cleantable">
	<tr>
	  <td style="width:33%"><b>Prefix</b></td>
	  <td><input type="text" name="n.prefix" class="text" style="width:250px;" 	value="#htmleditformat(stUser.prefix)#" /></td>
	</tr>

	<tr>
	  <td><b>First Name</b></td>
	  <td><input type="text" name="n.given" class="text" style="width:250px;" value="#htmleditformat(stUser.given)#" /></td>
	</tr>

	<tr>
	  <td><b>Middle Name</b></td>
	  <td><input type="text" name="n.additional" class="text" style="width:25px;" value="#htmleditformat(stUser.additional)#" /></td>
	</tr>

	<tr>
	  <td><b>Last Name</b></td>
	  <td><input type="text" name="n.family" class="text" style="width:250px;" value="#htmleditformat(stUser.family)#" /></td>
	</tr>

	<tr>
	  <td><b>Postfix</b></td>
	  <td><input type="text" name="n.suffix" class="text" style="width:250px;" 	value="#htmleditformat(stUser.suffix)#" /></td>
	</tr>

	<!--- hideable section --->
	<tbody id="link_window" style="display : none;">
	<tr>
	  <td><b>Title</b></td>
	  <td><input type="text" name="title" class="text" style="width:250px;" value="#htmleditformat(stUser.title)#"></td>
	</tr>

	<tr>
	  <td><b>Company</b></td>
	  <td><input type="text" name="org" class="text" style="width:250px;" value="#htmleditformat(stUser.org)#" /></td>
	</tr>
	
	<tr>
	  <td><b>Office Phone</b></td>
	  <td><input type="text" name="officetel" class="text" style="width:150px;" value="#htmleditformat(stUser.officetel)#"></td>
	</tr>
	
	<tr>
	  <td><b>Mobile Phone</b></td>
	  <td><input type="text" class="text" name="celltel" style="width:150px;" value="#htmleditformat(stUser.celltel)#"></td>
	</tr>
	
	<tr>
	  <td><b>Fax Number</b></td>
	  <td><input type="text" class="text" name="faxtel" style="width:150px;" value="#htmleditformat(stUser.faxtel)#"></td>
	</tr>
	
	
	<tr>
	  <td><b>Photo</b></td>
	  <td><input type="text" name="photo" class="text" style="width:250px;" value="#htmleditformat(stUser.photo)#" /></td>
	</tr>
	<tr>
	  <td><b>URL</b></td>
	  <td><input type="text" name="url" class="text" style="width:250px;" value="#htmleditformat(stUser.url)#" /></td>
	</tr>
	
	<!---
	<tr>
	  <td><b>Email</b></td><!--- this is in case you want to show another email --->
	  <td><input type="text" name="email" class="text" style="width:250px;" value="#htmleditformat(stUser.email)#"></td>
	</tr>
	--->
	
	<!--- start adr --->
	<tr>
	  <td><b>Address</b></td>
	  <td><input type="text" name="street" class="text" style="width:250px;" value="#htmleditformat(stUser.street)#"><br />
	  <small>Street Name</small></td>
	</tr>
	
	<tr>
	  <td></td>
	  <td>
	    <table class="cleantable" style="width:260px;padding:0;margin:0;">
	    <tbody>
	    <tr>
	    	<td style="padding-left:0px;"><input type="text" name="locality" class="text" style="width:130px;" value="#htmleditformat(stUser.locality)#"><br />
	    		<small>City</small></td>
	    	<td><input type="text" name="region" class="text" style="width:20px;" value="#htmleditformat(stUser.region)#"><br />
	    		<small>State</small></td>
	    	<td><input type="text" name="code" class="text" style="width:55px;" value="#htmleditformat(stUser.code)#"><br />
	    		<small>Postal Code</small></td>
		</tr>
	  	</tbody>
	  	</table>
	  </td>
	</tr>
	<tr>
	  <td><b>Country</b></td>
	  <td><input type="text" name="country" class="text" style="width:250px;" value="#htmleditformat(stUser.country)#"></td>
	</tr>
	<!--- end adr --->
	
	<tr>
		<td><b>Notes</b></td>
		<td><textarea name="note" rows="3" cols="80" style="height : 40px;">#htmleditformat(stUser.note)#</textarea></td>
	</tr>
	
	<!--- above are pre wired --->


		
	#application.GSAPI.exec_action("settings-user-extras")#
	
	</tbody>
	</table>

	<div class="clear"></div>
	
	<!--- This is for stuff in between the custom tag --->
	#inner#

	


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
	
		
	<h3 class="floated" style="margin-top :0;" id="submit_line">
	<span>	
		<button type="submit" name="submit" class="save" value="profile">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
	</span>
	</h3>	
	
	
	<cfif attributes.deletelink NEQ "" AND isnumeric(stUser.UserID)>
		<a class="delconfirm" href="#attributes.deletelink#" accesskey="D"> <em>D</em>elete</a>
	</cfif>
	</div>
</cfform>

</cfoutput>


</cfcase>
</cfswitch>






