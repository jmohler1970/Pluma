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

	<h3>Database Schema Documentation</h3>
	

<cfoutput query="rc.qryDBinfo" group="table_name">
	<h2>#table_schema#.#table_name#</h2>

<table>
<tbody>
<tr>

	<th style="width : 450px;">Column Name</th>
	<th style="width : 150px;">Data Type</th>
	<th>Is Nullable</th>
</tr>
<cfoutput>
<tr>
	<td>
	<cfif right(column_name, 2) EQ "ID">
		<b>#column_name#</b>
	<cfelse>
		#column_name#
	</cfif>
	</td>
	<td>#data_type#
	<cfswitch expression="#character_maximum_length#">
	<cfcase value=""></cfcase>
	<cfcase value="-1">(MAX)</cfcase>
	<cfdefaultcase>(#character_maximum_length#)</cfdefaultcase> 
	</cfswitch>
	</td>
	<td>
	<cfif is_nullable>
		Yes
	<cfelse>
		No
	</cfif>
	</td>
</tr>
</cfoutput>
</tbody>
</table>


</cfoutput>

	
</div>