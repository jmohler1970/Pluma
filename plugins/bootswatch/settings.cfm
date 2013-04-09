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

<h3>Bootswatch  Options</h3>
	



<cfoutput>
<form action="?plugin=bootswatch&plx=settings" method="post" class="form-horizontal">



<p>
    <label class="control-label" for="bootswatch_css">Primary CSS</label>
   
    	<input type="radio" name="bootswatch_css" value="" <cfif rc.bootswatch_css EQ "">checked</cfif> /> None
    	
    	<cfloop query="rc.qryCSS">
   			<br />
    		<input type="radio" name="bootswatch_css" value="#name#" <cfif rc.bootswatch_css EQ name>checked</cfif> /> #listrest(name, "_")#
 
    	</cfloop>
   
</p>

<p>
    <label class="control-label" for="bootswatch_backgroundcolor">Background Color</label>
   
    	<input type="text" class="text" name="bootswatch_backgroundcolor" value="#htmleditformat(rc.bootswatch_backgroundcolor)#" />
  
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

<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>


</form>
</cfoutput>

<p></p>

<p>For more information on Bootswatch, visit <a href="http://bootswatch.com">Bootswatch</a></p>

