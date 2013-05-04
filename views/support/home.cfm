

<div class="main">




<cfoutput>
<h3>#application.GSAPI.i18n("GETTING_STARTED")#</h3>



<ul>
	<li id="documentation"><a href="https://github.com/jmohler1970/Pluma/wiki">#application.GSAPI.i18n("SIDE_DOCUMENTATION")#</a></li>
	<li id="security"><a href="#buildURL('support.security')#">Security</a></li>
	<li id="support"><a href="#buildURL('support.contact')#">Support Options</a></li>
</ul>


<p>
#application.GSAPI.i18n("welcome_msg")#
#application.GSAPI.i18n("welcome_p")#
</p>





<ul>
	<li><a href="#buildURL('support.jvm')#">#application.GSAPI.i18n("WEB_HEALTH_CHECK")#</a></li>
	<li><a href="#buildURL('pages.edit')#">#application.GSAPI.i18n("CREATE_NEW_PAGE")#</a></li>
	<li><a href="#buildURL('files.home')#">#application.GSAPI.i18n("UPLOADIFY_BUTTON")#</a></li>
	<li><a href="#buildURL('settings.home')#">#application.GSAPI.i18n("GENERAL_SETTINGS")#</a></li>
	<li><a href="#buildURL('theme.home')#">#application.GSAPI.i18n("CHOOSE_THEME")#</a></li>
</ul>


<h3>#application.GSAPI.i18n("SUPPORT")#</h3>

<ul>
	<li id="recent_login"><a href="#buildURL('.jour')#">#application.GSAPI.i18n("VIEW_FAILED_LOGIN")# </a></li>
</ul>



	

<h3>#application.GSAPI.i18n("plumacms/OTHER_TECH")#</h3>
<p>#application.GSAPI.i18n("plumacms/OTHER_TECH_DESC")#</p>

		<ul>
			<li><a href="http://www.adobe.com/products/coldfusion-family.html" target="_blank">Adobe ColdFusion </a></li>
			<li><a href="http://www.microsoft.com/sqlserver" target="_blank">Microsoft SQL Server </a></li>
			<li><a href="http://jquery.com/" target="_blank">jQuery</a></li>
			<li><a href="http://fw1.riaforge.org/" target="_blank">FW/1 by Sean Corfield </a></li>
			<li><a href="http://twitter.github.com/bootstrap/" target="_blank">Twitter Bootstrap</a></li>
			<li><a href="http://bootswatch.com/" target="_blank">Bootswatch Themes</a></li>
			<li><a href="http://freegeoip.net/" target="_blank">freegeoip.net</a></li>
			<li><a href="http://www.hr-xml.org/" target="_blank">HR-XML</a></li>
			<li><a href="https://developers.google.com/chart/" target="_blank"> Google Charts and Maps</a></li>
			<li><a href="http://lesscss.org/" target="_blank"> LESS</a></li>
			<li><a href="http://get-simple.info/" target="_blank"> GetSimple CMS</a></li>
		</ul>

</div>
</cfoutput>
