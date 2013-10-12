
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
		
	
		
		 
		this.AddInfo("ER_YOUR_CHANGES", ['#arguments.rc.given# #arguments.rc.family#']);
		
		}
	
	// Get myself
	rc.stUser = application.USERAPI.get();
		

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

	param rc.err_uselog = 0;
	param rc.err_subject = "";
	param rc.err_SysAdminEmail = "";
	param rc.err_Email = "";
	param rc.err_type = "";
		
	param rc.feedback_subject = "";
	param rc.feedback_SysAdminEmail = "";
	param rc.feedback_Email = "";

	param rc.notif_level = 0;
	param rc.notif_subject = "";
	param rc.notif_SysAdminEmail = "";
	param rc.notif_Email = "";
	
	param rc.search_profile 	= 0;
	param rc.search_max 		= 10;
	param rc.search_letters 	= 100;
	param rc.search_parentpage 	= 0;
	param rc.search_tags 		= 0;
	param rc.search_publishDate = 0;
	param rc.search_rank 		= 0;
	

	
	rc.xa =	{
		jour404	 			= variables.fw.buildURL(action='support.jour', querystring='kind=404'),
		missing	 			= variables.fw.buildURL(action='home.missing'),
		error404 			= variables.fw.buildURL(action = '.error404'),
		
		feedback_test 		= variables.fw.buildURL(action='home.feedback'),
		feedback			= variables.fw.buildURL(action = '.feedback'),
		
		notification_test 	= variables.fw.buildURL(action='settings.notificationtest'),
		notification 		= variables.fw.buildURL(action = '.notification'),
		
		password			= variables.fw.buildURL(action = '.home'),
		profile				= variables.fw.buildURL(action = '.home'),
		
		search				= variables.fw.buildURL(action = 'settings.search'),
		reindex				= variables.fw.buildURL(action = 'settings.reindex'),
		settings			= variables.fw.buildURL(action = '.home')
		};

	
	
	StructAppend(rc, application.IOAPI.get_pref("Err"));

	StructAppend(rc, application.IOAPI.get_pref("Feedback"));

	StructAppend(rc, application.IOAPI.get_pref("Notif"));
	
	StructAppend(rc, application.IOAPI.get_pref("Search"));	


	/*
	if (rc.err_email != "" and not rc.err_email contains "@")	{
		this.AddWarning("PLUMACMS/Email_NO_AT");
		}

	
	if (rc.feedback_SysAdminEmail == "" AND rc.feedback_Email == "")
		this.AddWarning("PLUMACMS/EMAIL_NOT_SETUP");


	if (rc.feedback_email != "" and not rc.feedback_email contains "@")	{
		this.AddWarning("PLUMACMS/Email_NO_AT", [rc.feedback_email]);
		}
		

	if (rc.notif_email != "" and not rc.notif_email contains "@")	{
		this.AddWarning("PLUMACMS/EMAIL_NO_AT");
		}
	
	*/	


	
	}



void function sitemap(required struct rc) output="false"	{

	if (cgi.request_method == "Post")	{
		application.GSAPI.generate_sitemap(rc);
		}	

	}
	


	
	


void function error404(required struct rc) output="false"	{




	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Err", rc);
		
		
		this.AddInfo("SETTINGS_UPDATED");
		
		} // end if

	
	}



void function feedback(required struct rc) output="false"	{

	


	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Feedback", rc);
		
		
		this.AddInfo("PLUMACMS/Feedback_updated");
		

		} // end if

		
	}
	



void function notification(required struct rc) output="false"	{




	if (cgi.request_method == "Post")	{
	
			
		application.IOAPI.set_pref("Notif", rc);
		
		this.AddInfo("SETTINGS_UPDATED");
		

		} // end if

	
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



void function search(required struct rc) output="false"	{


	


	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Search", rc);
		
		
		this.AddInfo("SETTINGS_UPDATED");
		
		} // end if


	}

</cfscript>


<cffunction name="reindex">
	<cfargument name="rc" type="struct" required="true">
	
	<cfquery>
	ALTER FULLTEXT CATALOG ftc_Node REBUILD
	</cfquery>
	
	<cfset this.AddSuccess("PLUMACMS/Index_Rebuilt")> 


	<cfset variables.fw.redirect("settings.search", "all")>
</cffunction>


</cfcomponent>

