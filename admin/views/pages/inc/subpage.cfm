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
	param rc.SubPageID = ""; //main page --->
	</cfscript>



<div style="width : 450px; background : white;">
<table class="table table-condensed">
<thead> 
<tr>
	<th>Page Title</th>
	<th>View</th>
	<th>&nbsp;</th>
	<th align="center">Delete</th>
</tr>
</thead>

<cfoutput>
<tr>
	<td>
	<cfif rc.subpageid EQ "">
		Main
	<cfelse>
		<a href="#buildURL(action = 'page.edit', querystring = 'PageID=#rc.PageID#')#">Main</a>
	</cfif>
	</td>
	<td style="text-align : center;"><a href="/index.cfm/page/#rc.pageid#"><i class="icon-eye-open"></i></a></td>
	<td><!--- sort ---></td>
	<td><!--- can't delete ---></td>
</tr>
</cfoutput>


<cfoutput query="rc.qrySubNode">
<cfif isnumeric(NodeID)>
	<tr>
		<td>
			<cfif NodeID EQ rc.SubPageID>
				<b>#htmlEditFormat(Title)#<cfif Title EQ ""><i>No Sub Page Title</i></cfif></b>
			<cfelse>
				<a href="#buildURL(action = 'subpage.edit', querystring = 'PageID=#rc.PageID#&SubPageID=#NodeID#')#">#htmlEditFormat(Title)#<cfif Title EQ ""><i>No Page Title</i></cfif>
			</cfif>
			
			
		</td>
		
		<td style="text-align : center;" title="Click to preview"><a href="#buildURL(action = 'page.preview', querystring = 'PageID=#rc.PageID#&currentpage=#currentrow#')#"><i class="icon-eye-open"></i></a></td>
		<td>
			<cfif rc.qrySubNode.recordcount GT 1>
			<cfset mycurrentrow = currentrow>
			
			<select name="NodeSort_#NodeID#" class="input-mini">
				<cfloop from="1" to="#rc.qrySubNode.recordcount#" index="j">
					<option value="#j#" <cfif j EQ mycurrentrow>selected</cfif>>#j#</option>
				</cfloop>
			</select> 
			<cfelse>
			&nbsp;
			</cfif>
		</td>
		<td align="center">
			<a class="btn btn-danger" href="#buildURL(action = 'subpage.delete', querystring = 'PageID=#rc.PageID#&SubPageID=#NodeID#')#" onclick="return confirm('Are you sure?');"><i class="icon-trash icon-white"></i></a>
		</td>
	</tr>
</cfif>				
</cfoutput>
</table>

<cfif isnumeric(rc.PageID) and AND NOT getSection() contains "subpage">
	<cfoutput>
		<a href="#buildURL(action = 'subpage.edit', querystring = 'PageID=#rc.Pageid#')#" class="btn btn-primary pull-left"><i class="icon-plus icon-white"></i> Add sub page</a>
	</cfoutput>
</cfif>
</div>

	