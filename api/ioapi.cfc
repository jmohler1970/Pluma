

<!--- Expected to be tied into application scope --->

<cfcomponent extends="base" hint="Performs saving and retrieval of all XML and related data">
<cfscript>


boolean function storage() output="false" {
	
	if (not structkeyexists(application.stSettings, "storage"))	{
		return false;			
		}
	
	
	// web services
	for (var key in application.stSettings.storage)	{
		
		setVariable("this.ws#key#", ""); // at least the variable exists	
		
		var i = application.stSettings.storage[key];
		
		
		try	{
						
			var tmpWS = CreateObject(i);
		
			
			if (tmpWS.getStatus() == "OK")	{
				setVariable("this.ws#key#", tmpWS);
				}
			else 
				{
				this.InitStatus &= "Storage Service <tt>#key#</tt> is not ready.";
				}
					
			}
		catch (any e)	{
			this.InitStatus &= "Unable to create Storage Service #i#. #e.detail#<br /><br />";
			}
		
		}	
		
	return true;	
	}





void function add_log(required string Kind, required string message)	output="false"	{
	
	this.wsNode.addLog(arguments.Kind, arguments.message, session.LOGINAPI.getLoginName()); 
	}

	
string function std_date(required string MyDate, boolean verbose = 0) output="false" {
	// Support for verbose will come with CF 10
	
	var curDay = day(now());
	var curMonth = month(now());
	var curYear = year(now());
	
	if (not isDate(arguments.MyDate)) return application.GSAPI.i18n("plumacms/Unknown");
		
		
	if (day(arguments.MyDate) 		== curDay  
		AND month(arguments.MyDate) == curMonth
		AND year(arguments.MyDate) 	== curYear
		) return application.GSAPI.i18n("plumacms/Today");
		
	if (day(DateAdd("d", 1, arguments.MyDate)) 	== curDay
		AND month(arguments.MyDate) 			== curMonth
		AND year(arguments.MyDate) 				== curYear
		)	return application.GSAPI.i18n("plumacms/Yesterday");
	
	
	var myDateformat = application.GSAPI.i18n("Date_Format"); // needs to use CF style not PHP
	
	
	if (myDateFormat == "")	{
		myDateformat = 	"ddd, mmm dd, 'yy";		
		}
	
	return LSDateFormat(arguments.MyDate, myDateFormat, request.meta.language);
	}
	




query function get_page_parent() output="false"	{

	return this.wsNode.getPageParent();
	}
	

query function get_all_tags() output="false"	{

	return this.wsNode.getAllTags();
	}
	




query function get_feed(required string plugin, required string baselink) output="false"	{
	

	qryBlog = this.wsNode.getFeed(arguments.plugin, arguments.baselink);
	}


query function get_site_map() output="false"	{
	
	qryNode = this.wsNode.getOne({NodeID = "max", Kind = "Sitemap" } );
	

	return this.wsNode.getSiteMap(qryNode.NodeID, 8);
	}



/* gets list of archives */
query function get_archive(required struct NodeK) output="false"	{

	param arguments.NodeK.Kind 	= "Page";
	param arguments.NodeK.NodeID = ""; // all
	

	return this.wsNode.getArchive(arguments.NodeK.nodeID);
	}
	

query function get_archive_details(required string NodeArchiveID) output="false"	{

	

	return this.wsNode.getArchiveDetails(arguments.nodeArchiveID);
	}
	
	
struct function restore_archive(required string NodeArchiveID) output="false"	{

	return this.wsNode.restoreArchive(arguments.nodeArchiveID, session.LOGINAPI.getLoginName());
	}		
	
	
struct function delete_archive(required string NodeArchiveID) output="false"	{


	return this.wsNode.deleteArchive(arguments.nodeArchiveID, session.LOGINAPI.getLoginName());
	}	
	
	
struct function delete_archive_by_date(required date clearDate, string nodeid="") output="false"	{


	return this.wsNode.deleteArchiveByDate(arguments.clearDate, arguments.nodeid, session.LOGINAPI.getLoginName());
	}	
	



