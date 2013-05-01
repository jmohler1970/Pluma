

<div class="main">



<cfoutput>

<h3 class="floated">#application.GSAPI.i18n("uploaded_files")#

<span id="filetypetoggle">&nbsp; &nbsp;/&nbsp; &nbsp; #application.GSAPI.i18n(rc.imagefilter)#</span>
</h3>

<div class="edit-nav">
	<form action="#buildURL(action='.home')#" method="post" id="myfilter">
		<input type="hidden" name="path" value="#rc.path#">
	

		<select name="imagefilter" onchange="myfilter.submit();">
			<option value="Show_All">#application.GSAPI.i18n("show_all")#</option>
			<option value="Documents" 	<cfif rc.imagefilter EQ "documents">selected="selected"</cfif>>#application.GSAPI.i18n("ftype_documents")#</option>
			<option value="Images" 		<cfif rc.imagefilter EQ "images">selected="selected"</cfif>>#application.GSAPI.i18n("images")#</option>
		</select>
		
		<div class="clear"></div>
	</form>
</div>






	
	<div class="h5 clearfix">
	
	<div class="crumbs">	
	/ <a href="#buildURL(action='.home')#">uploads</a> / 
	
	<cfset partialPath = "">
	
	<cfloop index="i" list="#rc.path#" delimiters="|">
		<cfset partialPath = ListAppend(PartialPath, i, '|')>
		
		<cfif i NEQ listlast(rc.path, "|")>
			<a href="#buildURL(action='.home', querystring='path=#partialpath#')#">#htmleditformat(i)#</a>	
		<cfelse>
			#htmleditformat(i)#
		</cfif>
		
		/
	</cfloop>
	</div>
	


		
	<div id="new-folder">
		<a id="createfolder" href="##">#application.GSAPI.i18n("create_folder")#</a></small>
	
	
	<form action="#buildURL(action='.createfolder')#" method="post">
		<input type="hidden" name="path" value="#rc.path#" />

	
			<input name="foldername" type="text" class="text" />

			<button type="submit">#application.GSAPI.i18n("create_folder")#</button> 
	
			<a class="cancel" href="##">#application.GSAPI.i18n("cancel")#</a>

	</form>
	</div>
</div>

<table class="edittable highlight paginate">
<thead>
<tr>
	<th>&nbsp;</th>
	<th>#application.GSAPI.i18n("file_name")#</th>
	
	<th style="text-align : right;">#application.GSAPI.i18n("file_size")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("date")#</th>
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
			<cfset mypath = rc.path EQ "" ? urlencodedformat(name) : urlencodedformat("#rc.path#|#name#")>
			<a href="#buildURL(action='.', querystring='path=#mypath#')#"><b>#name#</b></a>
		</td>
	
		
		<td style="text-align : right;"></td>
		
		<td style="text-align : right;"><span>#application.IOAPI.std_date(datelastmodified)#</span></td>
	
		
		<td class="delete">
			<a 	href="#buildURL(action='.delete', querystring='folder=#name#')#"
				onclick="return confirm('#application.GSAPI.i18n("API_CONFIRM")#')"
				title="#application.GSAPI.i18n("deletepage_title")#">&times;</a>
		</td>
	</tr>
	
	<cfelse>
	
	<cfif 	rc.imagefilter EQ "Show_All" 
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
	
		
		<td style="text-align : right;"><span>#LSNumberFormat(size \ 1024)# KB</span></td>
		
		<td style="text-align : right;"><span>#application.IOAPI.std_date(datelastmodified)#</span></td>
	
		
		<td class="delete">
			<a href="#buildURL(action='.delete', querystring=querystring)#" title="#application.GSAPI.i18n("deletepage_title")#">&times;</a>
		</td>

	</tr>
		</cfif>
	
	</cfif>

</cfoutput>
</table>


<cfoutput>
<p><i><b>#rc.qryDirectory.recordcount#</b> #application.GSAPI.i18n("total_files")# (#rc.totalsize# KB)</i></p>
</cfoutput>

<cfoutput>
<h3>#application.GSAPI.i18n("uploadify_button")#</h3><a name="upload"></a>


<form action="#BuildURL(action = 'files.process')#" method="post" enctype="multipart/form-data">
	<input type="hidden" name="path" value="#rc.path#" />

	<input type="file" name="csv1" class="text" />

	<button type="submit">#application.GSAPI.i18n("file_upload")#</button>
</form>  


<p><small>#application.GSAPI.i18n("max_file_size")# <b>2MB</b></small></p>
</cfoutput>



</div>
