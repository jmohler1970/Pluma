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
	
	
		application.GSAPI.add_action('nav-tab', 		"createNavTab", 	["?plugin=gallery", "Gallery/TAB_NAME", "gallery"]);
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu",	["?plugin=gallery", "GALLERY/PLUGIN_NAME", "gallery"]);
		application.GSAPI.add_action("gallery_sidebar", "createSideMenu", 	["?plugin=gallery&plx=edit", "GALLERY/ADD_TITLE", "gallery"]);
	//	application.GSAPI.add_action("gallery_sidebar", "createSideMenu", ["?plugin=gallery&plx=options", "GALLERY/SETTINGS", "gallery"]);	
	
		application.GSAPI.add_filter("content", "gallery", "display_gallery");
	
		application.GSAPI.register_style('colorbox', 	'~/plugins/gallery/assets/colorbox.css', 	'2.0.4', "screen");
		application.GSAPI.register_script('colorbox', 	'~/plugins/gallery/assets/jquery.colorbox.js', 	'2.0.4', false);
		application.GSAPI.register_script('colorbox', 	'~/plugins/gallery/assets/ready.js', 	'2.0.4', true);
	}
		
</cfscript>



<cffunction name="display_gallery" returnType="string" output="false" hint="uses colorbox">
	<cfargument name="strIn" type="string" required="true">
	<cfargument name="rc" type="struct" required="true">

		
	<cfset rc.thumbspath 	= "data/thumbs/">	
	<cfset var stResults = {}>
	<cfset var qryGallery = application.IOAPI.get_link({Kind = "Gallery"})>
	<cfset rc.path = "">
	
	<cfoutput query="qryGallery" group="NodeID">
		<cfset var gallery = "">
		
		
		<cfsavecontent variable="gallery">
		<ul>
		<cfoutput>
			
		 
			<li><a class="group4" href="#application.GSAPI.get_site_root()##rc.thumbspath##rc.path#/#type#" title="#message#">
				<img src="#application.GSAPI.get_site_root()##rc.thumbspath##rc.path#/#type#" alt="#type#" style="width : 100px;" /></a></li>
					
	
		</cfoutput>	
		<ul>
		</cfsavecontent>
		
		
		<cfset strIn = replace(strIn, "{gallery_#NodeID#}", trim(gallery), "all")>
	</cfoutput>


	<cfreturn strIn>
</cffunction>



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
			
			// Add page if it does not exist
			application.IOAPI.set({Kind="Page"}, {
				slug = "gallery_#rc.nodeid#",
				title = "Gallery : #rc.title#",
				strData = "{gallery:#rc.NodeID#}",
				allowupdate = 0
				});
			
			//location("?plugin=gallery", "no");			
			
		} // end post
	
	
		StructAppend(rc, application.IOAPI.get_bundle(NodeK));
	
		
		
		param rc.path		= "";
		
		rc.thumbspath 	= "data/thumbs/";
		rc.totalsize 		= 0;
		rc.qryDirectory		= QueryNew("Empty");
	
		rc.path = replace(rc.path, '|', '/', 'all');
	
	
		if (not DirectoryExists(application.GSDATAUPLOADPATH & rc.path))	{
		//	this.addInfo("NOT_FOUND", [rc.path]);
		
			return;
			}	
	
		rc.qryDirectory = DirectoryList(application.GSDATAUPLOADPATH & rc.path, 
			false, "query", "", "type,name");
	
	
	
		for (var j = 1; j <= rc.qryDirectory.recordcount; j++)	{
			rc.totalsize += rc.qryDirectory.size[j];
			}
	
		rc.totalsize = rc.totalsize \ 1024; 
		
		// path pulldown
		rc.qryPath = DirectoryList(application.GSDATAUPLOADPATH, 'true', 'query');
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

