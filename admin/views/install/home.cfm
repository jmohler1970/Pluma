<!---
Copyright (C) 2013 James Mohler

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

<cfset continue = true>

<div class="main" >

<cfoutput>
<h3>#application.GSAPI.get_site_name()# #application.GSAPI.get_string("installation")#</h3>


<div class="wrapper">

<table class="highlight healthcheck" style="width : 650px">
<tr>
	<td style="width:250px;" >#application.GSAPI.get_site_name()# #application.GSAPI.get_string("version")#</td>
	<td>#application.GSAPI.get_site_version()#</td>
</tr>
<tr>
	<td>ColdFusion Version</td>
	<td>#server.ColdFusion.ProductVersion#</td>
</tr>

<tr>
	<td>SQL Server Version</td>
	<td>#application.IOAPI.get_db_version()#</td>
</tr>

<tr>
	<td>Data Source Name</td>
	<td>#application.IOAPI.get_db_dsn()# &nbsp; <a href="#buildURL('.dsn')#"><b>Change...</b></a></td>
</tr>

<tr>
	<td>GSAPI</td>
	<td>
	<cfif application.GSAPI.InitStatus EQ "">
		<span class="OKmsg"> #application.GSAPI.get_string("ok")#</span></td>
	<cfelse>
		<span class="WARNmsg">#application.GSAPI.get_string("warning")#</span></td>
	</cfif>
	
	</td>
</tr>
<tr>
	<td>IOAPI</td>
	<td>
	<cfif application.IOAPI.InitStatus EQ "">
		<span class="OKmsg"> #application.GSAPI.get_string("ok")#</span></td>
	<cfelse>
		<cfset continue = "false">
		<span class="ERRmsg">#application.GSAPI.get_string("error")#: #application.IOAPI.InitStatus#</span></td>
	</cfif>
	</td>
</tr>
<tr>
	<td>USERAPI</td>
	<td>
	<cfif application.USERAPI.InitStatus EQ "">
		<span class="OKmsg"> #application.GSAPI.get_string("ok")#</span></td>
	<cfelse>
		<span class="WARNmsg">#application.GSAPI.get_string("warning")#</span></td>
	</cfif>
	</td>
</tr>


<tr>
	<td>LOGINAPI</td>
	<td>
	<cfif session.LOGINAPI.InitStatus EQ "">
		<span class="OKmsg"> #application.GSAPI.get_string("ok")#</span></td>
	<cfelse>
		<span class="WARNmsg">#application.GSAPI.get_string("warning")#</span></td>
	</cfif>
	</td>
</tr>
</table>

</div>


<p class="hint">For more information on the required modules, visit the <a href="#buildURL('.requirements')#" target="_blank">requirements page</a>.</p>



<cfif not continue>
	<p class="error"><b>Error:</b> The site cannot be setup.</p>

	<p>&nbsp;</p>

	<cfexit>
</cfif>



<form action="#buildURL('.setup')#">

<div class="clear"></div>
	<p>
		<button type="submit">#application.GSAPI.get_string("continue_setup")#  &raquo;</button>
	</p>
</form>

</cfoutput>

</div>





