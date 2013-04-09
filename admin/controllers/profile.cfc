<!---
Copyright © 2012 James Mohler

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


<cfcomponent output="false" extends="base" > 
<cfscript>
function init(fw) { variables.fw = fw; }


struct function before(required struct rc) output="false"	{



	param rc.plugin = "";
	param rc.userid = "";


	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "Settings")	{
	
		variables.fw.redirect("profile.settings", "all");
		}
	




	return rc;
	}

void function home(required struct rc) output="false"	{


	
	// Post
	if (cgi.request_method == "post")	{
			
		if (arguments.rc.sitepwd != "" AND arguments.rc.sitepwd == arguments.rc.sitepwd_confirm)	{
			arguments.rc.passhash = left(hash(rc.sitepwd), 10);
			
			this.AddMessage("Password has been updated.");
			
			
			}
	
		
		application.USERAPI.set(session.LOGINAPI.userid, arguments.rc);
		
	
		
		 
		
		this.AddMessage("User &quot;#arguments.rc.firstname# #arguments.rc.lastname#&quot; saved");
		}
	
	// All
	rc.qryUser = application.USERAPI.get();
	

	}	
	





</cfscript>
</cfcomponent>

