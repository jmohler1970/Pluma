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
	<h3 class="float">Preview Data Import</h3>



<form action="#buildURL(action = '.preview')#" method="post" class="anondata">


	<input type="hidden" name="title" value="#xmlformat(rc.title)#" />
	<input type="hidden" name="tags" value="#xmlformat(rc.tags)#" />
	<input type="hidden" name="menuStatus" value="#xmlformat(rc.menuStatus)#" />
	<input type="hidden" name="menu" value="#xmlformat(rc.menu)#" />
	<input type="hidden" name="menuorder" value="#xmlformat(rc.menuorder)#" />
	<input type="hidden" name="theme_template" value="#xmlformat(rc.theme_template)#" />
	<input type="hidden" name="parentnodeid" value="#xmlformat(rc.parentnodeid)#" />
	<input type="hidden" name="pStatus" value="#xmlformat(rc.pStatus)#" />
	
	<input type="hidden" name="modifyby" value="#xmlformat(rc.modifyby)#" />
	
	
	<input type="hidden" name="xmlData" value="#xmlformat(rc.xmlData)#" />
	<input type="hidden" name="strData" value="#xmlformat(rc.strData)#" />
	


	
	<cfoutput>
	<p><b>Title:</b> #htmleditformat(rc.title)# <cfif rc.title EQ ""><i>None</i></cfif></p>
	<p><b>pStatus:</b> #htmleditformat(rc.pStatus)# <cfif rc.pstatus EQ ""><i>None</i></cfif></p>

	<blockquote> 	
		#rc.strData#
		<cfif rc.xmlData NEQ ""><hr /></cfif>
		#rc.xmlData#
	</blockquote>	
	</cfoutput>


<h3>Merge To</h3>
	


<p class="clearfix">
	<label>Page</label>


		<select name="NodeID"  class="text autowidth">
			<option> -- Pick One</option>
			<option>Create new page</option>
						
			<cfoutput query="rc.qryAllPages">
				<option value="#NodeID#" <cfif slug EQ rc.slug>selected="selected"</cfif>>
					<cfloop from="1" to="#level#" index="i">
							<span>&nbsp; &mdash; &nbsp;</span>
					</cfloop>
					
					 #htmleditformat(Title)#</option>
			</cfoutput>
			
		</select>
</p>


<!---
<p class="clearfix">
	<label>Apply to</label>
	
	<input type="radio" name="apply" value="strData" checked="checked"> Body
	
	&nbsp; &nbsp;
	
	<input type="radio" name="apply" value="xmlData"> XML Data (Must have Template support)
	
</p>
--->


<p class="submit">
	<br />
	<button type="submit" name="submit" class="submit">Data Import</button>
</p>	


	
</form>




</div>
