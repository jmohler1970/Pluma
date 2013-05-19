
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
		
		if (left(rc.meta_root, 1) != "/")	{
			rc.meta_root &= "/";			
			}
		
		if (result == "")
			this.AddInfo("SETTINGS_UPDATED");
		
		else	
			this.AddWarning(result);
		
		} // end if
		
		
	// Post
	if (cgi.request_method == "post" AND rc.submit == "profile")	{
			
		if (arguments.rc.sitepwd != "")	{
			if (arguments.rc.sitepwd == arguments.rc.sitepwd_confirm)	{
				arguments.rc.passhash = left(hash(rc.sitepwd), 10);
			
				this.AddInfo("PLUMACMS/Password_updated");
				}
			else	{
				this.AddInfo("PASSWORD_NO_MATCH");
				}
			
			} // end if sitepwd
	
		
		application.USERAPI.set(session.LOGINAPI.userid, arguments.rc);
		
	
		
		 
		this.AddInfo("ER_YOUR_CHANGES", ['#arguments.rc.firstname# #arguments.rc.lastname#']);
		
		}
	
	// All
	rc.qryUser = application.USERAPI.get();
	
	
		

	}
	

void function endhome(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("meta"));

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
				this.AddInfo("ER_FILE_DEL_SUC");				
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
			
	
		this.addInfo(stResult.key);
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

	param rc.err_uselog = 0;
	param rc.err_subject = "";
	param rc.err_SysAdminEmail = "";
	param rc.err_Email = "";
	param rc.err_type = "";


	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Err", rc);
		
		
		this.AddInfo("SETTINGS_UPDATED");
		
		} // end if

	
	}


void function enderror404(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Err"));

	
	if (rc.err_email != "" and not rc.err_email contains "@")	{
		this.AddWarning("PLUMACMS/Email_NO_AT");
		}

	}


void function feedback(required struct rc) output="false"	{

	


	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Feedback", rc);
		
		
		this.AddInfo("PLUMACMS/Feedback_updated");
		

		} // end if

		
	}
	

void function endfeedback(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Feedback"));

	

	param rc.feedback_subject = "";
	param rc.feedback_SysAdminEmail = "";
	param rc.feedback_Email = "";
	
	if (rc.feedback_SysAdminEmail == "" AND rc.feedback_Email == "")
		this.AddWarning("PLUMACMS/EMAIL_NOT_SETUP");

	if (rc.feedback_email != "" and not rc.feedback_email contains "@")	{
		this.AddWarning("PLUMACMS/Email_NO_AT", [rc.feedback_email]);
		}

		

	}	
	
	


void function notification(required struct rc) output="false"	{




	if (cgi.request_method == "Post")	{
	
			
		application.IOAPI.set_pref("Notif", rc);
		
		this.AddInfo("SETTINGS_UPDATED");
		

		} // end if

	
	}
	
void function endnotification(required struct rc) output="false"	{

	StructAppend(rc, application.IOAPI.get_pref("Notif"));

	param rc.notif_level = 0;
	param rc.notif_subject = "";
	param rc.notif_SysAdminEmail = "";
	param rc.notif_Email = "";

	if (rc.notif_email != "" and not rc.notif_email contains "@")	{
		this.AddWarning("PLUMACMS/EMAIL_NO_AT");
		}

	}	
	
		


void function clearAll(required struct rc) output="false"	{
	
	var SuccessOn = "";
	
	for (i = 1; i <= ArrayLen(application.arPref); i++)	{
		var clearresult = application.IOAPI.delete_pref("All");
		
		if (clearresult) SuccessOn &= application.arPref[i] & " ";
		
		cacheRemove(i);
		}
		
	this.AddInfo("PLUMACMS/Options_removed", [SuccessOn]);	
		

	}



</cfscript>


<cffunction name="reindex">
	<cfargument name="rc" type="struct" required="true">
	
	<cfquery>
	ALTER FULLTEXT CATALOG ftc_Node REBUILD
	</cfquery>
	
	<cfset this.AddSuccess("PLUMACMS/Index_Rebuilt")> 


	<cfset variables.fw.redirect("support.health", "all")>
</cffunction>


</cfcomponent>

