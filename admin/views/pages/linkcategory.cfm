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


<h3>Link Categories</h3>

	
<table class="edittable highlight paginate">
<thead>
<tr>
	<th>Link Category</th>
	<th style="text-align : right;">Usage</th>
	<th style="text-align : right;">Date</th>
	<th></th>
</tr>
</thead>

<cfoutput query="rc.qryLinkCategory">
	<tr>
		<td>#htmleditformat(Title)#</td>
		
		
		<td style="text-align : right;">#FacetCount#</td>	
		<td style="text-align : right;">#application.GSAPI.stdDate(CreateDate)#</td>
		<td class="delete">
			<cfif FacetCount EQ 0>
				<a  class="delconfirm" href="#buildURL(action='.linkCategoryDelete', querystring ='NodeID=#NodeID#')#" onclick="return confirm('Are you sure?');">&times;</a>
			<cfelse>
				&nbsp;
			</cfif>
		</td>
		
	</tr>
	</cfoutput>
	</table>
	

<cfoutput>
	<p><i><b>#rc.qryLinkCategory.recordcount#</b> total link categories</i></p>
</cfoutput>




<h3>Add Link Category</h3>	

<cfoutput>
<cfform action="#BuildURL(action = '.linkcategory')#" method="post">
	


<p>
   <b>Title</b>
   <br />
  
	<cfinput type="Text" name="title" class="text" value="" size="50" maxlength="75" required="yes" message="You must enter a new item" />	
</p>

		
	<input type="submit" class="submit" value="Add" />
</cfform>
</cfoutput>


</div>
