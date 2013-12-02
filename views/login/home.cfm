


<script language="javascript">
function formCheck() 
    {
        if (document.theform.username.value == "") 
        {
        alert("Please include your EID to sign in.");
        return false;
        }    
        if (document.theform.password.value == "") 
        {
        alert("Please include your password to sign in.");
        return false;
        }         	        
    }
    

</script>




<div class="main">

<cfoutput>
	<h3>#application.GSAPI.get_site_name()#</h3>
	#application.GSAPI.exec_action("index-login")#

	<form action="#buildURL(action = '.')#" method="post" class="login">

        
    <p>
   		<b>#application.GSAPI.i18n("label_userName")#</b>
   	 	<br />
    	<input type="text" name="login" class="text" autofocus="autofocus" />
    </p>
   
   
   	<p>
    	<b>#application.GSAPI.i18n("Password")#</b>
    	<br />
        <input type="password" name="password" class="text" />
    </p>
   
   
          
   <p>       
          <button type="submit" id="login">#application.GSAPI.i18n("Login")#</button>
   </p>       
          
<p class="cta" >
	<b>&laquo;</b> <a id="back_to_website" href="/">#application.GSAPI.i18n("Back_To_Website")#</a> 
	&nbsp; | &nbsp; 
	<a id="forgot_pwd" href="#application.GSAPI.get_site_root()#index.cfm/forgot">#application.GSAPI.i18n("Forgot_pwd")#</a> &raquo;
</p>

	<div class="reqs" >#application.GSAPI.exec_action("login-reqs")#</div>
		
   	
	</form>
</cfoutput>







</div>

