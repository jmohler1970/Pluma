



<cfcomponent extends="base">
<cfscript>


	this.stResults = {result = true, resultCode = 0, Message = ''};
	this.touch = 0;

	variables.QueryService = new query();
	variables.QueryService.setName("qryResult");
	

	
	variables.lstNode = "NodeID,ParentNodeID,Root,Kind
      ,Slug,title,meta,metad,content
      ,menu,menuOrder,menuStatus
      ,parent, parentTitle
      ,Deleted,DeleteDate
      ,ModifyBy,ModifyDate,CreateBy,CreateDate
      ,NodeCount,ArchiveCount
      ,template,private,author
      ,DataSize"; // rather than using select *
</cfscript>


<cffunction name="getStatus" output="false"  returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "OK">

</cffunction>




<cffunction name="getOne" returntype="query"  hint="Even if there is no match, one is returned">
	<cfargument name="nodek" required="true" type="struct">
	
	<cfscript>
		var qryNode = QueryNew("Empty");
	
		param arguments.nodek.NodeID 	= "";
		param arguments.nodek.Slug 	= "";
		param arguments.nodek.Kind 	= "";
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
		<cfreturn this.getBySlug(arguments.nodek.slug)>
	</cfif>


	
	

	<cfset local.qryNode = QueryNew(variables.lstNode)>
	<cfset QueryAddRow(local.qryNode)>		


	
	<cfreturn local.qryNode>	
</cffunction>



<cffunction name="getBySlug" output="false" returnType="query">
	<cfargument name="slug" required="true" type="string">

	<cfquery name="local.qryGetBySlug">
		DECLARE @Slug 	varchar(20) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.Slug#">

		SELECT 	TOP 1 #variables.lstNode#  
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		Slug = @Slug
		ORDER BY CreateDate DESC
	</cfquery>

	<cfreturn local.qryGetBySlug>

</cffunction>




<cffunction name="getArchiveDetails" returntype="query"  hint="Returns a specific archive">
	<cfargument name="nodeArchiveID" required="true" type="string">
	
	<cfquery name="local.qryNodeArchive">
		SELECT 	*
		FROM 	dbo.NodeArchive WITH (NOLOCK)
		CROSS APPLY dbo.udf_gsRead(xmlTitle)
		
		WHERE	NodeArchiveID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.nodeArchiveID#">
	</cfquery>
	
	<cfreturn local.qryNodeArchive>
</cffunction>	
	



	



<cffunction  name="getAllByUserID" returnType="query" output="no" >
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



<cfscript>
struct function getBundle(required struct NodeK, required string Kind, required string UserID) output="false" 	{

	
	
	var qryEmpty 		= QueryNew("Empty");
	var qryNode			= this.getOne(arguments.NodeK);
	
	
		

	var stResult = {
		qryNode			= qryNode,
		qrySubNode 		= this.getSubNode(qryNode.NodeID, arguments.kind),
	
		qryConfig 		= this.getConf(qryNode.NodeID),
		qryLink 		= this.getLink({NodeID = qryNode.NodeID, Kind = qryNode.Kind})
		};
	
	
	
	return stResult;
	}


</cfscript>



<cffunction name="getPageParent" output="false" returntype="query" hint="Only pages can contain things">
	
	
	<cfquery name="local.qryPageParent">
		SELECT	#variables.lstNode#, CONVERT(varchar(30), modifyDate, 126) AS Date2 
		FROM	dbo.vwNode WITH (NOLOCK)
		WHERE	deleted = 0
		AND		Kind = 'Page' 
		ORDER BY Title
	</cfquery>
		
	<cfreturn local.qryPageParent>
</cffunction>



<cffunction name="getAll" output="false" returntype="query" >
	<cfargument name="kind" required="true" type="string">
	<cfargument name="sortBy" required="true" type="string">		
	<cfargument name="maxrows" required="true" type="numeric">
	

			
			
	<cfquery name="local.qryAll">
		SELECT TOP 	<cfif isnumeric(arguments.maxrows)>#arguments.maxrows#</cfif> 	
			#variables.lstNode#		
			
			
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	deleted = 0
		
		<cfif arguments.Kind NEQ "All">
			AND		kind IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#" list="yes">)
		</cfif>
		
		
		<cfif arguments.sortBy EQ "Menu">
			AND	MenuStatus = 'Y'
		</cfif>
		
		
		ORDER BY
		
		<cfswitch expression="#arguments.sortBy#">
		<cfcase value="Natural">
			modifyDate DESC
		</cfcase>
		
		<cfcase value="SortOrder">
			SortOrder
		</cfcase>
		
		<cfcase value="Title">
			Title
		</cfcase>
		
		<cfcase value="Menu">
			MenuOrder
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

			
	<cfreturn local.qryAll>
