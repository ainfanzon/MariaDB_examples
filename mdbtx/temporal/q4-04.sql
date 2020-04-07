UPDATE Employees
  FOR PORTION OF appl_time
  FROM '2016-01-01' to '2016-06-30'
SET departmentName = 'Marketing'
WHERE empId = 1;
