-- 1. CONSTRAINT(제약조건): 제약조건은 데이터의 정확성과 무결성을 보장해주는 데이터를 저장하는 규칙
-- 						 제약조건에는 PK, FK, UK, NOT NULL, DEFAULT, CHECK 등이 존재한다.
-- 1-1. PK(PRIMARY KEY): 테이블에 식별자 역할을 하는 컬럼을 지정
--					     PK로 지정된 컬럼의 데이터는 유일해야 하며(UK), 색인 역할도 하며(INDEX),
--						 NULL값이 저장될 수 없다(NOT NULL).
-- 단일 컬럼 PK인 테이블 생성
CREATE TABLE EMP_PK1 (
	-- 시스템에서 제약조건명을 자동으로 생성
	ENO NUMBER(4) PRIMARY KEY,
	ENAME VARCHAR2(20),
	JOB VARCHAR2(10),
	HDATE DATE,
	DNO NUMBER(2)
);

-- PK로 설정된 컬럼의 데이터는 유일한 값(UK)을 가져야 하기 때문에 중복된 데이터를 저장할 수 없다.
INSERT INTO EMP_PK1
VALUES (1, '고기천', '개발', SYSDATE, 1);
COMMIT;

INSERT INTO EMP_PK1
VALUES (1, '임꺽정', '분석', SYSDATE, 2);

-- PK로 설정된 데이터는 NULL 값을 가질 수 없다.(NOT NULL)
INSERT INTO EMP_PK1
VALUES (NULL, '임꺽정', '분석', SYSDATE, 2);

INSERT INTO EMP 
VALUES (NULL, '임꺽정', '회계', NULL, SYSDATE, 5000, 600, NULL);
INSERT INTO EMP 
VALUES ('9999', '임꺽정', '회계', NULL, SYSDATE, 5000, 600, NULL);
COMMIT;

-- 제약조건명을 달아서 PK 생성
CREATE TABLE STUDENT_PK1 (
	SNO NUMBER(6) CONSTRAINT STUDENT_SNO_PK PRIMARY KEY,
	SNAME VARCHAR2(20),
	MAJOR VARCHAR2(10),
	SYEAR NUMBER(1)
);

-- 테이블을 생성하면서 컬럼을 모두 지정 후에 PK 지정
CREATE TABLE DEPT_PK1(
	DNO NUMBER(2),
	DNAME VARCHAR2(10),
	LOC VARCHAR2(10),
	DIRECTOR NUMBER(4),
	CONSTRAINT DEPT_DNO_PK PRIMARY KEY(DNO)
);

-- 다중 컬럼 PK 지정
-- 모든 테이블에서 PK는 한 번만 지정할 수 있다.
CREATE TABLE PROFESSOR_PK1(
	PNO NUMBER(4),
	PNAME VARCHAR2(20),
	SECTION VARCHAR2(10),
	ORDERS VARCHAR2(10),
	HIREDATE DATE,
	CONSTRAINT PK_PROFESSOR_PNO_PNAME PRIMARY KEY(PNO, PNAME)
);

-- 다중 컬럼으로 PK를 지정하게 되면 PK로 지정된 컬럼들을 데이터 셋으로 묶어서 PK로 인식한다.
-- PK로 지정된 컬럼들의 데이터 모두 중복돼야 중복으로 인식한다.
INSERT INTO PROFESSOR_PK1
VALUES (1, '고기천', '화학', '정교수', SYSDATE);
COMMIT;

INSERT INTO PROFESSOR_PK1
VALUES (1, '홍길동', '생물', '부교수', SYSDATE);
COMMIT;

INSERT INTO PROFESSOR_PK1
VALUES (1, '고기천', '물리', '부교수', SYSDATE);

-- PK로 지정된 모든 컬럼에 NULL 값은 허용되지 않는다.
INSERT INTO PROFESSOR_PK1
VALUES (NULL, '고기천', '물리', '부교수', SYSDATE);

INSERT INTO PROFESSOR_PK1
VALUES (2, NULL, '물리', '부교수', SYSDATE);


CREATE TABLE BOARD(
	BOARD_NO NUMBER(10),
	BOARD_TITLE VARCHAR2(1000),
	CONSTRAINT PK_BOARD_BOARD_NO PRIMARY KEY(BOARD_NO)
);

