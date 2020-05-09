DROP DATABASE IF EXISTS acme_apac;
CREATE DATABASE acme_apac;
USE acme_apac;

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

INSERT INTO acme_apac.dept
  (deptno, dname, loc)
VALUES
  (10, 'ACCOUNTING', 'JAPAN'),
  (20, 'RESEARCH', 'INDIA'),
  (30, 'SALES', 'AUSTRALIA'),
  (40, 'OPERATIONS', 'AUSTRALIA');

INSERT INTO emp
  ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
VALUES
  (6369,'ARJUN','CLERK',6902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20),
  (6499,'ALLEN','SALESMAN',6698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30),
  (6521,'SANJAY','SALESMAN',6698,STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500,30),
  (6566,'KARAN','MANAGER',6839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20),
  (6654,'MARTIN','SALESMAN',6698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30),
  (6698,'KAAKALEE','MANAGER',6839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30),
  (6782,'CLARK','MANAGER',6839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10),
  (6788,'DINGXIANG','ANALYST',6566,STR_TO_DATE('9-12-1982','%d-%m-%Y') - 85,3000,NULL,20),
  (6839,'AKANE', 'PRESIDENT', NULL,STR_TO_DATE ('17-11-1981','%d-%m-%Y'),5000,NULL,10),
  (6844,'MICHAEL','SALESMAN',6698,STR_TO_DATE ('8-9-1981','%d-%m-%Y'),1500,0,30),
  (6876,'RAIDEN','CLERK',6788,STR_TO_DATE ('13-6-87','%d-%m-%Y') ,1100,NULL,20),
  (6900,'ICHIRO','CLERK',6698,STR_TO_DATE ('3-12-1981','%d-%m-%Y'),950,NULL,30),
  (6902,'RUSSELL','ANALYST',6566,STR_TO_DATE ('3-12-1981','%d-%m-%Y'),3000,NULL,20),
  (6934,'JACKIE','CLERK',6782,STR_TO_DATE ('23-1-1982','%d-%m-%Y'),1300,NULL,10);

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
