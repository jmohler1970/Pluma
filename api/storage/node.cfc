
 	
 			
<cfcomponent extends="nodero">		

 	
<cffunction name="Reactivate" returnType="struct" output="false"  hint="Unmarks as deleted">
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
 	
 
<cffunction name="Delete" returnType="struct" output="false"  hint="marks as deleted">
	<cfargument name="nodek" type="struct" required="true">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="byuserid" type="string" required="true">
	
		
	<cfquery name="qryUpdate" >
		DECLARE @T TABLE (NodeID int)
		
		UPDATE	dbo.Node
		SET	DeleteDate = getDate(),
			Modified = dbo.udf_4jSuccess('Node was deleted',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">) 
		OUTPUT 	deleted.NodeID 
		INTO 	@T	
		WHERE	NodeID 	IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#" list="Yes">)
		AND		Kind 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
		AND		Deleted = 0
		
		SELECT 	NodeID
		FROM	@T
	</cfquery>
	
	<cfif qryUpdate.NodeID EQ "">
		<cfset this.stResults.result = false>
		<cfset this.stResults.key = "NOT_FOUND">
	<cfelse>
		<cfset this.stResults.key = "ER_HASBEEN_DEL">
	</cfif>
	

	<cfreturn this.stResults>
</cffunction>  

	 


<cffunction name="XMLSave" returnType="struct" output="no" >
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
	this.stResults.key="SETTINGS_UPDATED";
	

	return this.stResults;
	</cfscript>

</cffunction>



<cffunction name="commit" returnType="struct" output="no" >
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
		this.stResult.key = "ER_REQ_PROC_FAIL";
		
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
	param rc.allowupdate 		= 1;	
	
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
	 
	<cfset var alreadyExists = false>
	<cfscript>
		// operations based on slug
		if (rc.slug != "")	{
			var qryNode = this.getBySlug(rc.slug);
			
			if (qryNode.recordcount != 0)	{
				alreadyExists = true;
				}					
			} 
	</cfscript>
	
	
	<cfif rc.submit CONTAINS "clone" OR arguments.NodeK.NodeID EQ "" OR alreadyExists EQ false>
	

		
		<cfset rc.slug = qryTest.Nodecount EQ 0 ?  'index' : this.doSlug(rc.Title)>
		
		
	
		<cfquery name="qryNewNode">
		INSERT
		INTO dbo.Node(Kind, Root, NoDelete, Slug, strData, pStatus, Created)
		OUTPUT Inserted.NodeID
		VALUES (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodeK.Kind#">,
			
			<cfqueryparam CFSQLType="CF_SQL_BIT" 	value="#IIF(qryTest.Nodecount EQ 0, 1, 0)#">,
			<cfqueryparam CFSQLType="CF_SQL_BIT" 	value="#IIF(qryTest.Nodecount EQ 0, 1, 0)#">,
			
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.Slug#">,
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#trim(rc.strData)#"  null="#yesnoformat(rc.strData EQ "")#">,
			
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.pStatus#">,
			
			dbo.udf_4jInfo('Created',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
		 		)
		</cfquery>
	
		<cfset this.stResults.NodeID = qryNewNode.NodeID>
		<cfset arguments.NodeK.NodeID = qryNewNode.NodeID>
	</cfif>
	
	
	<cfif rc.allowupdate EQ 0>
		<cfreturn this.stResults>
	</cfif>
	
	
	<cftry>
	<cfquery>
	
	UPDATE	dbo.Node
	SET		ParentNodeID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.parentnodeid#">,
						
			xmlTitle 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#xmlTitle#">,
			strData 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#trim(rc.strData)#"  null="#yesnoformat(rc.strData EQ "")#">,
			xmlData		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.xmlData#" null="#yesnoformat(rc.xmlData EQ "")#">,
			
			CommentMode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.commentMode#">,
			Pinned 		= <cfqueryparam CFSQLType="CF_SQL_bit" 		value="#rc.pinned#">,
			cStatus		= <cfqueryparam CFSQLType="CF_SQL_bit" 		value="#rc.cStatus#">,
			pStatus		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.pStatus#">,
			
			startDate 	= <cfqueryparam CFSQLType="CF_SQL_date" 	value="#rc.startDate#" 		null="#yesnoformat(isDate(rc.startDate) AND startDate NEQ "")#">,
			expirationDate 	= <cfqueryparam CFSQLType="CF_SQL_date" value="#rc.expirationDate#" null="#yesnoformat(not isDate(rc.expirationDate) OR rc.expirationDate EQ "")#">,
			
		
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

	
	//this.stResults.key="ER_YOUR_CHANGES";
	

	return this.stResults;
	</cfscript>

</cffunction>




<cffunction name="TaxonomyAdd" output="false" returnType="boolean"  hint="Valid value list of taxonomy types">
	<cfargument name="Extra" required="true" type="string">
	<cfargument name="Title" required="true" type="string">
	<cfargument name="Remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	<cfscript>
	var xmlTitle = "";
	if (arguments.Title != "")		{ xmlTitle &= "<title>#xmlFormat(arguments.Title)#</title>"; 	}
	if (arguments.Extra != "")		{ xmlTitle &= "<extra>#xmlFormat(arguments.Extra)#</extra>"; 	}
	
	slug = this.doSlug(arguments.extra & '-' & arguments.Title); // this is to create unique ids for deleting
	</cfscript>
	
	<cfquery>
	INSERT
	INTO dbo.Node (Kind, xmlTitle, slug, Modified,Created)
	VALUES ('Facet', <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#xmlTitle#">,
		<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#slug#">,
		dbo.udf_4jInfo('Created',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">),
		
		dbo.udf_4jInfo('Created',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
		)
	</cfquery>
	
	
	<cfreturn true>
</cffunction>




<cffunction name="xmlConfSave" returnType="struct" output="no" >
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
		
	for (var MyFormField in rc)	{
		
		
		
		if (MyFormField CONTAINS "simple")	{
			i++;
			
			
			if (rc[MyFormField] != "" and i < 100)	{
			
				type = listlast(MyFormField, '_');
						
				xmlConf &= '<simple type="#lcase(type)#">' & xmlFormat(rc[MyFormField]) & '</simple>';
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
		AND		CONVERT(varchar(max), xmlConf) <> <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#xmlConf#">
	</cfquery>
	
		
	<cfreturn this.stResults>
</cffunction>


<!--- Link actions --->
<cffunction name="LinkAdd" output="false" returntype="struct">
	<cfargument name="NodeK" 		required="true" type="struct">
	<cfargument name="rc" 			required="true" type="struct">
	<cfargument name="remote_addr" 	required="true" type="string">
	<cfargument name="UserID" 		required="true" type="string">
	
	<cfscript>
	param rc.type = '';
	
	if (rc.type == '')	{
		this.stResults.key = "plumacms/blank";	
		
		return this.stResults;
		}
		
	if (this.LinkExists(arguments.NodeK.NodeID, rc))	{
		this.stResults.result = false;
		this.stResults.key = "plumacms/already_exists";
		return this.stResults;
		}
		
	</cfscript>
	
	
	
	<cfquery>
		UPDATE	dbo.Node
		SET		xmlLink.modify('
			insert <data 
				type		= "#xmlformat(rc.type)#" 
				href		= "#xmlformat(trim(rc.href))#"
				<cfif isDefined("rc.title")>
					title	= "#xmlformat(trim(rc.title))#"
				</cfif> 
				
				<cfif isDefined("rc.position")>
					position = "#xmlformat(trim(rc.position))#"
				</cfif>
				
				>#xmlformat(trim(rc.message))#</data>
			as last into (/)
			')
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.nodeid#">)
		AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
	</cfquery>

	<cfset this.stResults.key = "ER_YOUR_CHANGES">

	
	<cfreturn this.stResults>
</cffunction>




<cffunction name="LinkSave" output="false" returntype="struct" >
	<cfargument name="NodeK" required="true" type="struct">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	
	<cfquery name="qryClearLink">
	UPDATE	dbo.Node
	SET		xmlLink = '',
		Modified = dbo.udf_4jInfo('Link has been updated',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
			
	WHERE	Deleted = 0
	AND		NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.nodeid#">
	AND		CONVERT(varchar(max), xmlLink) <> ''
	</cfquery>
	
	
	<cfscript>
	for (var i = 1; isDefined("rc.type_#i#") and evaluate("rc.type_#i#") != ""; i++)	{
		attr = {
			type 		= evaluate("rc.type_#i#"), 
			href 		= isDefined("rc.href_#i#") 		? evaluate("rc.href_#i#") 		: '', 
			message 	= isDefined("rc.message_#i#") 	? evaluate("rc.message_#i#") 	: '',
			title 		= isDefined("rc.title_#i#") 	? evaluate("rc.title_#i#") 		: '',
			position	= isDefined("rc.position_#i#")	? evaluate("rc.position_#i#") 	: ''
			};

		if (not isDefined("rc.delete_#i#"))	{
		
			this.stResults = this.LinkAdd(arguments.NodeK, attr, arguments.remote_addr, arguments.byUserID);	
		
			}
	
		}
	</cfscript>
	
	
	
	
	<cfreturn this.stResults>
</cffunction>




<!--- menu, tags, facets --->
<cffunction name="TaxonomySave" returnType="boolean"  outut="false">
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


<cffunction name="deleteArchive" returnType="struct" output="no" >
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

<cffunction name="deleteArchiveByDate" returnType="struct" output="no" >
	<cfargument name="ClearDate" type="date" required="true">
	<cfargument name="NodeID" type="string" default="">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	<cfquery name="qryDelete">
	DELETE
	FROM	dbo.NodeArchive
	OUTPUT 	deleted.NodeID
	WHERE	CONVERT(date, versionDate) = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#clearDate#">
	<cfif isnumeric(arguments.NodeID)>
		AND		NodeID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.NodeID#">
	</cfif>
	
	</cfquery>

	<cfscript>
	if (qryDelete.recordcount == 0)	{
		this.stResults.result = false;
		}
	

	return this.stResults;
	</cfscript>

</cffunction>





<cffunction name="restoreArchive" returnType="struct" output="no" >
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


<cffunction returnType="void" name="addLog" output="no">
	<cfargument name="Kind" required="true" type="string">
	<cfargument name="Message" required="true" type="string">
	<cfargument name="Remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">

	<cfquery>
		INSERT
		INTO	dbo.DataLog (Kind, Created)
		VALUES (
			
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">,
						
			dbo.udf_4jInfo(
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.message#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">) 	
			)
	</cfquery>
</cffunction> 


<cffunction returnType="boolean" name="clearLog" output="no">
	<cfargument name="Kind" required="true" type="string">


	<cfquery name="qryDeleted">
		DELETE
		FROM	dbo.DataLog
		OUTPUT deleted.DataLogID
		WHERE	Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
	</cfquery>
	
	<cfif qryDeleted.recordcount EQ 0>
		<cfreturn false>
	</cfif>	

	<cfreturn true>
</cffunction>


</cfcomponent>


