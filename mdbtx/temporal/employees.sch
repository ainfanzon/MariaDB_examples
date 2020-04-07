DROP TABLE IF EXISTS Employees; 

CREATE TABLE Employees (
    empID INTEGER
  , firstName VARCHAR(100)
  , lastName VARCHAR(100)
  , address VARCHAR(100)
  , city VARCHAR(100)
  , state VARCHAR(50)
  , zip VARCHAR(20)
  , departmentName VARCHAR(20)  
  , startDate DATETIME NOT NULL
  , endDate DATETIME NOT NULL
  , PERIOD FOR appl_time (startDate, endDate)
);


SET @min_value = 1;
SET @max_value = 10;

LOAD DATA INFILE '/mdb/mdbtx/temporal/employees.csv'
  INTO TABLE Employees
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES   (
        empId
      , firstName
      , lastName
      , address
      , city
      , state
      , zip
      , departmentName
      , @startDate
      , @promiseDate
      , @endDate
      , @row_start
      , @row_end)
    SET   startDate = DATE_SUB( NOW(), INTERVAL FLOOR(@min_value + RAND() * (@max_value - @min_value +1)) YEAR)
        , endDate = DATE_ADD( NOW(), INTERVAL 20 YEAR);
