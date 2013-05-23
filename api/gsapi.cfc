
<!--- Expected to be tied into application scope --->


<cfcomponent extends="base">

<cfscript>
void function init() output="false"{

	this.i18n_data = {}; // For language strings
	
	this.stFilter = {};	// For data that will be subsituted
	
	this.GS_scripts = queryNew("handle,src,ver,in_footer,sortby"); // JavaScript, sortby low is first
	this.GS_styles 	= queryNew("handle,src,ver,media,sortby");
	}




void function i18n_merge(string plugin="") output="false"{

	
	
	if (arguments.plugin == "") {
		
		var fileToRead = "#application.GSLANGPATH##request.Meta.language#.properties";	
		}
	else	{
		
		var fileToRead = "#application.GSPLUGINPATH##arguments.plugin#\lang\#request.Meta.language#.properties";	
		}	


	try	{
		StructAppend(this.i18n_data, this.readPropertiesFile(filetoRead, arguments.plugin));
		}
	catch (any e)	{ this.InitStatus = "Unable to read language file: #e.message#."; }
		
	}


/* i18n strings */	
string function i18n(required string key, array placeholder = []) output="false"	{

	if (structKeyExists(this.i18n_data, arguments.key))	{
		
		var myString = this.i18n_data[arguments.key];
		
		
		for (var i in arguments.placeholder)	{
		
			myString = replace(myString, '%s', i); // only does first match
			}
	
		return myString;
		}
		
	
	return "{#arguments.key#}";
	}	



public string function get_plugin_content(){
	
	if (not isDefined("request.stIOR.qryNode.plugin_content"))	{
		return "";
		}
	
	return request.stIOR.qryNode.plugin_content;
	}



/**
* @hint Gets the normal page content if there isn't a pluggin content instead
*/	
public string function get_page_content(){

	var plugin_content = this.get_plugin_content();


	if (plugin_content != "")	{
		// plugins must inject content as necessary into content-top and content-bottom

		try	{
			this.run_plugin(
				listfirst(plugin_content, '_'),
				listlast(plugin_content, '_'),
				request.stIOR);
			}
				
			catch (any e) {;}
		}
	
		
	local.result = "";	
		
	local.result &= this.exec_action('content-top');	
		

	if (not isnull(request.stIOR.qryNode.strData))	{
		local.result &= this.exec_filter(request.stIOR.qryNode.strData); // no strip decode here
		}	
	
	local.result &= this.exec_action('content-bottom');	
	
	
	return local.result;
	}
	
	
/**
* @hint Get Page Excerpt
*/		
public string function get_page_excerpt(numeric n=200){
	
	// we are happy if we are a few bytes off. 
	return left(this.strip_tags(request.stIOR.qryNode.strData), arguments.n);
	}

	
/**
* @hint Get Page Meta Keywords
*/		
	
public string function get_page_meta_keywords()	{

	if (StructKeyExists(request.stIOR, "tags"))	{
		return xmlformat(request.stIOR.tags);
		}
	
	return "";	
	}

/**
* @hint Currently global, not per page
*/	
public string function get_page_meta_desc()	{
	
	if (structkeyexists(request.Meta, "Description"))	{
		return this.strip_tags(request.Meta.Description);
		}
		
	return "";	
	}

/**
* @display Get Page Title
* @hint Page title with markup
*/
public string function get_page_title()	{
	
	return request.stIOR.qryNode.title;
	}
	

/**
* @display Get Page Clean Title
* @hint Page title without markup
*/	
public string function get_page_clean_title()	{
	return this.strip_tags(request.stIOR.qryNode.title);
	}
	
	
/**
* @display Get Page Subtitle
* @hint Page subtitle with markup
*/
public string function get_page_subtitle()	{
	
	return request.stIOR.qryNode.subtitle;
	}	
	
	
/**
* @display Get Page Slug
* @hint Slug back to self
*/	
string function get_page_slug()	{
	return request.stIOR.qryNode.slug;
	}

	
/**
* @display Parent slug could be blank
*/	
string function get_parent()	{
	request.stIOR.qryNode.parentslug;
	}
	

/**
* @display Get Page Date
*/	
	
string function get_page_date()	{
	// Currently does not do any timezone stuff
	return LSDateFormat(request.stIOR.qryNode.ModifyDate);
	}


/**
* @hint This is used to create canonical links. Slugs can change, canonical links can't
*/
string function get_page_url()	{
	if (isDefined("request.Meta.root"))
		return request.Meta.root;
		
	return "";	
	}

