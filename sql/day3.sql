/* DML: INSERT 데이터 삽입 */
--1. 기본형태 컬럼명 기술
CREATE TABLE  ex3_1 (
     col1 VARCHAR(100)
    ,col2 NUMBER
    ,col3 DATE
);

INSERT INTO ex3_1(col1, col2, col3)
VALUES ('NICK', 10, SYSDATE);

--문자열 타입은 '' 숫자는 원래면 그냥 쓰지만 '' 붙이는 것도 됨
-- 특정 걸럼만 삽입할 때는 무조건 컬럼명 작성
INSERT INTO ex3_1(col1, col2)
VALUES('judy', 9);

INSERT INTO ex3_1(col1, col2)
VALUES('jack', '20');
--테이블에 있는 전체 컬럼에 대해서 삽입할 때는 안써도 됨
INSERT INTO ex3_1 VALUES ('팽수',10,SYSDATE);

-- INSERT INTO ~ SELECT 조회결과를 삽입
INSERT INTO ex3_1 (col1, col2)
SELECT emp_name, employee_id
FROM employees;

INSERT INTO ex3_1 (col1, col2)
SELECT nm, team
FROM tb_info;

-- DML: UPDATE 데이터 수정
UPDATE ex3_1
SET col2 = 20           -- 수정하고자하는 컬럼과 데이터
    ,col3 = SYSDATE     -- 수정해야하는 컬럼이 여러개면 ,로 추가
WHERE col1 = 'judy';    -- 수정되어지는 행에대한 조건(없으면 모든 행이 수정 됨)

UPDATE tb_info
SET hobby = '집 지키기'
WHERE nm = '강성준';

SELECT* FROM tb_info;
SELECT* FROM ex3_1;

-- DML: DELETE 데이터 삭제
DELETE ex3_1;       -- 전체 데이터 삭제

DELETE ex3_1        
where col1= 'judy'; --특정 데이터 삭제

DELETE dep 
where deptno = 3;   -- dep는 emp에서 참조하고 있으니 

DELETE emp
where empno =  200; -- emp껄 먼저 삭제하고 그 부모인  dep를 삭제해야 함

DELETE dep;

DROP TABLE dep CASCADE CONSTRAINTS; -- 제약조건도 삭제 후 테이블을 삭제(잘 안씀)

-- 의사 컬럼 
-- 테이블이 없지만 있는것처럼 사용
SELECT ROWNUM AS rnum
    ,pc_no
    , nm
    , hobby
FROM tb_info
WHERE ROWNUM <=10;


--중복 제거
SELECT DISTINCT cust_gender
FROM customers;
-- 표현식 (테이블에 특정 데이터의 표현을 바꾸고 싶을 때 사용)
SELECT cust_name
        , CASE WHEN cust_gender= 'M' THEN '남자'
               WHEN cust_gender= 'F' THEN '여자'
           ELSE '?'
         END as gender
FROM customers;

-- salary 10000이상 고액연봉, 나머지는 연봉
SELECT emp_name
    , salary
    , CASE WHEN salary >= 10000 THEN '고액연봉'
        ELSE '연봉'
    END as salary
FROM employees;


-- NULL 조건식과 논리조건식 (AND, OR, NOT)
SELECT *
FROM departments
WHERE parent_id IS NULL; 
// null값은 where 조건식 쓸 때 =null 이 아니라 IS NULL로 조회해야함
// NULL 값이 아닌걸 조회하려면 IS NOT NULL



--IN 조건식 (여러개 or 가 필요할 때)
-- 30, 60, 80번 부서 조회
SELECT emp_name, department_id
FROM employees
WHERE department_id IN (30,60,80);



--LIKE 검색 문자열 패턴 검색
-- 문자열 검색에서 가장 많이 사용 됨
SELECT *
FROM tb_info
WHERE nm LIKE '%강%'; -- %가 붙으면 그 쪽은 뭐든 나오는거
                      -- %김 이면 마지막에 김이 붙은
                      -- 김% 이면 김으로 시작하는 
                      
SELECT *
FROM tb_info
WHERE email LIKE '%94%';