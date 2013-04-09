USE [mWWI]
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
DROP PROCEDURE [dbo].[usp_TrafficReferer]
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creates all stored procedures


CREATE PROCEDURE
  [dbo].[usp_TrafficReferer]
(
  @startDate date,
  @endDate date,
  @serverName varchar(80)

)
AS	

BEGIN
		SELECT 	CONVERT(date, CreateDate) AS CreateDate, referer AS Item, ISNULL(remote_addr, 0) AS remote_addr
		INTO 	#tempTraffic
		FROM 	dbo.Traffic WITH (NOLOCK)
		WHERE 	Createdate BETWEEN @startDate AND @endDate
		AND	NOT Referer LIKE '%' + @serverName + '%'
		AND NOT Referer LIKE '%localhost%'
		AND NOT Referer = ''
		
			
	
		SELECT Area, AreaSort, Item, CalendarDate, isNull(Visitor, 0) AS Visitor, ISNULL(Hit,0) AS Hit
		FROM	dbo.Calendar LEFT JOIN 
			(
	
	
		
			SELECT AreaSort = 10, 'Referer' AS Area, FullGrid.Item AS Item, FullGrid.CalendarDate AS CreateDate,
			
					COUNT(DISTINCT remote_addr) AS visitor, 
					COUNT(remote_addr) as hit
			
			FROM  (
				SELECT DISTINCT CalendarDate, Item
				FROM dbo.Calendar, #TempTraffic
				WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
				) FullGrid 
					
			LEFT JOIN #TempTraffic AS DataItem
				ON FullGrid.CalendarDate = CreateDate
				AND FullGrid.Item = DataItem.Item		
							
			GROUP BY FullGrid.Item, FullGrid.CalendarDate
						
			
			
			) AS SummaryDetail
			
		ON 	CalendarDate = SummaryDetail.CreateDate
		
		WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
		AND AreaSort IS NOT NULL	
		
		ORDER BY AreaSort, Item, CalendarDate

END;
GO


/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
DROP PROCEDURE [dbo].[usp_TrafficOrganic]
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creates all stored procedures


CREATE PROCEDURE
  [dbo].[usp_TrafficOrganic]
(
  @startDate date,
  @endDate date

)
AS	

BEGIN
	
		SELECT 	CONVERT(date, CreateDate) AS CreateDate, url_vars.value('(search)[1]', 'nvarchar(max)') AS Item, remote_addr
		INTO 	#tempTraffic
		FROM 	dbo.Traffic WITH (NOLOCK)
		
		WHERE 	Createdate BETWEEN @startDate AND @endDate
		AND		url_vars.exist('.[search]') = 1		
	
	
		SELECT Area, AreaSort, Item, CalendarDate, isNull(Visitor, 0) AS Visitor, ISNULL(Hit,0) AS Hit
		FROM	dbo.Calendar LEFT JOIN 
			(
	
	
		
			SELECT AreaSort = 10, 'Search' AS Area, FullGrid.Item AS Item, FullGrid.CalendarDate AS CreateDate,
			
					COUNT(DISTINCT remote_addr) AS visitor, 
					COUNT(remote_addr) as hit
			
			FROM  (
				SELECT DISTINCT CalendarDate, Item
				FROM dbo.Calendar, #TempTraffic
				WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
				) FullGrid 
					
			LEFT JOIN #TempTraffic AS DataItem
				ON FullGrid.CalendarDate = CreateDate
				AND FullGrid.Item = DataItem.Item		
							
			GROUP BY FullGrid.Item, FullGrid.CalendarDate
						
			
			
			) AS SummaryDetail
			
		ON 	CalendarDate = SummaryDetail.CreateDate
		
		WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
		AND AreaSort IS NOT NULL	
		
		ORDER BY AreaSort, Item, CalendarDate
END;
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
DROP PROCEDURE [dbo].[usp_TrafficCountry]
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creates all stored procedures


CREATE PROCEDURE
  [dbo].[usp_TrafficCountry]
(
  @startDate date,
  @endDate date

)
AS	

BEGIN
	
		SELECT 	CONVERT(date, CreateDate) AS CreateDate, CountryName + ' : ' + RegionName AS Item, remote_addr
		INTO 	#tempTraffic
		FROM 	dbo.Traffic WITH (NOLOCK)
		
		WHERE 	Createdate BETWEEN @startDate AND @endDate
		AND		CountryName <> ''
		AND		RegionName <> ''
			
	
		SELECT Area, AreaSort, Item, CalendarDate, isNull(Visitor, 0) AS Visitor, ISNULL(Hit,0) AS Hit
		FROM	dbo.Calendar LEFT JOIN 
			(
	
	
		
			SELECT AreaSort = 10, 'Country / Region' AS Area, FullGrid.Item AS Item, FullGrid.CalendarDate AS CreateDate,
			
					COUNT(DISTINCT remote_addr) AS visitor, 
					COUNT(remote_addr) as hit
			
			FROM  (
				SELECT DISTINCT CalendarDate, Item
				FROM dbo.Calendar, #TempTraffic
				WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
				) FullGrid 
					
			LEFT JOIN #TempTraffic AS DataItem
				ON FullGrid.CalendarDate = CreateDate
				AND FullGrid.Item = DataItem.Item		
							
			GROUP BY FullGrid.Item, FullGrid.CalendarDate
						
			
			
			) AS SummaryDetail
			
		ON 	CalendarDate = SummaryDetail.CreateDate
		
		WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
		AND AreaSort IS NOT NULL	
		
		ORDER BY AreaSort, Item, CalendarDate

