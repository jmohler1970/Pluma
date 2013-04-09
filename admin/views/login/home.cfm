<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->



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
          <button type="submit">#application.GSAPI.get_string("Login")#</button>
   </p>       
          
<p class="cta" >
	<b>&laquo;</b> <a href="/">#application.GSAPI.get_string("Back_To_Website")#</a> 
	&nbsp; | &nbsp; 
	<a href="#buildURL(action = '.email')#">#application.GSAPI.get_string("Forgot_pwd")#</a> &raquo;
</p>
			
   	
	</form>
</cfoutput>





</div>

