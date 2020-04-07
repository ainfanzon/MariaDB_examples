DELIMITER $$

CREATE OR REPLACE PACKAGE dbsample.employee_tools AS
  FUNCTION getSalary(eid INT) RETURN DECIMAL(10,2);
  PROCEDURE raiseSalary(eid INT, amount DECIMAL(10,2));
  PROCEDURE raiseComm(eid INT, pct INTEGER);
  PROCEDURE hire(vEmpno smallint(6), vEname varchar(10), vJob varchar(9), vMgr smallint(6), vHiredate datetime, vSal decimal(7,2), vComm decimal(7,2), vDeptno tinyint(4));
END;
$$
CREATE PACKAGE BODY employee_tools AS
  -- package body variables
  stdRaiseAmount DECIMAL(10,2):=500;

  -- private routines
  PROCEDURE log (eid INT, ecmnt TEXT) AS
  BEGIN
    INSERT INTO employee_log (id, cmnt) VALUES (eid, ecmnt);
  END;

  -- public routines
  PROCEDURE hire(
      vEmpno smallint(6)
    , vEname varchar(10)
    , vJob varchar(9)
    , vMgr smallint(6)
    , vHiredate datetime
    , vSal decimal(7,2)
    , vComm decimal(7,2)
    , vDeptno tinyint(4)
  ) AS
    eid INT;
  BEGIN
    INSERT INTO emp VALUES (vEmpno, vEname, vJob, vMgr, vHiredate, vSal, vComm, vDeptno);
    eid:= last_insert_id();
    log(eid, 'hire ' || vEname);
  END;

  FUNCTION getSalary(eid INT) RETURN DECIMAL(10,2) AS
    nSalary DECIMAL(10,2);
  BEGIN
    SELECT sal INTO nSalary FROM emp WHERE empno=eid;
    log(eid, 'getSalary id=' || eid || ' salary=' || nSalary);
    RETURN nSalary;
  END;

  PROCEDURE raiseSalary(vEmpno smallint(6), amount DECIMAL(10,2)) AS
  BEGIN
    UPDATE emp SET sal=sal+amount WHERE empno=vEmpno;
    log(vEmpno, 'raiseSalary id=' || vEmpno || ' amount=' || amount);
  END;

  PROCEDURE raiseComm(vEmpno INT, pct INTEGER) AS
  BEGIN
    UPDATE emp SET comm=comm*(1+(pct/100)) WHERE empno=vEmpno;
    log(vEmpno, 'raiseComm id=' || vEmpno);
  END;

BEGIN
  -- This code is executed when the current session
  -- accesses any of the package routines for the first time
  log(0, 'Session ' || connection_id() || ' ' || current_user || ' started');
END;
$$

DELIMITER ;