</cfscript>


<cffunction name="get_header">
	<cfargument  name="full" required="false" default="true" type="boolean">

	<!--- configuration.php settings should be in application.cfc --->

	<cfoutput>
	<meta name="description" 	content="#this.strip_tags(this.get_page_meta_desc())#" />
	<meta name="keywords" 		content="#this.strip_tags(this.get_page_meta_keywords())#" />
	
	<cfif arguments.full>
		<meta name="generator" 	content="#application.GSSITE_FULL_NAME#" />
		<link rel="canonical" 	href="#this.get_page_url()#" />
	
		
		#this.get_scripts_frontend()#
		#this.exec_action('theme-header')#
	</cfif>
	</cfoutput>
</cffunction>


<cfscript>
/**
* @display Get Footer
* @hint Links to admin edit page. It blank if user can't edit
*/	
string function get_footer()	{
	this.exec_action('theme-footer');
	}
	

/**
* @display Get Site URL
* @hint Links to admin edit page. It blank if user can't edit
*/	
string function get_site_url()	{
	if (isDefined("request.Meta.root"))
		return request.Meta.root;
		
	return "";	
	}

	
/**
* @display Get Theme URL
* @hint Links to theme template. This is good for paths to theme specific css and js. Does not end in / because GS does not
*/	
string function get_theme_url()	{
	
	return request.Meta.root & "theme/" & this.get_theme();
	}

/**
* @display Get Site Name
*/	
string function get_site_name()	{
	
	return isDefined("request.Meta.title") ? request.Meta.title : "";
	}
	
string function get_site_credits(string poweredby = "Powered By")	{

	return '#arguments.poweredby# <a href="#application.GSSITE_LINK_BACK_URL#" target="_blank">#application.GSSITE_FULL_NAME#</a> &mdash; #application.GSVersion#';
	}


query function menu_data() output="false" {
	
	return application.IOAPI.get_all("Page", {}, "Menu");
	}	
	

	

string function get_component(required string id) {
	
	if (isDefined("request.Components.#arguments.id#"))
		return replace(request.Components[arguments.id], "~/" , this.get_site_root() , "all");
	
	return "<b>Error:</b> Component <tt>#arguments.id#</tt> could not be found. You can add this component in themes -> edit components.";
	} 





string function get_navigation(string currentslug = "") {

	var qryMenu = this.menu_data();
	
	var result = "";
	
	for (var i = 1; i <= qryMenu.recordcount; i++)	{
		
		result &= '<li title="#qryMenu.title[i]#" '; 
		if (currentslug == qryMenu.slug[i])
			result &= 'class="current #qryMenu.slug[i]#"';
		else
			result &= 'class="#qryMenu.slug[i]#"'; 
		// endif
		result &= '><a href="#this.find_url(qryMenu.slug[i])#">#qryMenu.menu[i]#</a></li>';
		}
	
	return result;
	}


boolean function is_logged_in() {	
	
	return session.LOGINAPI.UserID == "" ? false : true;
	
	}


void function register_script(string handle, string src, string ver, boolean in_footer=false, numeric sortBy=5)	{
	
	arguments.src = replacelist(arguments.src, "~/", this.get_site_url());
	
	QueryAddRow(this.GS_scripts);
	QuerySetCell(this.GS_scripts, "handle", 	arguments.handle);
	QuerySetCell(this.GS_scripts, "src", 		arguments.src);
	QuerySetCell(this.GS_scripts, "ver", 		arguments.ver);
	QuerySetCell(this.GS_scripts, "in_footer", 	arguments.in_footer);
	QuerySetCell(this.GS_scripts, "sortby", 	arguments.sortby);
	}

</cfscript>


<cffunction name="get_scripts_frontend" returnType="string" output="false">
	<cfargument name="footer" type="boolean" default="0">

	<cfset	var strResult = "">
	<cfset var qryTemp = this.GS_scripts>

	<cfif not arguments.footer>
		<cfset strResult = this.get_styles_frontend()>
	</cfif>
	
	<cfquery name="qryScripts" dbtype="query">
		SELECT 	in_footer, src, ver
		FROM 	qryTemp
		ORDER BY SortBy
	</cfquery>
	
	<cfloop query="qryScripts">
		<cfset strResult &= '<script src="#src#?v=#ver#"></script>
		'>
	</cfloop>
	
	<cfreturn strResult>	
</cffunction>




