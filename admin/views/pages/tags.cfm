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
	<h3>#application.GSAPI.get_string("tag_summary")#</h3>
	
	<table  class="edittable highlight paginate">
	

	<thead>
	<tr>
		<th>#application.GSAPI.get_string("tag_name")#</th>
		<th>#application.GSAPI.get_string("tags")#</th>
		<th style="text-align : right;">#application.GSAPI.get_string("page_count")#</th>
		<th style="text-align : right;">#application.GSAPI.get_string("tag_rank")#</th>
	</tr>
	</thead>
	</cfoutput>
	
	<cfoutput query="rc.qryTags">
	<tr>

		<td>#Tags#</td>
		
		<td><a href="#application.GSAPI.get_site_root()#index.cfm/tag/#tagslug#" rel="tooltip" title="This leaves the tools area">./index.cfm/tag/#tagslug#</a></td>
		<td style="text-align : right;">#LSNumberFormat(TagCount)#</td>
		<td style="text-align : right;">#taglevel#</td>
		

	</tr>
	</cfoutput>
	</table>

<cfoutput>
	<p><i><b>#rc.qryTags.recordcount#</b> #application.GSAPI.get_string("total_tags")#</i></p>
</cfoutput>

	
</div>	


