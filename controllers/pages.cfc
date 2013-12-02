

<cfcomponent extends="base">


<cfscript>
function init(fw) { 
	variables.fw = fw; 
	variables.Kind = "Page";
	}


struct function before(required struct rc) output="false" {



		
	param rc.plugin = "";
	
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("pages.settings", "all");
		}
	
			
	return rc;
	}


void function starthome(required struct rc) output="false" {
	
	param rc.filter = "";
	param rc.group = "";
	param rc.pstatus = "";
	param rc.commentmode = "";
	param rc.recent = false;
	

	}


void function home(required struct rc) output="false" {
	

	 
	
	
	
	if (isDefined("rc.Mode")) {
		switch (rc.Mode)	{
		case "all" :
			rc.qryPage = application.IOAPI.get_all("Page", {}, 'Title');
			return;
			break;
			}
		}
		

	}
	
void function endhome(required struct rc) output="false" {
	
	
	rc.qryAllPages = application.IOAPI.get_page_parent();
	}	
	



void function edit(required struct rc) output="false" {
		

	param rc.NodeID = "";
	param rc.ParentNodeID = "";
	param rc.submit = "Save";		
		
	// Post
	if (cgi.request_method == "post")	{
	
		
		if (rc.submit CONTAINS "Reactivate")	{
			application.IOAPI.Reactivate(rc.NodeID);
			}
	
		if (rc.submit == "Save")	{
			
					
			var NodeK = {NodeID = rc.NodeID, Kind = "Page"};	
			
			
			application.GSAPI.exec_action('changedata-save', "", rc);
				
			var stResult = application.IOAPI.set(NodeK, rc);
		
			if (not stResult.result)	{
				this.AddError(stResult.key, [stResult.message]);
				
				return;
				}
		
			rc.NodeID = stResult.NodeID;
			NodeK.NodeID = rc.NodeID;
			
			if (NodeK.NodeID > 0)	{	
				application.IOAPI.set_Link(NodeK, rc.Link);
				
				application.IOAPI.set_Conf(NodeK, rc.Conf);
				}
			
			application.GSAPI.exec_action('changedata-aftersave', "", rc);
			//application.GSAPI.generate_sitemap({});
			
			this.AddSuccess("ER_YOUR_CHANGES", [rc.slug]);				
					
			}
			
		} // end post
	
	}


	
void function endedit(required struct rc) output="false" {	
	
	var NodeK = {NodeID = rc.NodeID};	
	
	StructAppend(rc, application.IOAPI.get_bundle(NodeK));
	
	rc.lstTheme_template = "";
	
	param request.Theme.current = "";
	

	var qryTheme = DirectoryList(application.GSTHEMESPATH & request.Theme.current & "/", false, "query");
	
	for (var i = 1; i <= qryTheme.recordcount; i++)	{
		if (qryTheme.type[i] == "File" AND qryTheme.name[i] != "functions.cfm" AND qryTheme.name[i] CONTAINS "cfm")	{
			rc.lstTheme_template = ListAppend(rc.lstTheme_template, qryTheme.name[i]);
			}
		
		}		

	rc.myPath = application.GSAPI.get_path({NodeID = rc.NodeID, Kind = "Page"}, "internal", "breadcrumb");

		
	}



	
	
void function delete(required struct rc) output="false" {



	var stResult = application.IOAPI.delete({NodeID = rc.NodeID});
	
	application.GSAPI.generate_sitemap({});
	application.GSAPI.exec_action("page-delete", "", rc);
			
	this.AddInfo(stResult.key);
	
	variables.fw.redirect("pages.home", "all");
	}
		
		
	
// Link 

void function addLink(required struct rc) output="false" {

	application.IOAPI.add_link({NodeID = rc.NodeID}, rc);

	var message = "Page Link added";
		
	this.AddInfo("PLUMACMS/Link_Added");
	

	variables.fw.redirect('pages.edit?tab=link', "all");		
	}		




