<cfcomponent>

<cfscript>
thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");



function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
	'PlumaCMS user management Language',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'Supports UI for management of multiple users. If this is shutdown PlumaCMS allows all users to access site.',
	'',
	'',
	'icon-heart');

	}	
</cfscript>

</cfcomponent>
