
<div class="main">

<cfoutput> 
	<h3>#application.GSAPI.i18n("choose_theme")#</h3>



<form action="#buildURL(action='.home')#" method="post">
</cfoutput>

<p>
	<select class="text" style="width : 300px;" name="theme_current"> 
	<cfoutput query="rc.qryTheme">
	<cfif type EQ "dir">
		<option value="#name#" <cfif request.Theme.current EQ name>selected="selected"</cfif>>#ucase(left(name, 1))##mid(name, 2, 50)# Theme</option>
	</cfif>
	</cfoutput>
	</select>

<cfoutput>	
	<button type="submit">#application.GSAPI.i18n("activate_theme")#</button>
</p>	
</form>


	<img src="#application.GSAPI.get_site_root()#theme/#request.theme.current#/images/screenshot.png" alt="Screenshot" />


	#application.GSAPI.exec_action("theme-extras", '', rc)#

</cfoutput>


</div>


