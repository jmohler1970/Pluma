<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->


<div class="main">



<cfoutput>
	<h3>#application.GSAPI.get_string("website_settings")#</h3>


<form action="#buildURL(action = '.home')#" method="post">

<div class="leftsec">

<p>
    <b>#application.GSAPI.get_string("label_website")#</b>
    <br />
   
		<input type="text" name="meta_title" class="text" placeholder="Your Website's Name" value="#htmleditformat(rc.meta_title)#" />
</p>

</div>

<div class="rightsec">
	<p>
    <b>#application.GSAPI.get_string("label_baseurl")#</b>
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
    <b>#application.GSAPI.get_string("label_email")#</b>
    <br />
  	<input type="text" name="meta_email" class="text"  placeholder="Contact" value="#htmleditformat(rc.meta_Email)#" />
</p>
</div>


<div class="rightsec">
	<p><label for="timezone">#application.GSAPI.get_string("local_timezone")#</label>
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

	<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>

</form>
</cfoutput>

<p></p>

<p>Meta information is used by searching engines to help evaluate the site. These settings take effect in 5 minutes.</p>

<p>For more information on meta tags, visit <a href="http://www.webmarketingnow.com/tips/meta-tags-uncovered.html">http://www.webmarketingnow.com/tips/meta-tags-uncovered.html</a></p>



</div>
