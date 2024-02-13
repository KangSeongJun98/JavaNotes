/* 숫자 데이터 타입(number)
    number(p,s) p는 소수점을 기준으로 모든 유효숫자 자릿수를 의미함.
                s는 소수점 자리수를 의미함 (디폴트 0)
                s가 2이면 소수점 2자리까지 반올림
                s가 음수면 소수점 기준 왼쪽 자리수만큼 반올림
*/

CREATE TABLE ex2_1(
    num1 NUMBER(3)        -- 정수만 3자리
    ,num2 NUMBER(3,2)     -- 정수 1자리 소수점 2자리
    ,num3 NUMBER(5,-2)    -- 십의자리까지 반올림 (총 7자리)
    ,num NUMBER --38
    );
    
INSERT INTO ex2_1 (num1) VALUES(0.7898);
INSERT INTO ex2_1 (num1) VALUES(99.5);
INSERT INTO ex2_1 (num1) VALUES(1004); --오류
SELECT * FROM ex2_1; --select 해보면 반올림 해서 3자리수까지 값이 들어감 (넘어가면 오류)

INSERT INTO ex2_1(num2) VALUES(0.7898);
INSERT INTO ex2_1(num2) VALUES(1.2345);
INSERT INTO ex2_1(num2) VALUES(9.9945); 
INSERT INTO ex2_1(num2) VALUES(9.9995); -- 오류 (반올림하면 정수 두자리가 돼니까)
INSERT INTO ex2_1(num2) VALUES(32);     -- 오류
INSERT INTO ex2_1(num3) VALUES(12345.2345);
INSERT INTO ex2_1(num3) VALUES(1234569.2345);
INSERT INTO ex2_1(num3) VALUES(12345699.2345); --오류 7자리 넘음

INSERT INTO ex2_1(num) VALUES(12345699.2345); --디폴트는 값이 많이 들어감
SELECT * FROM ex2_1;



/* 
    날짜 데이터 타입(date 년월일시분초, timestamp 년월일시분초 밀리초)
*/

CREATE TABLE ex2_2(
    date1 DATE
    ,date2 TIMESTAMP
);
-- sysdate 현재시간
INSERT INTO ex2_2(date1, date2) VALUES (SYSDATE, SYSTIMESTAMP);
-- date의 출력물은 연월일만 보이지만 내부적으로 보면 시분초 까지 값이 들어가있음
SELECT * FROM ex2_2;


/*
    제약조건
    NOT NULL:           NULL 허용 안함 
    UNIQUE:             중복 허용 안함     
    CHECK:              특정 데이터만 허용함(체크 이외에는 허용 안함)
    PRIMARY KEY(기본키):하나의 테이블에 1개만 설정 가능
                        하나의 행을 구분하는 식별자 키값이라고도 하며 PK라고도 함
                        PK는 UNIQUE 이면서 NOT NULL임
    FOREIGN KEY 외래키: 다른 테이블의 PK를 참조하는 키
    
*/

CREATE TABLE ex2_3(
    mem_id VARCHAR(100) NOT NULL UNIQUE
    ,mem_nm VARCHAR(100)
    ,mem_email VARCHAR(100)     NOT NULL
    ,CONSTRAINT uq_ex2_3 UNIQUE(mem_email) -- 제약조건의 이름을 관리하고 싶을 때
);

INSERT INTO ex2_3 (mem_id, mem_email)
VALUES ('a001', 'a001@gmail.com');

INSERT INTO ex2_3 (mem_id, mem_email)
VALUES ('a001', 'a002@gmail.com'); --id는 유니크여서 오류발생

SELECT*FROM ex2_3;
SELECT * FROM user_constraints; -- 제약조건의 이름을 싹 다 보여줌

SELECT * FROM user_constraints 
WHERE constraint_name LIKE '%EX%';

-- check 제약조건

CREATE TABLE ex2_4(
    nm VARCHAR2(100)
    ,age NUMBER  CHECK(age BETWEEN 1 AND 150)
    ,gender VARCHAR2(1)
    ,CONSTRAINT ck_ex2_4_age CHECK (age BETWEEN 1 AND 150)
    ,CONSTRAINT ck_ex2_4_gender CHECK(gender IN ('F','M'))
);

INSERT INTO ex2_4 VALUES('팽수', 100, 'F'); 
INSERT INTO ex2_4 VALUES('길동', 151, 'F'); -- age 체크조건 오류
INSERT INTO ex2_4 VALUES('동길', 10, 'A');  -- gender 체크조건 오류

SELECT * FROM ex2_4;

/*
    primary key 는 한 테이블에 1개만 설정할 수 있으며
    한개의 pk는 (여러 컬럼을 사용한) 복합키로 설정 가능 1~n
    
    foreign key로 참조하는 테이블의 컬럼은 pk로 정의되어 있어야함.
*/

CREATE TABLE dep(
    deptno NUMBER(3) PRIMARY KEY
    ,depnm VARCHAR(20)
    ,dep_floor NUMBER(5)
    );

CREATE TABLE emp(
    empno NUMBER(5)
    ,empnm VARCHAR(20)
    ,title VARCHAR(20)
    ,dno NUMBER(3) CONSTRAINT emp_fk REFERENCES dep(deptno) 
    -- fk 만드는 법
    -- dep 테이블의 deptno테이블을 참조하겠다. 
    -- 이렇게 참조하려면 참조하려는 테이블의 컬럼이 pk여야하고 
    -- 타입이 같아야 하고
    -- 생성돼있어야 함
    );
   
    
 INSERT INTO dep VALUES(1, '영업', 8);   
 INSERT INTO dep VALUES(2, '기획', 10);
 INSERT INTO dep VALUES(3, '개발', 9);
 INSERT INTO EMP VALUES(100, '김창섭', '대리', 2); --EMP부터 값 넣으면 오류 발생 2라는 값이 없음
 INSERT INTO EMP VALUES(200, '박영권', '과장', 3);
 INSERT INTO EMP VALUES(300, '이수민', '부장', 1);
 
 SELECT * FROM emp;
 SELECT * FROM dep; 
 
 SELECT emp.empnm
        ,dep.depnm
        ,dep.dep_floor --  dep<-- 테이블명.컬럼멸
 FROM emp,dep
 WHERE emp.dno = dep.deptno -- pk fk를 이용하여 관계를 맺어 데이터를 가져옴
 AND empnm = '김창섭';

-- table, column에 코멘트 작성(해당 컬럼이 뭘 의미하는지)
 COMMENT ON TABLE dep IS '부서테이블';
 COMMENT ON COLUMN dep.deptno IS '부서번호';
 COMMENT ON COLUMN dep.depnm IS '부서명';
 
 SELECT *
 FROM all_tab_comments
 WHERE OWNER = 'JAVA';