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


<cfcomponent hint="Manages Comments">


<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "">

	<cftry>
		<cfset this.get()>
		
		<cfreturn "">

		<cfcatch />
	</cftry>
	
	<cfreturn "Unable to query preferences DB">
</cffunction>




<cfscript>
function stripHTML(str) output="false" {
	return REReplaceNoCase(arguments.str,"<[^>]*>","","ALL");
	}
</cfscript>





<cffunction name="getInbox" output="false" access="remote" returnType="query">

	<cfset var qryComment = "">

	<cfquery name="qryComment">
		SELECT 	C.UserID, C.Subject, C.Content, C.Handle, C.Email, C.CommentID, C.pStatus, C.CreateDate
		FROM 	dbo.Comment C
		WHERE 	NodeID is null
		AND		C.Deleted = 0
		ORDER BY CreateDate DESC
	</cfquery>

	<cfreturn qryComment>
</cffunction>




<cffunction name="getByKindpStatus" output="false" access="remote" returnType="query">
	<cfargument name="kind" required="true" type="string">
	<cfargument name="pStatus" required="true" type="string">

	<cfset var qryComment = "">

	<cfquery name="qryComment">
		SELECT 	C.Subject, C.Content, C.Handle, C.Email, C.CommentID, C.pStatus, C.CreateDate AS CommentDate,
			N.NodeID, N.Title, N.CreateDate, N.CreateBy, N.ModifyDate, N.ModifyBy
		FROM 	dbo.Comment C, dbo.vwNode N
		WHERE 	C.pStatus = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pStatus#">
		AND		C.NodeID = N.NodeID
		AND		N.Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.Kind#">
		AND		N.Deleted = 0
	</cfquery>

	<cfreturn qryComment>
</cffunction>




<cffunction name="getByNodeID" output="false" access="remote" returnType="query">
	<cfargument name="NodeK" required="true" type="struct">


	<cfset var qryComment = "">

	<cfquery name="qryComment">
		SELECT 	C.Content, C.Handle, C.Email, C.CommentID, C.pStatus, C.CreateDate AS CommentDate, 
			N.NodeID, N.Title, N.CreateDate, N.CreateBy, N.ModifyDate, N.ModifyBy
		FROM 	dbo.Comment C, dbo.vwNode N
		WHERE 	C.NodeID = N.NodeID
		AND		N.NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
		AND		N.Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
		
		AND		N.Deleted = 0
		ORDER BY C.CreateDate DESC
	</cfquery>

	<cfreturn qryComment>
</cffunction>


<cfscript>
boolean function savepStatus(required string lstCommentID, required string submit) output="false" access="remote"	{

	arCommentID = ListToArray(arguments.lstCommentID);
	
	for (var i = 1; i <= ArrayLen(arCommentID); i++)	{
		ormComment = EntityLoadByPK("Comment", arCommentID[i]);
		
		ormComment.setPStatus(arguments.submit);
	
		EntitySave(ormComment);
		}

	ORMFlush();

	return true;
	}



boolean function add(required struct rc) output="false" access="remote" {
	
	param rc.comment = "Comment field is blank";
	
	/* bad things */
	if (not isdefined("rc.mousy")) {return false; }
	if (not isdefined("rc.register")) {return false; }
	if (rc.mousy 	!= 1) 	{return false; } // must exist
	if (rc.register != "") 	{return false; } // must exist
	if (rc.createReply != hash(LSDateFormat(now()))) {return false; }
	if (Len(rc.comment) > application.stHomeSetting.Spam.maxlen)	{return false; }
	
	
	lstMyList = application.stHomeSetting.Spam.lstkeywords;
	for (i = 1; i <= ListLen(lstMyList); i++)	{
		if (rc.comment CONTAINS listGetAt(lstMyList, i)) { return false; }
		if (rc.email CONTAINS listGetAt(lstMyList, i)) { return false; }
		}
	
	lstMyList = application.stHomeSetting.Spam.lstspam;
	for (i = 1; i <= ListLen(lstMyList); i++)	{
		if (rc.comment CONTAINS listGetAt(lstMyList, i)) { return false; }
		if (rc.email CONTAINS listGetAt(lstMyList, i)) { return false; }
		}
		
	if (not isnumeric(rc.NodeID)) {return false;}
	
	/* Good things */
	return this.addSafe(rc);
	}



boolean function addSafe(required struct rc) output="false" access="remote" {
	
	param rc.ParentCommentID = "";
	param rc.likeUnlike = 0;
	
	param rc.NodeID = "";
	param rc.handle = "";
	param rc.email  = "";
	param rc.subject = "";
	param rc.comment = "Comment field is blank";
	
	if (NOT rc.email CONTAINS "@")	{
		return false;
		}
	
	var ormComment = EntityNew("Comment");
	
	if (isnumeric(rc.NodeID))	{
		ormComment.setNodeID(rc.NodeID);
		}
	
	if (isnumeric(rc.ParentCommentID)) {
		ormComment.setParentCommentID(rc.ParentCommentID); 
		}	
	
	ormComment.setHandle(this.stripHTML(rc.handle));
	ormComment.setEmail(this.stripHTML(rc.email));
	
	
	if (rc.subject != "")	{
		ormComment.setSubject(this.stripHTML(rc.subject));
		}
				
	ormComment.setContent(this.stripHTML(rc.comment));
	ormComment.setLikeUnLike(rc.likeUnlike);

	EntitySave(ormComment);
	
	return true;
	}
	

boolean function delete(required string CommentID) output="false" access="remote" {	
	
	if (arguments.commentID == "")	{
		return false;
		}
	
	for(var i = 1; i <= listLen(arguments.CommentID); i++)	{
		var ormComment = EntityLoadByPK("Comment", listGetAt(arguments.CommentID, i));
		ormComment.setDeleteDate(now());
		
		EntitySave(ormComment);		
		}
	
	return true;		
	}
</cfscript>




</cfcomponent>
 
