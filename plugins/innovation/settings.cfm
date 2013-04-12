

<h3>Innovation Options</h3>
	



<cfoutput>
<form action="?plugin=innovation&plx=settings" method="post" class="form-horizontal">


<p>
    <label class="control-label" for="innovation_facebook">Facebook URL</label>
   
    <input type="text" class="text" name="innovation_facebook" value="#htmleditformat(rc.innovation_facebook)#" />
  
</p>

<p>
    <label class="control-label" for="innovation_twitter">Twitter URL</label>
   
    <input type="text" class="text" name="innovation_twitter" value="#htmleditformat(rc.innovation_twitter)#" />
  
</p>


<p>
    <label class="control-label" for="innovation_linkedin">LinkedIn URL</label>
   
    <input type="text" class="text" name="innovation_linkedin" value="#htmleditformat(rc.innovation_linkedin)#" />
  
</p>


<p>
    <label class="control-label" for="innovation_stackoverflow">Stackoverflow URL</label>
   
    <input type="text" class="text" name="innovation_stackoverflow" value="#htmleditformat(rc.innovation_stackoverflow)#" />
  
</p>


<p>
    <label for="innovation_login">Show login</label>
   
    <input type="checkbox" name="innovation_login" value="1" <cfif rc.innovation_login>checked="checked"</cfif> />
  
</p>


<p>
    <label for="innovation_search">Show search</label>
   
    <input type="checkbox" name="innovation_search" value="1" <cfif rc.innovation_search>checked="checked"</cfif> />
</p>


<p>
    <label for="innovation_tags">Show tags</label>
   
    <input type="checkbox" name="innovation_tags" value="1" <cfif rc.innovation_tags>checked="checked"</cfif> />
</p>




<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>


</form>
</cfoutput>

<p></p>