END;
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
DROP PROCEDURE [dbo].[usp_TrafficOS]
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creates all stored procedures


CREATE PROCEDURE
  [dbo].[usp_TrafficOS]
(
  @startDate date,
  @endDate date

)
AS	

BEGIN
	
		SELECT 	CONVERT(date, CreateDate) AS CreateDate, OS + ' : ' + Browser AS Item, ISNULL(remote_addr, 1) AS remote_addr
		INTO 	#tempTraffic
		FROM 	dbo.Traffic WITH (NOLOCK)
		
		WHERE 	Createdate BETWEEN @startDate AND @endDate
		AND		Item <> ''
		
	
	
		SELECT Area, AreaSort, Item, CalendarDate, isNull(Visitor, 0) AS Visitor, ISNULL(Hit,0) AS Hit
		FROM	dbo.Calendar LEFT JOIN 
			(
	
	
		
			SELECT AreaSort = 10, 'OS / Browser' AS Area, FullGrid.Item AS Item, FullGrid.CalendarDate AS CreateDate,
			
					COUNT(DISTINCT remote_addr) AS visitor, 
					COUNT(remote_addr) as hit
			
			FROM  (
				SELECT DISTINCT CalendarDate, Item
				FROM dbo.Calendar, #TempTraffic
				WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
				) FullGrid 
					
			LEFT JOIN #TempTraffic AS DataItem
				ON FullGrid.CalendarDate = CreateDate
				AND FullGrid.Item = DataItem.Item		
							
			GROUP BY FullGrid.Item, FullGrid.CalendarDate
						
			
			
			) AS SummaryDetail
			
		ON 	CalendarDate = SummaryDetail.CreateDate
		
		WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
		AND AreaSort IS NOT NULL	
		
		ORDER BY AreaSort, Item, CalendarDate


END;
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
DROP PROCEDURE [dbo].[usp_TrafficDetails]
GO

/****** Object:  StoredProcedure [dbo].[usp_TrafficDetails]    Script Date: 1/5/2013 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creates all stored procedures


CREATE PROCEDURE
  [dbo].[usp_TrafficDetails]
(
  @startDate date,
  @endDate date

)
AS	

BEGIN
	
	--DROP TABLE #tempTraffic
	--GO
	
	SELECT 	CONVERT(date, CreateDate) AS CreateDate, 
		CASE 
		WHEN isPost = 1 THEN [Section] + '.' + Item + ' (post)'
		ELSE [Section] + '.' + Item
		END AS Item, isBot, ISNULL(remote_addr, 0) AS remote_addr
	INTO 	#tempTraffic
	FROM 	dbo.Traffic WITH (NOLOCK)
	
	WHERE 	Createdate BETWEEN @startDate AND @endDate
	AND		Item <> ''
	


	SELECT Area, AreaSort, Item, CalendarDate, isNull(Visitor, 0) AS Visitor, ISNULL(Hit,0) AS Hit
	FROM	dbo.Calendar LEFT JOIN 
		(


		SELECT AreaSort = 1, 'Summary' AS Area, 'Total Hits/Visits' AS Item, CreateDate,
		
			COUNT(DISTINCT remote_addr) AS visitor, 
			COUNT(remote_addr) as hit
					
		FROM 	#TempTraffic
		GROUP BY CreateDate
		
		
		
		
		UNION ALL
		
		
		SELECT AreaSort = 3, 'Summary' AS Area, 'Human Hits/Visits' AS Item, CreateDate,
		
			COUNT(DISTINCT CASE WHEN isBot = 0 THEN remote_addr ELSE NULL END) AS visitor, 
			SUM(CASE WHEN isBot = 0 THEN 1 ELSE 0 END) as hit
					
		FROM 	#TempTraffic
		GROUP BY CreateDate
		
		
		
		
		UNION ALL
		
		
		SELECT AreaSort = 5,'Summary' AS Area, 'Bot Hits/Visits' AS Item, CreateDate,
		
			COUNT(DISTINCT CASE WHEN isBot = 1 THEN remote_addr ELSE NULL END) AS visitor, 
			SUM(CASE WHEN isBot = 1 THEN 1 ELSE 0 END) as hit
			
		FROM 	#TempTraffic
		GROUP BY CreateDate
	
		
		UNION ALL
	
		SELECT AreaSort = 10, 'Page' AS Area, FullGrid.Item AS Item, FullGrid.CalendarDate AS CreateDate,
		
				COUNT(DISTINCT CASE WHEN isBot = 1 THEN remote_addr ELSE NULL END) AS visitor, 
				SUM(CASE WHEN isBot = 1 THEN 1 ELSE 0 END) as hit
		
		FROM  (
			SELECT DISTINCT CalendarDate, Item
			FROM dbo.Calendar, #TempTraffic
			WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
			AND		Createdate BETWEEN @startDate AND @endDate
			) FullGrid 
				
		LEFT JOIN #TempTraffic AS DataItem
			ON FullGrid.CalendarDate = CreateDate
			AND FullGrid.Item = DataItem.Item		
						
		GROUP BY FullGrid.Item, FullGrid.CalendarDate
					
		
		
		) AS SummaryDetail
		
	ON 	CalendarDate = SummaryDetail.CreateDate
	
	WHERE 	CalendarDate  BETWEEN @startDate AND @endDate
	AND AreaSort IS NOT NULL	
	
	ORDER BY AreaSort, Item, CalendarDate
		
END;		
		
GO


