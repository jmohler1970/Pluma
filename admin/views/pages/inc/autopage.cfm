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

<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value="start">

<cfscript>
param attributes.autopage = "";

variables.qryDirectory = DirectoryList("#GetDirectoryFromPath(GetCurrentTemplatePath())#autopage/", false, "query", "", "name");	
</cfscript>

</cfcase>

<cfcase value= 'end'>
<cfoutput>
	<!-- Autopage: #attributes.autopage# -->
</cfoutput>

<select name="autopage">
	<option></option>
	<cfoutput query="qryDirectory">
		<cfset DisplayName = listfirst(name, ".")>
	
		<option value="#name#" <cfif attributes.autopage EQ name>selected</cfif>>#DisplayName#</option>
	</cfoutput>
</select>

</cfcase>
</cfswitch>

