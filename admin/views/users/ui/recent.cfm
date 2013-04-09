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


<cfif not isnumeric(rc.userid)>
	<cfexit>
</cfif>


<h2>Recently Added Items</h2>


<table class="table">
<thead>
<tr>
	<th>&nbsp;</th>
	<th>Title</th>
	<th>Complete</th>
	<th>Status</th>
	<th>&nbsp;</th>
</tr>
</thead>

<cfoutput query="rc.qryNode" maxRows="50">
<tr>
	<td>
		<a href="##" rel="popover" data-content="Kind: #Kind# Modified: #application.GSAPI.stdDate(ModifyDate)# By: #ModifyBy#
	Created: #application.GSAPI.stdDate(CreateDate)# By: #CreateBy#">
			<i class="#Icon#"></i>
		</a>
	</td>
	<td></td>
	<td><cfif NOT cStatus>Draft</cfif></td>
	<td>#pStatus#</td>
	<td>
		<input type="checkbox" name="NodeID" value="#NodeID#" <cfif deleted>disabled="disabled"</cfif> />
	</td>
</tr>
</cfoutput>


<cfoutput>
<tfoot>
<tr>
	<td colspan="7" style="text-align : right;">
	<select name="pStatus">
		<option></option>
		<option>Delete</option>
		<optgroup label="Publication Status">	
		<cfloop index="ii" list="#application.stAdminSetting.Node.lstpstatus#">
			<option value="#ii#">#ii#</option>
		</cfloop>
		</optgroup>
	</select>
	
	<button class="btn">Update</button>		
	</td>
</tr>
</tfoot>
</cfoutput>


<cfif rc.qryNode.recordcount EQ 0>
<tr>
	<td colspan="7"><i>None</i></td>
</tr>
</cfif>


</table>