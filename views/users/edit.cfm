


<cfimport prefix="ui" taglib="ui">





<!---
<cfsavecontent variable="strButtons">
<cfoutput query="rc.qryUser">

	
	<cfif isnumeric(UserID)><!--- This will be blank if userid is numeric, but there is no such user --->

	<h3 class="floated" id="submit_line">
		<span>
			<button name="submit" type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
		</span>
	</h3>	  	
			
	<cfelse>
		<button type="submit">#application.GSAPI.i18n('Add')#</button>
	</cfif>  
	
</cfoutput>	
</cfsavecontent> 
--->

<div class="main">

	
<cfif rc.qryUser.Groups EQ "" AND isnumeric(rc.userid)>
	<div class="error">
  	
  		<b>Warning!</b> User does not have any access to any groups. This person cannot login.
	</div>	
</cfif>


<cfoutput>	



<cfif isnumeric(rc.UserID)>	
	<h3 class="floated">#application.GSAPI.i18n('plumacms/Edit_user')#</h3>
	
    <div class="edit-nav clearfix">	
    
	
    	
    	<a href="##" id="metadata_toggle" accesskey="n">#application.GSAPI.i18n("PLUMACMS/USER_options")#</a>

		<a href="#application.GSAPI.find_url('profile')#/#rc.userid#" target="_blank" accesskey="v">#application.GSAPI.i18n("view")#</a>
    
		&nbsp;
		
		&nbsp;
    	
    	<a href="#buildURL(action = 'login.impersonate', querystring = 'UserID=#rc.UserID#')#" accesskey="I"> #application.GSAPI.i18n("PLUMACMS/IMPERSONATE")#</a>
    	
	</div>		
	
	
<cfelse>
	<h3 class="floated">#application.GSAPI.i18n('plumacms/Add_user')#</h3>

	
	<div class="clearfix"></div>
</cfif>




</cfoutput>




	<ui:profile rc="#rc#" 
		action		= "#BuildURL(action = '.edit')#"  
		deletelink 	= "#buildURL(action = '.delete', querystring = 'UserID=#rc.UserID#')#" 
		showpermissions="1">

			
		<cfinclude template="../pages/links.cfi"> 		

	</ui:profile>	
		
		


		


<cfoutput query="rc.qryUser">
<cfif isnumeric(rc.UserID)>
	<p class="backuplink" >
		#application.GSAPI.i18n("LAST_SAVED", [modifyby])# #application.IOAPI.std_date(modifyDate)#
	</p>
</cfif>

</cfoutput>





</div>




