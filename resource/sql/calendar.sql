IF EXISTS (SELECT * FROM information_schema.tables WHERE Table_Name = 'Calendar' AND Table_Type = 'BASE TABLE')
BEGIN
DROP TABLE [Calendar]
END

CREATE TABLE [Calendar]
(
    [CalendarDate] DATE NOT NULL PRIMARY KEY
)

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = DateAdd(yy, -10, GETDATE())
SET @EndDate = DATEADD(yy, 50, @StartDate)

WHILE @StartDate <= @EndDate
      BEGIN
             INSERT INTO [Calendar]
             (
                   CalendarDate
             )
             SELECT
                   @StartDate

             SET @StartDate = DATEADD(dd, 1, @StartDate)
      END