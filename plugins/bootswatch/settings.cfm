

<h3>Bootswatch  Options</h3>
	



<cfoutput>
<form action="?plugin=bootswatch&amp;plx=settings" method="post" class="form-horizontal">



<p>
    <label class="control-label" for="bootswatch_css">Primary CSS</label>
   
	<select name="bootswatch_css" class="text autowidth">
		<option value=""></option>
		
		<cfloop query="rc.qryCSS">
			<cfif NOT name CONTAINS "responsive">
				<cfset partname = listfirst(name,'.')>
			 
	   			<option value="#partname#" <cfif rc.bootswatch_css EQ partname>selected="selected"</cfif> >#listrest(partname, '_')#</option>
			</cfif>	
 
    	</cfloop>
	</select>	
</p>

<p>
    <label class="control-label" for="bootswatch_backgroundcolor">Background Color</label>
   
    	<input type="text" class="text" name="bootswatch_backgroundcolor" value="#xmlformat(rc.bootswatch_backgroundcolor)#" />
  
</p>



<p>
    <label class="control-label" for="bootswatch_backgroundimage">Background Image</label>
   
    	
    	<input type="radio" name="bootswatch_backgroundimage" value="" <cfif rc.bootswatch_backgroundimage EQ "">checked</cfif> /> None
    	
    
    	<cfloop query="rc.qryBackground">
   			<br />
    		<input type="radio" name="bootswatch_backgroundimage" value="#name#" <cfif rc.bootswatch_backgroundimage EQ name>checked</cfif> /> #name#
 
    	</cfloop>
   
</p>

<p>
    <label class="control-label" for="bootswatch_backgroundrepeat">Background Repeat</label>

    	<cfloop list="no-repeat,repeat,repeat-x,repeat-y" index="i">
    	
    		<input type="radio" name="bootswatch_backgroundrepeat" value="#i#" <cfif rc.bootswatch_backgroundrepeat EQ i>checked</cfif> /> #i#
    
    	</cfloop>

</p>


<p>
    <label class="control-label" for="bootswatch_backgroundattachment">Background Fixed</label>

    	<input type="checkbox" name="bootswatch_backgroundattachment" value="1" <cfif rc.bootswatch_backgroundattachment>checked</cfif> />

</p>

<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>


</form>
</cfoutput>

<p></p>

<p>For more information on Bootswatch, visit <a href="http://bootswatch.com">Bootswatch</a></p>

