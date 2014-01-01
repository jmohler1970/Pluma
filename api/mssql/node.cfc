
 			
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
	
	<cfif not isnumeric(arguments.NodeK.NodeID)>
		<cfset this.stResults.result = false>
		<cfset this.stResults.key = "NOT_FOUND">
	
		<cfreturn this.stResults>
	</cfif>
	
	
	<cfquery>
	UPDATE	dbo.Node
	SET		xmlData = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rc.xmlData#">,
			Modified = dbo.udf_4jInfo('xmlData was updated',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
	WHERE	NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
	AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
	AND		Deleted = 0
	AND		CONVERT(nvarchar(max), xmlData) <> <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rc.xmlData#">
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
	</cfscript>

	<cfsavecontent variable="xmlTitle">
	<ul class="xoxo">
	<cfoutput>	
		<cfif isDefined("rc.Extra")		 ><li><b>Extra</b>			<var>#xmlFormat(rc.Extra)#</var></li>		</cfif>
		<cfif isDefined("rc.Title")		 ><li><b>Title</b>	 		<var>#xmlFormat(rc.Title)#</var></li>		</cfif>
		<cfif isDefined("rc.SubTitle")	 ><li><b>Subtitle></b> 		<var>#xmlFormat(rc.subTitle)#</var></li>	</cfif>
		<cfif isDefined("rc.Description")><li><b>Description></b> 	<var>#xmlFormat(rc.Description)#</var></li>	</cfif>
		<cfif isDefined("rc.ISBN")		 ><li><b>ISBN</b> 			<var>#xmlFormat(rc.ISBN)#</var></li>		</cfif>
	</cfoutput>
	</ul>
	</cfsavecontent>
	
	
		
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
	<cfquery name="qryUpdate"
	>
	DECLARE	@parentNodeID int 		= <cfqueryparam cfsqltype="CF_SQL_VARCHAR"	value="#rc.parentnodeid#">,
		@xmlTitle	varchar(max)	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#xmlTitle#">,
		@strData 	varchar(max) 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#trim(rc.strData)#"  null="#yesnoformat(rc.strData EQ "")#">,
		@xmlData	varchar(max)	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.xmlData#">,
		@CommentMode varchar(50) 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#rc.commentMode#">,
		@pinned bit				= <cfqueryparam CFSQLType="CF_SQL_bit" 		value="#rc.pinned#">,
		@cStatus bit			= <cfqueryparam CFSQLType="CF_SQL_bit" 		value="#rc.cStatus#">,
		@pStatus varchar(50)	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.pStatus#">,
		@startDate date			= <cfqueryparam CFSQLType="CF_SQL_date" 	value="#rc.startDate#" 		null="#yesnoformat(isDate(rc.startDate) AND startDate NEQ "")#">,
		@expirationDate date	= <cfqueryparam CFSQLType="CF_SQL_date" value="#rc.expirationDate#" null="#yesnoformat(not isDate(rc.expirationDate) OR rc.expirationDate EQ "")#">
		
	
	
	UPDATE	dbo.Node
	SET		ParentNodeID = @ParentNodeID,
						
			xmlTitle 	= @xmlTitle,
			strData 	= @strData,
			xmlData		= @xmlData,
			
			CommentMode = @CommentMode,
			Pinned 		= @pinned,
			cStatus		= @cStatus,
			pStatus		= @pStatus,
			
			startDate 	= @startDate,
			expirationDate 	= @expirationDate,
			
		
			Modified 	= dbo.udf_4jInfo('Node was updated',
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">,
		 		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
			 		
	WHERE	NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
	AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
	AND		Deleted = 0
	AND		(
			ParentNodeID <> @ParentNodeID
			OR
			CONVERT(varchar(max), xmlTitle) 	<> @xmlTitle
			OR
			strData 	<> @strData
			OR
			CONVERT(varchar(max), xmlData) 		<> @xmlData
			OR
			CommentMode <> @CommentMode
			OR
			Pinned <> @pinned
			OR
			cStatus <> @cStatus
			OR
			pStatus <> @pStatus
			OR
			startDate <> @startDate
			OR
			expirationDate <> @expirationDate
			)
	</cfquery>
	
		<cfcatch>
		
		<cfset this.stResults.key = "PLUMACMS/FAILURE">
		
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
	
	
	<cfsavecontent variable="xmlTitle">
	<ul class="xoxo">
	<cfoutput>	
		<cfif isDefined("rc.Extra")><li><b>Extra</b>	<var>#xmlFormat(rc.Extra)#</var></li>	</cfif>
		<cfif isDefined("rc.Title")><li><b>Title</b> 	<var>#xmlFormat(rc.Title)#</var></li>	</cfif>
	</cfoutput>
	</ul>
	</cfsavecontent>
	
		
	<cfset slug = this.doSlug(arguments.extra & '-' & arguments.Title)> // this is to create unique ids for deleting
	
	
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
	<cfargument name="Conf" type="struct" required="true">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	



<cfscript>
	var xmlConf = "";

	
		
	// Data
	if (structkeyExists(Conf, "showHeader") OR structkeyExists(Conf, "startRow") OR structkeyExists(Conf, "startCol"))	{
		xmlConf &= "<data";
		if (structkeyExists(Conf, "showHeader")) 	{ xmlConf &= " showHeader=#xmlFormat(Conf.showHeader)#"; }
		if (structkeyExists(Conf, "startRow")) 		{ xmlConf &= " showHeader=#xmlFormat(Conf.startRow)#"; }
		if (structkeyExists(Conf, "startCol")) 		{ xmlConf &= " showHeader=#xmlFormat(Conf.startCol)#"; }
				
		xmlData &= " />";
		}

	
	param Conf.youtube 		= "";
	param Conf.notes 			= "";
	param Conf.src 			= "";
	param Conf.map 			= "";
	param Conf.location		= "";
	param Conf.plugin_content = "";
	param Conf.theme_template	= "";
	param Conf.href 			= "";
	
		

	if (Conf.youtube 		!= "")		{ xmlConf &= "<youtube>#xmlformat(Conf.youtube)#</youtube>"; }
	if (Conf.notes 			!= "")		{ xmlConf &= "<notes>#xmlformat(Conf.notes)#</notes>"; }
	if (Conf.src 			!= "")		{ xmlConf &= "<src>#xmlformat(Conf.src)#</src>";	}
	if (Conf.map 			!= "")		{ xmlConf &= "<map>#xmlformat(Conf.map)#</map>";	}
	if (Conf.location 		!= "")		{ xmlConf &= "<location>#xmlformat(Conf.location)#</location>";	}
	if (Conf.theme_template	!= "")		{ xmlConf &= "<theme_template>#xmlformat(Conf.theme_template)#</theme_template>";	}
	if (Conf.href 			!= "")		{ xmlConf &= "<href>#xmlformat(Conf.href)#</href>"; }
	
	
		
			
	if (Conf.plugin_content != "")	{
		xmlConf &= "<plugin_content>#xmlformat(Conf.plugin_content)#";
		
		for (var i = 1; i <= 10; i++)	{
			if (isDefined("Conf.config#i#"))	{
				xmlConf &= '<config position="#i#">#xmlformat(evaluate('Conf.config#i#'))#</config>';
				}
			}
		xmlConf &= "</plugin_content>";
		}


	// Anything simple
	var i = 0;
		
	for (var MyFormField in Conf)	{
		
		
		
		if (MyFormField CONTAINS "simple")	{
			i++;
			
			
			if (Conf[MyFormField] != "" and i < 100)	{
			
				type = listlast(MyFormField, '_');
						
				xmlConf &= '<simple type="#lcase(type)#">' & xmlFormat(Conf[MyFormField]) & '</simple>';
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




<cffunction name="LinkSave" output="false" returntype="struct" hint="similar to User.linksave">
	<cfargument name="NodeK" required="true" type="struct">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="remote_addr" required="true" type="string">
	<cfargument name="byUserID" required="true" type="string">
	
	
	
	
	<cfquery name="qryClearLink">
	DECLARE @xmlLink varchar(max) = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#this.encodeXML(rc, 'href')#">
	
	
	UPDATE	dbo.Node
	SET		xmlLink = @xmlLink,
		Modified = dbo.udf_4jInfo('Link has been updated',
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.remote_addr#">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">)
			
	WHERE	Deleted = 0
	AND		NodeID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.nodeid#">
	AND		CONVERT(varchar(max), xmlLink) <> @xmlLink
	</cfquery>
	
	
	
	
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
	
	
	
	<li><b>Tag</b> <var>Dogs</var></li>
	<li data-position="4" data-status="whatever"><b>Menu</b> <var>Animals</var></li>
	
	<cfsavecontent variable="strXML">
		<ul class="xoxo">
		<cfoutput>
			<li data-position	="#xmlFormat(arguments.rc.menuorder)#" 
				data-status		="#xmlFormat(arguments.rc.menustatus)#">
				
				<b>Menu</b> <var>#xmlFormat(arguments.rc.menu)#</var>
			</li>
			
		
	
		<cfloop index="i" list="#rc.facet#">
			<li><b>Facet</b> <cite>#listfirst(i, ':')#</cite> <var>#listlast(i, ':')#</var></li>
		</cfloop>
		<cfloop index="i" list="#rc.tags#">
			<li><b>Tag</b> <var>#xmlformat(i)#</var></li>
		</cfloop>
		</cfoutput>
		</ul>
	</cfsavecontent>
	


	<cfquery>
		UPDATE 	dbo.Node
		SET 	xmlTaxonomy = <cfqueryparam CFSQLType="CF_SQL_varchar" 	value="#trim(strXML)#">
		WHERE 	NodeID 		= <cfqueryparam CFSQLType="CF_SQL_INTEGER" 	value="#arguments.NodeK.NodeID#">
		AND		Deleted = 0
		AND		CONVERT(varchar(max), xmlTaxonomy) <>  <cfqueryparam CFSQLType="CF_SQL_varchar" 	value="#trim(strXML)#">
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


