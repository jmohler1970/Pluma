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
   	
 	
 			
<cfcomponent extends="nodero">		

 	
<cffunction name="Reactivate" returnType="struct" output="false" access="remote" hint="Unmarks as deleted">
	<cfargument name="nodek" type="struct" required="true">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="byuserid" type="string" required="true">
	

	
	
	<cfquery>
		UPDATE	dbo.Node
		SET	CommentMode = 'Closed',
			DeleteDate = NULL,
			Modified = dbo.udf_4jSuccess('Node was reactivated',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">) 
		WHERE	NodeID 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
		AND		Kind 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
		AND		Deleted = 1
	</cfquery>

	<cfreturn this.stResults>
</cffunction> 
 	
 
<cffunction name="Delete" returnType="struct" output="false" access="remote" hint="marks as deleted">
	<cfargument name="nodek" type="struct" required="true">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="byuserid" type="string" required="true">
	
	
	
	<cfquery>
		UPDATE	dbo.Node
		SET	DeleteDate = getDate(),
			Modified = dbo.udf_4jSuccess('Node was deleted',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">) 
		WHERE	NodeID 	IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#" list="Yes">)
		AND		Kind 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
		AND		Deleted = 0
	</cfquery>

	<cfreturn this.stResults>
</cffunction>  

 	
 	 


<cffunction name="XMLSave" returnType="struct" output="no" access="remote">
	<cfargument name="NodeK" type="struct" required="true">
	<cfargument name="rc" type="struct" required="true">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	<cfquery>
	UPDATE	dbo.Node
	SET		xmlData = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rc.xmlData#">,
			Modified = dbo.udf_4jInfo('xmlData was updated',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
	WHERE	NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
	AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
	AND		Deleted = 0
	AND		xmlData <> <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rc.xmlData#">
	</cfquery>

	<cfscript>
	this.stResults.message="<b>Success:</b> XML Data was successfully set. Length: #Len(rc.xmlData)# bytes";
	

	return this.stResults;
	</cfscript>

</cffunction>



<cffunction name="commit" returnType="struct" output="no" access="remote">
	<cfargument name="NodeK" type="struct" required="true">
	<cfargument name="rc" type="struct" required="true">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byuserID" required="true" type="string">
	


	<cfscript>
	param rc.submit = "";
	
	param arguments.NodeK.NodeID = "";
	param arguments.NodeK.Kind = "";
	
	if (arguments.NodeK.Kind == "")	{
		
		this.stResult.result = false;
		this.stResult.message = "Kind is a required field";
		
		return this.stResults;
		}
	
	
	this.stResults.NodeID		= arguments.NodeK.NodeID;
	
	
	// rc stuff
	param rc.Message			= "";
		
	param rc.slug				= "";
	param rc.title				= "No Title";	 // maybe I will get one later
	param rc.strData			= "";
	param rc.xmlData			= "";
	
	param rc.commentMode		= "No one";		// must have approved + complete to actually publish 
	
	param rc.pinned				= 0;
	param rc.pStatus			= "Approved";	// must have approved + complete to actually publish 
	param rc.submit				= ""; 
	
	param rc.menu				= "";
	param rc.menuorder			= "";
	param rc.menustatus			= "";
	param rc.tags				= "";
	param rc.facet				= "";
		
	
	param rc.StartDate			= "";	 
	param rc.ExpirationDate		= "";	
	
	rc.cstatus = (rc.submit CONTAINS "draft") ? 0 : 1;
	


		
	var xmlTitle = '';
	if (isDefined("rc.Extra"))		{ xmlTitle &= "<extra>#xmlFormat(rc.Extra)#</extra>"; 	}
	if (isDefined("rc.Title"))		{ xmlTitle &= "<title>#xmlFormat(rc.Title)#</title>"; 	}
	if (isDefined("rc.SubTitle"))	{ xmlTitle &= "<subtitle>#xmlFormat(rc.subTitle)#</subtitle>"; 	}
	if (isDefined("rc.Description")){ xmlTitle &= "<description>#xmlFormat(rc.Description)#</description>"; 	}
	if (isDefined("rc.ISBN"))		{ xmlTitle &= "<isbn>#xmlFormat(rc.ISBN)#</isbn>"; 	}
	</cfscript>
	
	
	
		
	<!--- first item never gets deleted --->
	<cfquery name="qryTest">
	SELECT 	COUNT(NodeID) AS NodeCount
	FROM 	dbo.Node
	</cfquery>
	
	<cfif qryTest.NodeCount EQ 0>
		<cfquery name="qryNewRoot">
		INSERT
		INTO dbo.Node(Kind, PrimaryRecord, pStatus, Created)
		VALUES ('Root', 1, 'Active',
			
			dbo.udf_4jInfo('Created',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
		 		)
		</cfquery>
	
	</cfif>
	
	<cfquery name="qryPrimaryRecord">
	SELECT 	MIN(NodeID) AS NodeID
	FROM 	dbo.Node
	WHERE	PrimaryRecord = 1
	</cfquery>
	
	<cfparam name="rc.ParentNodeID" default="#qryPrimaryRecord.NodeID#">
	
	
	<cfif rc.ParentNodeID EQ "top">
		<cfset rc.ParentNodeID = qryPrimaryRecord.NodeID>
	</cfif>

	
	
	
	
	<!---: PrimaryRecord means the is the base of the tree --->
	<!---: The root is the default page that is shown --->
	<!---: The nodelete applies to any page that cannot be deleted --->
	 
	 
	
	
	<cfif rc.submit CONTAINS "clone" OR arguments.NodeK.NodeID EQ "">
	
		<cfset Slug = qryTest.Nodecount EQ 0 ?  'index' : this.doSlug(rc.Title)>
	
	
		<cfquery name="qryNewNode">
		INSERT
		INTO dbo.Node(Kind, Root, NoDelete, Slug, pStatus, Created)
		OUTPUT Inserted.NodeID
		VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodeK.Kind#">,
			
			<cfqueryparam CFSQLType="CF_SQL_BIT" value="#IIF(qryTest.Nodecount EQ 0, 1, 0)#">,
			<cfqueryparam CFSQLType="CF_SQL_BIT" value="#IIF(qryTest.Nodecount EQ 0, 1, 0)#">,
			
			
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Slug#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.pStatus#">,
			
			dbo.udf_4jInfo('Created',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
		 		)
		</cfquery>
	
		<cfset this.stResults.NodeID = qryNewNode.NodeID>
		<cfset arguments.NodeK.NodeID = qryNewNode.NodeID>
	</cfif>
	
	
	
	
	<cftry>
	<cfquery>
	
	UPDATE	dbo.Node
	SET		ParentNodeID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.parentnodeid#">,
						
			xmlTitle 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#xmlTitle#">,
			strData 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.strData#"  null="#yesnoformat(rc.strData EQ "")#">,
			xmlData		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.xmlData#" null="#yesnoformat(rc.xmlData EQ "")#">,
			
			CommentMode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.commentMode#">,
			Pinned 		= <cfqueryparam CFSQLType="CF_SQL_bit" 		value="#rc.pinned#">,
			cStatus		= <cfqueryparam CFSQLType="CF_SQL_bit" 		value="#rc.cStatus#">,
			pStatus		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.pStatus#">,
			
			startDate 	= <cfqueryparam CFSQLType="CF_SQL_date" 	value="#rc.startDate#" 		null="#yesnoformat(isDate(rc.startDate) AND startDate NEQ "")#">,
			expirationDate 	= <cfqueryparam CFSQLType="CF_SQL_date" value="#rc.expirationDate#" null="#yesnoformat(isDate(rc.expirationDate) AND expirationDate NEQ "")#">,
			
		
			Modified 	= dbo.udf_4jInfo('Node was updated',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
	WHERE	NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
	AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
	AND		Deleted = 0
	</cfquery>
	
		<cfcatch>
		
		<cfset this.stResults.result = false>
		<cfset this.stResults.message = cfcatch.detail>
		
		<cfreturn this.stResults>
		</cfcatch>
	</cftry>


	
	<cfscript>
	this.TaxonomySave(arguments.NodeK, { 
		facet = rc.facet, tags = rc.tags, menu = rc.menu, menuorder = rc.menuorder, menustatus = rc.menustatus},
		arguments.Remote_addr, arguments.byUserID);
	
	this.XMLConfSave(arguments.NodeK, rc, arguments.Remote_addr, arguments.byUserID);

	
	this.stResults.message="<b>Success:</b> XML Data was successfully set. Length: #Len(rc.xmlData)# bytes";
	

	return this.stResults;
	</cfscript>

</cffunction>




<cffunction name="TaxonomyAdd" output="false" returnType="void" access="remote">
	<cfargument name="Extra" required="true" type="struct">
	<cfargument name="Title" required="true" type="struct">
	<cfargument name="Remote_addr" required="true">
	<cfargument name="byUserID" required="true" type="numeric">
	
	
	<cfscript>
	var xmlTitle = "";
	if (arguments.Title != "")		{ xmlTitle &= "<title>#xmlFormat(arguments.Title)#</title>"; 	}
	if (arguments.Extra != "")		{ xmlTitle &= "<extra>#xmlFormat(arguments.Extra)#</extra>"; 	}
	</cfscript>
	
	<cfquery>
	INSERT
	INTO dbo.Node (Kind, xmlTitle, Modified,Created)
	VALUES ('Facet', <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#xmlTitle#">,
		dbo.udf_4jInfo('Created',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.UserID#">),
		
		dbo.udf_4jInfo('Created',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.UserID#">)
		)
	</cfquery>
	
	
	
</cffunction>




<cffunction name="xmlConfSave" returnType="struct" output="no" access="remote">
	<cfargument name="NodeK" type="struct" required="true">
	<cfargument name="rc" type="struct" required="true">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	



<cfscript>
	var xmlConf = "";

	
		
	// Data
	if (structkeyExists(rc, "showHeader") OR structkeyExists(rc, "startRow") OR structkeyExists(rc, "startCol"))	{
		xmlConf &= "<data";
		if (structkeyExists(rc, "showHeader")) 	{ xmlConf &= " showHeader=#xmlFormat(rc.showHeader)#"; }
		if (structkeyExists(rc, "startRow")) 	{ xmlConf &= " showHeader=#xmlFormat(rc.startRow)#"; }
		if (structkeyExists(rc, "startCol")) 	{ xmlConf &= " showHeader=#xmlFormat(rc.startCol)#"; }
				
		xmlData &= " />";
		}

	
	param rc.youtube 		= "";
	param rc.notes 			= "";
	param rc.src 			= "";
	param rc.map 			= "";
	param rc.location		= "";
	param rc.plugin_content = "";
	param rc.theme_template	= "";
	param rc.href 			= "";
	
		

	if (rc.youtube 	!= "")		{ xmlConf &= "<youtube>#xmlformat(rc.youtube)#</youtube>"; }
	if (rc.notes 	!= "")		{ xmlConf &= "<notes>#xmlformat(rc.notes)#</notes>"; }
	if (rc.src 		!= "")		{ xmlConf &= "<src>#xmlformat(rc.src)#</src>";	}
	if (rc.map 		!= "")		{ xmlConf &= "<map>#xmlformat(rc.map)#</map>";	}
	if (rc.location 		!= "")		{ xmlConf &= "<location>#xmlformat(rc.location)#</location>";	}
	if (rc.theme_template	!= "")		{ xmlConf &= "<theme_template>#xmlformat(rc.theme_template)#</theme_template>";	}
	if (rc.href 	!= "")		{ xmlConf &= "<href>#xmlformat(rc.href)#</href>"; }
	
	
		
			
	if (rc.plugin_content != "")	{
		xmlConf &= "<plugin_content>#xmlformat(rc.plugin_content)#";
		
		for (var i = 1; i <= 10; i++)	{
			if (isDefined("rc.config#i#"))	{
				xmlConf &= '<config position="#i#">#xmlformat(evaluate('rc.config#i#'))#</config>';
				}
			}
		xmlConf &= "</plugin_content>";
		}


	// Anything simple
	var i = 0;
		
	for (MyFormField in rc)	{
		
		
		
		if (MyFormField CONTAINS "simple")	{
			i++;
			
			
			if (evaluate("rc.#MyFormField#") != "" and i < 100)	{
			
				type = listlast(MyFormField, '_');
						
				xmlConf &= '<simple type="#lcase(type)#">' & xmlFormat(evaluate("rc.#MyFormField#")) & '</simple>';
				}
			}
		}	
	</cfscript>
	
		
	<cfquery>
		UPDATE	dbo.Node
		SET	xmlConf = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#xmlConf#">,
			
			Modified = dbo.udf_4jSuccess('XML Conf updated',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">) 
		WHERE	NodeID 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
		AND		Kind 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
		AND		Deleted = 0
	</cfquery>
	
		
	<cfreturn this.stResults>
</cffunction>


<!--- Link actions --->
<cffunction name="LinkAdd" output="false" returntype="struct">
	<cfargument name="NodeK" required="true" type="struct">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="UserID" required="true" type="numeric">
	
	<cfscript>
	param rc.linkcategory = '';
	
	if (rc.linkcategory == '')	{
		this.stResults.message &= "Link Category was blank or missing";	
		}
		
	if (this.LinkExists(NodeID, rc))	{
		this.stResults.result = false;
		this.stResults.message = "Link was not added because it already exists.";
		return this.stResults;
		}
		
	</cfscript>
	
	
	
	<cfquery>
		UPDATE	dbo.Node
		SET		xmlLink.modify('
			insert <link 
				category= "#xmlformat(rc.linkcategory)#" 
				href	= "#xmlformat(trim(rc.href))#"
				<cfif isDefined("rc.tooltip")>
					tooltip	= "#xmlformat(trim(rc.tooltip))#"
				</cfif> 
				
				<cfif isDefined("rc.sortorder")>
					sortorder = "#xmlformat(trim(rc.sortorder))#"
				</cfif>
				
				>#xmlformat(trim(rc.value))#</link>
			as last into (/)
			')
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.nodeid#">)
		AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
	</cfquery>

	<cfset this.stResults.message &= "Link to: #htmleditformat(trim(rc.value))# has been saved.">

	
	<cfreturn this.stResults>
</cffunction>




<cffunction name="LinkSave" output="false" returntype="struct" access="remote">
	<cfargument name="NodeK" required="true" type="struct">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="UserID" required="true" type="numeric">
	
	
	<cfquery>
	UPDATE	dbo.Node
	SET		xmlLink = ''
		Modified = dbo.udf_4jInfo('Link has been updated',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.rc.userID#">)
			
	WHERE	Deleted = 0
	AND		NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.nodeid#">
	</cfquery>
	
	
	<cfscript>
	this.touch = 0;
	
	for (var i = 1; isDefined("rc.linkcategory_#i#"); i++)	{
		attr = {
			linkcategory = evaluate("rc.linkcategory_#i#"), 
			href 		= evaluate("rc.href_#i#"), 
			value 		= evaluate("rc.value_#i#"),
			tooltip 	= isDefined("rc.tooltip_#i#") ? evaluate("rc.tooltip_#i#") : '',
			sortorder 	= evaluate("rc.sortorder_#i#")
			};

		if (not isDefined("rc.delete_#i#"))	{
		
			stResults = this.LinkAdd(arguments.NodeID, attr, arguments.UserID);	
		
			this.stResults.message &= stResults.message & evaluate("rc.sortorder_#i#");
			}
	
		}
	</cfscript>
	
	
	
	<cfreturn this.stResults>
</cffunction>




<!--- menu, tags, facets --->
<cffunction name="TaxonomySave" returnType="boolean" access="remote" outut="false">
	<cfargument name="NodeK" required="true" type="struct">
	<cfargument name="rc" type="struct" required="true" hint="This is a list">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="UserID" required="true" type="numeric">


	<cfscript>
	param arguments.rc.menu 		= 'skip';	// title of menu, if blank then no override
	param arguments.rc.menuorder 	= '';
	param arguments.rc.menustatus 	= '';
			
	
	param arguments.rc.facet 		= ""; //list
	param arguments.rc.tags 		= ""; // we still want to delete if blank
	</cfscript>
	
	
	<cfif arguments.rc.tags EQ "skip" AND arguments.rc.facet EQ "skip" AND arguments.rc.menu EQ "skip">
		<!--- Menu update only, hack --->
		
	
		<cfquery>
		DECLARE @sort 	integer	
		SET 	@sort 	= <cfqueryparam CFSQLType="CF_SQL_varchar" 	value="#arguments.rc.menuorder#">			
	
	
		UPDATE 	dbo.Node
		SET 	xmlTaxonomy.modify('
			replace value of (/menu/@sortorder)[1]
			with sql:variable("@sort")
			')
		WHERE 	NodeID = <cfqueryparam CFSQLType="CF_SQL_varchar" 	value="#arguments.NodeK.NodeID#">
		AND		Deleted = 0
	
		</cfquery>
	


		<cfreturn true>
	</cfif> 
	
	
	
	
	
	<cfsavecontent variable="strXML">
		<cfoutput>
		
		<menu status 	= "#xmlFormat(arguments.rc.menustatus)#" 
			sortorder 	= "#xmlFormat(arguments.rc.menuorder)#">#xmlFormat(arguments.rc.menu)#</menu>
		
	
		<cfloop index="i" list="#rc.facet#">
			<facet type="#listfirst(i, ':')#">#listlast(i, ':')#</facet>
		</cfloop>
		<cfloop index="i" list="#rc.tags#">
			<tags>#xmlformat(i)#</tags>
		</cfloop>
		</cfoutput>
	</cfsavecontent>
	


	<cfquery>
		UPDATE 	dbo.Node
		SET 	xmlTaxonomy = <cfqueryparam CFSQLType="CF_SQL_varchar" 	value="#trim(strXML)#">
		WHERE 	NodeID 		= <cfqueryparam CFSQLType="CF_SQL_INTEGER" 	value="#arguments.NodeK.NodeID#">
		AND		Deleted = 0
	</cfquery>
	


	<cfreturn true>
</cffunction>


<cffunction name="deleteArchive" returnType="struct" output="no" access="remote">
	<cfargument name="NodeArchiveID" type="string" required="true">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	<cfquery name="qryDelete">
	DELETE
	FROM	dbo.NodeArchive
	OUTPUT 	deleted.NodeID
	WHERE	NodeArchiveID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeArchiveID#">
	</cfquery>

	<cfscript>
	if (not isnumeric(qryDelete.NodeID))	{
		this.stResults.result = false;
		}
	

	return this.stResults;
	</cfscript>

</cffunction>


<cffunction name="restoreArchive" returnType="struct" output="no" access="remote">
	<cfargument name="NodeArchiveID" type="string" required="true">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	<cfquery name="qryUpdate">
	UPDATE	dbo.Node
	SET	dbo.Node.parentNodeID 	= dbo.NodeArchive.parentNodeID,
		dbo.Node.slug			= dbo.NodeArchive.slug,
		dbo.Node.xmlTitle		= dbo.NodeArchive.xmlTitle,
		dbo.Node.Kind			= dbo.NodeArchive.Kind,
		dbo.Node.strData		= dbo.NodeArchive.strData,
		dbo.Node.xmlData		= dbo.NodeArchive.xmlData,
		dbo.Node.xmlConf		= dbo.NodeArchive.xmlConf,
		dbo.Node.xmlLink		= dbo.NodeArchive.xmlLink,
		dbo.Node.xmlTaxonomy	= dbo.NodeArchive.xmlTaxonomy,
		dbo.Node.xmlSecurity	= dbo.NodeArchive.xmlSecurity,
		dbo.Node.expirationDate	= dbo.NodeArchive.expirationDate,
		dbo.Node.pinned			= dbo.NodeArchive.pinned,
		dbo.Node.pStatus		= dbo.NodeArchive.pStatus,
		dbo.Node.cStatus		= dbo.NodeArchive.cStatus,
		dbo.Node.StartDate		= dbo.NodeArchive.StartDate,
		dbo.Node.CommentMode	= dbo.NodeArchive.CommentMode,
		dbo.Node.StationaryPad	= dbo.NodeArchive.StationaryPad,
		dbo.Node.SortOrder		= dbo.NodeArchive.SortOrder,
		dbo.Node.DeleteDate		= dbo.NodeArchive.DeleteDate,
		dbo.Node.Modified		= dbo.NodeArchive.Modified
			
	FROM dbo.Node
	INNER JOIN dbo.NodeArchive
	ON dbo.Node.NodeID = dbo.NodeArchive.NodeID
	
	WHERE	NodeArchiveID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeArchiveID#">
	</cfquery>

	<cfscript>
	//if (not isnumeric(qryUpdate.NodeID))	{
	//	this.stResults.result = false;
	//	}
	

	return this.stResults;
	</cfscript>

</cffunction>






</cfcomponent>
