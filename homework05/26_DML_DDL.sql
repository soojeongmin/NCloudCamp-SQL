--1) STUDENT 테이블을 참조하여 ST_TEMP 테이블을 만들고 모든 학생의 성적을 4.5만점 기준으로 수정하세요
CREATE TABLE ST_TEMP
	AS SELECT * FROM STUDENT;

UPDATE ST_TEMP
	SET AVR = AVR*1.125;
	
SELECT * FROM ST_TEMP;

--2) PROFESSOR 테이블을 참조하여 PF_TEMP 테이블을 만들고 모든 교수의 부임일자를 100일 앞으로 수정하세요
CREATE TABLE PF_TEMP
	AS SELECT * FROM PROFESSOR;

UPDATE PF_TEMP
	SET HIREDATE = HIREDATE - 100;

SELECT * FROM PF_TEMP;


--3) ST_TEMP 테이블에서 화학과 2학년 학생의 정보를 삭제하세요
DELETE FROM ST_TEMP
	WHERE MAJOR = '화학' AND SYEAR = 2;

SELECT * FROM ST_TEMP;

--4) PF_TEMP 테이블에서 조교수의 정보를 삭제하세요
DELETE FROM PF_TEMP
	WHERE ORDERS = '조교수';

SELECT * FROM PF_TEMP;

--5) EMP 테이블을 참조하여 EMP2 테이블을 만들고 
-- DNO = 30인 사원의 보너스를 15프로 상승시킨 값으로 변경하시고 
-- DNO = 10인 사원의 보너스를 5프로 상승시킨 값으로 변경,
-- DNO = 20인 사원의 급여를 10프로 상승시킨 값으로 변경하세요.
CREATE TABLE EMP2
	AS SELECT * FROM EMP;

UPDATE EMP2 
	SET COMM = COMM * 1.15
	WHERE DNO = '30';

UPDATE EMP2 
	SET COMM = COMM * 1.05
	WHERE DNO = '10';

UPDATE EMP2 
	SET COMM = COMM * 1.10
	WHERE DNO = '20';

SELECT * FROM EMP2;

--6) 화학과 2학년 학생중 기말고사 성적의 등급이 A, B인 정보를 갖는 테이블 SCORE_STGR을 생성하세요.(SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT, GRADE)
DROP TABLE SCORE_STGR;

CREATE TABLE SCORE_STGR(SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT, GRADE)
	AS SELECT ST.SNO
			, ST.SNAME
			, ST.MAJOR
			, ST.SYEAR
			, C.CNO
			, C.CNAME
			, SC.RESULT
			, G.GRADE
		FROM STUDENT ST
		JOIN SCORE SC 
		ON ST.SNO = SC.SNO
		JOIN COURSE C
		ON C.CNO = SC.CNO
		JOIN SCGRADE G 
		ON SC.RESULT BETWEEN G.LOSCORE AND G.HISCORE
		WHERE ST.MAJOR = '화학'
		AND ST.SYEAR = 2
		AND G.GRADE IN ('A', 'B');
	
SELECT * FROM SCORE_STGR;

--7) 생물학과 학생중 평점이 2.7이상인 학생이 수강중인 과목의 정보를 갖는 테이블 ST_COURSEPF를 생성하세요. (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
CREATE TABLE ST_COURSEPF(SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
	AS SELECT ST.SNO
			, ST.SNAME
			, C.CNO
			, C.CNAME
			, P.PNO
			, P.PNAME
			, ST.AVR
		FROM PROFESSOR P
		JOIN COURSE C 
		ON P.PNO = C.PNO
		JOIN SCORE SC 
		ON SC.CNO = C.CNO
		JOIN STUDENT ST 
		ON ST.SNO = SC.SNO
		WHERE ST.MAJOR = '생물'
		AND ST.AVR >= 2.7;

SELECT * FROM ST_COURSEPF;
