
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
			#application.GSAPI.std_date(VersionDate)#
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
