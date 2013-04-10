


<h2>Meta Data</h2>

<table class="table table-condensed">
<cfset info = SpreadSheetInfo(rc.ssData)> 
	<cfoutput>
	<cfloop index="i" list="#structKeyList(info)#">
   		<tr>
 	  		<th>#i#</th>
 	  		<td>#evaluate("info.#i#")#</td>    
  		
   		</tr>
 	</cfloop>
</cfoutput>
</table>


