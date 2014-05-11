/* Creates all views */
/* For: MS SQL 2008 and above */


/*
Description:

For Tax, see udf_taxonomy read 

Question: Is there a reason you don't use getSimple?

*/


CREATE VIEW [dbo].[vwNode]
AS
SELECT  A.NodeID, A.[Root], A.Kind, A.Slug, A.Title, A.Parent, A.DataSize,

		A.ModifyBy, A.ModifyDate, A.CreateBy, A.CreateDate, A.Deleted, A.DeleteDate, 

		ISNULL(NodeArc.ArchiveCount, 0) AS ArchiveCount,
		
		GS.pubdate,	GS.meta, GS.metad,

		GS.menu, GS.menuorder, GS.menuStatus, GS.template, 
				
		GS.content, GS.private, GS.author,
		
		B.NodeCount,
		
		P.NodeID AS ParentNodeID, P.Title AS ParentTitle
				
FROM         dbo.Node AS A 
OUTER APPLY dbo.udf_gsRead(gsData)	GS


LEFT OUTER JOIN
				-- Parent info
                          (SELECT     NodeID, Title, Slug, CreateDate
                            FROM          dbo.Node WITH (NOLOCK)
							WHERE      (Deleted = 0)
							) AS P 
				ON A.[Parent] = P.slug 
							
							
				LEFT OUTER JOIN
								


				-- Number of children
                          (SELECT     Parent, COUNT(NodeID) AS NodeCount
                            FROM       dbo.Node AS Node_1 WITH (NOLOCK)
                            WHERE      (Deleted = 0)
                            GROUP BY Parent) AS B 
                ON A.Slug = B.Parent
                
                
                LEFT OUTER JOIN
				
				-- Number of backups
                          (SELECT     NodeID, COUNT(NodeID) AS ArchiveCount
                            FROM          dbo.NodeArchive WITH (NOLOCK)
                            WHERE      (Deleted = 0)
                            GROUP BY NodeID) AS NodeArc ON A.NodeID = NodeArc.NodeID 





CREATE VIEW [dbo].[vwNodeSort] AS


WITH RecursiveCTE( [Level] , Parent, slug )
AS
	(
	SELECT CONVERT( INT , 0 ) [Level]
		, Parent
		, Slug
	FROM dbo.Node WITH (NOLOCK)
	WHERE parent = ''

	UNION ALL

	SELECT CONVERT( INT , ( ct.[Level] + 1 ) ) [Level]
   		, pc.Parent
   		, pc.Slug
   	FROM dbo.Node pc
   	JOIN RecursiveCTE ct
    	ON pc.Parent = ct.Slug
		),
DataPlusLevel --
AS
(
SELECT [Level]
     , Parent
     , Slug
     , ROW_NUMBER() OVER ( ORDER BY [Level] , Parent, Slug) AS RowID
  FROM RecursiveCTE
),

DataPlusPath( [Level] , Parent , slug , RowID , SortCol )
AS
( -- Now I'm adding the "SortCol" which is just a string to be used so it ends up in the right order
SELECT dpl.[Level]
     , dpl.Parent
     , dpl.Slug
     , dpl.RowID
     , CONVERT( VARBINARY(MAX) , dpl.[RowID] ) as SortCol -- This is my psuedo sorting key
  FROM DataPlusLevel dpl
WHERE [Level] = 0 -- Anchor for this recursice CTE.

UNION ALL

SELECT dp2.[Level]
     , dp2.Parent
     , dp2.Slug -- I build this recursively too because it needs to add
     , dp2.RowID -- its' parent IDs as it goes..
     , CONVERT( VARBINARY(MAX) , ( SortCol + CONVERT( BINARY(4), dp2.[RowID] ) ) ) as SortCol
  FROM DataPlusLevel dp2
  JOIN DataPlusPath dpp
    ON dp2.Parent = dpp.slug
),

DataPlusRN -- Now I add a row number, grouping on the Parent name - this is for my "output"
AS
(
SELECT [Parent]
     , [Level]
     , [slug]
     , RowID
     , ROW_NUMBER() OVER ( PARTITION BY Parent ORDER BY RowID ) AS RowNum
     , SortCol
  FROM DataPlusPath
)

select [Level], Parent AS SortParent, Slug AS SortSlug, SortCol
from DataPlusRN

GO






/* 
Description: User information is expected to need to be extensible. It is more important to be able store a variety of user information that it is to be able to store the data so that it can be searched rapidly. The Personname format is based on rfc 6351 (https://tools.ietf.org/html/rfc6351)  
*/


CREATE VIEW [dbo].[vwUser] 

AS


SELECT   dbo.Users.UserID, login, passhash, slug,

	
		PersonName.value('(/vcard/n/prefix)[1]', 	'nvarchar(max)') AS prefix,
		PersonName.value('(/vcard/n/given)[1]', 	'nvarchar(max)') AS given,
		PersonName.value('(/vcard/n/additional)[1]','nvarchar(max)') AS additional,
		PersonName.value('(/vcard/n/family)[1]', 	'nvarchar(max)') AS family,
		PersonName.value('(/vcard/n/suffix)[1]', 	'nvarchar(max)') AS suffix,



		PersonName.value('(/vcard/org)[1]', 		'nvarchar(max)') AS org,
		PersonName.value('(/vcard/photo)[1]', 		'nvarchar(max)') AS photo,
		PersonName.value('(/vcard/url)[1]', 		'nvarchar(max)') AS url,
		PersonName.value('(/vcard/email)[1]', 		'nvarchar(max)') AS email,
		PersonName.value('(/vcard/title)[1]', 		'nvarchar(max)') AS title,

		PersonName.value('(/vcard/tel/uri[../parameters/text = "office"])[1]', 	'nvarchar(max)') AS officetel,
		PersonName.value('(/vcard/tel/uri[../parameters/text = "cell"])[1]', 	'nvarchar(max)') AS celltel,
		PersonName.value('(/vcard/tel/uri[../parameters/text = "fax"])[1]', 	'nvarchar(max)') AS faxtel,

		PersonName.value('(/vcard/adr/street)[1]', 	'nvarchar(max)') AS street,
		PersonName.value('(/vcard/adr/locality)[1]','nvarchar(max)') AS locality,
		PersonName.value('(/vcard/adr/region)[1]', 	'nvarchar(max)') AS region,
		PersonName.value('(/vcard/adr/code)[1]', 	'nvarchar(max)') AS code,
		PersonName.value('(/vcard/adr/country)[1]', 'nvarchar(max)') AS country,

		PersonName.value('(/vcard/tz/text)[1]', 	'nvarchar(max)') AS tz, /* timezone */
		PersonName.value('(/vcard/note)[1]', 		'nvarchar(max)') AS note,


		lastLogin, ExpirationDate, pStatus,
		xmlProfile,  xmlLink,  
		dbo.udf_xmlToStr(xmlGroup) AS Groups,
		xmlGroup, Active,
		Deleted, DeleteDate, 

		M.Address AS ModifyBy, M.Datetime AS ModifyDate, 
		C.Address AS CreateBy, M.Datetime AS CreateDate


FROM    dbo.Users WITH (NOLOCK)
OUTER APPLY dbo.udf_xoxoRead(Modified, DEFAULT)	M
OUTER APPLY dbo.udf_xoxoRead(Created, DEFAULT)	C






