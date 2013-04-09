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
<h3 class="floated">#application.GSAPI.get_string("page_management")#</h3>




<div class="edit-nav clearfix">
	<a href="##" id="filtertable" accesskey="r">#application.GSAPI.get_string("filter")#</a>
	
	<a href="##" id="show-characters" accesskey="u">#application.GSAPI.get_string("toggle_status")#</a>
</div>	



<div id="filter-search" style="display : none; ">
	<form>
		<input type="text" autocomplete="off" class="text" id="q" placeholder="filter..." /> &nbsp; <a href="#buildurl('.home')#" class="cancel">#application.GSAPI.get_string("cancel")#</a>
		</form>
</div>
</cfoutput>			


<cfoutput>
<table id="editpages" class="edittable highlight paginate">
<tr>
	<th>#application.GSAPI.get_string("page_title")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("date")#</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
</cfoutput>

<tbody>
<cfoutput query="rc.qryAllPages">
<tr>
	<td <cfif Root>style="text : bold;"</cfif> class="pagetitle">
		<cfloop from="1" to="#level#" index="i">
			<span>&nbsp; &nbsp; &mdash; &nbsp; &nbsp; </span>
		</cfloop>
	
	
		<cfif Kind EQ "Page">
			<a title="Edit Page" href="#BuildURL(action = 'pages.edit', querystring = 'NodeID=#NodeID#')#"><cfif Root><b>#htmleditformat(title)#</b><cfelse>#htmleditformat(title)#</cfif> 
			<cfif title EQ ""><i>No Title</i></cfif></a>
		<cfelse>
			<a title="Edit Page" href="#BuildURL(action = 'plugins.edit', querystring = 'NodeID=#NodeID#')#"><cfif Root><b>#htmleditformat(title)#</b><cfelse>#htmleditformat(title)#</cfif>
			<cfif title EQ ""><i>No Title</i></cfif>
			</a>
		</cfif>
		
		<span class="showstatus toggle" style="display : none;">
			<cfif Root><sup>[homepage]</sup></cfif>	
			<cfif MenuStatus EQ 1><sup>[menu item]</sup></cfif>
			<cfif pStatus NEQ "Public"><sup>[#pStatus#]</sup></cfif>
			
		</span>
	</td>

	<td style="text-align : right;"><span>#application.GSAPI.stdDate(ModifyDate)#</span></td>
	<td class="secondarylink">
	
		<a href="#application.GSAPI.get_site_root()#index.cfm/main/#slug#" rel="tooltip" title="View Page" target="_blank"><cfif Root><b>##</b><cfelse>##</cfif></a>
	
	</td>	
	<td class="delete">
		<cfif NoDelete EQ 0>	
			<a href="#buildURL(action = 'pages.delete', querystring = 'NodeID=#NodeID#')#" rel="tooltip" title="Delete Page">&times;</a>
		</cfif>
	</td>
</tr>
</cfoutput>
<cfif rc.qryAllPages.recordcount EQ 0>
<tr>
	<td colspan="8"><i>Sorry, no matches</i></td>
</tr>
</cfif>
</tbody>

</table>


<cfoutput>
	<p><i><b>#rc.qryAllPages.recordcount#</b> #application.GSAPI.get_string("total_pages")#</i></p>
</cfoutput>

</div>

