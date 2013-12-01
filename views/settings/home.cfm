

<div class="main">




<cfoutput>
	<h3>#application.GSAPI.i18n("website_settings")#</h3>


<form action="#rc.xa.settings#" method="post">

<div class="leftsec">

<p>
    <b>#application.GSAPI.i18n("label_website")#</b>
    <br />
   
		<input type="text" name="meta.title" class="text" placeholder="Your Website's Name" value="#rc.meta.title#" />
</p>

</div>

<div class="rightsec">
	<p>
    <b>#application.GSAPI.i18n("label_baseurl")#</b>
    <br />
   
		<input type="text" name="meta.root" class="text" placeholder="#application.GSAPI.suggest_site_path()#" value="#rc.meta.root#" />
	</p>
</div>

<div class="clear"></div>
#application.GSAPI.exec_action("settings-website-extras")#

<p>
    <b>#application.GSAPI.i18n("META_DESC")#</b>
    <br />
   	<textarea name="meta.description" class="text" rows="5" style="height : 50px;" value="#rc.meta.description#"></textarea>
</p>


<p>
    <b>#application.GSAPI.i18n("TAG_KEYWORDS")#</b>
    <br />
 	<textarea name="meta.keywords" class="text" rows="5" style="height : 50px;" value="#rc.meta.keywords#"></textarea>
</p>


<div class="rightsec">

<p>
    <b>#application.GSAPI.i18n("label_email")#</b>
    <br />
  	<input type="text" name="meta.email" class="text"  placeholder="Contact" value="#rc.meta.email#" />
</p>
</div>



<div class="clear"></div>

<div class="rightsec">
	<p><label for="timezone">#application.GSAPI.i18n("local_timezone")#</label>
		<select class="text" name="meta.timezone">
			<cfif rc.meta.timezone EQ "">
				<option value="">-- None</option>
			<cfelse>
				<option value="#rc.meta.timezone#" selected="selected">#rc.meta.timezone#</option>
			</cfif>
			<cfinclude template="timezone_options.txt">
 		</select>
	</p>
</div>

<div class="leftsec">

<p>
    <label>#application.GSAPI.i18n("language")#</label>
    <select class="text" name="meta.language">
    	<cfif rc.meta.language EQ "">
			<option value="">-- Default</option>
		<cfelse>
			<option value="#rc.meta.language#" selected="selected">#rc.meta.language#</option>
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


</div>