</cffunction>






<cffunction name="getSubNode" output="false" returntype="query" >
	<cfargument name="Parent" required="true" type="string" hint="This is a slug too">	
	<cfargument name="Kind" required="true" type="string">		
			
			
	<cfquery name="local.qryCategory">
		DECLARE @Parent varchar(20) = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.parent#">
	
	
		SELECT 	A.*
		FROM 	dbo.vwNode A WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		ISNULL(A.Parent, '') = @Parent
				
		<cfif arguments.Kind NEQ "Any">
			AND	Kind IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#" list="Yes">)
		</cfif>
		
				
		ORDER BY	Kind, Title
	</cfquery>
	
	<cfif local.qryCategory.recordcount EQ 0>
		<cfreturn QueryNew("Empty")>
	</cfif>

			
	<cfreturn local.qryCategory>
</cffunction>





<cffunction name="getKindHistory" output="false" returntype="query" >

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
						
			SUM(CASE WHEN NOT Kind IN ('Category', 'Photo', 'Page', 'Event', 'Banner', 'Blog', 'Facet') THEN 1 ELSE 0 END) AS Unknown
					
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		GROUP BY year(CreateDate), month(CreateDate), Kind
		ORDER BY year(CreateDate), month(CreateDate)
	</cfquery>

	<cfreturn local.qryKind>
</cffunction>



<cffunction name="getKindCount" output="false" returntype="query" >
	
		
	<cfquery name="local.qryKind">
		SELECT Section, SectionSort, Kind, Datasize, KindCount, ActiveKindCount
		FROM (
	
			SELECT  'Summary' AS Section, 10 AS SectionSort,	'All' AS Kind,
				SUM(DataSize) AS DataSize, 
				COUNT(Kind) AS KindCount,
				SUM(CASE WHEN Deleted = 0 THEN 1 ELSE 0 END) AS ActiveKindCount
			FROM 	dbo.vwNode WITH (NOLOCK)
				
			
			UNION ALL
		
			SELECT 'Kind' AS Section, 20 AS SectionSort,
				CASE WHEN Kind = '' THEN 'Unknown' ELSE Kind END AS Kind, 
				SUM(DataSize) AS Datasize,
				COUNT(Kind) AS KindCount,
				SUM(CASE WHEN Deleted = 0 THEN 1 ELSE 0 END) AS ActiveKindCount
				
				
			FROM 	dbo.vwNode WITH (NOLOCK)
				
			GROUP BY Kind
			) A
		ORDER BY SectionSort, Kind
	</cfquery> 



	<cfreturn local.qryKind>
</cffunction>


<cffunction name="getCountByKind" output="false" returntype="numeric" >
	<cfargument name="kind" required="true" type="string">
			
	<cfquery name="local.qryCategory">
		SELECT 	Count(NodeID) AS CategoryCount
		FROM 	dbo.Node WITH (NOLOCK)
		WHERE	Kind = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		AND		Deleted = 0
	</cfquery>
	
	<cfif not isnumeric(local.qryCategory.CategoryCount)>
		<cfreturn 0>
	</cfif>
			
	<cfreturn local.qryCategory.CategoryCount>
</cffunction>




<cffunction name="getAllTags" returnType="query"  output="false">

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





<cffunction name="tagsGet" returnType="query" output="false" >
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






<cffunction name="getTagsCountByKind" output="false" returntype="numeric" >
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



