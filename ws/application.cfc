

<cfcomponent>


<cfscript>
	// Either put the org folder in your webroot or create a mapping for it!
	
	this.name 			= "mWWISoa077";
	this.datasource		= "PlumaCMS";
	

// We want to delete the OnRequest
// event handler so the web service has access.

	StructDelete( this, "OnRequest" );
	StructDelete( this, "OnRequestEnd" );
</cfscript>


 <cffunction name="onRequestStart">
  <cflogin>
   <cfset isAuthorized = false>
   <cfif isDefined("cflogin")>
    <!---<cfdump output="console" var="#cflogin#">--->
    <cfif (cflogin.name eq "plumacms") and (cflogin.password eq "plumacms")>
     <cfset isAuthorized = true>
    <cfelse>
     <cfheader statuscode="401">
     <cfabort>
    </cfif>
   </cfif>
  </cflogin>
  <cfreturn />
  <cfif not isAuthorized>
   <!--- If the user does not pass a user name/password, return a 401 error. 
   The browser then prompts the user for a user name/password. --->
   <cfheader statuscode="401">
   <cfheader name="WWW-Authenticate" value="Basic realm=""Test""">
   <cfabort>
  </cfif>
 </cffunction>

	
</cfcomponent>

	