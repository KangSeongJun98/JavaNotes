/*
    공백제거 trim
    왼쪽:ltrim 오른쪽:rtrim 공백제거
*/

SELECT LTRIM(' ABC ') as ex1
    ,  RTRIM(' ABC ') as ex2
    ,  TRIM(' ABC ' ) as ex3
FROM dual;

/* 
     LPAD, RPAD 빈 공간을 채우는 길이만큼 채우고 표현함
     길이가 넘어가면 나머지는 짤림 문자열로 반환해줌
     (대상, 길이 ,표현)
*/
SELECT LPAD(123, 5, '0') as ex1
      ,LPAD(1, 5, '0') as ex2
      ,LPAD(11235, 5, '0') as ex3
      ,LPAD(112352, 5, '0') as ex4  -- 출력이 무조건 2번째 매개변수 길이
      ,RPAD(2,5,'*') as ex5
FROM dual;

/* REPLACE, TRANSLATE 변환 */
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?' ,'나는', '너를') as ex1
    ,  TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') as ex2
    -- TRABSTATE 는 단어를 한글자씩 매칭해서 한글자씩 바꿔줌 (자주 쓰진 않는다)
FROM dual;


/* LENGTH 문자열 길이, LENGTHB 문자열 크기(byte)*/
SELECT LENGTH('abc1') as ex1  
    ,  LENGTHB('abc1') as ex2  --숫자, 특수문자, 영어는 1byte
    ,  LENGTH('팽수1') as ex3
    ,  LENGTHB('팽수1') as ex4 -- utf-8기준 한글 3byte
FROM dual;


SELECT * FROM MEMBER;

SELECT mem_name
    ,  mem_mileage
    , CASE WHEN  mem_mileage <= 2500 THEN 'silver'
           WHEN  2500<mem_mileage  and mem_mileage <=5000 THEN 'gold' 
           WHEN  5000 <mem_mileage THEN 'vip'
      END as rating
    ,  mem_job
FROM MEMBER
WHERE MEM_JOB IN ('주부', '회사원', '자영업')
ORDER BY mem_mileage DESC;