<cffunction name="getMatchlist" returnType="query" >
	<cfargument name="kind" required="true" type="string">	
	<cfargument name="filter" required="true" type="string">
	<cfargument name="group" required="true" type="string">
	<cfargument name="recent" required="true" type="boolean">
	<cfargument name="withaction" required="true" type="boolean">
	
	
	<cfquery name="local.qryPage">
		DECLARE @Kind varchar(80)
		DECLARE @MyFilter varchar(80)
		DECLARE @Group varchar(80)
		
		SET 	@Kind 		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		SET 	@MyFilter	= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lcase(arguments.filter)#">
		SET 	@Group 		= <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.group#">

	
		
		SELECT 	#variables.lstNode#
		FROM 	dbo.vwNode
		WHERE	Deleted 	= 0
		AND		([Kind]  	= @Kind  OR @Kind  IN ('', 'Any'))
		AND		([Group] 	= @Group OR @Group IN ('', 'Any'))
	
			
		<cfif arguments.filter NEQ "">
			AND		(
				Title LIKE <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="%#arguments.filter#%">
				OR		xmlTaxonomy.exist('taxonomy/tag[fn:lower-case(.) = sql:variable("@MyFilter")]') = 1
				)
		</cfif>
			
			
			
		<cfif arguments.recent>
			AND		CreateDate  > DateAdd(m, -6, getDate()) 
		</cfif>	
			
		
		ORDER BY Title	
	</cfquery>

	
	<cfreturn local.qryPage>
</cffunction>




<!--- Was IOR --->
<cffunction name="getNodePath" output="false" returnType="query" >
	<cfargument name="NodeID" required="false" default="">
		


	<cfif NOT isNumeric(arguments.nodeID)>
		<cfreturn QueryNew("Empty")>
	</cfif>
		
	<cfquery name="local.qryNode">
		WITH Family AS ( 
    		
    		SELECT 	N.NodeID, ISNULL(N.Parent, '') AS Parent, Slug, N.Title, N.Kind, 0 AS Depth, N.CreateDate
			FROM 	dbo.vwNode N WITH (NOLOCK)
   			WHERE 	NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
			
			UNION ALL 
  		  	
  		  	SELECT 	N2.NodeID, ISNULL(N2.Parent, '') AS Parent, N2.Slug,  N2.Title, N2.Kind, Depth + 1, N2.CreateDate
    		FROM	dbo.vwNode N2 WITH (NOLOCK)
    		
        	INNER JOIN 	Family 
            ON 		Family.Parent = N2.slug
            WHERE	[root] = 0 
			) 
			
			
		SELECT 	NodeID, Parent, Slug, Title, Kind, Depth, CreateDate
		FROM 	Family
		ORDER BY Depth DESC
	</cfquery>		
		
	<cfreturn local.qryNode>
</cffunction>





