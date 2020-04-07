SELECT
    firstName
  , lastName 
  , address
  , city
  , state
  , zip 
FROM Employees 
FOR SYSTEM_TIME ALL 
WHERE empID = 1;