CREATE TABLE BOARD_FILE(
	BOARD_NO NUMBER(10),
	BOARD_FILE_NO NUMBER(10),
	BOARD_FILE_NAME VARCHAR2(1000),
	CONSTRAINT PK_BOARD_FILE_FILE_NO PRIMARY KEY(BOARD_FILE_NO)
);

INSERT INTO BOARD
VALUES(1, '게시글 1');

INSERT INTO BOARD
VALUES(2, '게시글 2');
COMMIT;

INSERT INTO BOARD_FILE
VALUES (1, 1, '게시글1 - 첨부파일1');

INSERT INTO BOARD_FILE
VALUES (1, 2, '게시글1 - 첨부파일2');
COMMIT;

INSERT INTO BOARD_FILE
VALUES (2, 3, '게시글2 - 첨부파일1');

INSERT INTO BOARD_FILE
VALUES (2, 1, '게시글2 - 첨부파일1');
COMMIT;

CREATE TABLE BOARD_FILE_MULTIPK(
	BOARD_NO NUMBER(10),
	BOARD_FILE_NO NUMBER(10),
	BOARD_FILE_NAME VARCHAR2(1000),
	CONSTRAINT PK_BOARD_FILE_BOARD_FILE_NO PRIMARY KEY(BOARD_NO, BOARD_FILE_NO)
);

INSERT INTO BOARD_FILE_MULTIPK
VALUES (1, 1, '게시글1 - 첨부파일1');

INSERT INTO BOARD_FILE_MULTIPK
VALUES (1, 2, '게시글1 - 첨부파일2');
COMMIT;

INSERT INTO BOARD_FILE_MULTIPK
VALUES (2, 1, '게시글2 - 첨부파일1');
INSERT INTO BOARD_FILE_MULTIPK
VALUES (2, 2, '게시글2 - 첨부파일2');
COMMIT;

SELECT *
	FROM BOARD_FILE_MULTIPK;

SELECT *
	FROM BOARD_FILE;

-- 기존 테이블에 PK 추가
-- 기존 테이블의 구조를 변경하는 작업이라 ALTER TABLE 구문을 사용한다.
-- PK로 지정될 컬럼의 데이터에 중복값이나 NULL값이 없어야 된다.
ALTER TABLE PROFESSOR 
	ADD CONSTRAINT PK_PROFESSOR_PNO PRIMARY KEY(PNO);

-- 기존 테이블에 다중컬럼 PK 추가
ALTER TABLE SCORE 
	ADD CONSTRAINT PK_SCORE_SNO_CNO PRIMARY KEY(SNO, CNO);

-- PK 삭제
-- ALTER TABLE 구문을 이용
-- 제약조건명을 이용한 삭제
ALTER TABLE SCORE
	DROP CONSTRAINT PK_SCORE_SNO_CNO;

-- 제약조건명 없이 삭제
ALTER TABLE PROFESSOR 
	DROP PRIMARY KEY;

-- 1-2. FOREIGN KEY(외래키, 참조키): 다른 테이블의 PK나 UK로 설정된 컬럼을 참조하여 제약조건을 생성
--				 				참조한 컬럼에 존재하는 데이터만 저장할 수 있는 제약조건이 생성된다.
--								테이블간의 관계를 맺어주는 제약조건
--								참조하는 테이블이 부모 테이블이 되고 참조해오는 테이블이 자식 테이블이 돼서
--							    테이블간의 종속관계를 형성한다. 부모테이블에 존재하는 데이터만 저장가능
-- 							    관계에는 1:1, 1:N, N:1, N:N 등 다양한 형태가 존재한다.
-- DEPT_PK1 테이블의 PK로 설정된 DNO을 참조한 FK를 갖는 EMP_FK1 테이블 생성
CREATE TABLE EMP_FK1 (
	ENO NUMBER(4),
	ENAME VARCHAR2(20),
	-- FK로 지정될 컬럼의 데이터 타입은 참조하는 컬럼의 데이터 타입과 일치해야 한다.
	-- DEPT_PK1테이블에 DNO컬럼에 존재한 데이터들만 DNO 컬럼에 저장할 수 있다.
	DNO NUMBER(4) CONSTRAINT FK_EMP_DNO
				  REFERENCES DEPT_PK1(DNO)
);