<cfscript>

void function register_style(string handle, string src, string ver="", string media="")	{
	
	arguments.src = replacelist(arguments.src, "~/", this.get_site_url());
	
	
	QueryAddRow(this.GS_styles);
	QuerySetCell(this.GS_styles, "handle", 	arguments.handle);
	QuerySetCell(this.GS_styles, "src", 	arguments.src);
	QuerySetCell(this.GS_styles, "ver", 	arguments.ver);
	QuerySetCell(this.GS_styles, "media", 	arguments.media);
	}



string function get_styles_frontend() {

	var strResult = "";

	
	for(var i = 1; i <= this.GS_styles.recordcount; i++)	{
											strResult &= '<link href="#this.GS_styles.src[i]#';
		if (this.GS_styles.ver[i] != "") 	strResult &= '?v=#this.GS_styles.ver[i]#';	
		
											strResult &= '" rel="stylesheet" type="text/css"';
		if (this.GS_styles.media[i] != "") 	strResult &= ' media="#this.GS_styles.media[i]#"';		
											strResult &= "/>
";
		
		}

	return strResult;
	} 



struct function generate_sitemap(required struct rc) output="false"	{

	param rc.submit = "";
	param rc.siteMapID = "";
	param rc.entrycount = 0;

	rc.siteroot = "http://#cgi.http_host##cgi.script_name#/";
	var target = application.GSROOTPATH & "/sitemap.xml";
			

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
	
	

	application.GSAPI.exec_action("save-sitemap", "", rc);
	
	filewrite(target, strSiteMap);
	


	return stResult;		
	}




/* Everything above was in theme_functions.php */
	



/**
* @hint Site's theme
*/
string function get_theme()		{
	
	if (isDefined("request.Theme.current"))
		return request.Theme.current;
	
	return "";	
	}

/**
* @hint Site's theme's particular template
*/
string function get_theme_template()		{

	if (isDefined("request.stIOR.qryNode.theme_template"))	{
		if (request.stIOR.qryNode.theme_template != "")
			return request.stIOR.qryNode.theme_template;
		}
	
	return "template.cfm";
	
	}




string function get_site_root()	{
	if (isDefined("request.Meta.root") AND request.Meta.root NEQ "")
		return request.Meta.root;
		
	return "/";	
	}




string function get_site_email()	{
	
	if (isDefined("request.Meta.email"))
		return request.Meta.Email;
	
	return "";
	}
	

/* Converts slugs to proper urls */
string function find_url(required string slug) {
	
	if (arguments.slug == 'index')	{
		return request.Meta.root;
		}
	
	return "#request.Meta.root#/index.cfm/main/#arguments.slug#";
	}


/* Does all string replacements */
string function exec_filter(required string strIn) output="false"	{
	
	for (var i in this.stFilter)	{
		strIn = replace(strIn, "{#i#}", this.stFilter[i], "all");		
		}
		
	return strIn;	
	}	




// Suggestion function for SITEURL variable
string function suggest_site_path() {

		
	fullpath = "http://" & cgi.server_name & "/";
		
		
	return fullpath;

}


string function get_site_version() {


	return application.GSVERSION;
	}
</cfscript>



<cffunction name="get_path" returnType="string">
	<cfargument name="NodeK" required="true" type="struct"> 
	<cfargument name="mode" required="false" type="string" default="internal">
	<cfargument name="class" required="false" type="string" default="">
	<cfargument name="base" required="false" type="string" default="/index.cfm/pages/edit/NodeID/">
	
	

<cfscript>
	// Do not catche. This is not used repeteively anyway
	var qryNodePath = application.IOAPI.get_path(arguments.NodeK);
</cfscript>


<cfsavecontent variable="strResult"> 
<cfoutput query="qryNodePath">
	
		
		<cfset MyTitle = xmlformat(title)>
		<cfif title EQ "">
			<cfset MyTitle = "<i>No Title</i>">
		</cfif>

	
		<cfif arguments.mode EQ "internal">
			/ <a href="#arguments.base##NodeID#" rel="tooltip" title="Kind: #kind#" class="#arguments.class#">#MyTitle#</a>
			
		<cfelse>
			<a href="#this.find_url(slug)#" class="#arguments.class#">#MyTitle#</a>
			/
		</cfif>
		

	
</cfoutput>
</cfsavecontent>

	<cfreturn trim(strResult)>

</cffunction>


