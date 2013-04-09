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



	
<form action="#buildURL(action = '.load')###basic" method="post">

	<legend>Spreadsheet Preview</legend>




<table class="table table-condensed">
<thead>
<tr>
	<cfloop index="c" list="#rc.colList#">
		<cfoutput><th>#c#</th></cfoutput>
	</cfloop>
</tr>
</thead>

<cfoutput query="rc.qryData" startRow="2">
	<cfset variables.hadStuff = false>
	<cfsavecontent variable="row">
	<tr>
		
		<cfloop index="c" list="#rc.colList#">
			
			<cfif not variables.hadStuff and len(trim(rc.qryData[c][currentRow]))>
				<cfset variables.hadStuff = true>
			</cfif>
			
			<cfif isnumeric(rc.qrydata[c][currentRow]) OR rc.qryData[c][currentRow] CONTAINS "$">
				<td style="text-align : right">#rc.qrydata[c][currentRow]#</td>
			<cfelse>
				<td>#rc.qrydata[c][currentRow]#</td>
			</cfif>
			
		</cfloop>
		<td>
			<input type="checkbox" name="row" value="#currentrow#" checked="checked" />
		</td>
	</tr>
	</cfsavecontent>
	<cfif variables.hadStuff>#row#</cfif>		
	</cfoutput>
			
</table>


<div class="form-actions">
	

	<button type="submit" name="submit" class="btn btn-primary" value=""
	
	<cfif NOT rc.colList CONTAINS "SKU">
		disabled="disabled"
	</cfif>
	>SKU Import</button>
</div>	

	
</form>


<cfinclude template="ui/meta.cfm">

