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

<h3 class="floated">#application.GSAPI.get_string("uploaded_files")#

<span id="filetypetoggle">&nbsp; &nbsp;/&nbsp; &nbsp; #rc.imagefilter#</span>
</h3>

<div class="edit-nav">
	<form action="#buildURL(action='.home')#" method="post" id="myfilter">
		<input type="hidden" name="path" value="#rc.path#">
	

		<select name="imagefilter" onchange="myfilter.submit();">
			<option value="Show All">#application.GSAPI.get_string("show_all")#</option>
			<option value="Documents" 	<cfif rc.imagefilter EQ "documents">selected="selected"</cfif>>Documents</option>
			<option value="Images" 		<cfif rc.imagefilter EQ "images">selected="selected"</cfif>>Images</option>
		</select>
		
		<div class="clear"></div>
	</form>
</div>






	
	<div class="h5 clearfix">
	
	<div class="crumbs">	
	/ <a href="#buildURL(action='.home')#">uploads</a> / 
	
	<cfloop index="i" list="#rc.path#" delimiters="/">
		#i# /
	</cfloop>
	</div>
	


		
	<div id="new-folder">
		<a id="createfolder" href="##">#application.GSAPI.get_string("create_folder")#</a></small>
	
	
	<form action="#buildURL(action='.createfolder')#" method="post">
		<input type="hidden" name="path" value="#rc.path#" />

	
			<input name="foldername" type="text" class="text" />

			<button type="submit">#application.GSAPI.get_string("create_folder")#</button> 
	
			<a class="cancel" href="##">#application.GSAPI.get_string("cancel")#</a>

	</form>
	</div>
</div>

<table class="edittable highlight paginate">
<thead>
<tr>
	<th>&nbsp;</th>
	<th>#application.GSAPI.get_string("file_name")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("file_size")#</th>
	<th style="text-align : right;">#application.GSAPI.get_string("date")#</th>
	<th></th>
</tr>
</thead>
</cfoutput>


<cfoutput query="rc.qryDirectory">
	<cfif name EQ ".ds_store">
	
	<cfelseif type EQ "dir">
	

	<tr>
	
		<td>&nbsp;</td>
	
		<td>
			<a href="#buildURL(action='.', querystring='path=#name#')#"><b>#name#</b></a>
		</td>
	
		
		<td style="text-align : right;"></td>
		
		<td style="text-align : right;">#LSDateFormat(datelastmodified)#</td>
	
		
		<td class="delete">
			<a href="#buildURL(action='.delete', querystring='folder=#name#')#">&times;</a>
		</td>
	</tr>
	
	<cfelse>
	
	<cfif 	rc.imagefilter EQ "Show All" 
		OR	rc.imagefilter EQ "Images" AND ListFindNoCase("jpg,jpeg,gif,png", listlast(name, ".")) 		NEQ 0
		OR	rc.imagefilter EQ "Documents" AND ListFindNoCase("jpg,jpeg,gif,png", listlast(name, ".")) 	EQ 0
		>
		
	<tr>
		<td>
			<cfif rc.imagefilter EQ "images">
			<img src="#rc.thumbspath##rc.path#/#name#" alt="#name#" style="width : 100px;" />
			</cfif>
		</td>
		<td>
			<cfif rc.path EQ "">
				<cfset querystring = "name=#name#">
			<cfelse>
				<cfset querystring = "path=#rc.path#&name=#name#">
			</cfif>
			
		<cfif ListFindNoCase("jpg,jpeg,gif,png", listlast(name, ".")) NEQ 0>
		
			<a href="#buildURL(action='.details', querystring=querystring)#">#name#</a>
		<cfelse>
			<cfif rc.path EQ "">
				<a href="#application.GSAPI.get_site_root()##rc.uploadspath##name#">#name#</a>	
			<cfelse>
				<a href="#application.GSAPI.get_site_root()##rc.uploadspath##rc.path#/#name#">#name#</a>	
			</cfif>
		
			
		
		</cfif>
		
		</td>
	
		
		<td style="text-align : right;">#LSNumberFormat(size \ 1024)# KB</td>
		
		<td style="text-align : right;">#LSDateFormat(datelastmodified)#</td>
	
		
		<td class="delete">
			<a href="#buildURL(action='.delete', querystring=querystring)#">&times;</a>
		</td>

	</tr>
		</cfif>
	
	</cfif>

</cfoutput>
</table>


<cfoutput>
<p><i><b>#rc.qryDirectory.recordcount#</b> total files &amp; folders (#rc.totalsize# KB)</i></p>
</cfoutput>

<cfoutput>
<h3>#application.GSAPI.get_string("choose_file")#</h3><a name="upload"></a>


<form action="#BuildURL(action = 'files.process')#" method="post" enctype="multipart/form-data">
	<input type="hidden" name="path" value="#rc.path#" />

	<input type="file" name="csv1" class="text" />

	<button type="submit">#application.GSAPI.get_string("file_upload")#</button>
</form>  


<p><small>#application.GSAPI.get_string("max_file_size")# <b>2MB</b></small></p>
</cfoutput>

</div>
