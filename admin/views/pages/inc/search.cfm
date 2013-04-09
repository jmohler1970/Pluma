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
	<h3>Search</h3>




<cfoutput query="qryPage">
	


	<div class="thumbnail">
	<cfif isnumeric(rank)>
	<div class="date">
		<div class="month">Rank</div>
		<div class="rank">#LSNumberFormat(Rank, '99.0')#%</div>
	</div>
	</cfif>	
	
	
	<p><b>
		<cfswitch expression="#kind#">
		<cfcase value="Blog">
			<a href="#buildURL(action = 'admin:blog.edit', querystring = 'BlogID=#NodeID#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		</cfcase>
		<cfcase value="Photo">
			<a href="#buildURL(action = 'admin:photo.edit', querystring = 'PhotoID=#NodeID#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		</cfcase>
		<cfcase value="Page">
			<a href="#buildURL(action = 'admin:page.edit', querystring = 'PageID=#NodeID#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		</cfcase>
		<cfcase value="SubPage">
			<a href="#buildURL(action = 'admin:subpage.edit', querystring = 'PageID=#ParentNodeID#&SubPageID=#NodeID#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		</cfcase>
		<cfcase value="Tags">
			<a href="#buildURL(action = 'admin:tags.home', querystring = 'Tag=#urlencodedformat(Title)#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		</cfcase>
		<cfdefaultcase>
			#Title#
		</cfdefaultcase> 
		</cfswitch>
		</b>
		
		(#Kind#)</p>
		
		<h6>#application.GSAPI.stdDate(CreateDate)# by #CreateBy#</h6>
		
		<cfif Src NEQ "">
			<cfset basePath = getPath(ParentNodeID)>
		
		
			<img src="/#basePath#/#src#" title="#src#" /><br />
		</cfif>
		
		<cfif rc.taxonomy>
			<cfif strData CONTAINS "<p>">
				#application.IOAPI.stripHTML(strData, 200)#
			<cfelse>
				#paragraphformat(strData)#
			</cfif>
			
	
			<p>
			<b>Parent Page:</b>
			<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#htmlEditFormat(ParentTitle)#</a> 
			
			
			<b>Tags:</b> 	
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#htmleditformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
			
			</p>
		</cfif>

</cfoutput>


<cfif qryPage.recordcount EQ 0>
	<p>No matches</p>
</cfif>




</div>



