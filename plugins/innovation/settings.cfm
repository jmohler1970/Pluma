<!---
Copyright (C) 2013 James Mohler

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




<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>


</form>
</cfoutput>

<p></p>



