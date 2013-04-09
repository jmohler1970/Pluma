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
param rc.tag = "";

qryTag = application.IOAPI.get_by_tag(rc.tag, "Page");
</cfscript>




<cfinclude template="header.cfi"> 


<cfoutput>	
	<div class="wrapper clearfix">
		<!-- page content -->
		<article>
			<section>
				
				<!-- title and content -->
				<h1>#application.GSAPI.get_page_title()#</h1>
				
				
<table>	
<cfloop query="qryTag">
<tr>
	<td>
		
		<h3><a href="/index.cfm/main/#slug#">#htmleditformat(Title)#</a></h3>

	
		<cfif isDate(CreateDate)>
			<h6>Created: #LSDateFormat(CreateDate)#</h6>
		</cfif>
		
		<p>#application.IOAPI.stripHTML(strData, 1000)#</p>
		
		<h6>
			<b>Parent Page:</b> 
			<cfif ParentTitle EQ ""><i>None</i></cfif>
			<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#htmlEditFormat(ParentTitle)#</a> 
			
			
			<b>Tags:</b> 
			<cfif tags EQ ""><i>None</i></cfif>
				
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#htmleditformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
		</h6>
	</td>
</tr>
</cfloop>
</table>				
				
							
				#application.GSAPI.get_page_content()#
				
				
				
				<!-- page footer -->
				<div class="footer">
					<p>Published on <time>#application.GSAPI.get_page_date()#</time></p>
				</div>
			</section>
			
		</article>

		<cfinclude template="sidebar.cfi">
	</div>
</cfoutput>
