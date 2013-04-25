

<div class="main">



<cfoutput>
	<h3>#application.GSAPI.i18n("website_settings")#</h3>


<form action="#buildURL(action = '.home')#" method="post">

<div class="leftsec">

<p>
    <b>#application.GSAPI.i18n("label_website")#</b>
    <br />
   
		<input type="text" name="meta_title" class="text" placeholder="Your Website's Name" value="#htmleditformat(rc.meta_title)#" />
</p>

</div>

<div class="rightsec">
	<p>
    <b>#application.GSAPI.i18n("label_baseurl")#</b>
    <br />
   
		<input type="text" name="meta_root" class="text" placeholder="#application.GSAPI.suggest_site_path()#" value="#htmleditformat(rc.meta_root)#" />
	</p>
</div>

<div class="clear"></div>


<p>
    <b>Meta Description</b>
    <br />
   	<textarea name="meta_description" class="text" rows="5" style="height : 50px;">#htmleditformat(rc.meta_description)#</textarea>
</p>


<p>
    <b>Meta Keywords</b>
    <br />
 	<textarea name="meta_keywords" class="text" rows="5" style="height : 50px;">#htmleditformat(rc.meta_keywords)#</textarea>
</p>


<div class="leftsec">

<p>
    <b>#application.GSAPI.i18n("label_email")#</b>
    <br />
  	<input type="text" name="meta_email" class="text"  placeholder="Contact" value="#htmleditformat(rc.meta_Email)#" />
</p>
</div>


<div class="rightsec">
	<p><label for="timezone">#application.GSAPI.i18n("local_timezone")#</label>
		<select class="text" name="meta_timezone">
			<cfif rc.meta_timezone EQ "">
				<option value="">-- None</option>
			<cfelse>
				<option value="#rc.meta_timezone#" selected="selected">#rc.meta_timezone#</option>
			</cfif>
			<cfinclude template="timezone_options.txt">
 		</select>
	</p>
</div>






<div class="clear"></div>

	<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>

</form>
</cfoutput>

<p></p>

<p>Meta information is used by searching engines to help evaluate the site. These settings take effect in 5 minutes.</p>

<p>For more information on meta tags, visit <a href="http://www.webmarketingnow.com/tips/meta-tags-uncovered.html">http://www.webmarketingnow.com/tips/meta-tags-uncovered.html</a></p>



</div>