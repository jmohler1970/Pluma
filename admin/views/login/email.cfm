


<cfoutput>
<div class="main">

	<h3>#application.GSAPI.get_string("reset_password")#</h3>
	

	<p class="desc">#application.GSAPI.get_string("msg_please_email")#</p>



<cfform action="#buildURL(action = '.email')#" method="post" class="login">



	<p>
    	<b>#application.GSAPI.get_string("label_username")#</b><br />
           	<cfinput type="text" name="email" class="text" maxLength="50" required="yes" message="Email address is required" />
   </p>

	<p>
   		<button type="submit">#application.GSAPI.get_string("send_new_pwd")#</button>
	</p>
</cfform>




<p class="cta" >
	<b>&laquo;</b> <a href="#application.GSAPI.get_site_root()#">#application.GSAPI.get_string("back_to_website")#</a> 
	&nbsp; | &nbsp; 
	<a href="#buildURL(action = '.home')#">#application.GSAPI.get_string("control_panel")#</a> &raquo;
</p>
</cfoutput>		

</div>
