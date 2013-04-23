


<cfif not isnumeric(rc.userid)>
	<cfexit>
</cfif>


<h2>Recently Added Items</h2>


<table class="table">
<thead>
<tr>
	<th>&nbsp;</th>
	<th>Title</th>
	<th>Complete</th>
	<th>Status</th>
	<th>&nbsp;</th>
</tr>
</thead>

<cfoutput query="rc.qryNode" maxRows="50">
<tr>
	<td>
		<a href="##" rel="popover" data-content="Kind: #Kind# Modified: #application.GSAPI.std_date(ModifyDate)# By: #ModifyBy#
	Created: #application.GSAPI.std_date(CreateDate)# By: #CreateBy#">
			<i class="#Icon#"></i>
		</a>
	</td>
	<td></td>
	<td><cfif NOT cStatus>Draft</cfif></td>
	<td>#pStatus#</td>
	<td>
		<input type="checkbox" name="NodeID" value="#NodeID#" <cfif deleted>disabled="disabled"</cfif> />
	</td>
</tr>
</cfoutput>


<cfoutput>
<tfoot>
<tr>
	<td colspan="7" style="text-align : right;">
	<select name="pStatus">
		<option></option>
		<option>Delete</option>
		<optgroup label="Publication Status">	
		<cfloop index="ii" list="#application.stAdminSetting.Node.lstpstatus#">
			<option value="#ii#">#ii#</option>
		</cfloop>
		</optgroup>
	</select>
	
	<button class="btn">Update</button>		
	</td>
</tr>
</tfoot>
</cfoutput>


<cfif rc.qryNode.recordcount EQ 0>
<tr>
	<td colspan="7"><i>None</i></td>
</tr>
</cfif>


</table>