INSERT INTO DEPT_PK1
VALUES (1, '개발', '서울', 1);
INSERT INTO DEPT_PK1
VALUES (2, '분석', '서울', 2);
COMMIT;

SELECT *
	FROM DEPT_PK1;

INSERT INTO EMP_FK1
VALUES (1, '홍길동', 1);
INSERT INTO EMP_FK1
VALUES (2, '임꺽정', 2);
COMMIT;

-- 부모테이블인 DEPT_PK1에 존재하지 않는 DNO 3은
-- 자식테이블인 EMP_FK1의 DNO로 사용할 수 없다.
INSERT INTO EMP_FK1
VALUES (3, '장길산', 3);

-- 식별자 역할은 하지 않아서 중복된 값을 여러개 저장할 수 있다.
INSERT INTO EMP_FK1
VALUES (3, '장길산', 1);
COMMIT;

SELECT *
	FROM EMP_FK1;

-- FK는 NULL값도 저장할 수 있다.
INSERT INTO EMP_FK1
VALUES (4, '고기천', NULL);
COMMIT;

-- FK로 관계가 형성되면 부모테이블에서 데이터의 수정이나 삭제가 자유롭게 진행되지 않는다.
-- 자식테이블에서 사용하고 있는 부모테이블의 데이터가 없어야 수정이나 삭제가 가능하다.
INSERT INTO DEPT_PK1
VALUES (3, '회계', '대전', 3);
COMMIT;

DELETE FROM DEPT_PK1
	WHERE DNO = 1;

UPDATE DEPT_PK1 
	SET
		DNO = 4
	WHERE DNO = 1;

DELETE FROM DEPT_PK1
	WHERE DNO = 3;
ROLLBACK;

UPDATE DEPT_PK1
	SET
		DNO = 4
	WHERE DNO = 3;
COMMIT;

SELECT *
	FROM DEPT_PK1;

-- 컬럼을 모두 지정하고 FK 생성
-- CASCADE 옵션 추가하여 생성, ORACLE에서는 DELETE CASCADE 옵션만 추가 가능
-- CASCADE 옵션은 부모테이블 데이터의 수정이나 삭제가 일어날 경우
-- 자식테이블의 데이터도 수정이나 삭제가 일어나는 옵션
CREATE TABLE EMP_FK2(
	ENO NUMBER(4),
	ENAME VARCHAR2(20),
	DNO NUMBER(4),
	CONSTRAINT FK_EMP_FK2_DNO FOREIGN KEY(DNO)
		REFERENCES DEPT_PK1(DNO)
		ON DELETE CASCADE
);

INSERT INTO EMP_FK2
VALUES (1, '홍길동', 1);
INSERT INTO EMP_FK2
VALUES (2, '임꺽정', 2);
INSERT INTO EMP_FK2
VALUES (3, '장길산', 1);
COMMIT;

SELECT *
	FROM EMP_FK2;

DROP TABLE EMP_FK1;

-- ON DELETE CASCADE 옵션에 의해서 부모테이블인 DEPT_PK1의 데이터를 삭제하면
-- 참조하고 있는 자식테이블인 EMP_FK2에서도 데이터가 삭제된다.
DELETE FROM DEPT_PK1
	WHERE DNO = 1;
COMMIT;

-- FK면서 PK역할을 하는 컬럼을 갖는 테이블 생성
-- COURSE의 CNO을 FK로 받아오면서 PK로 지정
ALTER TABLE COURSE ADD CONSTRAINT PK_SCORE_CNO PRIMARY KEY(CNO);

-- 1:1 관계가 형성된 FK
-- COURSE 테이블에도 CNO 데이터는 중복될 수 없고
-- SCORE_PK1_FK1 테이블에도 CNO 데이터는 중복될 수 없다.
CREATE TABLE SCORE_PK1_FK1(
	CNO VARCHAR2(8),
	SNO VARCHAR2(8),
	RESULT NUMBER(3),
	CONSTRAINT PK_SCORE_PK1_FK1_CNO PRIMARY KEY(CNO),
	CONSTRAINT FK_SCORE_PK1_FK1_CNO FOREIGN KEY(CNO)
		REFERENCES COURSE(CNO)
);