query function get_path(required struct NodeK) output="false"	{

	param arguments.NodeK.Kind = "Page";

	return this.wsNode.getNodePath(arguments.NodeK.nodeID);
	}



query function get(required struct NodeK) output="false"	{

	param arguments.NodeK.Kind = "Page";

	return this.wsNode.getOne(arguments.nodeK);
	}


struct function get_bundle(required struct NodeK) output="false"	{

	if (this.InitStatus != "")	{
		return {}; // Can't connect to webservice
		}

	
	param arguments.NodeK.Kind = "Page";

	return this.wsNode.getBundle(arguments.nodeK, "", session.LOGINAPI.getLoginName());
	}



/* Gets links associated with page. Defaults to current page */
query function get_link(struct NodeK) output="false"	{

	param arguments.NodeK.Kind = "Page";
	param arguments.NodeK.NodeID = "";

	return this.wsNode.getLink(arguments.nodeK);
	}



query function get_comment(struct NodeK) output="false"	{

	param arguments.NodeK.Kind = "Page";
	param arguments.NodeK.NodeID = request.stIOR.qryNode.NodeID;

	return this.wsComment.getByNodeID(arguments.nodeK);
	}

/* Traffic functions */
query function get_traffic_details(required struct Filter) output="false"	{

	return this.wsTraffic.getTrafficDetails(arguments.Filter);
	}
	

query function get_traffic_last_hits(string Filter="") output="false"	{

	return this.wsTraffic.getLastHits(arguments.filter, cgi.server_name);
	}



query function get_all(required string Kind, required string sortby, numeric maxrows=100) output="false" {

	return this.wsNode.getAll(arguments.kind, arguments.sortBy, arguments.maxrows);
	}


query function get_all_by_userid(required string Kind, required string userid, required string sortby) output="false" {

	return this.wsNode.getAllByUserID(arguments.kind, arguments.userid, arguments.sortBy);
	}




query function get_by_search(required string Search, required string Kind) output="false" {

	return this.wsNode.getBySearch(arguments.search, arguments.kind);
	}
	

query function get_by_tag(required string Tag, required string Kind) output="false" {

	return this.wsNode.getByTag(arguments.tag, arguments.kind);
	}

	

query function get_kind_count() output="false" {

	return this.wsNode.getkindcount();
	}


query function get_kind_history() output="false" {

	return this.wsNode.getkindhistory();
	}




	
struct function get_pref(required string Pref) output="false"	{
	
	
	return (structkeyExists(request, arguments.Pref)) ? request[arguments.Pref] : {};
	}	

</cfscript>


