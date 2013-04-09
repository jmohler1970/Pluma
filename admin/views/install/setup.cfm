<!---
Copyright (C) 2013 James Mohler

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

