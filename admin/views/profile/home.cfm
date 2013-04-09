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



<div class="main">

	<cfoutput>
	<h3>#application.GSAPI.get_string("profile")#</h3>
	</cfoutput>
	

	
	
<cfoutput query="rc.qryUser">

<cfform action="#BuildURL(action = 'profile.home')#" method="post">


<div class="leftsec">

	<p class="clearfix">
		<b>First Name</b>
		
	    <cfinput type="text" name="firstname" class="text" required="yes" value="#firstname#" maxLength="50" message="First name is required" />

	</p>

<!---	
	<p>
		<b>Middle Name</b>
		<br />
		<cfinput type="text" name="middleName" maxLength="1" value="#middleName#" class="text" />
	</p>
--->	
</div>	

<div class="rightsec">	
	<p>
		<b>Last Name</b>
		
       	<cfinput type="text" name="lastname" class="text" required="yes" value="#lastname#" maxLength="50" message="Last name is required" />
	</p>
	
	
</div>


<div class="leftsec">
	<p>
		<b>Login</b>
		<br />
	    <cfinput type="text" name="login" class="text" value="#login#" maxLength="25" readonly="readonly"  />
	</p>
</div>

	<div class="rightsec">
	
	<p>
		<b>Email</b>
		<br />
		<cfinput type="text" name="email" class="text" value="#email#" maxLength="80"  />
	</p>
	</div>


	<p style="margin:0px 0 5px 0;font-size:12px;color:##999;" >Only provide a password below if you want to change your current one:</p>
	

		
	<div class="leftsec">
			<p><label for="sitepwd" >New Password:</label><input autocomplete="off" class="text" id="sitepwd" name="sitepwd" type="password" value="" /></p>
	</div>
	<div class="rightsec">
			<p><label for="sitepwd_confirm" >Confirm Password:</label><input autocomplete="off" class="text" id="sitepwd_confirm" name="sitepwd_confirm" type="password" value="" /></p>
	</div>
	
	<div class="clear"></div>	

	<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>

</cfform>

</cfoutput>



</div>



