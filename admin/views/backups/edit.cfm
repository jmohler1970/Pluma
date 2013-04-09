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
	<h3 class="floated">Backup of '<em>#rc.qryArchive.slug#</em>'</h3>


	


		<div class="edit-nav" >

			
			<a href="#buildURL(action = 'backups.restore', querystring = 'NodeArchiveID=#rc.NodeArchiveID#')#" rel="tooltip"  accesskey="r"><em>R</em>estore</a>			 
			 
			<a href="#buildURL(action = 'backups.delete', querystring = 'NodeArchiveID=#rc.NodeArchiveID#')#" rel="tooltip" title="Delete Archive" id="delback" accesskey="d" class="delconfirm noajax" ><em>D</em>elete</a>
		

			<div class="clear"></div>
		</div>
	 </cfoutput>
		

<cfform>

	<cfoutput query="rc.qryArchive">		
	<table class="simple highlight" >
		<tr><td class="title" >Page Title:</td><td><b>#title#</b> </td></tr>
		<tr>
			<td class="title" >Backup of:</td>
			<td>
			<a target="_blank" href="#application.GSAPI.get_site_root()#index.cfm/main/#slug#">#application.GSAPI.get_site_root()#index.cfm/main/#slug#</a>
			</td>
		</tr>
		<tr>
			<td class="title" >Date:</td>
			<td>#application.GSAPI.stdDate(VersionDate)# @
			#LSTimeFormat(VersionDate)# </td>
		</tr>
		<tr><td class="title" >Tags &amp; Keywords:</td><td><em>#tags#</em></td></tr>
		
		<tr><td class="title" >Menu Text:</td><td>#menu#</td></tr>
		<tr><td class="title" >Priority:</td><td>#menusort#</td></tr>
		<tr><td class="title" >Add this page to the menu</td><td>#yesnoformat(menustatus)#</td></tr>
	</table>


	<cftextarea name="strData" richtext="true" toolbar="Basic"  height="500" width="740">#strData#</cftextarea>


	</cfoutput>
</cfform>


</div>