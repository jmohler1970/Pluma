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