<!---
Copyright (c) 2012 James Mohler

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

<cfcomponent extends="base">

<cfscript>

this.EntryCount = 8;

function init(fw) { variables.fw = fw; }



struct function before(required struct rc) output="false"	{
	

		
	param rc.plugin = "";
	
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("settings.settings", "all");
		}

	
	request.qrySystemAdmin = application.USERAPI.get_system_admin();
	
	
	
	return rc;
	}





void function home(required struct rc) output="false"	{





	if (cgi.request_method == "Post")	{
		
		var result = application.IOAPI.set_pref("Meta", rc);
		
		if (result == "")
			this.AddMessage("Settings successfully updated");
		
		else	
			this.AddMessage(result);
		
		} // end if

	}
	

void function endhome(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Meta"));

	param rc.meta_title  	= "";
	param rc.meta_root 		= "";
	param rc.meta_description  = "";
	param rc.meta_keywords 	= "";
	param rc.meta_robots 	= "";
	param rc.meta_author 	= "";
	param rc.meta_email 	= "";
	param rc.meta_timezone	= "";
	

	}



void function sitemap(required struct rc) output="false"	{

	param rc.submit = "";
	param rc.siteMapID = "";
	param rc.entrycount = 0;

	rc.siteroot = "http://#cgi.http_host##cgi.script_name#/";
	var target = GetDirectoryFromPath(GetBaseTemplatePath()) & "/sitemap.xml";
			

	if (cgi.request_method == "Post")	{
	
		if (rc.submit EQ "Delete")	{
			application.IOAPI.delete({NodeID = rc.SiteMapID, Kind = "Sitemap"});
			
			if (fileexists(target))	{
				filedelete(target);
				this.AddMessage("File was deleted");				
				}
			
			
			return;
			}
	
		rc.xmlData = "";
	
		for (var i = 1; i <= this.entrycount; i++)	{
			var loc = ""; 		if (isDefined("rc.loc_#i#")) 			{ loc = evaluate("rc.loc_#i#"); }
			var changefreq = ""; if (isDefined("rc.changefreq_#i#")) 	{ changefreq = evaluate("rc.changefreq_#i#"); }
			var priority = ""; 	if (isDefined("rc.priority_#i#")) 		{ priority = evaluate("rc.priority_#i#"); }
		
				
			if (changefreq != "exclude")	{
				rc.xmlData &= "<url>"  & variables.crlf;
				rc.xmlData &= "<loc>#xmlformat(loc)#</loc>" & variables.crlf;
				rc.xmlData &= "<changefreq>#changefreq#</changefreq>" & variables.crlf;
				rc.xmlData &= "<priority>#LSNumberformat(priority, "9.9")#</priority>" & variables.crlf;
				rc.xmlData &= "</url>" & variables.crlf;
				}
				
			} /* end for */
	
		
		rc.Kind = "Sitemap";
	
		var stResult  = application.IOAPI.set({NodeID = rc.SiteMapID, Kind = "Sitemap"});
	
		rc.SiteMapID = stResult.NodeID;
	
		var stResult = application.IOAPI.set_XMLData({NodeID = rc.SiteMapID, Kind = "Sitemap"}, rc.xmlData);
		
		/* Do write operation */
		var strSiteMap = '<?xml version="1.0" encoding="utf-8"?>'
			& variables.crlf
			& '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' 
			& variables.crlf
			& rc.xmlData 
			& variables.crlf
			& '</urlset>';
			
		strSiteMap = replace(strSiteMap, "<loc>", "<loc>#rc.siteroot#", "all");	
		
		
	
		
		filewrite(target, strSiteMap);
			
	
		this.addMessage(stResult.message);
		} /* end post */


	
	}
	

void function endsitemap(required struct rc) output="false"	{
	

	var NodeK = {NodeID = "max", Kind = "Sitemap"};
	
	rc.qryNode = application.IOAPI.get(NodeK);
	
		
	rc.qrySiteMap = application.IOAPI.get_site_map(NodeK, this.entryCount); 
	
	
	
	if (rc.qryNode.Kind == "Sitemap") 
		rc.sitemapid = rc.qryNode.NodeID; 
	}
	
	
	



void function error404(required struct rc) output="false"	{


	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Err", rc);
		
		
		this.AddMessage("Error settings updated.");
		
		} // end if

	
	}


void function enderror404(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Err"));

	param rc.err_subject = "";
	param rc.err_SysAdminEmail = "";
	param rc.err_Email = "";
	param rc.err_type = "";

	}


void function feedback(required struct rc) output="false"	{




	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Feedback", rc);
		
		
		this.AddMessage("Feedback settings updated.");
		

		} // end if


	}
	

void function endfeedback(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Feedback"));

	param rc.feedback_subject = "";
	param rc.feedback_SysAdminEmail = "";
	param rc.feedback_Email = "";
	
	if (rc.feedback_SysAdminEmail == "" AND rc.feedback_Email == "")
		this.addMessage("No one has been set to receive feedback emails.", "Warning");

	

	}	
	
	


void function notification(required struct rc) output="false"	{




	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Notif", rc);
		
		this.AddMessage("Notification settings updated.");
		

		} // end if

	
	}
	
void function endnotification(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Notif"));

	param rc.notif_level = 0;
	param rc.notif_subject = "";
	param rc.notif_SysAdminEmail = "";
	param rc.notif_Email = "";


	}	
	
		


void function clearAll(required struct rc) output="false"	{
	
	var SuccessOn = "";
	
	for (i = 1; i <= ArrayLen(application.arPref); i++)	{
		var clearresult = application.IOAPI.delete_pref("All");
		
		if (clearresult) SuccessOn &= application.arPref[i] & " ";
		
		cacheRemove(i);
		}
		
	this.AddMessage("All options have been removed from: #SuccessOn#");	
		

	}


	
/* Sitemap end */

	
void function after(required struct rc) output="false"	{
	
	

		
		
	}	

</cfscript>


<cffunction name="reindex">
	<cfargument name="rc" type="struct" required="true">
	
	<cfquery>
	ALTER FULLTEXT CATALOG ftc_Node REBUILD
	</cfquery>
	
	<cfset this.AddMessage("Main Text Index Rebuilt")> 


	<cfset variables.fw.redirect("system.health", "all")>
</cffunction>


</cfcomponent>

