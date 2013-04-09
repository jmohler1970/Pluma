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



<cfscript>
param variables.maxresults = 10;
</cfscript>




<table class="table table-condensed">

<cfoutput query="rc.qryPage" maxRows="#variables.maxresults#">
	<tr>
		<td style="text-align : center;">
			<a href="##" rel="popover" data-content="Modified: #application.GSAPI.stdDate(ModifyDate)# By: #ModifyBy#
	Created: #application.GSAPI.stdDate(CreateDate)# By: #CreateBy#"><i class="#Icon#"></i></a>
		</td>
			
		<td>
			<small><cfset application.GSAPI.get_path(NodeID)></small> <cfif cStatus EQ 0><span class="label label-info">Draft</span></cfif>
			<p><small style="font-size : 0.8em;"> Updated: #application.GSAPI.stdDate(ModifyDate)#</small></p>
		</td>
		
	
		<td style="text-align : right;">
		<div class="btn-group">
			<a class="btn" 
				href="/index.cfm/page/#nodeid#&amp;preview=1" 
				rel="tooltip" title="This leaves the tools area"><i class="icon-share-alt"></i> View</a>
			<cfif StructKeyExists(session.LOGINAPI.stGroup, "system")>
			<a class="btn btn-success" 
				href="#buildURL(action = 'page.edit', querystring = 'PageID=#NodeID#')#"><i class="icon-pencil icon-white"></i> Edit</a>
			</cfif>	
		</div>

		</td>
	</tr>
</cfoutput>

<cfif rc.qryPage.recordcount EQ 0>
<tr>
	<td colspan="3"><i>None</i></td>
</tr>
</cfif>


</table>

<cfoutput>
	<a class="btn btn-primary pull-right" href="#buildURL(action='page.edit')#"><i class="icon-plus icon-white"></i> Add</a>
</cfoutput>
	

