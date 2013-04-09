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

<div class="row">
    <div class="span2">&nbsp;</div>
	
	<div class="span8">



<cfoutput>
<form action="#buildURL(action = '.components')#" method="post" class="form-horizontal">
	<input type="hidden" value="components" type="Footer" />


<legend>About Us</legend>

<div class="control-group">
 
    <div class="controls">
 		<textarea class="input-xxlarge" name="footer_aboutus" rows="6">#htmleditformat(request.stFooter.aboutus)#</textarea>
    </div>
</div>


<legend>Showcase Links</legend>
		<a class="btn btn-success" href="#buildURL(action = 'page.menu', querystring = 'extra=Showcase')#"
			rel="tooltip" title="Kind: Menu"><span class="count" style="text-transform : capitalize;">Edit</span></a>


<legend>Sitemap Links</legend>

<a class="btn btn-success" href="#buildURL(action = 'page.menu', querystring = 'extra=Sitemap')#"
			rel="tooltip" title="Kind: Menu"><span class="count" style="text-transform : capitalize;">Edit</span></a>
			
			
<legend>Contact Us</legend>
<div class="control-group">
 
    <div class="controls">
 		<textarea class="input-xxlarge" name="footer_contactus" rows="6">#htmleditformat(request.stFooter.contactus)#</textarea>
    </div>
</div>			
			

<!---
<legend>Social Media</legend>

<div class="control-group">
    <label class="control-label" for="socialbox_facebook">Facebook</label>
    <div class="controls">
    	<input type="checkbox" name="socialbox_facebook" value="1" <cfif request.footer_facebook EQ 1>checked="checked"</cfif> /> 
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="socialbox_twitter">Twitter</label>
    <div class="controls">
    	<input type="checkbox" name="socialbox_twitter" value="1" <cfif rc.socialbox_twitter EQ 1>checked="checked"</cfif> />
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="socialbox_youtube">YouTube</label>
    <div class="controls">
    	<input type="checkbox" name="socialbox_youtube" value="1" <cfif rc.socialbox_youtube EQ 1>checked="checked"</cfif> />

    </div>
</div>


<div class="control-group">
    <label class="control-label" for="socialbox_other">Other</label>
    <div class="controls">
 		<input type="checkbox" name="socialbox_other" value="1" <cfif rc.socialbox_other EQ 1>checked="checked"</cfif> />
    </div>
</div>
--->

<div class="form-actions">
	
	<button type="submit" name="submit" class="btn btn-primary" value="">Save</button>

</div>	


</form>
</cfoutput>
			
	</div>
</div>

