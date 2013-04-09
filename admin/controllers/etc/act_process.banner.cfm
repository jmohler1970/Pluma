<!---
Copyright © 2012 James Mohler

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


