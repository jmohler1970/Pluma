

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value= 'start'>
	
	<cfscript>
	param attributes.stars = "";
	
	maxstars = 2;
	if (attributes.stars > maxstars)
		maxstars = attributes.stars;
	</cfscript>

</cfcase>

<cfcase value="end">



<cfoutput>
<cfloop from="0" to="#maxstars#" index="i">
	<cfset ii = i>
	<cfif ii EQ 0>
		<cfset ii = "">
	</cfif>

	<input type="radio" name="stars" value="#i#" <cfif attributes.stars EQ ii>checked="checked"</cfif>> #repeatstring("&##9733;", i)# <cfif i EQ 0><i>None</i></cfif>
	<br />
	

</cfloop> 
</cfoutput>



</cfcase>
</cfswitch>