-- FK면서 식별자 역할을 하기 때문에 데이터의 중복이 허용되지 않고 NULL 값도 저장할 수 없다.
INSERT INTO SCORE_PK1_FK1 
VALUES('1214', '111111', 100);
COMMIT;

INSERT INTO SCORE_PK1_FK1 
VALUES('1214', '222222', 95);

INSERT INTO SCORE_PK1_FK1
VALUES(NULL, '333333', 80);

-- PK는 테이블 한 번만 지정을 할 수 있지만
-- FK는 여러 번 지정할 수 있다.
-- STUDENT 테이블의 SNO를 참조하고, COURSE의 CNO를 참조해서 FK로 설정하고
-- SNO, CNO의 묶음을 PK로 지정하는 테이블 ST_SCORE_PK_FK를 생성하세요.(SNO, CNO만 컬럼으로 생성)
ALTER TABLE STUDENT ADD CONSTRAINT PK_STUDENT_SNO PRIMARY KEY(SNO);

CREATE TABLE ST_SCORE_PK_FK(
	SNO VARCHAR2(8),
	CNO VARCHAR2(8),
	CONSTRAINT PK_ST_SCORE_SNO_CNO PRIMARY KEY(SNO, CNO),
	CONSTRAINT FK_ST_SCORE_SNO FOREIGN KEY(SNO)
		REFERENCES STUDENT(SNO),
	CONSTRAINT FK_ST_SCORE_CNO FOREIGN KEY(CNO)
		REFERENCES COURSE(CNO)
);

-- STUDENT 테이블에 SNO로 존재하는 데이터와 COURSE 테이블에 CNO로 존재하는 데이터만 저장할 수 있고
-- 데이터의 묶음이 중복이면 안되고 NULL 값을 허용하지 않는 테이블
INSERT INTO ST_SCORE_PK_FK
VALUES('913901', '1211');
INSERT INTO ST_SCORE_PK_FK
VALUES('913901', '1212');

COMMIT;

INSERT INTO ST_SCORE_PK_FK
VALUES(NULL, '1211');
INSERT INTO ST_SCORE_PK_FK
VALUES('913901', NULL);

INSERT INTO ST_SCORE_PK_FK
VALUES('913901', '9123');

INSERT INTO ST_SCORE_PK_FK
VALUES('123456', '1211');

-- 1대 1 관계
-- 부모테이블에 존재하는 데이터가 자식테이블에도 하나만 존재할 수 있는 구조
CREATE TABLE MEMBER(
	ID NUMBER(9),
	USERNAME VARCHAR2(100),
	PASSWORD VARCHAR2(100),
	CONSTRAINT PK_USER_ID PRIMARY KEY(ID)
);

CREATE TABLE MEMBER_DETAIL(
	ID NUMBER(9),
	NICKNAME VARCHAR2(100),
	TELNUM VARCHAR2(100),
	EMAIL VARCHAR2(100),
	CONSTRAINT PK_MEMBER_DETAIL_ID PRIMARY KEY(ID),
	CONSTRAINT FK_MEMBER_DETAIL_ID FOREIGN KEY(ID)
		REFERENCES MEMBER(ID)
);

INSERT INTO MEMBER
VALUES (1, 'bit', '!dkdlxl1234');
COMMIT;

INSERT INTO MEMBER_DETAIL
VALUES (1, 'bitcamp', '01011111111', 'bit@bit.com');
COMMIT;

INSERT INTO MEMBER_DETAIL
VALUES (1, 'bit1111', '0102222222', 'bit11@bit.com');

SELECT M.ID
	 , M.USERNAME
	 , M.PASSWORD
	 , MD.NICKNAME
	 , MD.TELNUM
	 , MD.EMAIL
	FROM MEMBER M
	JOIN MEMBER_DETAIL MD
	  ON M.ID = MD.ID
	WHERE M.ID = 1;

-- 1대 N관계, N대 1관계: 부모테이블에 존재하는 데이터가 자식테이블에 여러개 존재하는 구조
DROP TABLE BOARD;

