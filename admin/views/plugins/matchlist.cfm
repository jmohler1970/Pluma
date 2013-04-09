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


<tbody id="change2">
<cfoutput query="rc.qryMatchList">
<tr>
	<td>#Kind#</td>
	<td style="text-align : right;"><a href="#BuildURL(action = '.edit', querystring = 'NodeID=#NodeID#')#">#NodeID#</a></td>
	<td>#htmleditformat(title)#</td>
	<td>#slug#</td>
	<td>#pStatus#</td>
	
	<td style="text-align : center;">
	<cfif slug NEQ "">
		<a href="#buildURL(action = 'traffic.details', querystring = 'slud=#rc.slug#')#"><i class="icon-road"></i></a>
	</cfif>
	</td>
	
	<td>#group#</td>
	<td style="text-align : center;">
		#ModifyBy# @ #application.GSAPI.stdDate(ModifyDate)#
	</td>
	<td>
		<div class="btn-group">
			<a class="btn" 
				href="/index.cfm/page/#NodeID#" 
				rel="tooltip" title="This leaves the tools area"><i class="icon-share-alt"></i> View</a>
			<a class="btn btn-success" 
				href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#NodeID#')#"><i class="icon-pencil"></i> Edit</a>
		
		</div>
	</td>	
</tr>
</cfoutput>
<cfif rc.qryMatchList.recordcount EQ 0>
<tr>
	<td colspan="8"><i>Sorry, no matches</i></td>
</tr>
</cfif>
</tbody>