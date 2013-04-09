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
	<h3>#application.GSAPI.get_string("search")#</h3>


<form action="?" method="get" name="myFrm">
       
        	<input type="text" class="text" name="search" value="#htmleditformat(rc.search)#" placeholder="Part or all of title" />
       	

	<button type="submit">#application.GSAPI.get_string("search")#</button>
</form>
</cfoutput>

<p></p>


<cfoutput query="rc.qryPage">
	



	<cfif isnumeric(rank)>

		<h3>#LSNumberFormat(Rank, '99.0')#%</h3>
	
	</cfif>	
	
	
	<h2>
		<a href="#buildURL(action = 'admin:pages.edit', querystring = 'PageID=#NodeID#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		
		(#Kind#)
	</h2>

		
		
		<cfif rc.taxonomy>
			<cfif strData CONTAINS "<p>">
				#application.IOAPI.stripHTML(strData, 1000)#
			<cfelse>
				#paragraphformat(strData)#
			</cfif>
		
			<p>
			<b>Created:</b> #application.GSAPI.stdDate(CreateDate)# by #CreateBy#		
	
			<b>Parent Page:</b> 
			<cfif ParentTitle EQ ""><i>None</i></cfif>
			<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#htmlEditFormat(ParentTitle)#</a> 
			
			
			<b>Tags:</b> 
			<cfif tags EQ ""><i>None</i></cfif>
				
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#htmleditformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
			
			</p>	
		</cfif>

</cfoutput>


<cfif rc.qryPage.recordcount EQ 0 AND rc.search NEQ "">
	<p><i>No matches</i></p>
</cfif>




</div>