CREATE TABLE BOARD(
	BOARD_ID NUMBER(10),
	BORAD_TITLE VARCHAR2(1000),
	BOARD_CONTENT VARCHAR2(2000),
	CONSTRAINT PK_BOARD_BOARD_ID PRIMARY KEY(BOARD_ID)
);

CREATE TABLE BOARD_FILE_FK(
	BOARD_ID NUMBER(10),
	FILE_ID NUMBER(10),
	FILE_NAME VARCHAR2(1000),
	CONSTRAINT PK_BOARD_FILE_FK_FILE_ID PRIMARY KEY(FILE_ID),
	CONSTRAINT FK_BOARD_FILE_FK_BOARD_ID FOREIGN KEY(BOARD_ID)
		REFERENCES BOARD(BOARD_ID)
);

INSERT INTO BOARD
VALUES (1, 'AAAA', 'AAAA');
COMMIT;

INSERT INTO BOARD_FILE_FK
VALUES(1, 1, '게시글1 - 첨부파일1');
INSERT INTO BOARD_FILE_FK
VALUES(1, 2, '게시글1 - 첨부파일2');
INSERT INTO BOARD_FILE_FK
VALUES(1, 3, '게시글1 - 첨부파일3');
COMMIT;

SELECT B.BOARD_ID
	 , B.BORAD_TITLE
	 , B.BOARD_CONTENT
	 , BF.FILE_ID
	 , BF.FILE_NAME
	FROM BOARD B
	JOIN BOARD_FILE_FK BF
	  ON B.BOARD_ID = BF.BOARD_ID;
	 

-- N대 N관계(다대다 관계): 두 개의 테이블의 데이터가 여러개가 존재하는 N대 N관계가 매핑된 구조
-- 중간에 N대 N으로 매핑된 테이블이 필요하다
CREATE TABLE LECTURE(
	LECTURE_ID NUMBER(9),
	LECTURE_NAME VARCHAR2(30),
	CONSTRAINT PK_LECTURE_LECTURE_ID PRIMARY KEY(LECTURE_ID)
);

CREATE TABLE STUD(
	STUDENT_ID NUMBER(9),
	STUDENT_NAME VARCHAR2(30),
	CONSTRAINT PK_STUD_STUDENT_ID PRIMARY KEY(STUDENT_ID)
);

-- LECTURE테이블과 STUD테이블이 N대 N관계로 매핑된 테이블
CREATE TABLE LECTURE_STUDENT(
	LECTURE_ID NUMBER(9),
	STUDENT_ID NUMBER(9),
	CONSTRAINT PK_LECTURE_STUDENT_IDS PRIMARY KEY(LECTURE_ID, STUDENT_ID),
	CONSTRAINT FK_LECTURE_STUDENT_L_ID FOREIGN KEY(LECTURE_ID)
		REFERENCES LECTURE(LECTURE_ID),
	CONSTRAINT FK_LECTURE_STUDENT_S_ID FOREIGN KEY(STUDENT_ID)
		REFERENCES STUD(STUDENT_ID)
);
	 
INSERT INTO LECTURE
VALUES(1, '자바');
INSERT INTO LECTURE
VALUES(2, '오라클');	 
COMMIT;
	 
INSERT INTO STUD
VALUES (1, '고기천');
INSERT INTO STUD
VALUES (2, '홍길동');
INSERT INTO STUD
VALUES (3, '장길산');
COMMIT;

INSERT INTO LECTURE_STUDENT 
VALUES (1, 1);
INSERT INTO LECTURE_STUDENT 
VALUES (1, 2);
INSERT INTO LECTURE_STUDENT 
VALUES (1, 3);

INSERT INTO LECTURE_STUDENT 
VALUES (2, 1);
COMMIT;

SELECT LS.LECTURE_ID
	 , L.LECTURE_NAME
	 , LS.STUDENT_ID
	 , S.STUDENT_NAME
	FROM LECTURE_STUDENT LS
	JOIN LECTURE L
	  ON LS.LECTURE_ID = L.LECTURE_ID
	JOIN STUD S
	  ON LS.STUDENT_ID = S.STUDENT_ID;
	 
