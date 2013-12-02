




<cfscript>
param request.exception = {type = "unknown"};
</cfscript>



<cffunction name="doMail">
	<cfreturn>

	<cfmail subject="cfcatch on PlumaCMS" from="test@webworldinc.com" to="tfs@webworldinc.com,james@webworldinc.com" type="HTML" timeout="600">
		<cfdump var="#request.exception#" format="text">
		<cfdump var="#cgi#" format="text">
		<cfdump var="#url#" format="text">
		
		<cfif structkeyExists(form, "fieldnames")>
		
		<cfloop list="#form.fieldnames#" index="i">
			<cfoutput>
				<b>#i#:</b> 
				<cfif i CONTAINS "password">
					******
				<cfelse>
					#form[i]#
				</cfif>
			</cfoutput>
			<br />
		</cfloop>
		</cfif>
		
		<cfdump var="#session#" format="text">
	</cfmail>
	
</cffunction>


<cfif request.exception.type EQ "Unknown">



	
	<p>Nothing is no thing, denoting the absence of something. Nothing is a pronoun associated with nothingness, which is also an adjective, and an object as a concept in the Frege-Church ontology. In nontechnical uses, nothing denotes things lacking importance, interest, value, relevance, or significance. Nothingness is the state of being nothing, the state of nonexistence of anything, or the property of having nothing.</p>

	<cfexit>
</cfif>



<cfif request.exception.type EQ "Expression">


	<h1>ERROR - Expression Error!</h1>

	<p>An internal programming error has happened.</p>
	

	<cfset doMail()>
	
	<cflog type="Error"
        file="Foundation"
        text="#cgi.query_string# 
            Exception type: #request.exception.Type#
            Template: 		#request.exception.TagContext[1].raw_trace#">
    
    <cfset rc.error_details = request.exception.Detail>
    <cfset rc.error_message = cgi.query_string>
        
 	<cfif isDebugMode()>
 		<cfdump var="#request.exception#" label="Processed in #getCurrentTemplatePath()#">
 		
 		<cfdump var="#request.exception#">
 	</cfif>
 	

 		<cfdump var="#request.exception#">
            
    <cfexit>        
</cfif>


<cfset is404 = false>
<cfif request.exception.Type EQ "FW1.viewNotFound">

	<h1>404 ERROR - File not found!</h1>

	<p>The resource you are looking for could not be found! It could have been removed, had its name changed, or is temporarily unavailable. Please review the URL and make sure that it is spelled correctly.</p>
	
	<cfset doMail()>

	
	<cflog type="Error"
        file="404_Error"
        text="Circuit not found error -- 
            Exception type: #request.exception.Type#
            Template: 		#request.exception.Detail#">
	

	<cfexit>
</cfif>


<cfif request.exception.RootCause.Type EQ "FW1.viewNotFound">

	<h1>404 ERROR - File not found!</h1>

	<p>The resource you are looking for could not be found! It could have been removed, had its name changed, or is temporarily unavailable. Please review the URL and make sure that it is spelled correctly.</p>

	<cfset doMail()>
	
	
	<cflog type="Error"
        file="404_Error"
        text="File not found error -- 
            Exception type: #request.exception.RootCause.Type#
            Template: 		#request.exception.RootCause.Detail#">
	

	<cfexit>
</cfif>




﻿<h1>An Error Occurred</h1>
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



<cfdump var="#request.exception#" label="Request Exception">


<cfset doMail()>

<cflog type="Error"
        file="Foundation"
        text="#cgi.query_string# 
            Exception type: #request.exception.RootCause.Type#
            Template: 		#request.exception.RootCause.Detail#">

