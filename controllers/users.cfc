

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
		
		rc.UserID = application.USERAPI.set(rc.UserID, rc).UserID;
		
		application.USERAPI.set_profile(rc.UserID, rc);
		application.USERAPI.set_link(rc.UserID, rc);
		
			 
		
		this.AddSuccess("PLUMACMS/USER_SAVED", [rc.login]);
		}

	}	


void function endedit(required struct rc) output="false"	{

	
	
	
	rc.stUser =  application.USERAPI.get(rc.UserID);
	
	rc.qryNode = application.IOAPI.get_all_by_userID("Any", rc.UserID, "CreateDate DESC");
	
	if (rc.stUser.UserID == "" AND isnumeric(rc.UserID))	{
	
		this.AddError("IS_MISSING", [rc.userid]);
	
		variables.fw.redirect("users.home", "all");
		
		return;
		}
		

	
	StructAppend(rc.stUser, application.USERAPI.get_profile(rc.UserID));
		
	// Shared with pages
	rc.qryLink = application.USERAPI.get_link(rc.UserID); 
	
	rc.qryLinkCategory = application.IOAPI.get_All_By_Extra("Facet", "Link_Category", "Title");
	}	
	
	
	




// Make it handle a list
void function delete(required struct rc) output="false"	{

	param rc.userid = "";
	
	if (not isnumeric(rc.userid))	{
	
		this.AddError("NOT_FOUND", [rc.userid]);
		variables.fw.redirect("users.home", "all");
		}
	
		
	application.USERAPI.delete(rc.UserID);
	
	
	// Results
	this.AddSuccess("PLUMACMS/User_deleted", [rc.userid]);

	variables.fw.redirect("users.home", "all");
	}
	




void function renew(required struct rc) output="false"	{
	
	param rc.expiration = "renew";
	
	var result = application.USERAPI.renew(rc.userid, rc.expiration );

	if (result)	{
		this.AddSuccess("PLUMACMS/RENEW_SUC");
		}

	variables.fw.redirect("users.home", "all");
	}



</cfscript>



</cfcomponent>

