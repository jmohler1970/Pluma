


<div class="main">


<h3>Manage SiteMap</h3>



<cfform action="#buildurl(action = '.sitemap')#" name="myFrm" class="form-horizontal">
	
<cfoutput>	
	<input type="hidden" name="sitemapid" value="#rc.sitemapid#" />	

</cfoutput>






<p>
	<b>Title</b>
	
   	<cfinput type="text" name="title" class="text" required="yes" value="#rc.qryNode.title#" maxLength="50" message="Title is required" />



<p>
	<b>Site Root</b>

   	<span class="input-xlarge uneditable-input"><cfoutput>#rc.siteroot#</cfoutput></span>
</p>

  


<table class="edittable highlight paginate">
<thead>
	<tr>
		<th>Slug</th>
		<th>Change Frequency</th>
		<th>Priority</th>
	</tr>
</thead>
<tbody>

<cfoutput query="rc.qrySiteMap">
	<tr>
		<td><input type="text" name="loc_#currentrow#" value="#loc#" class="text" placeholder="[Root]" style="width : 350px;" /></td>
		<td>
		<select class="text" name="changefreq_#currentrow#" style="width : 150px;">
		<cfloop index="j" list="exclude,never,yearly,monthly,weekly,daily,hourly,always">
			<option value="#j#" <cfif j EQ changefreq>selected="selected"</cfif>>#j#</option>
		</cfloop>
		</select>
		</td>
		<td>
		<select class="text" name="priority_#currentrow#" style="width : 50px;">
		<cfloop index="j" from="1.0" to="0.0" step="-0.1">
			<option value="#LSNumberFormat(j, '9.9')#" 
				<cfif LSNumberFormat(j, '9.9') EQ priority>selected="selected"</cfif> 
				>#LSNumberFormat(j, '9.9')#</option>
		</cfloop>
		</select>
		
		</td>
	</tr>
</cfoutput>

</tbody>
</table>


    
<cfoutput>    

   


<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
	
	<cfif isnumeric(rc.SitemapID)>
		<input type="submit" name="submit" class="submit" value="Delete" />

	</cfif>
			



</cfoutput>	
	
	
</cfform>	

</div>
	