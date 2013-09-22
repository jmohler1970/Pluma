
<cfimport prefix="ui" taglib="../users/ui">



<div class="main">




<cfoutput>
	<h3>#application.GSAPI.i18n("website_settings")#</h3>


<form action="#buildURL(action = '.home')#" method="post">

<div class="leftsec">

<p>
    <b>#application.GSAPI.i18n("label_website")#</b>
    <br />
   
		<input type="text" name="meta_title" class="text" placeholder="Your Website's Name" value="#xmlformat(rc.meta_title)#" />
</p>

</div>

<div class="rightsec">
	<p>
    <b>#application.GSAPI.i18n("label_baseurl")#</b>
    <br />
   
		<input type="text" name="meta_root" class="text" placeholder="#application.GSAPI.suggest_site_path()#" value="#xmlformat(rc.meta_root)#" />
	</p>
</div>

<div class="clear"></div>
#application.GSAPI.exec_action("settings-website-extras")#

<p>
    <b>#application.GSAPI.i18n("META_DESC")#</b>
    <br />
   	<textarea name="meta_description" class="text" rows="5" style="height : 50px;">#xmlformat(rc.meta_description)#</textarea>
</p>


<p>
    <b>#application.GSAPI.i18n("TAG_KEYWORDS")#</b>
    <br />
 	<textarea name="meta_keywords" class="text" rows="5" style="height : 50px;">#xmlformat(rc.meta_keywords)#</textarea>
</p>


<div class="rightsec">

<p>
    <b>#application.GSAPI.i18n("label_email")#</b>
    <br />
  	<input type="text" name="meta_email" class="text"  placeholder="Contact" value="#xmlformat(rc.meta_Email)#" />
</p>
</div>



<div class="clear"></div>

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

<div class="leftsec">

<p>
    <label>#application.GSAPI.i18n("language")#</label>
    <select class="text" name="meta_language">
    	<cfif rc.meta_language EQ "">
			<option value="">-- Default</option>
		<cfelse>
			<option value="#rc.meta_language#" selected="selected">#rc.meta_language#</option>
		</cfif>
			
    	<cfloop query="rc.qryLang">
    		<cfset lang = listfirst(name, '.')>
    		
    		<option value="#lang#">#lang#</option>
		</cfloop>
   	</select>
</p>
</div>




<div class="clear"></div>

	<button type="submit" name="submit" value="settings">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>

</form>
</cfoutput>

<p></p>

<p>Meta information is used by searching engines to help evaluate the site. These settings take effect in 5 minutes.</p>

<p>For more information on meta tags, visit <a href="http://www.webmarketingnow.com/tips/meta-tags-uncovered.html">http://www.webmarketingnow.com/tips/meta-tags-uncovered.html</a></p>


<a id="profile"></a>


<cfoutput>
	<h3>#application.GSAPI.i18n("side_user_profile")#</h3>
</cfoutput>
	

	<ui:profile stUser		= "#rc.stUser#" 
				action	= "#BuildURL(action = '.home')#"  
		/>
			



</div>





