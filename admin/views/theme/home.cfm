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
	<h3>#application.GSAPI.get_string("choose_theme")#</h3>



<form action="#buildURL(action='.home')#" method="post">
</cfoutput>

<p>
	<select class="text" style="width : 300px;" name="theme_current"> 
	<cfoutput query="rc.qryTheme">
	<cfif type EQ "dir">
		<option value="#name#" <cfif request.stTheme.current EQ name>selected="selected"</cfif>>#ucase(left(name, 1))##mid(name, 2, 50)# Theme</option>
	</cfif>
	</cfoutput>
	</select>

<cfoutput>	
	<button type="submit">#application.GSAPI.get_string("activate_theme")#</button>
</p>	
</form>


	<img src="#application.GSAPI.get_site_root()#theme/#request.stTheme.current#/images/screenshot.png" />

</cfoutput>


</div>


