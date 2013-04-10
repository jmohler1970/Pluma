

<cfcomponent hint="This component exists to be overridden">

<cfscript>

variables.stResult = {result = true, message = "", content = '', NodeID = ''};
this.stPlugin_info = {};

this.url = {settings = "settings", matchlist = "matchlist", edit = "edit"}; 


function init()	{;}


function register_plugin(required string id, required string name, string ver = "", string auth = "", string auth_url = "", string desc = "", string type = "", string loaddata = "", string icon = "")	{

	this.stPlugin_info = {
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
	
	request.arPluginsCount = ArrayLen(request.arPlugins);
	}



struct function settings(required struct rc) hint="Expected to be overridden"	{	
	
	
	return variables.stResult;
	}



struct function edit(required struct rc) hint="Expected to be overridden"	{	
	
	
	return variables.stResult;
	}
	








</cfscript>


</cfcomponent>

