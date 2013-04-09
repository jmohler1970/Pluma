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

	<h3>An Error Occurred</h3>

	<cfdump var="#request#">


</div>

<cfexit>

<h1>An Error Occurred</h1>
<p>I am the application error view: main.error (in error test).</p>
<p>Details of the exception:</p>
<cfoutput>
	<ul>
		<li>Failed action: <cfif structKeyExists( request, 'failedAction' )>#request.failedAction#<cfelse>unknown</cfif></li>
		<li>Application event: #request.event#</li>
		<li>Exception type: #request.exception.type#</li>
		<li>Exception message: #request.exception.message#</li>
		<li>Exception detail: #request.exception.detail#</li>
	</ul>
	

<p>Template Stack</p>

<ul>
<cfloop from="1" to="#ArrayLen(request.exception.TagContext)#" index="i">
		<li><b>Template:</b>
			#request.exception.TagContext[i].template#
			Line: #request.exception.TagContext[i].line#
			(#request.exception.TagContext[i].type#)
		
		</li>
	</cfloop>	
</ul>	
</cfoutput>



<cfdump var="#request.exception#" label="Request Exception" expand="no">