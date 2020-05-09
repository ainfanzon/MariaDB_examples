DROP DATABASE IF EXISTS acme_amer;
CREATE DATABASE acme_amer;
USE acme_amer;

DROP TABLE IF EXISTS dept;
CREATE TABLE dept
(
    deptno   TINYINT NOT NULL 
  , dname    VARCHAR(14)
  , loc      VARCHAR(13)
  , PRIMARY KEY ( deptno )
) ENGINE=InnoDB;

DROP TABLE IF EXISTS emp;
CREATE TABLE emp
(
    empno      SMALLINT NOT NULL PRIMARY KEY
  , ename      VARCHAR(10)
  , job        VARCHAR(9)
  , mgr        SMALLINT
  , hiredate   DATETIME
  , sal        DECIMAL(7, 2)
  , comm       DECIMAL(7, 2)
  , deptno     TINYINT
  , CONSTRAINT `fk_dept_emp` 
      FOREIGN KEY (deptno) REFERENCES dept ( deptno )
      ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB;

INSERT INTO acme_amer.dept
  (deptno, dname, loc)
VALUES
  (10, 'ACCOUNTING', 'NEW YORK'),
  (20, 'RESEARCH', 'DALLAS'),
  (30, 'SALES', 'CHICAGO'),
  (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp
  ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
VALUES
  (7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20),
  (7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30),
  (7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500,30),
  (7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20),
  (7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30),
  (7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30),
  (7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10),
  (7788,'SCOTT','ANALYST',7566,STR_TO_DATE('9-12-1982','%d-%m-%Y') - 85,3000,NULL,20),
  (7839,'KING', 'PRESIDENT', NULL,STR_TO_DATE ('17-11-1981','%d-%m-%Y'),5000,NULL,10),
  (7844,'TURNER','SALESMAN',7698,STR_TO_DATE ('8-9-1981','%d-%m-%Y'),1500,0,30),
  (7876,'ADAMS','CLERK',7788,STR_TO_DATE ('13-6-87','%d-%m-%Y') ,1100,NULL,20),
  (7900,'JAMES','CLERK',7698,STR_TO_DATE ('3-12-1981','%d-%m-%Y'),950,NULL,30),
  (7902,'FORD','ANALYST',7566,STR_TO_DATE ('3-12-1981','%d-%m-%Y'),3000,NULL,20),
  (7934,'MILLER','CLERK',7782,STR_TO_DATE ('23-1-1982','%d-%m-%Y'),1300,NULL,10);

DROP TABLE IF EXISTS bonus;
CREATE TABLE bonus
(
    ename   VARCHAR(10)
  , job     VARCHAR(9)
  , sal     DOUBLE
  , comm    DOUBLE
) ENGINE=INNODB; 

DROP TABLE IF EXISTS salgrade;
CREATE TABLE salgrade
(
    grade TINYINT
  , losal DOUBLE
  , hisal DOUBLE
) ENGINE=InnoDB;

INSERT INTO salgrade
  ( grade, losal, hisal )
VALUES
  (1, 700, 1200),
  (2, 1201, 1400),
  (3, 1401, 2000),
  (4, 2001, 3000),
  (5, 3001, 9999);
