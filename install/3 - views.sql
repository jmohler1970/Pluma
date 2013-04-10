/* Creates all views */






CREATE VIEW [dbo].[vwNode]
AS
SELECT     A.NodeID, A.ParentNodeID, A.PrimaryRecord, A.[Root], A.Kind, A.Slug,
 
				TT.extra, TT.title, TT.subtitle, TT.[description], TT.isbn,

				Tax.menu, Tax.menustatus, Tax.menusort, Tax.tags,
				
				P.parenttitle,
				
				P.Slug AS ParentSlug,
				P.CreateDate AS ParentCreateDate,

				A.strData, A.xmlData, A.pinned, A.pStatus, A.cStatus, 
				A.StartDate, A.ExpirationDate, A.CommentMode, 
				A.NoDelete, A.Deleted, A.DeleteDate, 
				A.Modified, M.[By] AS ModifyBy, M.[datetime] AS ModifyDate, 
				A.Created, C.[By] AS CreateBy, C.[datetime] AS CreateDate,
				
				B.NodeCount,
				ISNULL(NodeArc.ArchiveCount, 0) AS ArchiveCount, 
                
				A.xmlConf.value('/data[1]/@showheader', 'nvarchar(max)') AS showheader, 
				A.xmlConf.value('/data[1]/@startrow', 'nvarchar(max)') AS startrow, 
                A.xmlConf.value('/data[1]/@startcol', 'nvarchar(max)') AS startcol, 
				A.xmlConf.value('/plugin_content[1]', 'nvarchar(max)') AS plugin_content, 
				A.xmlConf.value('/theme_template[1]', 'nvarchar(max)') AS theme_template, 
				A.xmlConf.value('/href[1]', 'nvarchar(max)') AS href,
				A.xmlConf.value('/map[1]', 'nvarchar(max)') AS map,
				A.xmlConf.value('/location[1]', 'nvarchar(max)') AS location,
				A.xmlConf.value('/redirect[1]', 'nvarchar(max)') AS redirect, 
                A.xmlConf.value('/youtube[1]', 'nvarchar(max)') AS youtube, 
				A.xmlConf.value('/notes[1]', 'nvarchar(max)') AS notes, 
				A.xmlConf.value('/src[1]', 'nvarchar(max)') AS src,
				
				-- Short cut, does not do inherit
				A.xmlSecurity.value('/security[@role="Owner"][1]/@id', 'nvarchar(max)') AS OwnerID,
				A.xmlSecurity.value('/security[@role="Group"][1]/@id', 'nvarchar(max)') AS [Group],
				A.xmlSecurity.exist('/security[@role="Public"][1]') AS PublicAccess,
				 

				A.SortOrder, A.xmlConf,  A.xmlLink, A.xmlTaxonomy, A.xmlSecurity,

				A.DataSize
FROM         dbo.Node AS A 
CROSS APPLY dbo.udf_titleRead(xmlTitle)	TT
CROSS APPLY dbo.udf_taxonomyRead(xmlTaxonomy)	Tax
CROSS APPLY dbo.udf_4jRead(Modified)	M
CROSS APPLY dbo.udf_4jRead(Created)		C


LEFT OUTER JOIN
				-- Parent info
                          (SELECT     NodeID, Slug, PT.Title AS ParentTitle,  PC.[datetime] AS CreateDate
                            FROM          dbo.Node WITH (NOLOCK)
							CROSS APPLY dbo.udf_titleRead(xmlTitle)	PT
							CROSS APPLY dbo.udf_4jRead(Created)	PC
							WHERE      (Deleted = 0)) AS P ON A.ParentNodeID = P.NodeID 
							
							
							LEFT OUTER JOIN
					
			


				-- Number of children
                          (SELECT     ParentNodeID, COUNT(NodeID) AS NodeCount
                            FROM          dbo.Node AS Node_1 WITH (NOLOCK)
                            WHERE      (Deleted = 0)
                            GROUP BY ParentNodeID) AS B ON A.NodeID = B.ParentNodeID LEFT OUTER JOIN
				
				-- Number of backups
                          (SELECT     NodeID, COUNT(NodeID) AS ArchiveCount
                            FROM          dbo.NodeArchive WITH (NOLOCK)
                            WHERE      (Deleted = 0)
                            GROUP BY NodeID) AS NodeArc ON A.NodeID = NodeArc.NodeID 



GO





