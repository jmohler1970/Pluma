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

<cfscript>
param rc.datasource = "";


filecount = 0;
managefiles = false;
</cfscript>

<div class="main">

<h3>Import Data</h3>

<table class="edittable highlight paginate">

<tr>
	<th>File</th>
	<th>Date</th>
	<th style="text-align : right;">Size</th>
	<th>&nbsp;</th>
</tr>


		
<cfoutput query="rc.qryDirectory">
	<cfif type EQ "file">
	<cfset filecount++>
	
	<tr>
		<td>
		<cfswitch expression="#listlast(name, ".")#">
		<cfcase value="txt,xml,xls,xlsx">
			<a href="#buildURL(action = 'backups.preview', querystring = 'name=#urlencodedformat(name)#')#">#htmleditformat(name)#</a>
		</cfcase>
		<cfdefaultcase>
			#htmleditformat(name)#
		</cfdefaultcase>
		</cfswitch> 
		
		</td>
		<td>#application.GSAPI.stdDate(datelastmodified)#, #LSTimeFormat(datelastmodified)#</td>
		
		<td style="text-align : right;">#LSNumberFormat(size \ 1024)# kB</td>
		
	
			
		<td class="delete">	
			<a href="#buildURL(action = 'backups.deletedata', querystring = 'name=#urlencodedformat(name)#')#"> &times;</a>

		
		</td>
	</tr>


	</cfif>
</cfoutput>





</table>
	
<cfoutput>
	<p><i><b>#filecount#</b> data sources</i></p>
</cfoutput>





<h3>Uploaded New Files</h3>


<cfoutput>
<form action="#buildURL(action = 'backups.process')#" method="post" enctype="multipart/form-data"  class="anondata">
</cfoutput>

	
	<p>
	<label>File to upload</label>
	<input type="file" name="csv" class="text" />
</p>



	<p>
      	<label>Duplicate handling</label>
      	
      
		<select name="nameconflict">
			<option value="error">Stop</option>
			<option value="skip">Skip</option>
			<option value="overwrite">Overwrite</option>
			<option value="makeunique">Auto Rename</option>
		</select>
 
	</p>


	<input type="submit" class="submit" value="Upload" />

</form>


</div>

 