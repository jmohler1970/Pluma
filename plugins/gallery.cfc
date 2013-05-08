<cfcomponent>

<cfscript>


thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");

function Init()	{

this.stPlugin_info =
	application.GSAPI.register_plugin(thisFile, 
		'Gallery',
		'0.1',
		'James Mohler',
		'',
		'Settings for Gallery',
		'theme',
		'',
		'icon-cog');
	
		application.GSAPI.add_action('nav-tab', 'createNavTab', ["?plugin=gallery", "Gallery/TAB_NAME", "gallery"]);
		
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery", "GALLERY/PLUGIN_NAME", "gallery"]);
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery&plx=edit", "GALLERY/ADD_TITLE", "gallery"]);
	//	application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery&plx=options", "GALLERY/SETTINGS", "gallery"]);	
	}
		
</cfscript>

<cffunction name="settings" returnType="struct">



	<cfswitch expression="#rc.plx#">
	<cfcase value="edit">
		<cfscript>
		var NodeK = {NodeID = rc.NodeID, Kind = "Gallery"};
		
		
		// Post
		if (cgi.request_method == "post")	{
	
		
		if (rc.submit CONTAINS "Reactivate")	{
			application.IOAPI.Reactivate(rc.NodeID);
			}
	
		if (rc.submit == "Save")	{
			
				
				
			var stResult = application.IOAPI.set(NodeK, rc);
		
			if (not stResult.result)	{
				throw (stResult.key);
			
				this.AddError(stResult.key);
				
				return;
				}
		
			rc.NodeID = stResult.NodeID;
			NodeK.NodeID = rc.NodeID;
			
			if (NodeK.NodeID > 0)	{	
				application.IOAPI.set_Link(NodeK, rc);
				}
			
			//Application.IOAPI.AddSuccess("ER_YOUR_CHANGES", [rc.slug]);				
					
			}
			
		} // end post
	
	
		StructAppend(rc, application.IOAPI.get_bundle(NodeK));
	
		
		
		param rc.path		= "";
		
		rc.thumbspath 	= "data/thumbs/";
		rc.totalsize 		= 0;
		rc.qryDirectory		= QueryNew("Empty");
	
		rc.path = replace(rc.path, '|', '/', 'all');
	
	
		if (not DirectoryExists(application.GSDATAUPLOADPATH & rc.path))	{
			this.addInfo("NOT_FOUND", [rc.path]);
		
			return;
			}	
	
		rc.qryDirectory = DirectoryList(application.GSDATAUPLOADPATH & rc.path, 
			false, "query", "", "type,name");
	
	
	
		for (var j = 1; j <= rc.qryDirectory.recordcount; j++)	{
			rc.totalsize += rc.qryDirectory.size[j];
			}
	
		rc.totalsize = rc.totalsize \ 1024; 
		</cfscript>	
	
		<cfsavecontent variable="variables.stResult.Content">
			<cfinclude template="gallery/edit.cfi"> 
		</cfsavecontent>	
	</cfcase>
	<cfcase value="delete">
		<cfparam name="rc.NodeID" default="">
		
		<cfset application.IOAPI.delete({Kind = "Gallery", NodeID = rc.NodeID})>
	
		<cflocation url="?plugin=gallery" addToken="no">
	</cfcase>
	<cfdefaultcase>
		<cfset rc.qryGallery = application.IOAPI.get_all("Gallery", {}, 'Title')>
		
		<cfsavecontent variable="variables.stResult.Content">
			<cfinclude template="gallery/home.cfi"> 
		</cfsavecontent>	
		
		
	</cfdefaultcase>
	</cfswitch>


	<cfreturn variables.stResult>
</cffunction>


</cfcomponent>

