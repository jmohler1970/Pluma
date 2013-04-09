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





<cfoutput>
<form action="?plugin=simplex&plx=social" method="post" class="form-horizontal">

	<legend>Social Media</legend>

<div class="control-group">
    <label class="control-label" for="social_facebook">Facebook</label>
    <div class="controls">
 		<textarea class="input-xxlarge" name="social_facebook" rows="8">#htmleditformat(rc.social_facebook)#</textarea>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="social_twitter">Twitter</label>
    <div class="controls">
 		<textarea class="input-xxlarge" name="social_twitter" rows="8">#htmleditformat(rc.social_twitter)#</textarea>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="social_youtube">YouTube</label>
    <div class="controls">
 		<textarea class="input-xxlarge" name="social_youtube" rows="8">#htmleditformat(rc.social_youtube)#</textarea>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="social_other">Other</label>
    <div class="controls">
 		<textarea class="input-xxlarge" name="social_other" rows="8">#htmleditformat(rc.social_other)#</textarea>
    </div>
</div>





<div class="form-actions">
	<button type="submit" name="submit" class="btn btn-primary" value=""><i class="icon-ok icon-white"></i> Save</button>
</div>	


</form>
</cfoutput>


<p>Meta information is used by searching engines to help evaluate the site. These settings take effect in 5 minutes.</p>

<p>For more information on meta tags, visit <a href="http://www.webmarketingnow.com/tips/meta-tags-uncovered.html">http://www.webmarketingnow.com/tips/meta-tags-uncovered.html</a></p>

