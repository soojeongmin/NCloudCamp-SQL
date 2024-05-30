--1) 과목번호, 과목이름, 교수번호, 교수이름을 담을 수 있는 변수들을 선언하고 
--   유기화학 과목의 과목번호, 과목이름, 교수번호, 교수이름을 출력하세요.
DECLARE
    COURSE_ROW COURSE%ROWTYPE;
    PROFESSOR_ROW PROFESSOR%ROWTYPE;
BEGIN
    SELECT C.*, P.* INTO COURSE_ROW, PROFESSOR_ROW
    FROM COURSE C JOIN PROFESSOR P ON C.PNO = P.PNO WHERE C.CNAME = '유기화학';
    DBMS_OUTPUT.PUT_LINE(C.CNO);
   	DBMS_OUTPUT.PUT_LINE(C.CNAME);
    DBMS_OUTPUT.PUT_LINE(P.PNO);
    DBMS_OUTPUT.PUT_LINE(P.PNAME);
END;

--2) 위 데이터들을 레코드로 선언하고 출력하세요.
DECLARE
    TYPE PROFESSOR_REC IS RECORD (
        CNO COURSE.CNO%TYPE,
        CNAME COURSE.CNAME%TYPE,
        PNO PROFESSOR.PNO%TYPE,
        PNAME PROFESSOR.PNAME%TYPE
    );
    REC PROFESSOR_REC;
BEGIN
    SELECT C.CNO, C.CNAME, P.PNO, P.PNAME INTO REC
    FROM COURSE C JOIN PROFESSOR P ON C.PNO = P.PNO WHERE C.CNAME = '유기화학';
    DBMS_OUTPUT.PUT_LINE(REC.CNO);
    DBMS_OUTPUT.PUT_LINE(REC.CNAME);
    DBMS_OUTPUT.PUT_LINE(REC.PNO);
    DBMS_OUTPUT.PUT_LINE(REC.PNAME);
END;