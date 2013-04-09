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



<h2>Manage Links</h2>	

<table class="edittable highlight paginate">
<thead>
<tr>
	<th>Category</th>
	<th>Title</th>
	<th>Target</th>
	<th></th>
	<th>Delete Link</th>
</tr>
</thead>
<cfoutput query="rc.qryLink">
<tr>
	<td>#Category# <cfif Category EQ ""><i>None</i></cfif>
	
		<input type="hidden" name="key_#currentrow#" 		value="#htmleditformat(category)#|#htmleditformat(href)#" />
		<input type="hidden" name="linkcategory_#currentrow#" 	value="#category#" />
	</td>
	
	<td>
    	<input type="text" name="value_#currentrow#" value="#htmleditformat(value)#" />  
	</td>
		

	<td>
		<input type="text" name="href_#currentrow#" value="#htmleditformat(href)#" />
	
		<a href="#href#" target="_blank" class="btn">Go</a>
	</td>
	
	<td>
		<select name="sortorder_#currentrow#" class="input-mini">
			<cfloop from="1" to="#rc.qryLink.recordcount#" index="j">
				<option value="#j#" <cfif j EQ sortorder>selected="selected"</cfif>>#j#</option>
			</cfloop>
		</select> 
	</td>
	
	<td style="text-align : center;">
		<input type="checkbox" name="delete_#currentrow#" value="1" />
	
	</td>
</tr>
</cfoutput>
</table>


<cfoutput>
	<p><i><b>#rc.qryLink.recordcount#</b> total links</i></p>
</cfoutput>




