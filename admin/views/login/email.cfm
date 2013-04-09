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
