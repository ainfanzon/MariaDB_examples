SELECT
    firstName
  , lastName
  , address
  , departmentName
  , startDate
  , row_start 
FROM Employees 
FOR SYSTEM_TIME ALL  
WHERE empID = 2 ORDER BY row_start;
