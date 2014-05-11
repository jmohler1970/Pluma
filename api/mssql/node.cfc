<!---@ Description: Performs all C_UD operations --->
 			
<cfcomponent extends="nodero">		

 	
<cffunction name="Reactivate" returnType="struct" output="false"  hint="Unmarks as deleted">
	<cfargument name="nodek" type="struct" required="true">
	<cfargument name="byuserid" type="string" required="true">
		
	
	<cfquery>
		UPDATE	dbo.Node
		SET	DeleteDate = NULL,
			ModifyBy = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">,
			ModifyDate = getDate() 
		WHERE	NodeID 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">
		AND		Kind 	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">
		AND		Deleted = 1
	</cfquery>

	<cfreturn this.stResults>
</cffunction> 
 	
 
<cffunction name="Delete" returnType="struct" output="false"  hint="marks as deleted">
	<cfargument name="nodek" type="struct" required="true">
	<cfargument name="byuserid" type="string" required="true">
	
		
	<cfquery name="qryUpdate" >
		DECLARE @T TABLE (NodeID int)
		
		UPDATE	dbo.Node
		SET	DeleteDate = getDate(),
			ModifyBy = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">,
			ModifyDate = getDate() 
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




<cffunction name="commit" returnType="struct" output="no" >
	<cfargument name="NodeK" type="struct" required="true">
	<cfargument name="rc" type="struct" required="true">
	<cfargument name="byuserID" required="true" type="string">
	


	<cfscript>


	param arguments.NodeK.NodeID = "";
	param arguments.NodeK.Kind = "";
	
	if (arguments.NodeK.Kind == "")	{
		
		this.stResult.result = false;
		this.stResult.key = "ER_REQ_PROC_FAIL";
		
		return this.stResults;
		}
		
	param rc.submit = "";	
	if (rc.submit == "Clone")	{
		rc.title = "Copy of " & rc.title;	
		}	
	

	
	this.stResults.NodeID		= arguments.NodeK.NodeID;
	
	param name="rc.deleted"		default = "0";
	
	param name="rc.slug_url"	default	= ""; 
	
	
	param name="rc.title"		default	= "No Title";	 // maybe I will get one later
	param name="rc.gsData"		default	= "";
	
	param name="rc.arLink"		default = "#ArrayNew(1)#";
	
	local.arLink = [];
	for(local.Link in rc.arLink)	{
		if (local.Link.href != "")	{
			ArrayAppend(local.arLink, local.Link);				
			}		
		}
	
	local.xoxoLink = this.encodeXML(local.arLink);
	
	
	param name="rc.xoxoConf"	default	= "";
	
	
	param name="rc.meta"		default	= "";
	param name="rc.metad"		default	= "";
	param name="rc.menu"		default	= "";
	param name="rc.menuorder"	default	= "";
	param name="rc.menustatus"	default	= "";
	param name="rc.template"	default	= "";
	param name="rc.parent"		default	= "";
	param name="rc.private"		default	= "N";
	param name="rc.content"		default	= "";
		
	
	param name="rc.author"		default	= "#byUserID#";

	
	</cfscript>



	
	<cfquery name="local.qryNode">
	DECLARE @slug  nvarchar(40) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#xmlformat(rc.slug_url)#" null="#IIF(rc.slug_url EQ "", 1, 0)#">
	DECLARE @title nvarchar(40) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#xmlformat(rc.title)#">

	
	DECLARE @NodeCount int = (
		SELECT 	COUNT(NodeID) AS NodeCount
		FROM 	dbo.Node
		WHERE	Deleted = 0
		)	

	
	DECLARE @gsData xml = dbo.udf_GSwrite(
			getDate(),
			@title,
			CASE 
				WHEN @NodeCount = 0 THEN 'index' 
				WHEN @slug IS NULL THEN dbo.udf_slugify(@title)
				ELSE @slug
			END,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#xmlformat(rc.meta)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#xmlformat(rc.metad)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.menu#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.menuOrder#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.menuStatus#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.template#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.parent#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.content#">,
			<cfqueryparam cfsqltype="CF_SQL_bit" 	 value="#IIF(rc.private EQ 'Y', 1, 0)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.author#">
			)
	


	
	DECLARE @tblSource TABLE (
	
		NodeID		int,
		Kind		nvarchar(40),
		
		gsData		xml,
		xoxoLink	xml,
		xoxoConf	xml,

		ModifyBy	varchar(50),
		Deleted		bit
		)
		
	DECLARE @tblResult TABLE	(
		action varchar(20),
		nodeId int
		)	
		
		
	INSERT INTO @tblSource (NodeID, Kind, gsData, xoxoLink, xoxoConf, ModifyBy, Deleted)
	SELECT <cfqueryparam value="#arguments.NodeK.nodeid#" CFSQLType="CF_SQL_INTEGER" 
		null="#IIF(arguments.NodeK.nodeid EQ '' or rc.submit EQ 'Clone', 1, 0)#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeK.Kind#">,
		@gsData,
		<cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#local.xoxoLink#">,	
		<cfqueryparam CFSQLType="CF_SQL_VARCHAR" 	value="#rc.xoxoConf#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.byUserID#">,
		<cfqueryparam cfsqltype="CF_SQL_bit" 	 value="#rc.deleted#">
		
			
	MERGE dbo.Node AS target
	USING (
		SELECT NodeID, Kind, gsData, xoxoLink, xoxoConf, ModifyBy, deleted
		FROM @tblSource
		) AS source(NodeID, Kind, gsData, xoxoLink, xoxoConf, ModifyBy, deleted)
	ON target.NodeID = Source.NodeID
	
	
	WHEN MATCHED THEN
		
		UPDATE
		SET		target.gsData = source.gsData,
				target.xoxoLink = source.xoxoLink,
				target.xoxoConf = source.xoxoConf,
				target.modifyBy = source.modifyBy,
				target.modifyDate = getDate(),
				target.deleteDate = CASE WHEN source.deleted = 1 THEN getDate() ELSE target.deleteDate END
	
	WHEN NOT MATCHED THEN
	
		INSERT (Kind, gsData, xoxoLink, xoxoConf, ModifyBy, CreateBy)
		VALUES (Source.Kind, Source.gsData, Source.xoxoLink, Source.xoxoConf,
			Source.ModifyBy, Source.ModifyBy)
			
	OUTPUT $action, Inserted.NodeID
	INTO @tblResult
	;		
	
	
	SELECT Action, NodeID
	FROM @tblResult
	</cfquery>
	
	<cfset this.stResults.NodeID = local.qryNode.NodeID>
	
	<cfreturn this.stResults>
