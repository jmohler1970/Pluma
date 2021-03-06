
<cfscript>
param rc.datasource = "";


filecount = 0;
managefiles = false;
</cfscript>

<div class="main">

<h3>Import Data</h3>

<table class="edittable highlight paginate">

<cfoutput> 
<thead>
<tr>
	<th>#application.GSAPI.i18n("file_name")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("file_size")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("date")#</th>
	<th>&nbsp;</th>
</tr>
</thead>
</cfoutput>

		
<cfoutput query="rc.qryDirectory">
	<cfif type EQ "file">
	<cfset filecount++>
	
	<tr>
		<td>
		<cfswitch expression="#listlast(name, ".")#">
		<cfcase value="txt,xml,xls,xlsx">
			<a href="#buildURL(action = 'backups.preview', querystring = 'name=#urlencodedformat(name)#')#">#xmlformat(name)#</a>
		</cfcase>
		<cfdefaultcase>
			#xmlformat(name)#
		</cfdefaultcase>
		</cfswitch> 
		
		</td>
		
		<td style="text-align : right;"><span>#LSNumberFormat(size \ 1024)# KB</span></td>
		
		<td style="text-align : right;"><span>#application.IOAPI.std_date(datelastmodified)#, #LSTimeFormat(datelastmodified)#</span></td>
		
	
			
		<td class="delete">	
			<a href="#buildURL(action = 'backups.deletedata', querystring = 'name=#urlencodedformat(name)#')#" title="#application.GSAPI.i18n("deletepage_title")#"> &times;</a>

		
		</td>
	</tr>


	</cfif>
</cfoutput>





</table>
	
<cfoutput>
	<p><i><b>#filecount#</b> data sources</i></p>
</cfoutput>




<cfoutput>
<h3>#application.GSAPI.i18n("uploadify_button")#</h3>



<form action="#buildURL(action = 'backups.process')#" method="post" enctype="multipart/form-data"  class="anondata">


	
<p>
	<label>&nbsp;</label> 
	<input type="file" name="csv" class="text" />
</p>	

<div class="clear"></div>


	<p>
      	<label>#application.GSAPI.i18n("PLUMACMS/duplicate_handling")#</label>
      	
      
		<select name="nameconflict">
			<option value="error">Stop</option>
			<option value="skip">Skip</option>
			<option value="overwrite">Overwrite</option>
			<option value="makeunique">Auto Rename</option>
		</select>
 
	</p>


	<button type="submit" class="submit">#application.GSAPI.i18n("file_upload")#</button>

</form>
</cfoutput>

</div>

 