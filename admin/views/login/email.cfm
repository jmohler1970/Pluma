


<cfoutput>
<div class="main">

	<h3>#application.GSAPI.i18n("reset_password")#</h3>
	

	<p class="desc">#application.GSAPI.i18n("msg_please_email")#</p>



<cfform action="#buildURL(action = '.email')#" method="post" class="login">



	<p>
    	<b>#application.GSAPI.i18n("label_username")#</b><br />
           	<cfinput type="text" name="email" class="text" maxLength="50" required="yes" message="Email address is required" />
   </p>

	<p>
   		<button type="submit">#application.GSAPI.i18n("send_new_pwd")#</button>
	</p>
</cfform>




<p class="cta" >
	<b>&laquo;</b> <a href="#application.GSAPI.get_site_root()#">#application.GSAPI.i18n("back_to_website")#</a> 
	&nbsp; | &nbsp; 
	<a href="#buildURL(action = '.home')#">#application.GSAPI.i18n("control_panel")#</a> &raquo;
</p>
</cfoutput>		

</div>
