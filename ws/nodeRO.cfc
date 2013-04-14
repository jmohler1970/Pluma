



<cfcomponent>
<cfscript>


	this.stResults = {result = true, resultCode = 0, Message = ''};
	this.touch = 0;

	variables.QueryService = new query();
	variables.QueryService.setName("qryResult");
	

	
	variables.lstNode = "NodeID,ParentNodeID,Root,Kind
      ,extra,Slug,title,subtitle,description,isbn
      ,strData,xmlData,pinned,pStatus,cStatus
      ,menu,menuStatus,menuSort
      ,parentSlug, parentTitle,parentCreateDate
      ,StartDate,ExpirationDate,CommentMode
      ,NoDelete,Deleted,DeleteDate,Modified,ModifyBy,ModifyDate,Created,CreateBy,CreateDate
      ,NodeCount,ArchiveCount,showheader,startrow,startcol
      ,theme_template,plugin_content,href,redirect,youtube,notes,src,map,location
      ,OwnerID,PublicAccess,SortOrder
      ,Tags,xmlSecurity,xmlConf
      ,DataSize"; // rather than using select *
</cfscript>


<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "">

	<cftry>
		<cfset this.get()>
		
		<cfreturn "">

		<cfcatch />
	</cftry>
	
	<cfreturn "Unable to query preferences DB">
</cffunction>




<cffunction name="getOne" returntype="query" access="remote" hint="Even if there is no match, one is returned">
	<cfargument name="nodek" required="true" type="struct">
	
	<cfscript>
		var qryNode = QueryNew("Empty");
	
		param arguments.nodek.NodeID 	= "";
		param arguments.nodek.Slug 	= "";
		param arguments.nodek.Kind 	= "";
		param arguments.nodek.Extra = "";
	</cfscript>

	

	<!--- Node ID 	+ Kind:		best practice 						--->
	<!--- Node ID 	+ Kind: Max	Get the most recent			 		--->
	<!--- Extra 	+ Kind: 	Gets the most recent		 		--->
	<!--- Node ID:				ok, but be ready for anything 		--->
	<!--- Kind:					ok, but be ready for most recent 20	--->
	<!--- Slug:	 				great --->
	<!--- Bad ID 				blank --->
	<!--- Junk 					blank --->
	
	
	
	
	<cfif arguments.nodeK.NodeID EQ "max">
		<cfquery name="qryNode">
			DECLARE @Kind 	varchar(20)
			SET		@Kind 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodek.Kind#">
		
			SELECT 	TOP 1 #variables.lstNode# 
			FROM 	dbo.vwNode WITH (NOLOCK)
			WHERE	Deleted 		= 0
			AND		Kind 			= @Kind
			ORDER BY NodeID DESC	
 		</cfquery>
	
		<cfreturn qryNode>
	</cfif>
	
	
	<cfif arguments.nodeK.Extra NEQ "">
		
	
		<cfquery name="qryNodeViaKindExtra">
			SELECT 	TOP 1 #variables.lstNode# 
			FROM 	dbo.vwNode WITH (NOLOCK)
			WHERE	Deleted = 0
			AND		Kind 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodek.Kind#">
			AND		Extra 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodek.Extra#">
 		</cfquery>
	
		<cfreturn qryNodeViaKindExtra>
	</cfif>

	


	<cfquery name="local.qryNode">
		DECLARE @NodeID int
		DECLARE @Kind 	varchar(20)
		SET     @NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodek.NodeID#">)
		SET		@Kind 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodek.Kind#">
	
		SELECT 	TOP 20 #variables.lstNode#  
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		(NodeID 	= @NodeID 	OR @NodeID IS NULL)
		AND		(Kind 		= @Kind		OR @Kind = '')
		ORDER BY CreateDate DESC
	</cfquery>
	
	<cfif local.qryNode.recordcount EQ 1>
		<cfreturn local.qryNode>	
	</cfif>
	
	
	
	<cfif arguments.nodeK.Slug NEQ "">
		<cfquery name="qryNode">
			DECLARE @Slug 	varchar(20)
			SET		@Slug 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodek.Slug#">
	
			SELECT 	TOP 1 #variables.lstNode#  
			FROM 	dbo.vwNode WITH (NOLOCK)
			WHERE	Deleted = 0
			AND		(
					(Slug = @Slug AND Root <> 1)
				OR 	(@Slug = 'home' AND Root = 1)
				)
			ORDER BY CreateDate DESC
		</cfquery>
	
		<cfreturn local.qryNode>
	</cfif>


	



	<cfset local.qryNode = QueryNew(variables.lstNode)>
	<cfset QueryAddRow(local.qryNode)>		


	
	<cfreturn local.qryNode>	
</cffunction>


