
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
		
		var result = application.IOAPI.set_pref("Meta", rc.meta);
		
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

	rc.meta = {
		title  		= "",
		root 		= "",
		description = "",
		keywords 	= "",
		robots 		= "",
		author 		= "",
		email 		= "",
		timezone	= "",
		language	= ""		
		};

	StructAppend(rc.meta, application.IOAPI.get_pref("meta"));


	rc.qryLang = DirectoryList(application.GSLANGPATH, false, "query", "", "name");


	
	rc.xa =	{
		jour404	 			= variables.fw.buildURL(action='support.jour', querystring='kind=404'),
		settings			= variables.fw.buildURL(action = '.home')
		};

	


	
	}



void function sitemap(required struct rc) output="false"	{

	if (cgi.request_method == "Post")	{
		application.GSAPI.generate_sitemap(rc);
		}	

	}
	


	
	


void function error404(required struct rc) output="false"	{




	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Err", rc.err);
		
		
		this.AddInfo("SETTINGS_UPDATED");
		
		} // end if
		
		

	
	}

	
void function enderror404(required struct rc) output="false"	{	
	
	rc.xa =	{
		missing	 			= variables.fw.buildURL(action='home.missing'),
		error404	 		= variables.fw.buildURL(action='support.error404'),
		jour404	 			= variables.fw.buildURL(action='support.jour', querystring='kind=404')
		};

	rc.err = {
		uselog 			= 0,
		subject 		= "",
		sysAdminEmail 	= "",
		email 			= "",
		type 			= ""
		};
	
		
		
	StructAppend(rc.err, application.IOAPI.get_pref("Err"));


	if (rc.err.email != "" and not rc.err.email contains "@")	{
		this.AddWarning("PLUMACMS/Email_NO_AT");
		}


	}


void function feedback(required struct rc) output="false"	{

		

	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Feedback", rc.Feedback);
		
		
		this.AddInfo("PLUMACMS/Feedback_updated");
		

		} // end if



		
	}
	
	
void function endfeedback(required struct rc) output="false"	{	

	rc.xa =	{
		feedback_test 		= variables.fw.buildURL(action='home.feedback'),
		feedback			= variables.fw.buildURL(action = '.feedback')
		};
		
	
		
		
	rc.feedback	=	{
		subject = "",
		sysAdminEmail = "",
		email = ""
		};

	

	StructAppend(rc.feedback, application.IOAPI.get_pref("Feedback"));
	
			
	
	if (rc.feedback.email != "" and not rc.feedback.email contains "@")	{
		this.AddWarning("PLUMACMS/Email_NO_AT", [rc.feedback.email]);
		}
	
	}	



void function notification(required struct rc) output="false"	{






	if (cgi.request_method == "Post")	{
	
			
		application.IOAPI.set_pref("Notif", rc.Notif);
		
		this.AddInfo("SETTINGS_UPDATED");
		

		} // end if
		

	}

	
void function endnotification(required struct rc) output="false"	{	
	
		
	rc.xa =	{
		notification_test 	= variables.fw.buildURL(action='settings.notificationtest'),
		notification 		= variables.fw.buildURL(action = '.notification')
		};
	
			

	rc.notif = {	
		level 			= 0,
		subject 		= "",
		sysAdminEmail 	= "",
		email 			= ""
		};

	
	StructAppend(rc.notif, application.IOAPI.get_pref("Notif"));

	if (rc.notif.email != "" and not rc.notif.email contains "@")	{
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



void function search(required struct rc) output="false"	{


	if (cgi.request_method == "Post")	{
		
		application.IOAPI.set_pref("Search", rc.Search);
		
		
		this.AddInfo("SETTINGS_UPDATED");
		
		} // end if
	}
	
	

void function endsearch(required struct rc) output="false"	{	
	
	rc.xa =	{
		search				= variables.fw.buildURL(action = 'settings.search'),
		reindex				= variables.fw.buildURL(action = 'settings.reindex')
		};
	
	

	
	
	rc.search =	{
		profile 	= 0,
		max 		= 10,
		letters 	= 100,
		parentpage 	= 0,
		tags 		= 0,
		publishDate = 0,
		rank 		= 0
		};	
	
	StructAppend(rc.search, application.IOAPI.get_pref("Search"));	

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

