UPDATE Employees
  FOR PORTION OF appl_time 
FROM '2018-01-01' to '2018-06-30'
  SET departmentName = 'Marketing' 
WHERE empId = 2;