<cffunction name="getArchiveDetails" returntype="query" access="remote" hint="Returns a specific archive">
	<cfargument name="nodeArchiveID" required="true" type="string">
	
	<cfquery name="local.qryNodeArchive">
		SELECT 	*
		FROM 	dbo.NodeArchive WITH (NOLOCK)
		CROSS APPLY dbo.udf_titleRead(xmlTitle)
		CROSS APPLY dbo.udf_taxonomyRead(xmlTaxonomy)
		
		WHERE	NodeArchiveID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodeArchiveID#">
	</cfquery>
	
	<cfreturn local.qryNodeArchive>
</cffunction>	
	


<cffunction  name="getAllByExtra" returnType="query" output="no" access="remote">
	<cfargument name="Kind" type="string" required="true">
	<cfargument name="Extra" type="string" required="true">
	<cfargument name="SortBy" type="string" required="true"><!--- Not in use --->
	

	
	
	<cfscript>
		variables.QueryService.addParam(value = arguments.kind, cfsqltype="cf_sql_varchar");
		variables.QueryService.addParam(value = arguments.extra, cfsqltype="cf_sql_varchar");


		var oresult = variables.QueryService.execute(sql="SELECT 	TOP 100 #variables.lstNode#
			FROM 	dbo.vwNode  WITH (NOLOCK)
			WHERE	Deleted = 0
			AND		Kind 		= ?
			AND		Extra 		= ?
			ORDER BY Title");
	
		var local.qryNodeExtra = oresult.getResult();
	</cfscript>

	<cfreturn local.qryNodeExtra>
</cffunction>




<cffunction  name="getAllByUserID" returnType="query" output="no" access="remote">
	<cfargument name="Kind" type="string" required="true">
	<cfargument name="UserID" type="string" required="true">
	<cfargument name="SortBy" type="string" required="true"><!--- Not in use --->
	
	<cfquery name="qryNode">
		SELECT 	TOP 100 #variables.lstNode#
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		CreateBy = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.userid#">
		ORDER BY	CreateDate Desc
	</cfquery>
	

	<cfreturn qryNode>
</cffunction>


<cffunction name="getEvent" output="false" returntype="query" access="remote">
	<cfargument name="Kind" type="string" required="true">	
			
	<cfquery name="local.qryEvent">
		SELECT 	 #variables.lstNode#,
			
			CASE WHEN ExpirationDate > getDate()
				AND		(
					Month(ExpirationDate) <> Month(getDate())
					OR
					Year(ExpirationDate) <> Year(getDate())
					) THEN 'FutureMonth'
				WHEN ExpirationDate < getDate()
				AND		(
					Month(ExpirationDate) <> Month(getDate())
					OR
					Year(ExpirationDate) <> Year(getDate())
					) THEN 'PastMonth'
				ELSE 'ThisMonth'
			END AS TimeFrame			
			
		FROM 	dbo.vwNode
		WHERE	Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.Kind#">
		AND		Deleted = 0
		ORDER BY	ExpirationDate DESC
	</cfquery>

			
	<cfreturn local.qryEvent>
</cffunction>


<cfscript>

	


string function stripHTML(string str) output="false" {
	return REReplaceNoCase(str,"<[^>]*>","","ALL");
	}



struct function getBundle(required struct NodeK, required string Kind, required string UserID) output="false" access="remote"	{

	
	
	var qryEmpty 		= QueryNew("Empty");
	var qryNode			= this.getOne(arguments.NodeK);
	
	
		

	var stResult = {
		qryNode			= qryNode,
		qrySubNode 		= this.getSubNode(qryNode.NodeID, arguments.kind),
	
		qryData 		= this.getData(qryNode.NodeID),
		qryConfig 		= this.getConf(qryNode.NodeID),
		qryLink 		= this.getLink(qryNode.NodeID),
	
		qryFacet		= this.FacetGet(qryNode.NodeID)
		
		};
	
	
	
	return stResult;
	}


</cfscript>



<cffunction name="getPageParent" output="false" returntype="query" access="remote">
	
	
	<cfquery name="local.qryPageParent">
		SELECT	#variables.lstNode#, dbo.vwNodeSort.[Level] 
		FROM	dbo.vwNode INNER JOIN 
				dbo.vwNodeSort
		ON dbo.vwNode.NodeID = dbo.vwNodeSort.SortNodeID
				
		WHERE	deleted = 0
		
		ORDER BY SortCol	
	</cfquery>
		
	<cfreturn local.qryPageParent>
</cffunction>



<cffunction name="getAll" output="false" returntype="query" access="remote">
	<cfargument name="kind" required="true" type="string">
	<cfargument name="cstatus" required="true" type="string">
	<cfargument name="sortBy" required="true" type="string">		
	<cfargument name="maxrows" required="true" type="numeric">
	
	

			
			
	<cfquery name="local.qryCategory">
		SELECT TOP 	<cfif isnumeric(arguments.maxrows)>#arguments.maxrows#</cfif> 	
			#variables.lstNode#, 0 AS Level
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	deleted = 0
		
		<cfif arguments.Kind NEQ "All">
			AND		kind IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#" list="yes">)
		</cfif>
		
		<cfif isboolean(cstatus)>
			AND	cStatus = <cfqueryparam CFSQLType="CF_SQL_BIT" value="#arguments.cstatus#">
		</cfif>
		
		<cfif arguments.sortBy EQ "Menu">
			AND	MenuStatus = 1
		</cfif>
		
		ORDER BY
		
		<cfswitch expression="#arguments.sortBy#">
		<cfcase value="Natural">
			pinned DESC, modifyDate DESC
		</cfcase>
		
		<cfcase value="SortOrder">
			SortOrder
		</cfcase>
		
		<cfcase value="Title">
			Title
		</cfcase>
		
		<cfcase value="Menu">
			MenuSort
		</cfcase>
		
		
		<cfcase value="Extra_Title">
			Extra,Title
		</cfcase>
		
		<cfcase value="ModifyDate DESC">
			ModifyDate DESC
		</cfcase>
		
		<cfcase value="CreateDate DESC">
			CreateDate DESC
		</cfcase>
		
		<cfcase value="ExpirationDate DESC">
			ExpirationDate DESC
		</cfcase>
		
		
		
		
		<cfdefaultcase>
			<cfthrow>
		</cfdefaultcase> 
		</cfswitch>

	</cfquery>

			
	<cfreturn local.qryCategory>
</cffunction>






<cffunction name="getSubNode" output="false" returntype="query" access="remote">
	<cfargument name="NodeID" required="true" type="string">	
	<cfargument name="Kind" required="true" type="string">		
			
			
	<cfquery name="local.qryCategory">
		SELECT 	A.*, B.NodeCount
		FROM 	dbo.vwNode A WITH (NOLOCK)
			LEFT OUTER JOIN
			(
			SELECT 	ParentNodeID, Count(NodeID) AS NodeCount
			FROM 	dbo.Node WITH (NOLOCK)
			WHERE	Deleted = 0
			GROUP BY ParentNodeID
			) B
		ON A.NodeID = B.ParentNodeID
		WHERE	Deleted = 0
		
		<cfif arguments.Kind NEQ "Any">
			AND	Kind IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#" list="Yes">)
		</cfif>
		
		<cfif arguments.nodeid EQ "">
			AND		A.ParentNodeID IS NULL
		<cfelse>
			AND		A.ParentNodeID = TRY_CONVERT(int, <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.nodeid#">)
		</cfif>
		
		
		ORDER BY	Kind, SortOrder, Title
	</cfquery>
	
	<cfif local.qryCategory.recordcount EQ 0>
		<cfreturn QueryNew("Empty")>
	</cfif>

			
	<cfreturn local.qryCategory>
</cffunction>





<cffunction name="getKindHistory" output="false" returntype="query" access="remote">

	<cfquery name="local.qryKind">
		
		SELECT 	month(CreateDate) as themonth, year(CreateDate) as theyear, 
			SUM(CASE WHEN Kind = 'Category' THEN 1 ELSE 0 END) AS Category,
			SUM(CASE WHEN Kind = 'Facet' THEN 1 ELSE 0 END) AS Facet,
			SUM(CASE WHEN Kind = 'Photo' THEN 1 ELSE 0 END) AS Photo,
			SUM(CASE WHEN Kind = 'Video' THEN 1 ELSE 0 END) AS Photo,
			SUM(CASE WHEN Kind = 'Page' THEN 1 ELSE 0 END) AS Page,
			SUM(CASE WHEN Kind = 'Event' THEN 1 ELSE 0 END) AS Event,
			SUM(CASE WHEN Kind = 'Banner' THEN 1 ELSE 0 END) AS Banner,
			SUM(CASE WHEN Kind = 'Sponsor' THEN 1 ELSE 0 END) AS Sponsor,
			SUM(CASE WHEN Kind = 'Blog' THEN 1 ELSE 0 END) AS Blog,
			SUM(CASE WHEN Kind = 'SubPage' THEN 1 ELSE 0 END) AS SubPage,
			
			SUM(CASE WHEN NOT Kind IN ('Category', 'Photo', 'Page', 'Event', 'Banner', 'Blog', 'Facet', 'SubPage') THEN 1 ELSE 0 END) AS Unknown
					
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		GROUP BY year(CreateDate), month(CreateDate), Kind
		ORDER BY year(CreateDate), month(CreateDate)
	</cfquery>

	<cfreturn local.qryKind>
</cffunction>



<cffunction name="getKindCount" output="false" returntype="query" access="remote">
	
		
	<cfquery name="local.qryKind">
		SELECT Section, SectionSort, Kind, Datasize, KindCount, ActiveKindCount, CompletedKindCount
		FROM (
	
			SELECT  'Summary' AS Section, 10 AS SectionSort,	'All' AS Kind,
				SUM(DataSize) AS DataSize, 
				COUNT(Kind) AS KindCount,
				SUM(CASE WHEN Deleted = 0 THEN 1 ELSE 0 END) AS ActiveKindCount,
				SUM(CASE WHEN Deleted = 0 AND cStatus = 1 THEN 1 ELSE 0 END) AS CompletedKindCount
			FROM 	dbo.vwNode WITH (NOLOCK)
				
			
			UNION ALL
		
			SELECT 'Kind' AS Section, 20 AS SectionSort,
				CASE WHEN Kind = '' THEN 'Unknown' ELSE Kind END AS Kind, 
				SUM(DataSize) AS Datasize,
				COUNT(Kind) AS KindCount,
				SUM(CASE WHEN Deleted = 0 THEN 1 ELSE 0 END) AS ActiveKindCount,
				SUM(CASE WHEN Deleted = 0 AND cStatus = 1 THEN 1 ELSE 0 END) AS CompletedKindCount
				
				
			FROM 	dbo.vwNode WITH (NOLOCK)
				
			GROUP BY Kind
			) A
		ORDER BY SectionSort, Kind
	</cfquery> 



	<cfreturn local.qryKind>
</cffunction>


<cffunction name="getCountByKind" output="false" returntype="numeric" access="remote">
	<cfargument name="kind" required="true" type="string">
	<cfargument name="cstatus" required="true" type="string" hint="any,1,0">			
			
	<cfquery name="local.qryCategory">
		SELECT 	Count(NodeID) AS CategoryCount
		FROM 	dbo.Node WITH (NOLOCK)
		WHERE	Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		AND		Deleted = 0
		<cfif isboolean(arguments.cstatus)>
			AND	cStatus = <cfqueryparam CFSQLType="CF_SQL_BIT" value="#arguments.cstatus#">
		</cfif>
	</cfquery>
	
	<cfif not isnumeric(local.qryCategory.CategoryCount)>
		<cfreturn 0>
	</cfif>
			
	<cfreturn local.qryCategory.CategoryCount>
</cffunction>




<cffunction name="getAllFacet" returnType="query" access="remote" output="false" hint="This searching one facets in use">
	

	<cfquery name="local.qryFacet">
		SELECT FacetType, Facet, NTile(6) OVER(ORDER BY FacetCount) AS FacetLevel, FacetCount
		FROM (
			SELECT 	FacetType, Facet, COUNT(Facet) AS FacetCount
			FROM (
				SELECT 	T2.Facet.value('@type', 'varchar(80)') AS FacetType, T2.Facet.value('.', 'varchar(80)') AS Facet
				FROM   	dbo.Node WITH (NOLOCK)
				CROSS 	APPLY xmlTaxonomy.nodes('/facet') as T2(Facet)
				WHERE	Deleted = 0
				) A
			GROUP BY FacetType, Facet	
			)	B
		WHERE 1 = 1	
			
	
		ORDER BY FacetType, Facet
	</cfquery>
	
	<cfreturn local.qryFacet>
</cffunction>



<cffunction name="getAllTags" returnType="query" access="remote" output="false">

	<cfquery name="local.qryTags">
		SELECT Tags, dbo.udf_Slugify(Tags) AS TagSlug, NTile(6) OVER(ORDER BY TagCount) AS TagLevel, TagCount
		FROM (
			SELECT 	Tags, COUNT(Tags) AS TagCount
			FROM (
				SELECT 	T2.Tags.value('.', 'varchar(80)') AS Tags
				FROM   	dbo.Node WITH (NOLOCK)
				CROSS 	APPLY xmlTaxonomy.nodes('/tags') as T2(Tags)
				WHERE	Deleted = 0
				) A
			GROUP BY Tags	
			)	B
	
		ORDER BY Tags
	</cfquery>
	
	<cfreturn local.qryTags>
</cffunction>





<cffunction name="facetGet" returnType="query" access="remote" output="false">
	<cfargument name="NodeID" required="true" type="string">

	<cfquery name="local.qryFacet">
		DECLARE @NodeID int
		SET     @NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
	
		SELECT 	T2.Facet.value('.', 'varchar(80)') AS Facet, T2.Facet.value('.[@type]', 'varchar(80)') AS FacetType
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY xmlTaxonomy.nodes('/facet') as T2(Facet)
		WHERE	Deleted = 0
		
		AND		NodeID = @NodeID
			
		ORDER BY FacetType
	</cfquery>
	
	<cfreturn local.qryFacet>
</cffunction>



<cffunction name="tagsGet" returnType="query" output="false" access="remote">
	<cfargument name="NodeID" required="true" type="string">
	
	
	
	<cfquery name="local.qryTagsGet">
		DECLARE @NodeID int
		SET     @NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
	
				
		SELECT 	T2.Tags.value('.', 'varchar(80)') AS Tags, dbo.udf_Slugify(T2.Tags.value('.', 'varchar(80)')) AS TagSlug
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY xmlTaxonomy.nodes('/tags') as T2(Tags)
		WHERE	Deleted = 0
		AND		NodeID = @NodeID
			
		ORDER BY Tags	
	</cfquery>

	<cfreturn local.qryTagsGet>
</cffunction>






<cffunction name="getTagsCountByKind" output="false" returntype="numeric" access="remote">
	<cfargument name="kind" required="true" type="string">	
			
	
	
	<cfquery name="local.qryTags">
		SELECT 	COUNT(Tags) AS TagCount
		FROM (
			SELECT 	T2.Tags.value('.', 'varchar(80)') AS Tags
			FROM   	dbo.Node WITH (NOLOCK)
			CROSS 	APPLY xmlTaxonomy.nodes('/tags') as T2(Tags)
			WHERE	Deleted = 0
			AND		Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
			) A
	</cfquery>
	
	
	
	<cfif not isnumeric(local.qryTags.TagsCount)>
		<cfreturn 0>
	</cfif>
			
	<cfreturn local.qryTags.TagsCount>
</cffunction>		



<cffunction name="getMatchlist" returnType="query" access="remote">
	<cfargument name="kind" required="true" type="string">	
	<cfargument name="filter" required="true" type="string">
	<cfargument name="group" required="true" type="string">
	<cfargument name="pstatus" required="true" type="string">
	<cfargument name="commentmode" required="true" type="string">
	<cfargument name="recent" required="true" type="boolean">
	<cfargument name="withaction" required="true" type="boolean">
	
	
	<cfquery name="local.qryPage">
		DECLARE @Kind varchar(80)
		DECLARE @MyFilter varchar(80)
		DECLARE @Group varchar(80)
		DECLARE @pStatus varchar(80)
		
		SET 	@Kind 		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		SET 	@MyFilter	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lcase(arguments.filter)#">
		SET 	@Group 		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.group#">
		SET 	@pStatus	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.pStatus#">
	
		
		SELECT 	#variables.lstNode#
		FROM 	dbo.vwNode
		WHERE	Deleted 	= 0
		AND		([Kind]  	= @Kind  OR @Kind  IN ('', 'Any'))
		AND		([Group] 	= @Group OR @Group IN ('', 'Any'))
		AND		([pStatus] 	= @pStatus OR @pStatus IN ('', 'Any'))
	
			
		<cfif arguments.filter NEQ "">
			AND		(
				Title LIKE <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.filter#%">
				OR		xmlTaxonomy.exist('taxonomy/tag[fn:lower-case(.) = sql:variable("@MyFilter")]') = 1
				)
		</cfif>
			
	
			
		<cfif arguments.commentmode EQ "Any" OR arguments.commentmode EQ "">
			
		<cfelseif arguments.commentmode EQ "Active">
			AND		[CommentMode] != '' 
		<cfelse>
			AND		[CommentMode] = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.commentmode#"> 
		</cfif>	
			
			
		<cfif arguments.recent>
			AND		CreateDate  > DateAdd(m, -6, getDate()) 
		</cfif>	
			
		
		ORDER BY Title	
	</cfquery>

	
	<cfreturn local.qryPage>
</cffunction>





<cffunction name="getFeed" output="false" returntype="query" access="remote">
	<cfargument name="kind" required="true" type="string" hint="can be list">
	<cfargument name="baselink" required="true" type="string">
			
			
	<cfquery name="local.qryFeed">
		SELECT 	A.Title, A.strData AS Content, 'html' AS ContentType, 
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.baselink#"> + CONVERT(varchar(20), A.NodeID) AS Linkhref,
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.baselink#"> + CONVERT(varchar(20), A.NodeID) AS ID,
			
			A.CreateBy AS authorName, A.ModifyDate as UpdatedDate, A.CreateDate AS PublishedDate,
			B.Title AS CategoryTerm

		FROM 	dbo.vwNode A LEFT OUTER JOIN
			(
			SELECT 	NodeID, Title
			FROM 	dbo.vwNode WITH (NOLOCK)
			) B
		ON 	B.NodeID = A.ParentNodeID
		WHERE	Kind IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#" list="Yes">)
		AND		Deleted = 0
		AND		cStatus = 1
		AND		pStatus = 'Approved'
		
		
		ORDER BY	ModifyDate DESC
	</cfquery>

			
	<cfreturn local.qryFeed>
</cffunction>


<!--- Was IOR --->
<cffunction name="getNodePath" output="false" returnType="query" access="remote">
	<cfargument name="NodeID" required="false" default="">
		
	<cfset var qryNode = "">
	<cfset var lstPath = "">
		
	<cfif NOT isNumeric(arguments.nodeID)>
		<cfreturn QueryNew("Empty")>
	</cfif>
		
	<cfquery name="qryNode">
		WITH Family AS ( 
    		
    		SELECT 	N.NodeID, ISNULL(N.ParentNodeID, '') AS ParentNodeID, Slug, N.Title, N.Kind, 0 AS Depth, N.CreateDate
			FROM 	dbo.vwNode N WITH (NOLOCK)
   			WHERE 	NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
			
			UNION ALL 
  		  	
  		  	SELECT 	N2.NodeID, ISNULL(N2.ParentNodeID, '') AS ParentNodeID, N2.Slug,  N2.Title, N2.Kind, Depth + 1, N2.CreateDate
    		FROM	dbo.vwNode N2 WITH (NOLOCK)
    		
        	INNER JOIN 	Family 
            ON 		Family.ParentNodeID = N2.NodeID
            WHERE	PrimaryRecord = 0 
			) 
			
			
		SELECT 	NodeID, ParentNodeID, Slug, Title, Kind, Depth, CreateDate
		FROM 	Family
		ORDER BY Depth DESC
	</cfquery>		
		
	<cfreturn qryNode>
</cffunction>





<!--- Used by searching --->
<cffunction name="getBySearch" output="false" returntype="query" access="remote">
	<cfargument name="search" required="true" type="string">
	<cfargument name="kind" required="true" type="string">
		
	<cfif arguments.search EQ "">
		<cfreturn QueryNew("Empty")>
	</cfif>
		
		

	<cfquery name="local.qrySearch">
		SELECT 	TOP 20	NodeID, Slug, ParentNodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate, src, Rank
		FROM	(
			SELECT 	NodeID, Slug, ParentNodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate, src, [Rank] / 10.0 AS Rank
			FROM 	dbo.vwNode WITH (NOLOCK)
			INNER JOIN FREETEXTTABLE(dbo.Node, *, <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.search#">) AS SearchTable
			ON 		dbo.vwNode.NodeID = searchTable.[key]
			WHERE	Deleted = 0
			AND		[Rank] > 10
			-- AND		PublicAccess = 1
			
			UNION ALL
			
			SELECT 	NodeID, Slug, ParentNodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate, src, 100 AS Rank
			FROM 	dbo.vwNode	 WITH (NOLOCK)
			WHERE	CONVERT(varchar(80), NodeID) = <cfqueryparam CFSQLType="CF_SQL_varchar" value="#arguments.search#">
			AND		Deleted = 0
			-- AND		PublicAccess = 1
			) A

		WHERE 1 = 1
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
				
		ORDER BY rank DESC
	</cfquery>

	<cfreturn local.qrySearch>
</cffunction>


<cffunction name="getByFacet" output="false" returntype="query" access="remote">
	<cfargument name="facetType" required="true" type="string" hint="case insensitive">
	<cfargument name="facet" required="true" type="string" hint="case insensitive">
	<cfargument name="kind" required="true" type="string">


	<cfquery name="local.qryFacet">
		DECLARE @MyFacet 		varchar(30)
		DECLARE @MyFacetType 	varchar(30)
		
		SET 	@MyFacet 		=  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.facet#">
		SET 	@MyFacetType 	=  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.facetType#">
					
		
		SELECT 	ParentNodeID, NodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate, src, NULL AS Rank
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		
		AND		[Public] = 1
		AND		xmlTaxonomy.exist('/facet[@type = sql:variable("@MyFacetType")]') = 1
		
		<cfif arguments.facet NEQ "">
			AND	xmlTaxonomy.exist('/facet[. = sql:variable("@MyFacet")]') = 1
		</cfif>
		
		
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
		
		ORDER BY Kind, ModifyDate DESC
	</cfquery>

	<cfreturn local.qryFacet>
</cffunction>



<cffunction name="getByTag" output="false" returntype="query" access="remote">
	<cfargument name="tag" required="true" type="string" hint="case insensitive">
	<cfargument name="kind" required="true" type="string">


	<cfquery name="local.qryTag">
		DECLARE @MyTag varchar(30)
		SET 	@MyTag =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.tag#">
	
		SELECT 	ParentNodeID, NodeID, Kind, Title, ParentTitle, slug, vwNode.tags, 
			strData, CreateBy, CreateDate, src, NULL AS Rank
		FROM   	dbo.vwNode WITH (NOLOCK)
		CROSS 	APPLY xmlTaxonomy.nodes('/tags') as T2(Tags)
		WHERE	Deleted = 0
		AND 	dbo.udf_Slugify(T2.Tags.value('.', 'varchar(80)')) = @MyTag
			
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
			
		ORDER BY Kind, ModifyDate DESC	
	</cfquery>


	<cfreturn local.qryTag>
</cffunction>	
	

<cffunction name="getByArchive" output="false" returntype="query" access="remote">	
	<cfargument name="archiveyear" required="true" type="string">
	<cfargument name="archivemonth" required="true" type="string" hint="can be blank">
	<cfargument name="kind" required="true" type="string">
	
	<cfquery name="local.qryArchive">
		SELECT 	NodeID, ParentNodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate, src, NULL AS Rank
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
	
		AND		[Public] = 1
		
		AND		YEAR (CreateDate) = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.archiveyear#">
		<cfif isnumeric(arguments.archivemonth)>
			AND		MONTH(CreateDate) = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#arguments.archivemonth#">
		</cfif>
		
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
		ORDER BY CreateDate
	</cfquery>
	
	<cfreturn local.qryArchive>
</cffunction>		


<cffunction name="getByCategory" output="false" returntype="query" access="remote">	
	<cfargument name="category" required="true" type="string">	
	<cfargument name="kind" required="true" type="string">
	
	<cfquery name="local.qrySearch">
		SELECT	ParentNodeID, NodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate,src, NULL AS Rank
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	ParentTitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.category#"> 
		AND		Deleted = 0

		AND		[Public] = 1
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
		ORDER BY Kind, ModifyDate DESC
	</cfquery>	
	
	<cfreturn local.qrySearch>
</cffunction>		


<cffunction name="getByRandom" output="false" returntype="query" access="remote">	
	<cfargument name="kind" required="true" type="string">
	
	<cfquery name="local.qryRandom">
		SELECT TOP 20 ParentNodeID, NodeID, Kind, Title, ParentTitle, tags, strData, CreateBy, CreateDate, src, NULL AS Rank
		FROM 	dbo.vwNode
		WHERE	Deleted = 0
		AND		[Public] = 1
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
		ORDER BY newID()
	</cfquery>	
	
	<cfreturn local.qryRandom>
</cffunction>		






<cffunction name="getTOC" output="false" returntype="query" access="remote">
				
	<cfquery name="local.qryCategory">
		SELECT TOP 1000 	*
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		Kind = 'Page'
		AND		cStatus = 1
		AND		pStatus = 'Approved'
		
		AND		ParentNodeID IN (SELECT NodeID FROM dbo.Node WHERE Deleted = 0 AND ParentNodeID is null)
		
		ORDER BY	ParentTitle, SortOrder
	</cfquery>

			
	<cfreturn local.qryCategory>
</cffunction>



<cffunction name="LinkExists" output="false" returntype="boolean" access="remote">
	<cfargument name="NodeID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">


	<cfscript>
	param rc.type = '';
	</cfscript>



	<cfquery name="local.qryExists">
		SELECT	NodeID
		FROM	dbo.Node WITH (NOLOCK)
		CROSS APPLY dbo.udf_xmlRead(xmlLink)
		WHERE	NodeID = <cfqueryparam CFSQLType="CF_SQL_integer" value="#arguments.nodeid#">
		AND		Deleted = 0
		AND		type = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.type#">
		AND		href = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.href#">		
	</cfquery>

	<cfif local.qryExists.recordcount EQ 0>
		<cfreturn false>
	</cfif>
	
	<cfreturn true>
</cffunction>




<!--- Summary for tool bar --->
<cffunction name="getSecondary" output="false" access="remote" returnType="struct">

	
	<cfset stResult = {Inbox = 0, PendingUser = 0}>


	<cfset var qryComment = "">
	<cfset var qryCount = "">



	<cfquery name="qryComment">
		SELECT 	COUNT(CommentID) AS commentCount
		FROM 	dbo.Comment C
		WHERE 	NodeID is null
		AND		C.Deleted = 0
	</cfquery>
	
	<cfif isnumeric(qryComment.CommentCount)>
		<cfset stResult.Inbox = qryComment.CommentCount>
	</cfif>

	<!--- user count --->
	<cfquery name="qryCount">
		SELECT 	Count(UserID) AS UserCount
		FROM 	dbo.users
		WHERE	Deleted = 0
		AND		uStatus = 'Pending'
	</cfquery>
	
	<cfif isnumeric(qryCount.UserCount)>
		<cfset stResult.PendingUser = qryCount.UserCount>
	</cfif>


	<cfreturn stResult>
</cffunction>


<!--- XML stuff --->
<cffunction name="getSitemap" output="false" access="remote" returnType="query">
	<cfargument name="NodeID" required="true" type="string">
	<cfargument name="EntryCount" required="true" type="numeric">



	<cfquery name="local.qrySitemap">
		SELECT 
			T2.Loc.value('loc[1]', 'varchar(max)') AS loc, 
			T2.Loc.value('lastmod[1]', 'varchar(max)') AS lastmod,
			T2.Loc.value('changefreq[1]', 'varchar(max)') AS changefreq,
			T2.Loc.value('priority[1]', 'varchar(max)') AS priority
			
			
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY xmlData.nodes('/url') as T2(Loc)
		WHERE	Deleted = 0
		AND		NodeID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">
	</cfquery>		

	<cfset QueryAddRow(local.qrySitemap, (arguments.EntryCount - local.qrySitemap.recordcount))>



	<cfreturn local.qrySitemap>
</cffunction>



<cffunction name="getData" output="false" returntype="query" access="remote">
	<cfargument name="NodeID" required="true" type="string">

	<cfquery name="local.qryData">
		SELECT 	type, href, title, message, Position
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY dbo.udf_xmlRead(xmlData)
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
		ORDER BY type, Position, title
	</cfquery>


	<cfreturn qryData>
</cffunction>


<cffunction name="getConf" output="false" returntype="query" access="remote">
	<cfargument name="NodeID" required="true" type="string">


	<cfquery name="local.qryLink">
		SELECT 	type, href, title, message, Position
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY dbo.udf_xmlRead(xmlConf)
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
		ORDER BY type, Position, title	</cfquery>

	<cfreturn local.qryLink>
</cffunction>


<cffunction name="getLink" output="false" returntype="query" access="remote">
	<cfargument name="NodeID" required="true" type="string">


	<cfquery name="local.qryLink">
		SELECT 	type, href, title, message, Position
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY dbo.udf_xmlRead(xmlLink)
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
		ORDER BY type, Position, title
	</cfquery>

	<cfreturn local.qryLink>
</cffunction>



<cffunction name="getArchive" output="false" access="remote" returnType="query" hint="Old versions of this node">
	<cfargument name="NodeID" required="true" type="string">
	
	
	<cfquery name="local.qryArchive">
		DECLARE @NodeID int
		SET     @NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
		
	
		SELECT 	TOP 20 NodeArchiveID, NodeID, CONVERT(date, VersionDate) AS ShortDate,
			VersionDate, m.[by] AS ModifyBy, Kind, Root, NoDelete, 
			xmlTitle.value('/title[1]', 'nvarchar(max)') AS title, DataSize
		
		FROM 	dbo.NodeArchive
		CROSS APPLY dbo.udf_4jRead(Modified)	M
		WHERE	Deleted = 0
		AND		(NodeID 	= @NodeID 	OR @NodeID = '')
				
		
		ORDER BY ShortDate DESC,VersionDate DESC
	</cfquery>
	
	
	
	<cfreturn local.qryArchive>
</cffunction>




<cffunction name="sluggify" output="false" returnType="string">
    <cfargument name="str">
 
 	<cfscript>
 
    var spacer 	= "-";
    var ret 	= "";
    
    str = lCase(trim(str));
    str = reReplace(str, "[^a-z0-9-]", spacer, "all");
    ret = reReplace(str, "#spacer#+", spacer, "all");
    
    if (left(ret, 1) == spacer)
        ret = right(ret, len(ret)-1);
  
    if (right(ret, 1) == spacer)
      	ret = left(ret, len(ret)-1);
   
    
    return ret;
    </cfscript>
</cffunction>	


<cffunction name="doSlug" output="false" returnType="string" hint="Create a unique slug, if possible">
	<cfargument name="str">

	<cfscript>
	if (arguments.str == "")
		return "";
	
	var candidateSlug = this.sluggify(str);
	
	if (this.getOne({Slug = candidateSlug}).recordcount == 0)
		return candidateSlug;	
	
	for (var i = 1; i < 10; i++)	{
		var NewSlug = "#CandidateSlug#-#i#";
		
		if (this.getOne({Slug = NewSlug}).recordcount == 0)
			return NewSlug;	 
		
		}
		
	return "#CandidateSlug#-x-#randRange(1000,9999)#"; // I give up after this
	</cfscript>

</cffunction>



<cffunction name="getDBSchema" output="false" returnType="query" hint="Dump of tables, if possible" access="remote">


	<cfquery name="local.qryPlugin">
		SELECT column_name, data_type, character_maximum_length, TABLE_SCHEMA, 
		table_name, ordinal_position, is_nullable 
		FROM information_schema.COLUMNS WITH (NOLOCK)
		
		ORDER BY table_name, ordinal_position
	</cfquery>

	<cfreturn local.qryPlugin>
</cffunction>


<cffunction name="getDBVersion" output="false" returnType="string" hint="SQL Version" access="remote">


	<cfquery name="local.qryDB">
		SELECT @@Version AS DBVersion
	</cfquery>

	<cfreturn local.qryDB.DBVersion>
</cffunction>



<cffunction name="getDBDSN" output="false" returnType="string" access="remote">

	<!--- CF 9 --->
	<cfreturn application.getApplicationSettings().datasource>
	
	<!--- CF 10 --->
	<cfreturn GetApplicationMetaData().datasource>
</cffunction>


</cfcomponent>

