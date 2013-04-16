


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


	<form action="#buildURL(action = '.')#" method="post" class="login">

        
    <p>
   		<b>#application.GSAPI.get_string("label_userName")#</b>
   	 	<br />
    	<input type="text" name="login" class="text" placeholder="Login" autofocus>
    </p>
   
   
   	<p>
    	<b>#application.GSAPI.get_string("Password")#</b>
    	<br />
        <input type="password" name="password" class="text" placeholder="Password">
    </p>
   
   
          
   <p>       
          <button type="submit" id="login">#application.GSAPI.get_string("Login")#</button>
   </p>       
          
<p class="cta" >
	<b>&laquo;</b> <a href="/">#application.GSAPI.get_string("Back_To_Website")#</a> 
	&nbsp; | &nbsp; 
	<a href="#buildURL(action = '.email')#">#application.GSAPI.get_string("Forgot_pwd")#</a> &raquo;
</p>
			
   	
	</form>
</cfoutput>





</div>

