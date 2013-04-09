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


<div class="edit-nav">
        <a <cfif rc.plx EQ "country">class="current"</cfif> href="?plugin=traffic&plx=country">Region / Country</a>
               
        <a <cfif rc.plx EQ "os">class="current"</cfif> href="?plugin=traffic&plx=os">OS / Browsers</a>
        
        <a <cfif rc.plx EQ "search">class="current"</cfif> href="?plugin=traffic&plx=search">Search</a>
                
        <a <cfif rc.plx EQ "referer">class="current"</cfif> href="?plugin=traffic&plx=referer">Referers</a>
        
        <a <cfif rc.plx EQ "settings">class="current"</cfif> href="?plugin=traffic">Hits</a>

</div>

<div class="clear"></div>