</cffunction>



<cffunction name="deleteArchive" returnType="struct" output="no" >
	<cfargument name="NodeArchiveID" type="string" required="true">
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
	<cfargument name="byUserID" required="true" type="string">
	
	
	<cfquery name="qryUpdate">
	UPDATE	dbo.Node
	SET	dbo.Node.gsData			= dbo.NodeArchive.gsData,
		dbo.Node.xoxoConf		= dbo.NodeArchive.xoxoConf,
		dbo.Node.xoxoLink		= dbo.NodeArchive.xmlLink,
		dbo.Node.DeleteDate		= dbo.NodeArchive.DeleteDate,
		dbo.Node.ModifyBy		= dbo.NodeArchive.ModifyBy,
		dbo.Node.ModifyDate		= dbo.NodeArchive.ModifyDate
		
			
	FROM dbo.Node
	INNER JOIN dbo.NodeArchive
	ON dbo.Node.NodeID = dbo.NodeArchive.NodeID
	
	WHERE	NodeArchiveID = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.NodeArchiveID#">
	</cfquery>


	<cfreturn this.stResults>
</cffunction>


<cffunction returnType="void" name="addLog" output="no">
	<cfargument name="Kind" required="true" type="string">
	<cfargument name="Message" required="true" type="string">
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



<!--- menu, tags, facets --->
<cffunction name="TaxonomySave" returnType="boolean" outut="false">
	<cfargument name="NodeK" required="true" type="struct">
	<cfargument name="rc" type="struct" required="true">
	<cfargument name="UserID" required="true" type="numeric">



	<cfquery>
		DECLARE @sort integer = <cfqueryparam CFSQLType="CF_SQL_varchar" value="#arguments.rc.menuorder#">	


		UPDATE dbo.Node
		SET gsData.modify('
			replace value of (/item/menuOrder/text())[1]
			with sql:variable("@sort")
			')
			WHERE NodeID = <cfqueryparam CFSQLType="CF_SQL_varchar" value="#arguments.NodeK.NodeID#">
			AND Deleted = 0
	</cfquery>

	<cfreturn true>
</cffunction>




</cfcomponent>


