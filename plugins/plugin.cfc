<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->

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