void function saveLink(required struct rc) output="false" {

	
	if (cgi.request_method == "post")	{
	

	
		switch (rc.submit)	{
			case "Add" :

				stResult = application.IOAPI.add_link({NodeID = rc.NodeID}, rc);

		
				this.AddInfo(stResult.key);
			break;
			
			case "Save" :
						
				stResult = application.IOAPI.set_link({NodeID = rc.NodeID}, rc);

		
				this.AddInfo(stResult.key);

			break;
		
			} // end switch
		} // end post


		
	this.AddInfo("PLUMACMS/link_saved");

	

	variables.fw.redirect('pages.edit', "all");		
	}
	


		
/* menu */
void function menu(required struct rc) output="false" {


	if (cgi.request_method == "post")	{
		var arNode = ListToArray(rc.ProcessNodeID);
		
		
		for (var i = 1; i <= ArrayLen(arNode); i++)	{
		
			var menusort = evaluate("rc.MenuSort_#arNode[i]#");
		
			application.IOAPI.set_taxonomy({NodeID = arNode[i], Kind="Page"}, {
				tags = "skip", facet = "skip",
		 		menuorder = menusort, 
		 		menu = 'skip'}
		 		);
				
			}
		
		this.AddInfo("MENU_MANAGER_SUCCESS");
		}



	}
	
void function endmenu(required struct rc) output="false" {

	rc.qryMenu = application.IOAPI.get_all("Page", {}, "Menu");
	
	if (rc.qryMenu.recordcount == 0)	{
		this.AddInfo("PLUMACMS/ISEMPTY", ["Menu"]);		
		}
		
	}




void function tags(required struct rc) output="false"	{

		
	// This is managed over there
	if (rc.plugin != "")	{
	
		variables.fw.redirect("pages.settings", "all");
		}
	 

	
	rc.qryTags = application.IOAPI.get_all_tags();	
	}
		
		
void function linkCategory(required struct rc) output="false"	{
	cacheRemove("Link_Category");

	
	if (cgi.request_method == "post")	{
		application.IOAPI.add_taxonomy("Link_Category", rc.Title);
		
		
		this.AddInfo("plumacms/link_cat_added", [rc.title]);
	
		}
		

	rc.qryLinkCategory = application.IOAPI.get_All_By_Extra("Facet", "Link_Category", "Title"); 	
	}


void function linkCategoryDelete(required struct rc) output="false"	{
	

	
	if (not isnumeric(rc.Nodeid))	{
			
		this.addError("plumacms/link_cat_del_err");
		
		variables.fw.redirect('pages.linkcategory', "all");
		return;
		}
	
	application.IOAPI.delete({NodeID = rc.NodeID, Kind = "Facet"}); 
		
	
	this.AddInfo("plumacms/link_cat_del", [rc.NodeID]);

	
	variables.fw.redirect('pages.linkcategory', "all");
	
	}
		
	
		

void function find(required struct rc) output="false"	{


		
	// This is managed over there
	if (rc.plugin != "")	{
	
		variables.fw.redirect("pages.settings", "all");
		}
	 


	param rc.kind ="All";
	param rc.taxonomy = true;
	
	param rc.archive = "";
	param rc.tag = "";
	param rc.search = "";
	
	
	
	param rc.StartAt = "1";
	if (rc.startAt <= 0 OR NOT isnumeric(rc.startAt))	{
		rc.StartAt = 1;
		}
	
	
	if (rc.startAt <= 0 OR NOT isnumeric(rc.startAt))	{
		rc.StartAt = 1;
		}
	
	
	
	else if (rc.archive != "")	{
		rc.qryPage		= application.IOAPI.getByArchive(rc.Archive, rc.Kind);
		}
	else if (rc.tag != "")	{
		rc.qryPage		= application.IOAPI.getByTag(rc.Tag, rc.Kind);
		}
	else if (rc.search != "")	{
		rc.qryPage		= application.IOAPI.get_by_search(rc.Search, rc.Kind);
		}
	else	{
		rc.qryPage		= QueryNew("");
		}


	}


	
	
void function after(required struct rc) output="false" {	
	
	super.after(rc);
	
	rc.qryLinkCategory = application.IOAPI.get_All_By_Extra("Facet", "Link_Category", "title");
	
	request.qryPageParent = application.IOAPI.get_page_parent();
	
	}
	
</cfscript>


</cfcomponent>


