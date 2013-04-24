
<!--- Expected to be tied into application scope --->


<cfcomponent extends="base">

<cfscript>
void function init() output="false"{

	try	{
		this.i18n = this.readPropertiesFile("admin/lang/en_US.properties");
		}
	catch (any e)	{ this.InitStatus = "Unable to read language file."; }
		
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
		local.result &= request.stIOR.qryNode.strData; // no strip decode here
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
		return request.stIOR.tags;
		}
	
	return "";	
	}

/**
* @hint Currently global, not per page
*/	
public string function get_page_meta_desc()	{
	
	if (structkeyexists(request.stMeta, "Description"))	{
		return this.strip_tags(request.stMeta.Description);
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
	if (isDefined("request.stMeta.root"))
		return request.stMeta.root;
		
	return "";	
	}

</cfscript>


<cffunction name="get_header">
	<cfargument  name="full" required="false" default="false" type="boolean">

	<!--- configuration.php settings should be in application.cfc --->

	<cfoutput>
	<meta name="description" 	content="#this.strip_tags(this.get_page_meta_desc())#" />
	<meta name="keywords" 		content="#this.strip_tags(this.get_page_meta_keywords())#" />
	
	<cfif arguments.full>
		<meta name="generator" 	content="#application.GSSITE_FULL_NAME#" />
		<link rel="canonical" 	href="#this.get_page_url()#" />
	
		<!---
		<cfset this.get_scripts_frontend()>
		--->
		
		<cfset this.exec_action('theme-header')>
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
	if (isDefined("request.stMeta.root"))
		return request.stMeta.root;
		
	return "";	
	}

	
/**
* @display Get Theme URL
* @hint Links to theme template
*/	
string function get_theme_url()	{
	
	return request.stMeta.root & "theme/" & this.get_theme();
	}

/**
* @display Get Site Name
*/	
string function get_site_name()	{
	
	if (isDefined("request.stMeta.title"))
		return request.stMeta.title;
		
	return "";	
	}
	
string function get_site_credits(string poweredby = "Powered By")	{

	return '#arguments.poweredby# <a href="#application.GSSITE_LINK_BACK_URL#" target="_blank">#application.GSSITE_FULL_NAME#</a> &mdash; #application.GSVersion#';
	}


query function menu_data() output="false" {
	
	return application.IOAPI.get_all("Page", '', "Menu");
	}	
	

	

string function get_component(required string id) {
	
	if (isDefined("request.stComponents.#arguments.id#"))
		return replace(evaluate("request.stComponents.#arguments.id#"), "~/" , this.get_site_root() , "all");
	
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



string function get_scripts_frontend() {;} // not implemented
/* Everything above was in theme_functions.php */
	








/**
* @hint Site's theme
*/
string function get_theme()		{
	
	if (isDefined("request.stTheme.current"))
		return request.stTheme.current;
	
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
	if (isDefined("request.stMeta.root") AND request.stMeta.root NEQ "")
		return request.stMeta.root;
		
	return "/";	
	}




string function get_site_email()	{
	
	if (isDefined("request.stMeta.email"))
		return request.stMeta.Email;
	
	return "";
	}
	

/* Converts slugs to proper urls */
string function find_url(required string slug) {
	
	if (arguments.slug == 'index')	{
		return "/";
		}
	
	return "/index.cfm/main/#arguments.slug#";
	}

	
/* i18n strings */	
string function i18n(required string key) output="false"	{

	if (structKeyExists(this.i18n, arguments.key))	{
		/*
		if (isDebugMode())	{
			return '<span class="outline">#evaluate("this.i18n.#arguments.key#")#</span>';
			}
		*/
	
		return evaluate("this.i18n.#arguments.key#");
		}
		
	
	return "{#arguments.key#}";
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
	<cfargument name="base" required="false" type="string" default="/index.cfm/admin:pages/edit/NodeID/">
	
	

<cfscript>
	// Do not catche. This is not used repeteively anyway
	var qryNodePath = application.IOAPI.get_path(arguments.NodeK);
</cfscript>


<cfsavecontent variable="strResult"> 
<cfoutput query="qryNodePath">
	
		
		<cfset MyTitle = htmleditformat(title)>
		<cfif title EQ "">
			<cfset MyTitle = "<i>No Title</i>">
		</cfif>

	
		<cfif arguments.mode EQ "internal">
			/ <a href="#arguments.base##NodeID#" rel="tooltip" title="Kind: #kind#" class="#arguments.class#">#MyTitle#</a>
			
		<cfelse>
			<a href="/index.cfm/main/#slug#" class="#arguments.class#">#MyTitle#</a>
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
	<cfargument name="action" required="true" 	type="string" hint="what function to run in plugin">
	<cfargument name="selected" required="false" type="string" default="">


	<cfsavecontent variable="local.result">

	<cfloop from="1" to="#ArrayLen(request.arPlugins)#" index="i">
		<cfif request.arPlugins[i].hook_name EQ arguments.action>
			<cfswitch expression="#request.arPlugins[i].added_function#">
			
			<cfcase value="CreateSideMenu">
				<cfoutput>
					<li><a href="#request.arPlugins[i].attr[1]#"
						<cfif arguments.selected EQ request.arPlugins[i].attr[1]>class="current"</cfif>
						>#request.arPlugins[i].attr[2]#</a></li>	
				</cfoutput>
			</cfcase>
			
			<cfcase value="CreateSelectMenu">
				<cfoutput>
					<option value="#request.arPlugins[i].attr[1]#"
						<cfif request.arPlugins[i].attr[1] EQ arguments.selected>selected="selected"</cfif>
						>#request.arPlugins[i].attr[2]#</option>	
				</cfoutput>
			</cfcase>
			</cfswitch>
		</cfif>
	</cfloop>
	
	</cfsavecontent>
	
	<cfreturn local.result>
</cffunction>




</cfcomponent>


