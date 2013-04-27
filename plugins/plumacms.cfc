<cfcomponent>

<cfscript>
thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");



function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
	'PlumaCMS Language Bundles',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'Brings in language strings not in GetSimple',
	'',
	'',
	'icon-heart');

	}	
</cfscript>

</cfcomponent>
