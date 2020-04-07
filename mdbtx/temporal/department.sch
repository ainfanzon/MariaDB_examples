DROP TABLE IF EXISTS department;

CREATE TABLE department (
    deptID INT NOT NULL AUTO_INCREMENT
  , deptName VARCHAR(50) NOT NULL
  , managerID INT NULL
  , parentDeptID INT NULL
  , PRIMARY KEY ( deptID )
) WITH SYSTEM VERSIONING;

INSERT INTO department (deptID, deptName, managerID, parentDeptID) VALUES
   (0,'Engineering',4532,2)
 , (0,'Human Resources',5847,3)
 , (0,'Marketing',4893,4);

