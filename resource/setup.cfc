<!---
Copyright (c) 2012 James Mohler

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
   
 	
 			
<cfcomponent>		
 	
 	
<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "">
</cffunction> 	
 	


 	
<cffunction name="clear_all" returnType="boolean" output="false" access="remote" hint="Clears everything">

	
	<cfquery>
	DELETE
	FROM	dbo.Plugin
	
	DELETE
	FROM 	dbo.Pref
	
	DELETE
	FROM	dbo.LoginLog
	
	DELETE
	FROM	dbo.Users
	
	DELETE
	FROM	dbo.Comment
	
	
	DELETE
	FROM	dbo.NodeArchive
	
	DELETE
	FROM	dbo.Node
		
	DELETE
	FROM	dbo.Traffic
	
	--DELETE
	--FROM	dbo.Calendar
	</cfquery> 


	<cfreturn true>
</cffunction> 
 	
 	
	
 	
 
 </cfcomponent>	
 	