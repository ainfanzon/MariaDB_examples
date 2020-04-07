SELECT 
    row_start
  , name
  , venue
  , perfDate
  , tksSold 
FROM concertEvents 
  FOR SYSTEM_TIME ALL;
