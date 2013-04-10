




<div class="main">

<cfoutput>
	<h3>#application.GSAPI.get_site_name()# #application.GSAPI.get_string("installation")#</h3>


	<form action="#buildURL(action = '.')#" method="post" class="login">
		<p>
		    <b>Reset Preferences</b>
   
   			<input type="checkbox" checked="checked" disabled="disabled" />
   		</p>
	
		<p>
		    <b>Reset Pages</b>
   
   			<input type="checkbox" checked="checked" disabled="disabled" />
   		</p>
	
		<p>
		    <b>Reset Users</b>
   
   			<input type="checkbox" checked="checked" disabled="disabled" />
   		</p>
			

		
		
		<input type="hidden" name="meta_root" value="#application.GSAPI.suggest_site_path()#" />
		
		
		<!---
		<p>
		    <b>#application.GSAPI.get_string("label_baseurl")#</b><br />
   
			<input type="text" name="meta_root" class="text" placeholder="#application.GSAPI.suggest_site_path()#" value="#application.GSAPI.suggest_site_path()#" />
		</p>
		--->
	
		
		<p>
    		<b>#application.GSAPI.get_string("label_website")#:</b><br />
    	
			<input type="text" name="meta_title" class="text" placeholder="Your Website's Name" value="PlumaCMS" />
		</p>
		
					
		<p>
			<b>Login:</b><br />
			<input type="text" name="login" class="text" value="Admin" maxLength="25" size="20" />
		</p>	
		
		<p>
   			<b>#application.GSAPI.get_string("label_email")#:</b><br />
   
  			<input type="text" name="meta_email" class="text"  placeholder="Contact" value="" />
		</p>
		
	
		
		
	
	
		<button type="submit">#application.GSAPI.get_string("label_install")#</button>
	</form>

</cfoutput>

</div>

