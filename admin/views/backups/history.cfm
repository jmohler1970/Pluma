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

<h3>Archive Versions</h3>


<cfform action="#buildurl(action = '.history', querystring = 'nodeid=#rc.nodeID#')#" name="myFrm">

<table class="edittable highlight paginate">
<thead>
	<tr>
		<th></th>
		<th>Page Title</th>
		<th>Archive Date</th>
		<th>Size</th>
		<th>&nbsp;</th>
	</tr>
</thead>
<tbody>
<cfoutput query="rc.qryArchive">
	<tr>
		<td>#Kind#</td>
		
		<td>#Title#</td>
		
		<td>	
			#LSTimeFormat(VersionDate)# @
			#application.GSAPI.stdDate(VersionDate)#
		</td>
		
		<td>#ModifyBy#</td>
		
		<cfset kSize = DataSize \ 1024>
		<td style="text-align : right;">#LSNumberFormat(kSize)# KB</td>
		
		<td><input type="radio" name="NodeArchiveID" value="#NodeArchiveID#" <cfif currentrow EQ 1>checked="checked"</cfif> /></td>
	</tr>
</cfoutput>
</tbody>
</table>

<cfif rc.qryArchive.recordcount GT 0>
	<cfoutput>
		<button type="submit" name="submit" class="submit">Restore</button>
	</cfoutput>
</cfif>

</cfform>

<cfoutput>
	<p><i><b>#rc.qryArchive.recordcount#</b> archive versions</i></p>
</cfoutput>



</div>
