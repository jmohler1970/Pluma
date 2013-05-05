
<div class="main">

<cfoutput> 
	<h3>#application.GSAPI.i18n("SIDE_EDIT_THEME")#</h3>

<form action="#buildURL(action='theme.edit')#" method="post">

<select name="theme_files">
	<cfloop query="rc.qryTemplates">
		<cfif type EQ "file">
		<option value="#name#" <cfif rc.theme_files EQ name>selected="selected"</cfif>>#name#</option>
		</cfif>
	</cfloop>
</select>


<textarea name="strTemplate" cols="80" rows="30" wrap="soft">#xmlformat(rc.strTemplate)#</textarea> 




</form>


</cfoutput>



</div>