CREATE VIEW [dbo].[vwNodeSort] AS




WITH RecursiveCTE( [Level] , ParentNodeID, NodeID )
AS 
( 
SELECT CONVERT( INT , 0 ) [Level] 
     , ParentNodeID
     , NodeID 
  FROM dbo.Node  WITH (NOLOCK)
WHERE	ParentNodeID IN (Select NodeID FROM dbo.Node  WITH (NOLOCK) WHERE PrimaryRecord = 1)

UNION ALL
SELECT CONVERT( INT , ( ct.[Level] + 1 ) ) [Level]
     , pc.ParentNodeID
     , pc.NodeID
  FROM dbo.Node     pc
  JOIN RecursiveCTE    ct
    ON pc.ParentNodeID     = ct.NodeID 
),
 DataPlusLevel -- 
AS 
(
SELECT [Level]
     , ParentNodeID
     , NodeID
     , ROW_NUMBER() OVER ( ORDER BY [Level] , ParentNodeID , NodeID ) AS RowID
  FROM RecursiveCTE 
), 

DataPlusPath( [Level] , ParentNodeID , NodeID , RowID , SortCol )
AS
( -- Now I'm adding the "SortCol" which is just a string to be used so it ends up in the right order
SELECT dpl.[Level]
     , dpl.ParentNodeID 
     , dpl.NodeID
     , dpl.RowID
     , CONVERT( VARBINARY(MAX) , dpl.[RowID] ) as SortCol -- This is my psuedo sorting key
  FROM DataPlusLevel       dpl
 WHERE [Level] = 0 -- Anchor for this recursice CTE.
UNION ALL
SELECT dp2.[Level]
     , dp2.ParentNodeID
     , dp2.NodeID                      -- I build this recursively too because it needs to add 
     , dp2.RowID                      -- its' parent IDs as it goes..
     , CONVERT( VARBINARY(MAX) , ( SortCol + CONVERT( BINARY(4), dp2.[RowID] ) ) ) as SortCol 
  FROM DataPlusLevel       dp2
  JOIN DataPlusPath        dpp
    ON dp2.ParentNodeID        = dpp.NodeID
), 

DataPlusRN -- Now I add a row number, grouping on the Parent name - this is for my "output"
AS
(
SELECT [ParentNodeID]
     , [Level]
     , [NodeID]
     , RowID
     , ROW_NUMBER() OVER ( PARTITION BY ParentNodeID ORDER BY RowID ) AS RowNum
     , SortCol
  FROM DataPlusPath
)

select [Level], ParentNodeID AS SortParentNodeID, NodeID AS SortNodeID, SortCol
from DataPlusRN 

GO



CREATE VIEW [dbo].[vwUser] 
AS

SELECT   dbo.Users.UserID, login, passhash, 
		PersonName.value('(/PersonName/GivenName)[1]', 'nvarchar(max)') AS firstname,
		PersonName.value('(/PersonName/MiddleName)[1]', 'nvarchar(max)') AS middlename,
		PersonName.value('(/PersonName/FamilyName)[1]', 'nvarchar(max)') AS lastname,
		PersonName.value('(/PersonName/Affix)[1]', 'nvarchar(max)') AS postfix,

		homepath, 
	
		
		lastLogin, 
		ExpirationDate, xmlAbout, xmlProfile, xmlContact, xmlLink,  
        email,  comments, 
		dbo.udf_xmlToStr(xmlGroup) AS Groups,
		xmlGroup, Active,
		PrefGroup, Deleted, DeleteDate, 
		
		M.Datetime AS ModifyDate, M.[By] AS ModifyBy, C.[By] AS CreateDate, M.[Datetime] AS CreateBy,

		xmlPref.value('(/data/@type="php")[1]', 'nvarchar(max)') AS PHP,
		xmlPref.value('(/data/@type="stars")[1]', 'nvarchar(max)') AS Stars,
		xmlPref.value('(/data/@type="membershiptype")[1]', 'nvarchar(max)') AS Membershiptype,
		xmlPref.value('(/data/@type="commentmode")[1]', 'nvarchar(max)') AS CommentMode,
		xmlPref.value('(/data/@type="personalstatus")[1]', 'nvarchar(max)') AS PersonalStatus



FROM         dbo.Users WITH (NOLOCK)

CROSS APPLY dbo.udf_4jRead(Modified)	M
CROSS APPLY dbo.udf_4jRead(Created)		C



GO



