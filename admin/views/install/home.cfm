

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