<cffunction name="run_plugin" returnType="struct">
	<cfargument name="plugin" 	required="true" 	type="string" hint="what plugin">
	<cfargument name="action" 	required="true" 	type="string" hint="what function to run in plugin">
	<cfargument name="rc" 		required="true" 	type="struct" hint="data to pass in">
	


		<!--- It would be better to check if function exists --->
		
	<cftry>
		
		
		<cfinvoke  component = "plugins.#arguments.plugin#"  
	    	method			= "#arguments.action#"  
	    	returnVariable	= "stResult"> 
	    	<cfinvokeargument name="rc" value="#arguments.rc#">
		</cfinvoke>

		<cfparam name="stResult.priority" default="Info">
	<cfcatch>
		<cfset stResult.priority = "Error">
		<cfset stResult.message = cfcatch.message & cfcatch.detail>
	</cfcatch>
	</cftry>
	

	<cfreturn stResult>
</cffunction>


<cffunction name="exec_action" returnType="string">
	<cfargument name="action" 	required="true" type="string" hint="what function to run in plugin">
	<cfargument name="selected" required="false" type="string" default="">
	<cfargument name="rc" 		required="false" type="struct" default="#structNew()#">
	

	
	<cfsavecontent variable="local.result">



	<cfloop from="1" to="#ArrayLen(request.arPlugins)#" index="i">
		<cfif request.arPlugins[i].hook_name EQ arguments.action>
			
			<cfswitch expression="#request.arPlugins[i].added_function#">
			
			<cfcase value="CreateSideMenu">
				<cfoutput>
					<li id="sb_#request.arPlugins[i].attr[3]#"><a 
						href="#request.arPlugins[i].attr[1]#"
						<cfif arguments.selected EQ request.arPlugins[i].attr[1]>class="current"</cfif>
						>#this.i18n(request.arPlugins[i].attr[2])#</a></li>	
				</cfoutput>
			</cfcase>
			
			<cfcase value="CreateSelectMenu">
				<cfoutput>
					<option value="#request.arPlugins[i].attr[1]#"
						<cfif request.arPlugins[i].attr[1] EQ arguments.selected>selected="selected"</cfif>
						>#this.i18n(request.arPlugins[i].attr[2])#</option>	
				</cfoutput>
			</cfcase>
			
			<cfcase value="CreateNavTab">
				<cfoutput>
					<li><a 
						href="#this.loadtab##request.arPlugins[i].attr[1]#"
						<cfif arguments.selected EQ request.arPlugins[i].attr[1]>class="tabSelected"</cfif>
						>#this.i18n(request.arPlugins[i].attr[2])#</a>
					</li>	
						
				</cfoutput>
			</cfcase>
			
			<cfdefaultcase>
				<cfoutput> 
				<!-- Run: plugins.#request.arPlugins[i].attr[1]#.#request.arPlugins[i].added_function# -->
				</cfoutput>
			
				<cftry>
					<cfinvoke component="plugins.#request.arPlugins[i].attr[1]#" 
						method="#request.arPlugins[i].added_function#">
						<cfinvokeargument name="rc" value="#arguments.rc#">
					</cfinvoke>	
												
				
				
				<cfcatch><cfoutput><p class="error">#cfcatch.message#</p></cfoutput></cfcatch>
				</cftry>
				
			</cfdefaultcase>
			</cfswitch>
		</cfif>
	</cfloop>
	</cfsavecontent>
	
	
	<cfreturn local.result>
</cffunction>


<!--- Plugin functions --->
<cfscript>
struct function register_plugin(required string id, required string name, string ver = "", string auth = "", string auth_url = "", string desc = "", string type = "", string loaddata = "", string icon = "")	{

	return {
		id 			= arguments.id,
		name 		= arguments.name,
		version 	= arguments.ver,
		author 		= arguments.auth,
		author_url 	= arguments.auth_url,
		description = arguments.desc,
		page_type 	= arguments.type,
		load_data 	= arguments.loaddata,
		icon		= arguments.icon
		};
		
	}


function add_action(required string hook_name, required string added_function, required array attr)	{

	param request.arPlugins = []; // has a stack of all the activities

	
	
	ArrayAppend(request.arPlugins, {hook_name = arguments.hook_name, added_function = arguments.added_function, attr = arguments.attr});
	}

/* This is very different from GetSimple */
void function add_filter(required struct filter_data) output="false"	{
	
		
	StructAppend(this.stFilter, arguments.filter_data);	
	}



</cfscript>


</cfcomponent>


