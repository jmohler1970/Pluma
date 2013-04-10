



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

