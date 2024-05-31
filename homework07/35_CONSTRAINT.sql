--1) SCORE 테이블과 동일한 구조를 갖는 SCORE_CHK를 생성하고 RESULT 60이상 90이하만 입력 가능하도록 하세요.
CREATE TABLE SCORE_CHK (
    SNO VARCHAR2(10),
    CNO VARCHAR2(10),
    RESULT NUMBER(3) CHECK (RESULT BETWEEN 60 AND 90)
);

INSERT INTO SCORE_CHK (SNO, CNO, RESULT)
SELECT SNO, CNO, RESULT FROM SCORE WHERE RESULT BETWEEN 60 AND 90;

--2) STUDENT 테이블과 동일한 구조를 갖는 STUDENT_COPY 테이블을 생성하면서 SNO은 PK로 SNAME은 NOT NULL로 SYEAR의 DEFAULT는 1로 
--   설정하세요.
CREATE TABLE STUDENT_COPY (
    SNO NUMBER(10) PRIMARY KEY,
    SNAME VARCHAR2(10) NOT NULL,
    SYEAR NUMBER(2) DEFAULT 1
);

--3) COURSE 테이블과 동일한 구조를 갖는 COURSE_CONTSRAINT 테이블을 생성하면서 CNO, CNAME을 PK로 PNO은 PROFESSOR_PK의 PNO을 참조하여
--   FK로 설정하고 ST_NUM은 DEFAULT 2로 설정하세요.
CREATE TABLE PROFESSOR_PK
AS SELECT * FROM PROFESSOR;

ALTER TABLE PROFESSOR_PK
ADD CONSTRAINT PK_PROFESSOR_PK_PNO PRIMARY KEY(PNO);

CREATE TABLE COURSE_CONSTRAINT(
    CNO NUMBER(10),
    CNAME VARCHAR2(20),
    PNO VARCHAR2(10),
    ST_NUM NUMBER(10) DEFAULT 2,
    CONSTRAINT PK_COURSE_CONSTRAINT PRIMARY KEY (CNO, CNAME),
    CONSTRAINT FK_COURSE_CONSTRAINT_PNO FOREIGN KEY(PNO) REFERENCES PROFESSOR_PK(PNO)
);