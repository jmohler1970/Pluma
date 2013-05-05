


<cfoutput>
<form action="#buildURL(action = '.pageload')#" method="post">
</cfoutput>	

	<legend>Spreadsheet Preview</legend>


	<cfoutput>
		#rc.xmlData#
	</cfoutput>




<div class="form-actions">
	<select name="NodeID">
		<cfoutput query="rc.qrytoppage" group="ParentTitle">
			<optgroup label="#ParentTitle#"> 
			<cfoutput>
				<option value="#NodeID#">#xmlformat(title)# <cfif title EQ "">No Title</cfif></option>
			</cfoutput>
		</cfoutput>
		
	</select>
		

	<input type="submit" name="submit" class="submit" value="Import" />
</div>	


</form>


<cfinclude template="ui/meta.cfm">

