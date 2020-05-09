DROP DATABASE IF EXISTS acme_emea;
CREATE DATABASE acme_emea;
USE acme_emea;

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

INSERT INTO acme_emea.dept
  (deptno, dname, loc)
VALUES
  (10, 'ACCOUNTING', 'ENGLAND'),
  (20, 'RESEARCH', 'GERMANY'),
  (30, 'SALES', 'FRANCE'),
  (40, 'OPERATIONS', 'ISRAEL'),
  (50, 'ENGENEERING', 'BULGARIA');

INSERT INTO emp
  ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
VALUES
  (9369,'MIA','CLERK',9902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20),
  (9499,'ADRIAN','SALESMAN',9698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30),
  (9521,'ERYK','SALESMAN',9698,STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500,30),
  (9566,'AXEL','MANAGER',9839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20),
  (9654,'MATTEO','SALESMAN',9698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30),
  (9698,'PHILLIPE','MANAGER',9839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30),
  (9782,'MARKUS','MANAGER',9839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10),
  (9788,'ISAK','ANALYST',9566,STR_TO_DATE('9-12-1982','%d-%m-%Y') - 85,3000,NULL,20),
  (9839,'ELKE', 'PRESIDENT', NULL,STR_TO_DATE ('17-11-1981','%d-%m-%Y'),5000,NULL,10),
  (9844,'AUDREY','SALESMAN',9698,STR_TO_DATE ('8-9-1981','%d-%m-%Y'),1500,0,30),
  (9876,'ADAMS','CLERK',9788,STR_TO_DATE ('13-6-87','%d-%m-%Y') ,1100,NULL,20),
  (9900,'ILLONA','CLERK',9698,STR_TO_DATE ('3-12-1981','%d-%m-%Y'),950,NULL,30),
  (9902,'KRISTOFFER','ANALYST',9566,STR_TO_DATE ('3-12-1981','%d-%m-%Y'),3000,NULL,20),
  (9934,'MILLER','CLERK',7782,STR_TO_DATE ('23-1-1982','%d-%m-%Y'),1300,NULL,10);

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
