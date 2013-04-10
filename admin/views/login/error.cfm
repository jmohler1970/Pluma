

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