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
<h3>#application.GSAPI.get_string("plugins_management")#</h3>
</cfoutput>


<cfoutput>
<form action="#buildURL(action = '.home')#" method="post">
</cfoutput>


<table class="table table-condensed table-striped table-hover">

<cfoutput>
<thead>
<tr>
	<th>#application.GSAPI.get_string("status")#</th>
	<th>#application.GSAPI.get_string("plugin_name")#</th>
	<th>#application.GSAPI.get_string("plugin_desc")#</th>
</tr>
</thead>
</cfoutput>

<tbody>
<cfoutput query="application.qryPlugins">

<tr>
	<td>
		<input type="radio" name="plugin_#listfirst(filename, '.')#" value="1" 
			<cfif enabled>checked="checked"</cfif> /> Enabled
		&nbsp; &nbsp;
		<input type="radio" name="plugin_#listfirst(filename, '.')#" value="0" 
			<cfif NOT enabled>checked="checked"</cfif> /> Disabled
			
		
	
	</td>


	<td nowrap="nowrap">#Name#</td>
	<td>#Description#<br />
		<b>Version #Version#</b> - Author: <a href="#author_url#" target="_blank">#author#</a>
	</td>
</tr>

</cfoutput>
</tbody>
</table>

<cfoutput>
	<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
</cfoutput>
</form>	
	

<p>
	<i><cfoutput><b>#application.qryPlugins.recordcount#</b> plugins installed</cfoutput></i>
</p>



</div>