<cffunction name="load_plugins" returntype="void">

	<cfset var qryPlugins = QueryNew("Plugin, Name, Version, Author, Author_url, description, 
		page_type, load_data, filename, Enabled")>
		
	

	<!--- I don't want to use this elsewhere --->
		
	<cfdirectory directory="#application.GSPLUGINPATH#" name="qryDir" filter="*.cfc" sort="name">

	<cfloop query="qryDir">
		
	
		<cfscript>
		if (type == "File" AND NOT name CONTAINS "plugin")	{
		
			
			var objPlugin = cacheGet("plugins.#name#");
			if (isNull (objPlugin))	{
				var objPlugin = createObject("plugins.#listfirst(name, '.')#");
		
				cachePut("plugins.#name#", objPlugin, CreateTimeSpan(0, 6, 0, 0));
				} 
						
			
			
			objPlugin.Init();
			
			QueryAddRow(qryPlugins);
			QuerySetCell(qryPlugins, "Plugin", 		lcase(listfirst(name, '.')));
			QuerySetCell(qryPlugins, "Name", 		objPlugin.stPlugin_info.name);
			QuerySetCell(qryPlugins, "Version", 	objPlugin.stPlugin_info.version);
			QuerySetCell(qryPlugins, "Author", 		objPlugin.stPlugin_info.author);
			QuerySetCell(qryPlugins, "Author_url", 	objPlugin.stPlugin_info.author_url);
			QuerySetCell(qryPlugins, "Description", objPlugin.stPlugin_info.description);
			QuerySetCell(qryPlugins, "Page_type", 	objPlugin.stPlugin_info.page_type);
			QuerySetCell(qryPlugins, "Load_data",	objPlugin.stPlugin_info.load_data);
			
			QuerySetCell(qryPlugins, "filename", 	name);
			QuerySetCell(qryPlugins, "enabled", 	0); // It needs to prove it is active			
			
			if (isDefined("request.Plugin.#listfirst(name, '.')#"))	{
				var enabled = evaluate("request.Plugin.#listfirst(name, '.')#");
			
				QuerySetCell(qryPlugins, "enabled", enabled);
				}
			
			// Read language
			 
			
			}
		</cfscript>
 	</cfloop>

 	<cfloop query="qryPlugins">
 		<cfset application.GSAPI.status[plugin] = enabled>	
 		<cfif enabled>
 			<cfset application.GSAPI.i18n_merge(plugin)>
 		</cfif> 		 	
 	</cfloop>


	<cfset request.qryPlugins = qryPlugins>
</cffunction>



<cffunction name="get_matchlist" returnType="query" >
	<cfargument name="kind" required="true" type="string">	
	<cfargument name="filter" required="true" type="string">
	<cfargument name="group" required="true" type="string">
	<cfargument name="pstatus" required="true" type="string">
	<cfargument name="commentmode" required="true" type="string">
	<cfargument name="recent" type="boolean" default="0">
	<cfargument name="withaction" type="boolean" default="0">

	<cfreturn this.wsNode.getMatchlist(arguments.kind, arguments.filter, arguments.group, arguments.pstatus, arguments.commentmode, arguments.recent, arguments.withaction)>
</cffunction>




<cfscript>

// this is similar to load_ini(). This loads data into the request scope
void function load_pref(boolean force = 0) output="false"	{	

	request.tempPref = "fast exit";


	
	if (arguments.force == 1)	{
		cacheRemove("stPref");
		}
	
	request.tempPref = "force";
	
	
	var tempPref = cacheGet("stPref");
	if (isNull(tempPref) or arguments.force == 1)	{
		tempPref = this.wsPref.get();
				
		cachePut("stPref", tempPref, CreateTimeSpan(0, 6, 0, 0));
		
		request.tempPref = tempPref;	
		}
	
	request.tempPref = tempPref;
	
	StructAppend(request, tempPref); //over writes
	}




string function set_pref(required string pref, required struct Data) output="false"	{
	
	
	local.result = this.wsPref.commit(arguments.pref, arguments.Data, session.LOGINAPI.getLoginName());
	
		
	this.load_pref(1); //resets all preferences
	
	return local.result;
	}	
	
	
boolean function delete_pref(required string Pref, required string type) output="false"	{
	
	
	
	return this.wsPref.delete(arguments.Pref, arguments.type);

	this.load_pref(1); //resets all preferences

	}	
	
</cfscript>






<cffunction name="add_traffic" output="false">
	<cfargument name="rc" type="struct" required="true" hint="Keys: {subsystem,section,item,slug,url_vars}">
	<cfargument name="subsystem" type="string" default="">
	<cfargument name="section" type="string" default="">
	<cfargument name="item" type="string" default="">
	

<cfscript>

	
// Traffic
//thread name="thTraffic"	{
	
	if (not isnull(this.wsTraffic))	{
	
		this.wsTraffic.add(action =
			{
			SubSystem	= arguments.SubSystem,
			Section 	= arguments.Section,
			Item 		= rc.slug != "" ? rc.slug : arguments.Item
			},	
			isPost		= (cgi.request_method == "POST" ? 1 : 0),
		
			http_user_agent			= cgi.http_user_agent,
			Remote_addr				= cgi.remote_addr,
			http_referer			= cgi.http_referer,
			http_accept_language 	= cgi.http_accept_language,
			url_vars				= Duplicate(url)
			);
		}	

//	}
</cfscript>

</cffunction>


<cfscript>
/* Data I/O */
struct function set(required struct NodeK, required struct rc) output="false"	{


	variables.stResult = this.wsNode.commit(arguments.NodeK, arguments.rc, session.LOGINAPI.getLoginName());
	
	return variables.stResult;
	}


struct function add_taxonomy(required string extra, required string title) 	{


	variables.stResult.result = this.wsNode.TaxonomyAdd(arguments.extra, arguments.title, session.LOGINAPI.getLoginName());
	
	return variables.stResult;
	}

	


struct function set_taxonomy(required struct NodeK, required struct rc) hint="Stores an expected set of rc values. Fields are menu, facet, tags"	{

	param arguments.NodeK.Kind = "Page";

	variables.stResult.result = this.wsNode.TaxonomySave(arguments.NodeK, rc, session.LOGINAPI.getLoginName());
	
	return variables.stResult;
	}

	
	

	
	
query function reactivate(required struct NodeK) output="false"	{

	param arguments.NodeK.Kind = "Page";

	return this.wsNode.NodeReactivate(arguments.nodeK, session.LOGINAPI.getLoginName());
	}	


struct function delete(required struct NodeK) output="false"	{

	param arguments.NodeK.Kind = "Page";

	return this.wsNode.delete(arguments.nodeK, session.LOGINAPI.getLoginName());
	}	
</cfscript>


<cffunction name="showDatePicker" returnType="void"> 
	<cfargument name="fieldname" required="true" type="string">
	<cfargument name="myvalue" 	type="string" default="#now()#">
	<cfargument name="class"	type="string" default="text">

	<cfoutput>
		
		<input type="text" name="#arguments.fieldname#" class="#arguments.class#" maxlength="12" 
			<cfif isDate(arguments.myvalue)>
				value="#LSDateFormat(arguments.myvalue, "mm/dd/yyyy")#"
			</cfif>
		
		/>
		
	</cfoutput>

</cffunction>


<cfscript>
/* plugin */	
string function set_plugin(required string name, required string enabled) output="false" {

	var myPlugin = {};
	
	setVariable("myPlugin.Plugin_#listfirst(arguments.name, '.')#", enabled);
	

	var result = this.wsPref.commit("Plugin", myPlugin, session.LOGINAPI.getLoginName());
			
	this.load_pref(1); //resets all preferences
	
	return result;
	}
	
	
query function get_log(string filter="") output="false"	{

	return this.wsNode.getLog(arguments.filter);
	}

		
boolean function clear_log(string filter="") output="false"	{

	return this.wsNode.clearLog(arguments.filter);
	}
		

		
		
	
	
/* System functions. Use sparingly */
struct function get_site_info() output="false"	{
	
	var oSystem = createObject('java','java.lang.System');
	var jremodel 	= oSystem.getProperty("sun.arch.data.model");
	var allProp		= oSystem.getProperties(); 
	
	
	
	var stResult = {CFVERSION = server.ColdFusion.ProductVersion, 
		CFLEVEL = server.ColdFusion.ProductLevel,
		JREBIT		= allProp["sun.arch.data.model"],
		JREVENDOR 	= allProp["java.vendor"],
		JRENAME 	= allProp["java.runtime.name"],
		JREVERSION 	= allProp["java.runtime.version"]  };
		
	return stResult;
	}	
	
	
query function get_db_schema() output="false"	{
		

	return this.wsNode.getDBSchema();
	}	
	

string function get_db_version() output="false"	{

	if (this.InitStatus != "")	{
		return "Cannot connect to DB"; // Can't connect to webservice
		}


	return this.wsNode.getDBVersion();
	}	


string function get_db_dsn() output="false"	{

	if (this.InitStatus != "")	{
		return "Cannot connect to DB"; // Can't connect to webservice
		}

		

	return this.wsNode.getDBDSN();
	}
		
</cfscript>



<cfscript>
boolean function clear_all() output="false" {
	
	if (this.wsSetup == "")	{
		return false; // production setting
		}


	return this.wsSetup.clear_all();
	}
</cfscript>



</cfcomponent>

