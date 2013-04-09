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
	<h3>#application.GSAPI.get_string("menu_manager")#</h3>
</cfoutput>



<cfform action="#buildurl(action = '.menu')#" name="myFrm">

<table class="edittable highlight paginate">

<cfoutput>
<thead>
<tr>
	<th>#application.GSAPI.get_string("sort")#</th>
	<th>#application.GSAPI.get_string("menu_text")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("page_title")#</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
</thead>
</cfoutput>


<cfoutput query="rc.qryMenu">
	<input type="hidden" name="processNodeID" value="#NodeID#" />

<tr>
	<td style="width : 60px;">
		<select class="text" style="width : 60px"  name="menusort_#NodeID#">
			<option value="">-</option>
			
			<cfloop from="1" to="20" index="i">
				<option value="#i#" <cfif menusort EQ i>selected="selected"</cfif>>#i#</option>	
			</cfloop>
		</select>
	</td>
	
	
	<td>#Menu#</td>
	<td style="text-align : right;"><i>#Title#</i></td>
	
	
	

	<td class="secondarylink">
		<a href="#application.GSAPI.get_site_root()#index.cfm/main/#slug#" rel="tooltip" title="View Page" target="_blank"><cfif Root><b>##</b><cfelse>##</cfif></a>
	</td>
</tr>
</cfoutput>
</table>




<cfif rc.qryMenu.recordcount GT 0>
	<cfoutput>
		<button type="submit">#application.GSAPI.get_string("save_menu_order")#</button>
	</cfoutput>
</cfif>

</cfform>



</div>



