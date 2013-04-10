
<div class="main">

<cfoutput> 
	<h3>#application.GSAPI.get_string("choose_theme")#</h3>



<form action="#buildURL(action='.home')#" method="post">
</cfoutput>

<p>
	<select class="text" style="width : 300px;" name="theme_current"> 
	<cfoutput query="rc.qryTheme">
	<cfif type EQ "dir">
		<option value="#name#" <cfif request.stTheme.current EQ name>selected="selected"</cfif>>#ucase(left(name, 1))##mid(name, 2, 50)# Theme</option>
	</cfif>
	</cfoutput>
	</select>

<cfoutput>	
	<button type="submit">#application.GSAPI.get_string("activate_theme")#</button>
</p>	
</form>


	<img src="#application.GSAPI.get_site_root()#theme/#request.stTheme.current#/images/screenshot.png" />

</cfoutput>


</div>


