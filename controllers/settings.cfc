
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


	param rc.submit = "";


	if (cgi.request_method == "post" AND rc.submit == "settings")	{
		
		var result = application.IOAPI.set_pref("Meta", rc);
		
		if (result == "")
			this.AddMessage("Settings successfully updated");
		
		else	
			this.AddMessage(result);
		
		} // end if
		
		
	// Post
	if (cgi.request_method == "post" AND rc.submit == "profile")	{
			
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
	param rc.meta_language	= "";

	
	if (not DirectoryExists(application.GSLANGPATH))	{
		this.addMessage("Language Folder does not exist");
		
		return;
		}	
	
	rc.qryLang = DirectoryList(application.GSLANGPATH, 
		false, "query", "", "name");
	
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
	
	if (rc.err_email != "" and not rc.err_email contains "@")	{
		this.AddMessage("Error notification email needs to have an @.", "Warning");
		}

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

	if (rc.feedback_email != "" and not rc.feedback_email contains "@")	{
		this.AddMessage("Feedback email needs to have an @.", "Warning");
		}

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

	if (rc.notif_email != "" and not rc.notif_email contains "@")	{
		this.AddMessage("Notification email needs to have an @.", "Warning");
		}

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

