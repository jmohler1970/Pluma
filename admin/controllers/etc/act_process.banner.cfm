


<cfif NOT isDate(rc.startDate) OR NOT isDate(rc.expirationDate)>
	
	<cfset this.AddMessage("You must choose a start and end date.", "Error">
	
	<cfreturn>
</cfif>



<cftry>
	<cfscript>
		if (not DirectoryExists("#rc.bannerfolder#/#rc.extra#/"))	{
			DirectoryCreate("#rc.bannerfolder#/#rc.extra#/");
			}
	
		stResults = FileUpload("#rc.bannerfolder#/#rc.extra#/", "bannerfile", "image/*", "rename");
	
	
		rc.title = stResults.serverfile;
				
		rc.src = replace(rc.title,",","_","all");	// files with commas are problematic
			
		filemove("#rc.bannerfolder#/#rc.extra#/#stResults.serverfile#","#rc.bannerfolder#/#rc.extra#/#rc.src#");
			

	</cfscript>
	
			
	Done</p>
<cfcatch>
	
	<cfif cfcatch.message CONTAINS "did not contain a file">
		<cfset this.AddMessage("You must choose an image file to upload.", "Error")>
	<cfelse>
		<cfset this.AddMessage(cfcatch.message & cfcatch.detail)>
			
		<cfrethrow>
	</cfif>
		
		
</cfcatch>
</cftry>