<!--- Used by searching --->
<cffunction name="getBySearch" output="false" returntype="query" >
	<cfargument name="search" required="true" type="string">
	<cfargument name="kind" required="true" type="string">
		
	<cfif arguments.search EQ "">
		<cfreturn QueryNew("Empty")>
	</cfif>
		
		

	<cfquery name="local.qrySearch">
		SELECT 	TOP 20	NodeID, Slug, Parent, Kind, Title, ParentTitle, meta,
			content, CreateBy, CreateDate, Rank
		FROM	(
			SELECT 	NodeID, Slug, Parent, Kind, 
				Title, ParentTitle, meta, 
				content, CreateBy, CreateDate, [Rank] / 10.0 AS Rank
			FROM 	dbo.vwNode WITH (NOLOCK)
			INNER JOIN FREETEXTTABLE(dbo.Node, *, <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.search#">) AS SearchTable
			ON 		dbo.vwNode.NodeID = searchTable.[key]
			WHERE	Deleted = 0
			AND		[Rank] > 10
			AND		Private = 0
			
			UNION ALL
			
			SELECT 	NodeID, Slug, Parent, Kind, 
				Title, ParentTitle, meta, content, CreateBy, CreateDate, 100 AS Rank
			FROM 	dbo.vwNode	 WITH (NOLOCK)
			WHERE	CONVERT(varchar(80), NodeID) = <cfqueryparam CFSQLType="CF_SQL_varchar" value="#arguments.search#">
			AND		Deleted = 0
			AND		Private = 0
			
			UNION
			
			SELECT 	E.UserID, Slug, '' AS Parent, 'User' AS Kind, 
				given + ' ' + family + ' ' + ISNULL(suffix, '') AS Title, '' AS ParentTitle, '' AS meta,
				note as content, '' AS CreateBy, '' AS CreateDate, [Rank] / 10 AS Rank
			FROM 	dbo.vwUser, (
				SELECT 	UserID, Rank
				FROM 	dbo.Users
				INNER JOIN FREETEXTTABLE(dbo.Users, *, <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.search#">) AS SearchTable5
				ON 		dbo.Users.UserID = searchTable5.[key]
				) E
			WHERE dbo.vwUser.UserID = E.UserID
			AND		Deleted = 0
			AND		(ExpirationDate > getDate() OR ExpirationDate IS NULL)
						
			) A

		WHERE 1 = 1
		<cfif arguments.kind NEQ "all">
			AND kind =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.kind#">
		</cfif>
				
		ORDER BY rank DESC
	</cfquery>

	<cfreturn local.qrySearch>
</cffunction>




<cffunction name="getByTag" output="false" returntype="query" >
	<cfargument name="tag" required="true" type="string" hint="case insensitive">
	<cfargument name="kind" required="true" type="string">


	<cfquery name="local.qryTag">
		DECLARE @MyTag varchar(30)
		SET 	@MyTag =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#arguments.tag#">
	
		SELECT 	ParentNodeID, NodeID, Kind, Title, ParentTitle, slug, vwNode.tags, vwNode.tagSlugs,
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
	

<cffunction name="getByArchive" output="false" returntype="query" >	
	<cfargument name="archiveyear" required="true" type="string">
	<cfargument name="archivemonth" required="true" type="string" hint="can be blank">
	<cfargument name="kind" required="true" type="string">
	
	<cfquery name="local.qryArchive">
		SELECT 	NodeID, ParentNodeID, Kind, Title, ParentTitle, tags, , vwNode.tagSlugs,
			strData, CreateBy, CreateDate, src, NULL AS Rank
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


<cffunction name="getByCategory" output="false" returntype="query" >	
	<cfargument name="category" required="true" type="string">	
	<cfargument name="kind" required="true" type="string">
	
	<cfquery name="local.qrySearch">
		SELECT	ParentNodeID, NodeID, Kind, Title, ParentTitle, tags, vwNode.tagSlugs,
			strData, CreateBy, CreateDate,src, NULL AS Rank
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


<cffunction name="getByRandom" output="false" returntype="query" >	
	<cfargument name="kind" required="true" type="string">
	
	<cfquery name="local.qryRandom">
		SELECT TOP 20 ParentNodeID, NodeID, Kind, Title, ParentTitle, tags, vwNode.tagSlugs,
			strData, CreateBy, CreateDate, src, NULL AS Rank
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






<cffunction name="getTOC" output="false" returntype="query" >
				
	<cfquery name="local.qryCategory">
		SELECT TOP 1000 	*
		FROM 	dbo.vwNode WITH (NOLOCK)
		WHERE	Deleted = 0
		AND		Kind = 'Page'
		AND		cStatus = 1
		AND		pStatus = 'Approved'
		
		AND		ParentNodeID IN (
			SELECT NodeID 
			FROM dbo.Node WITH (NOLOCK) 
			WHERE Deleted = 0 
			AND ParentNodeID is null
			)
		
		ORDER BY	ParentTitle, SortOrder
	</cfquery>

			
	<cfreturn local.qryCategory>
</cffunction>



<cffunction name="LinkExists" output="false" returntype="boolean" >
	<cfargument name="NodeID" required="true" type="numeric">
	<cfargument name="rc" required="true" type="struct">


	<cfscript>
	param rc.type = '';
	</cfscript>



	<cfquery name="local.qryExists">
		SELECT	NodeID
		FROM	dbo.Node WITH (NOLOCK)
		CROSS APPLY dbo.udf_xoxoRead(xmlLink, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.type#">)
		WHERE	NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
		AND		Deleted = 0
		AND		href = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#rc.href#">		
	</cfquery>

	<cfif local.qryExists.recordcount EQ 0>
		<cfreturn false>
	</cfif>
	
	<cfreturn true>
</cffunction>




<!--- Summary for tool bar --->
<cffunction name="getSecondary" output="false"  returnType="struct">

	
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
<cffunction name="getSitemap" output="false"  returnType="query">
	<cfargument name="NodeID" required="true" type="string">
	<cfargument name="EntryCount" required="true" type="numeric">



	<cfquery name="local.qrySitemap">
		SELECT 
			T2.Loc.value('loc[1]', 'varchar(max)') AS loc, 
			T2.Loc.value('lastmod[1]', 'varchar(max)') AS lastmod,
			T2.Loc.value('changefreq[1]', 'varchar(max)') AS changefreq,
			T2.Loc.value('priority[1]', 'varchar(max)') AS priority
			
			
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS	APPLY xmlData.nodes('/url') as T2(Loc)
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
	</cfquery>		

	<cfset QueryAddRow(local.qrySitemap, (arguments.EntryCount - local.qrySitemap.recordcount))>



	<cfreturn local.qrySitemap>
</cffunction>




<cffunction name="getConf" output="false" returntype="query" >
	<cfargument name="NodeID" required="true" type="string">


	<cfquery name="local.qryConf">
		SELECT 	href, rel, C.title, message
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS	APPLY dbo.udf_xoxoRead(xoxoConf, DEFAULT) C
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
	</cfquery>

	<cfreturn local.qryConf>
</cffunction>


<cffunction name="getLink" output="false" returntype="query" >
	<cfargument name="NodeK" required="true" type="struct">

	<cfparam  name="arguments.NodeK.NodeID" default="">
	<cfparam  name="arguments.NodeK.Kind" 	default="">
	



	<cfquery name="local.qryLink">
		SELECT 	NodeID, [type], href, rel, L.title, message
		FROM   	dbo.Node WITH (NOLOCK)
		CROSS 	APPLY dbo.udf_xoxoRead(xoxoLink, DEFAULT) L
		WHERE	Deleted = 0
		AND		NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeK.NodeID#">)
		AND		href <> ''
	</cfquery>

	<cfreturn local.qryLink>
</cffunction>



<cffunction name="getArchive" output="false"  returnType="query" hint="Old versions of this node">
	<cfargument name="NodeID" required="true" type="string">
	
	
	<cfquery name="local.qryArchive">
		DECLARE @NodeID int
		SET     @NodeID = TRY_CONVERT(int, <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.NodeID#">)
		
	
		SELECT 	TOP 200 NodeArchiveID, NodeID, slug, CONVERT(date, VersionDate) AS ShortDate,
			VersionDate, ModifyBy, Kind, 
			T.title, DataSize
		
		FROM 	dbo.NodeArchive
		CROSS APPLY dbo.udf_gsRead(gsData)	T

				
		WHERE	Deleted = 0
		AND		(NodeID 	= @NodeID 	OR @NodeID = '')
				
		
		ORDER BY ShortDate DESC, VersionDate DESC
	</cfquery>
	
	
	
	<cfreturn local.qryArchive>
</cffunction>




<cffunction name="getLog" output="no" returnType="query">
	<cfargument name="kind" required="true" type="string">

	<cfquery name="local.qryRecentLogin">
		SELECT  TOP 100 Kind, address AS [by], [datetime], message, [type], tt AS ip
		FROM	dbo.DataLog WITH (NOLOCK)
		CROSS APPLY dbo.udf_xoxoRead(Created, DEFAULT)
		
		WHERE	1 = 1
		<cfif arguments.kind NEQ "">
    		AND	Kind LIKE <cfqueryparam CFSQLType="string" value="%#arguments.kind#%">		
    	</cfif>
    	
		ORDER BY [datetime] DESC
	</cfquery>
	
	<cfreturn local.qryRecentLogin>
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



<cffunction name="getDBSchema" output="false" returnType="query" hint="Dump of tables, if possible" >


	<cfquery name="local.qryPlugin">
		SELECT column_name, data_type, character_maximum_length, TABLE_SCHEMA, 
		table_name, ordinal_position, is_nullable 
		FROM information_schema.COLUMNS WITH (NOLOCK)
		
		ORDER BY table_name, ordinal_position
	</cfquery>

	<cfreturn local.qryPlugin>
</cffunction>


<cffunction name="getDBVersion" output="false" returnType="string" hint="SQL Version" >


	<cfquery name="local.qryDB">
		SELECT @@Version AS DBVersion
	</cfquery>

	<cfreturn local.qryDB.DBVersion>
</cffunction>



<cffunction name="getDBDSN" output="false" returnType="string" >

	<!--- CF 9 --->
	<cfreturn application.getApplicationSettings().datasource>
	
	<!--- CF 10 --->
	<cfreturn GetApplicationMetaData().datasource>
</cffunction>


</cfcomponent>

