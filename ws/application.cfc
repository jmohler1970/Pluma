

<cfcomponent>


<cfscript>
	// Either put the org folder in your webroot or create a mapping for it!
	
	this.name 			= "mWWISoa076";
	this.datasource		= "PlumaCMS";
	

// We want to delete the OnRequest
// event handler so the web service has access.

	StructDelete( this, "OnRequest" );
	StructDelete( this, "OnRequestEnd" );
</cfscript>
	
</cfcomponent>

	