

<cfoutput>

<div class="main">

<h3 class="floated">#application.GSAPI.i18n("SIDE_VIEW_SITEMAP")#</h3>
	<div class="edit-nav clearfix" >
		<a href="/sitemap.xml" target="_blank">
		#application.GSAPI.i18n("VIEW")#
		<?php i18n('VIEW'); ?></a>
		<a href="#buildURL(action='.sitemap', querystring='refresh=1')#">#application.GSAPI.i18n("REFRESH")#</a>
	</div>


<pre><code>#xmlformat(rc.xmlData)#</code></pre>


	

</div>


</cfoutput>

	