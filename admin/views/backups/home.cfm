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



<div class="main">


<cfoutput>
	<h3>#application.GSAPI.get_string("bak_management")#</h3>
</cfoutput>


<cfoutput query="rc.qryArchive" group="shortdate">
<h2>#application.GSAPI.stdDate(ShortDate)#</h2>

<table class="edittable highlight paginate">
<thead>
<tr>
	
	<th>#application.GSAPI.get_string("page_action")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("archive_date")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("by")#</th>
</tr>
</thead>

<tbody>
<cfoutput>
	<tr>
		<td <cfif Root>style="text : bold;"</cfif> class="pagetitle">
			<a href="#buildurl(action='.edit', querystring='nodearchiveid=#nodearchiveid#')#">#Title#
			<cfif title EQ ""><i>No Title</i></cfif>
			</a>
		</td>
		
		<td style="text-align : right;">	
			#application.GSAPI.stdDate(VersionDate)# @
			#LSTimeFormat(VersionDate)# 
		</td>
		
		<td style="text-align : right;">#ModifyBy#</td>
		
		<td <cfif Root>style="text : bold;"</cfif> class="delete">
		<cfif NoDelete EQ 0>	
			<a href="#buildURL(action = 'backups.delete', querystring = 'NodeArchiveID=#NodeArchiveID#')#" rel="tooltip" title="Delete Archive">&times;</a>
		</cfif>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>	
</cfoutput>
	


<cfif rc.qryArchive.recordcount EQ 0>
	<p class="alert"><b>Warning:</b> There is no history</p>
</cfif>

</div>