-- TABLE 수정
CREATE TABLE ex5_1(
    nm VARCHAR(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
);

-- 컬럼명 수정
ALTER TABLE ex5_1 RENAME COLUMN point To user_point;
-- 타입수정(타입 수정시 테이블에 데이터가 있다면 주의해야 함)
ALTER TABLE ex5_1 MODIFY gender VARCHAR(1);
-- 제약조건 추가
ALTER TABLE ex5_1 ADD CONSTRAINT pk_ex5 PRIMARY KEY (nm);
-- 컬럼추가
ALTER TABLE ex5_1 ADD crate_dt DATE;
-- 컬럼삭제
ALTER TABLE ex5_1 DROP COLUMN gender;


-- tb_info에 mbti 컬럼 추가
ALTER TABLE tb_info ADD mbti VARCHAR(4);

/*
숫자 함수(매개변수 숫자형)
ABS : 절대값, ROUND: 반올림, CEIL: 올림, TRUNC: 버림, SQRT: 제곱근
MOD(m, n): m을 n으로 나눴을 때 나머지 반환
*/
SELECT ABS(-10)            as ex1
    ,  ABS(10)             as ex2
    ,  ROUND(10.5555)      as ex3 -- defalut 는 정수까지 반올림
    ,  ROUND(10.5555, 1)   as ex4 -- 소수점 둘 째자리에서 반올림(소수점 한자리까지 표현하겠다)
    ,  TRUNC(10.5555, 1)   as ex5
    ,  MOD(4, 2)           as ex6
    ,  MOD(5, 2)           as ex7
FROM dual;

/*날짜 함수*/
SELECT SYSDATE 
    ,  SYSTIMESTAMP
FROM dual;
-- ADD_MONTHS(날짜, 1) 다을달
-- LAST DAY: 마지막날, NEXT_DAY(날짜, '요일') 가장 빠른 해당요일
SELECT ADD_MONTHS(SYSDATE, 1)      as ex1
    ,  ADD_MONTHS(SYSDATE, -1)     as ex2
    ,  LAST_DAY(SYSDATE)           as ex3
    ,  NEXT_DAY(SYSDATE,'수요일')  as ex4
    ,  NEXT_DAY(SYSDATE,'목요일')  as ex5 -- 오늘이 목요일이면 다음주 목요일로
FROM dual;

SELECT SYSDATE -1 -- <-- 1day 연산 가능 
    ,  ADD_MONTHS(SYSDATE, 1) - ADD_MONTHS(SYSDATE, -1) -- 날짜끼리도 연산 가능
FROM dual;

-- 이번달이 며칠 남았는지
SELECT 'd-day:'||(LAST_DAY(SYSDATE)- SYSDATE)||'일' as DDAY
FROM dual;

--DECODE 표현식--
SELECT        cust_name
            , cust_gender
            -- (조건식, 조건1 , true일때 반환값, false일때 반환값
            , DECODE(cust_gender, 'M', '남자', '여자') as gender
            -- (조건식, 조건1, true, 조건2, true, else)
            , DECODE(cust_gender, 'M', '남자', 'F', '여자', '?') as gender
FROM customers;

SELECT mem_name
    ,  mem_regno2
    ,  DECODE(SUBSTR(mem_regno2, 1, 1), 1, '남자','여자') as gender
FROM MEMBER;



/*  타입 변환 함수 
    TO_CHAR: 문자형으로 
    TO_DATE: 날짜형으로
    TO_NUMBER: 숫자형으로
*/
SELECT TO_CHAR(123456,'999,999,999') as ex1
    ,  TO_CHAR(SYSDATE, 'YYYY-MM-DD') as ex2
    ,  TO_CHAR(SYSDATE, 'YYYYMMDD') as ex3
    ,  TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') as ex4
    ,  TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS') as ex5
    ,  TO_CHAR(SYSDATE, 'day') as ex6
    ,  TO_CHAR(SYSDATE, 'YYYY') as ex7
    ,  TO_CHAR(SYSDATE, 'YY') as ex8
    ,  TO_CHAR(SYSDATE, 'dd') as ex9
    ,  TO_CHAR(SYSDATE, 'd') as ex10 --요일을 의미함 일~토까지를 1~7로 표현
FROM dual;

SELECT TO_DATE('231229', 'YYMMDD')  as ex1
    ,  TO_DATE('2023 12 29 09:10:00', 'YYYY MM DD HH24:MI:SS') as ex2
    ,  TO_DATE('25', 'YY') as ex3
    ,  TO_DATE('45', 'YY') as ex4
    -- RR은 세기를 자동으로 추적
    -- 50 -> 1950
    -- 49 -> 2049(Y2K 2000년 문제)에 대한 대응책으로 도입됨.
    ,  TO_DATE('50', 'RR') as ex5
FROM dual;

CREATE TABLE ex5_2(
        title VARCHAR(100)
     ,  d_day DATE
);
INSERT INTO ex5_2 VALUES('종료일', '20240614');
INSERT INTO ex5_2 VALUES('종료일', '2024.06.14');
INSERT INTO ex5_2 VALUES('종료일', '2024/06/24');
INSERT INTO ex5_2 VALUES('종료일', TO_DATE('2024 06 07 09', 'YYYY MM DD HH24'));
SELECT * FROM ex5_2;


CREATE TABLE ex5_3(
     seq1 VARCHAR(100)
    ,seq2 NUMBER
);
INSERT INTO ex5_3 VALUES('1234','1234');
INSERT INTO ex5_3 VALUES('99','99');
INSERT INTO ex5_3 VALUES('123456','123456');

SELECT * 
FROM ex5_3 
ORDER BY TO_NUMBER(seq1) DESC;

SELECT mem_name
    ,  mem_bir
    ,  TO_NUMBER( TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(mem_bir,'YYYY') )||'세'  as 나이
FROM member
ORDER BY 나이 DESC;

SELECT DISTINCT
    cust_name
    ,cust_year_of_birth
    ,TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth)||'세' AS 나이
    ,CASE 
        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth) BETWEEN 31 AND 39 THEN '30대'
        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth) BETWEEN 40 AND 49 THEN '40대'
        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth) BETWEEN 50 AND 59 THEN '50대'
        ELSE '기타'
    END AS 연령대
FROM customers
