-- SQL
-- DML (SELECT, INSERT, UPDATE, DELETE)
--       조회    삽입    수정    삭제
select * --*은 전체 컬럼을 의미함
from employees;

select employee_id, emp_name from employees;

select * from employees where employee_id = 199;

/* table 
    1.컬럼명의 최대 크기는 30바이트
    2.테이블명 컬럼명으로는 예약어를 사용할 수 없음(오류는 안나는데 권장 안함)
    3.테이블명 컬렴명으로 문자,숫자,_,$,#dmf 사용할 수 있음(첫 글자는 반드시 문자)
    4.한 테이블에 사용한 컬럼은 최대 255개
*/

create table ex1_1(
-- 하나의 컬럼은 하나의 타입과 사이즈를 가짐            
            col1 char(10)
            ,col2 varchar2(10) --테이블 생성시 컬럼은 ,로 구분       
);

-- INSERT 데이터 삽입
INSERT INTO ex1_1(col1, col2) VALUES('abc','ABC');
SELECT * FROM ex1_1;

-- 한글은 한글자에 3byte라 총 12 > 10바이트 넘어서 오류발생
--INSERT INTO ex1_1(col1, col2) VALUES('안녕','하하하하');
--SELECT * FROM ex1_1;

--테이블 삭제 DROP 
DROP TABLE ex1_1;

SELECT emp_name     as nm   --AS(alias 별칭) 
    , hire_date     hd      --콤마를 구분으로 컬럼명을 띄어쓰기 한 뒤에는 as 없이도 별칭 가능
    , salary
    , department_id
FROM employees;

SELECT * 
FROM employees 
where salary>=10000;
--검색 조건 여러개
-- and / or 사용
SELECT * 
FROM employees 
where salary>=10000 
AND    salary<=11000 ;

SELECT*
FROM employees
WHERE department_id =30
OR department_id = 60;

-- 정렬조건이 있다면 order by 사용 asc는 오름차순 desc는 내림차순 
-- 디폴트는 ASC 오름차순
SELECT emp_name, department_id
FROM employees
WHERE department_id =30
OR department_id = 60
ORDER BY department_id DESC, emp_name ASC; 

-- 사칙연산 사용가능
SELECT emp_name
    , ROUND(salary/30,2)        as 일당
    , salary                       월급
    , salary - salary*0.1          실수령액
    , salary * 12                  연봉
FROM employees
ORDER BY 3 DESC;

-- 논리 연산자
SELECT * FROM employees WHERE salary = 2600;  //같다 java와 햇갈릴수도
SELECT * FROM employees WHERE salary <> 2600; //같지 않다
SELECT * FROM employees WHERE salary != 2600; //같지 않다 
SELECT * FROM employees WHERE salary < 2600;  //미만
SELECT * FROM employees WHERE salary > 2600;  //초과
SELECT * FROM employees WHERE salary <= 2600; //이하
SELECT * FROM employees WHERE salary >= 2600; //이상

DESC products;

SELECT PROD_NAME
    ,PROD_CATEGORY
    ,PROD_MIN_PRICE
FROM products
where PROD_MIN_PRICE >=30
and   PROD_MIN_PRICE <50
ORDER BY PROD_CATEGORY ASC, PROD_MIN_PRICE DESC;