-- 1-3. UNIQUE KEY(UK): 중복값을 허용하지 않는 제약조건
--		 				PK가 중복값 불가, INDEX, NOT NULL 제약조건을 가지고 있는 반면
-- 						UK는 중복값 저장 불가만 가지고 있는 제약 조건이다. 그래서 NULL값이 저장된다.
CREATE TABLE EMP_UK(
	ENO NUMBER(4) CONSTRAINT PK_EMP_UK_ENO PRIMARY KEY,
	ENAME VARCHAR2(20) CONSTRAINT UK_EMP_UK_ENAME UNIQUE
);

-- UK는 중복된 값만 저장을 방지하는 제약조건
INSERT INTO EMP_UK
VALUES (1, '고기천');
COMMIT;
INSERT INTO EMP_UK 
VALUES (2, '고기천');
	 
INSERT INTO EMP_UK 
VALUES (2, '고기천B'); 
COMMIT;
	 
-- UK로 지정된 컬럼에는 NULL값이 저장되고 NULL값은 중복도 허용된다.
INSERT INTO EMP_UK
VALUES(3, NULL);
INSERT INTO EMP_UK
VALUES(4, NULL);
COMMIT;
	 
SELECT *
	FROM EMP_UK;

-- 컬럼을 모두 지정하고 UK 지정
CREATE TABLE DEPT_UK(
	DNO NUMBER(4),
	DNAME VARCHAR2(20),
	CONSTRAINT PK_DEPT_UK_DNO PRIMARY KEY(DNO),
	CONSTRAINT UK_DEPT_UK_DNAME UNIQUE(DNAME)
);

-- 기존 테이블에 UK 추가
ALTER TABLE PROFESSOR 
	ADD CONSTRAINT UK_PROFESSOR_PNO UNIQUE(PNO);
	 
-- UK 삭제
-- 제약조건 명으로만 삭제 가능하다.
ALTER TABLE DEPT_UK	
	DROP CONSTRAINT UK_DEPT_UK_DNAME;

-- 1-4. CHECK: 컬럼에 저장되는 데이터에 조건을 달아주는 제약조건
--			   CHECK가 지정되어 있는 컬럼의 데이터는 CHECK에 지정된 조건에 부합하는 데이터만 저장될 수 있다.
CREATE TABLE EMP_CHK(
	ENO NUMBER(4) PRIMARY KEY,
	ENAME VARCHAR2(20) UNIQUE,
	SAL NUMBER(5, 0) CHECK(SAL >= 3000),
	COMM NUMBER(5, 0),
	CONSTRAINT CHK_EMP_CHK_COMM CHECK(COMM BETWEEN 100 AND 1000)
);

-- CHECK 조건에 맞는 데이터 저장
INSERT INTO EMP_CHK
VALUES (1, '홍길동', 3000, 300);
INSERT INTO EMP_CHK
VALUES (2, '고기천', 3100, 150);
COMMIT;

-- CHECK 조건에 맞지 않는 데이터의 저장
INSERT INTO EMP_CHK
VALUES (3, '장길산', 2800, 150);
INSERT INTO EMP_CHK
VALUES (4, '임꺽정', 4500, 90);

-- 1-5. NOT NULL: 컬럼의 데이터로 NULL이 저장되지 않게 막아주는 제약조건
CREATE TABLE EMP_NOT_NULL(
	ENO NUMBER(4) PRIMARY KEY,
	ENAME VARCHAR2(20) UNIQUE NOT NULL,
	JOB VARCHAR2(10) NOT NULL CHECK(JOB = '개발'),
	DNO NUMBER(4) REFERENCES DEPT_PK1(DNO) NOT NULL 
);

-- NOT NULL 제약조건이 지정된 컬럼의 데이터로 NULL 저장하면 에러가 발생한다.
INSERT INTO EMP_NOT_NULL 
VALUES(1, '고기천', NULL);
INSERT INTO EMP_NOT_NULL 
VALUES(2, NULL, '개발');

-- 기존 테이블에 NOT NULL 제약조건 추가
ALTER TABLE PROFESSOR 
	MODIFY PNO VARCHAR2(8) NOT NULL;

