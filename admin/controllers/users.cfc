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
	
		variables.fw.redirect("users.settings", "all");
		}
	




	return rc;
	}


void function home(required struct rc) output="false"	{
	

	rc.qryUser 	= application.USERAPI.get_all();
	}


	
void function edit(required struct rc) output="false"	{

	
	
	
	// Post
	if (cgi.request_method == "post")	{
		
		application.USERAPI.set(rc.UserID, rc);
			 
		
		this.AddMessage("User &quot;#rc.firstname# #rc.lastname#&quot; saved");
		}
	
	// All
	rc.qryUser =  application.USERAPI.get(rc.UserID);
	
	rc.qryNode = application.IOAPI.get_all_by_userID("Any", rc.UserID, "CreateDate DESC");
	
	if (rc.qryUser.UserID == "" AND isnumeric(rc.UserID))	{
	
		this.AddMessage("User could not be loaded. There are no matching records for this userid","Error");
	
		variables.fw.redirect("users.home", "all");
		}
	
	}	
	




// Make it handle a list
void function delete(required struct rc) output="false"	{

	param rc.userid = "";
	
	if (not isnumeric(rc.userid))	{
	
		this.AddMessage("This is an invalid UserID.", "Error");
		variables.fw.redirect("users.home", "all");
		}
	
		
	application.LOGINAPI.delete(rc.UserID);
	
	
	// Results
	this.AddMessage("User deleted.");

	variables.fw.redirect("users.home", "all");
	}
	

void function jour(required struct rc) output="false"	{

	
	rc.qryRecentLogin = application.USERAPI.get_recent_login();
	}



void function renew(required struct rc) output="false"	{
	
	var stResult = application.USERAPI.set_bulk({bulkuserid = rc.userid, subaction = 'renew:12'});

	this.AddMessage(stResult.message);

	variables.fw.redirect("users.edit", "all");
	}



</cfscript>



</cfcomponent>

