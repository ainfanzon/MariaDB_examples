SELECT 
    empID
  , firstName
  , lastName
  , address
  , city
  , state
  , zip
  , departmentName
  , startDate
  , endDate 
FROM Employees 
WHERE empID = 1 
ORDER BY startDate;