-- 1-6. DEFAULT: 특정 컬럼의 데이터가 NULL로 오거나 들어오지 않았을 때를 대비해서 기본값을 지정해놓는 제약조건
-- DBMS마다 DEFAULT와 NOT NULL의 순서 차이가 있지만
-- 기본적으로 DEFAULT 제약조건이 먼저 설정돼야 하는 DBMS가 대부분이다.
DROP TABLE EMP_DEFAULT;

CREATE TABLE EMP_DEFAULT(
	ENO NUMBER(4) PRIMARY KEY,
	ENAME VARCHAR2(20) NOT NULL UNIQUE,
	JOB VARCHAR2(10) DEFAULT '개발' NOT NULL ,
	HDATE DATE DEFAULT SYSDATE NOT NULL,
	DNO NUMBER(4) DEFAULT 0 NOT NULL
);

-- DEFAULT 값이 지정된 컬럼을 제외한 나머지 컬럼들에 데이터 저장
INSERT INTO EMP_DEFAULT(ENO, ENAME)
VALUES (1, '고기천');
COMMIT;

SELECT * 
	FROM EMP_DEFAULT;
	 
-- 1-7. 제약조건이 모두 추가된 CREATE TABLE 구문
-- FNO(PK, NUMBER(10)), FNAME(VARCHAR2(50), NOT NULL, UNIQUE),
-- LOC(VARCHAR2(10), DEFAULT '서울', NOT NULL) 컬럼을 갖는 FACTORY1 테이블을 생성하세요.
CREATE TABLE FACTORY1(
	FNO NUMBER(10) PRIMARY KEY,
	FNAME VARCHAR2(50) NOT NULL UNIQUE,
	LOC VARCHAR2(10) DEFAULT '서울' NOT NULL
);

CREATE TABLE FACTORY1(
	FNO NUMBER(10),
	FNAME VARCHAR2(50) NOT NULL,
	LOC VARCHAR2(10) DEFAULT '서울' NOT NULL,
	CONSTRAINT PK_FACTORY1_FNO PRIMARY KEY(FNO),
	CONSTRAINT UK_FACTORY1_FNO UNIQUE(FNAME)
);

-- GNO(NUMBER(5), PK), GNAME(VARCHAR2(50), NOT NULL), PRI(NUMBER(5), DEFAULT 10000)
-- FNO(NUMBER(10), FK(FACTORY1의 FNO), NOT NULL) 컬럼을 갖는 GOODS1 테이블을 생성하세요.
CREATE TABLE GOOD1(
	GNO NUMBER(5) PRIMARY KEY,
	GNAME VARCHAR2(50) NOT NULL,
	PRI NUMBER(5) DEFAULT 10000,
	FNO NUMBER(10) REFERENCES FACTORY1(FNO) NOT NULL
);

CREATE TABLE GOOD1(
	GNO NUMBER(5),
	GNAME VARCHAR2(50) NOT NULL,
	PRI NUMBER(5) DEFAULT 10000,
	FNO NUMBER(10) NOT NULL,
	CONSTRAINT PK_GOOD1_GNO PRIMARY KEY(GNO),
	CONSTRAINT FK_GOOD1_FNO FOREIGN KEY(FNO)
		REFERENCES FACTORY1(FNO)
);

-- PNO(NUMBER(6), PK), GNO(NUMBER(5), FK(GOODS1의 GNO), NOT NULL), 
-- PRICE(NUMBER(5), DEFAULT 7000), PDATE(DATE, DEFATUL SYSDATE, NOT NULL)
-- 컬럼을 갖는 PROD1 테이블을 생성하세요.
CREATE TABLE PROD1(
	PNO NUMBER(6) PRIMARY KEY,
	GNO NUMBER(5) REFERENCES GOOD1(GNO) NOT NULL,
	PRICE NUMBER(5) DEFAULT 7000,
	PDATE DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE PROD1(
	PNO NUMBER(6),
	GNO NUMBER(5) NOT NULL,
	PRICE NUMBER(5) DEFAULT 7000,
	PDATE DATE DEFAULT SYSDATE NOT NULL,
	CONSTRAINT PK_PROD1_PNO PRIMARY KEY(PNO),
	CONSTRAINT FK_PROD1_GNO FOREIGN KEY(GNO)
		REFERENCES GOOD1(GNO)
);