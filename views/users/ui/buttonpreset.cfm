

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value= 'end'>
	

<script type="text/javascript">
function dobox(lstOption)	{
	
	var arOption = lstOption.split(",");
		
	//rForm.reset(); // set all to blank
	
	for (i = 0; i < rForm.elements.length; i++)	{
		if (rForm.elements[i].type == "checkbox")	{
			rForm.elements[i].checked = 0;
			}
		
		for (j = 0; j < arOption.length; j++)	{
			if (rForm.elements[i].value == arOption[j])	{
				rForm.elements[i].checked = 1;
				}
			}
		}
			
	}
</script>

<table align="center">
<tr>
	<cfloop index="i" list="#StructKeyList(application.stAdminSetting.AccessTemplate)#">
		<cfoutput>
			<cfset lstBox = application.stAdminSetting.AccessTemplate.get(i)>
		
			<td style="">
			<button type="button" onclick="dobox('#lstBox#');" style="text-transform : capitalize; width : 95px;">#replacelist(i, '_', ' ')#</button>
			

	</td>
		</cfoutput>
	</cfloop>
</tr>
</table>


</cfcase>
</cfswitch>