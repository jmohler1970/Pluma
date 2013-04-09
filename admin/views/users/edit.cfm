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


<cfimport prefix="ui" taglib="ui">




<cfsavecontent variable="strButtons">
<cfoutput query="rc.qryUser">

	
	<cfif isnumeric(UserID)><!--- This will be blank if userid is numeric, but there is no such user --->
<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
		  	
			
	<cfelse>
		<input type="submit" class="submit" value="Add" />
	</cfif>  
	
</cfoutput>	
</cfsavecontent> 


<div class="main">

	
<cfif rc.qryUser.Groups EQ "" AND isnumeric(rc.userid)>
	<div class="error">
  	
  		<b>Warning!</b> User does not have any access to any groups. This person cannot login.
	</div>	
</cfif>


	
<cfif isnumeric(rc.UserID)>	
	<h3 class="floated">Edit User</h3>
<cfelse>
	<h3 class="floated">New User</h3>
</cfif>

<cfoutput>
<div class="edit-nav clearfix">	
	<a href="##" id="metadata_toggle" accesskey="n">User Optio<em>n</em>s</a>

	<cfif isnumeric(rc.UserID)>
	
	
		<a href="#buildURL(action = 'login.impersonate', querystring = 'UserID=#rc.UserID#')#" accesskey="I"> <em>I</em>mpersonate</a>		
		
		<a href="#buildURL(action = 'users.delete', querystring = 'UserID=#rc.UserID#')#" onclick="return confirm('Are you sure you want to deactivate this user?')" accesskey="E"> <em>E</em>xpire</a>
	</cfif>
</div>
</cfoutput>

<cfoutput query="rc.qryUser">

<cfform action="#BuildURL(action = 'users.edit', querystring = 'UserID=#rc.UserID#')#" method="post">




<cfif Deleted EQ 1>
	<div class="alert alert-error">
		<h4 class="alert-heading">Error</h4>
		<cfoutput><p>Deleted User</p></cfoutput>
	</div>
</cfif>

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

	<div class="clear"></div>

<div id="metadata_window" style="display : none;">

	<p>
		<b>Credentials</b>
		<br />
       	<cfinput type="text" name="postfix" class="text" value="#htmleditformat(postfix)#" maxLength="50"  />
	</p>
	
	<p>
		<b>Comments</b>
		<br />
  		<textarea name="comments" class="text" style="height : 50px;">#htmleditformat(comments)#</textarea>
	</p>
	
	
</div>


 	<div class="clear"></div>





<div class="leftsec">
	<p>
		<b>Login</b>
		<br />
	    <cfinput type="text" name="login" class="text" value="#login#" maxLength="25" readonly="readonly"  />
	</p>
	
		
	<p>
		<b>Expiration</b>
		<br />
		<cfset application.IOAPI.showDatePicker("expirationDate", expirationdate)>

	</p>
	
	


	
	</div>
	
	<div class="rightsec">
	
	<p>
		<b>Email</b>
		<br />
		<cfinput type="text" name="email" class="text" value="#email#" maxLength="80"  />
	</p>
	
		
	
	
	<p>
		<b>Permission</b>
		<br />
   		<select name="group" class="text">
   			<option value=""> - </option>
			<cfloop index="ii" list="#Application.USERAPI.stSettings.Group.lstAccess#">
				<option value="#ii#" <cfif ii EQ groups>selected="selected"</cfif>>#ii#</option>
			</cfloop>
		</select>
 
	</p>

	

	</div>

	<div class="clear"></div>
		<p class="inline" ><input name="show_htmleditor" id="show_htmleditor" type="checkbox" value="1" checked /> &nbsp;<label for="show_htmleditor" ><b>Enable the HTML editor</b></label></p>
		
		<cfif isnumeric(rc.UserID)>		
			<p style="margin:0px 0 5px 0;font-size:12px;color:##999;" >Only provide a password below if you want to change your current one:</p>
		</cfif>
		
	<div class="leftsec">
			<p><label for="sitepwd" >New Password:</label><input autocomplete="off" class="text" id="sitepwd" name="sitepwd" type="password" value="" /></p>
	</div>
	<div class="rightsec">
			<p><label for="sitepwd_confirm" >Confirm Password:</label><input autocomplete="off" class="text" id="sitepwd_confirm" name="sitepwd_confirm" type="password" value="" /></p>
	</div>
	
	<div class="clear"></div>	


	
		
		#strButtons#

	
	
	</cfform>

	<p>In order to be able to login, the user must have...</p>
	<ul>
		<li>Username</li>
		<li>Password</li>
		<li>Group</li>
		<li>Not be expired</li>
	</ul>

</cfoutput>



</div>




