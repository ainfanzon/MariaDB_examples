SELECT
  e1.eventID,e1.name,
  ( SELECT SUM(e2.tksSold) / COUNT(e2.tksSold)
    FROM concertEvents AS e2
    FOR SYSTEM_TIME ALL
    WHERE eventID=e1.eventID 
  ) AS 'Moving Avg'
FROM concertEvents AS e1
WHERE eventID = 1
GROUP BY e1.row_start;


SELECT
  e1.eventID,e1.name,
  ( SELECT SUM(tksSold) / COUNT(tksSold)
    FROM concertEvents 
    FOR SYSTEM_TIME ALL
    WHERE eventID=e1.eventID
  ) AS 'Moving Avg'
FROM concertEvents AS e1
WHERE eventID = 1
GROUP BY e1.row_start;


SELECT
    e1.eventID
  , e1.name
  , ( SELECT 
          SUM(tksSold) / COUNT(tksSold)
      FROM concertEvents
        FOR SYSTEM_TIME FROM '2019-08-19 15:39:56' TO '2019-08-19 16:32:51'
      WHERE eventID=e1.eventID   ) AS 'Moving Avg'
FROM concertEvents AS e1 
WHERE eventID = 1 
GROUP BY e1.row_start;
