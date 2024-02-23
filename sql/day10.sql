-- EXISTS 존재하는지 체크
-- EXISTS 서브쿼리에 테이블에 검색조건의 데이터가 존재하면
--        존재하는 데이터에 대해서 메인쿼리에서 조회

SELECT a.department_id
      ,a.department_name
FROM departments a
WHERE EXISTS ( SELECT * -- select부분은 뭐가 오든 상관 없음
               FROM job_history b
               WHERE b.department_id = a.department_id);



SELECT a.department_id
      ,a.department_name
FROM departments a
WHERE NOT EXISTS ( SELECT 1 -- NOT EXISTS 존재하지 않는
               FROM job_history b
               WHERE b.department_id = a.department_id);

-- 수강이력이 없는 학생을 조회하시오
SELECT*
FROM 학생 a
WHERE NOT EXISTS ( SELECT *
                   FROM 수강내역
                   WHERE 학번 = a.학번);
               
               
-- 테이블 복사    
CREATE TABLE emp_temp AS
SELECT *
FROM employees;
-- update문 중첩쿼리 사용
-- 전 사원의 급여를 평균금액으로 갱신
UPDATE emp_temp
SET salary = (SELECT AVG(salary)
              FROM emp_temp);
ROLLBACK;
SELECT* FROM emp_temp;               

-- 평균 급여보다 많이 받는 사원 삭제
DELETE emp_temp
WHERE salary >= (SELECT AVG(salary)
                 FROM emp_temp);
                 

-- 실무에서 쓰는 조인
SELECT a.학번
      ,a.이름
      ,b.수강내역번호
FROM 학생 a, 수강내역 b
WHERE a.학번 = b.학번;


-- 미국 국립 표준 협회 ANSI
-- FROM 절에 join이 들어감
-- inner join(equi-join)을 표준 ANSI JOIN 방법으로
-- ANSI JOIN은 WHERE까지 안가고 FROM절에서 전부 다 끝낸다
SELECT a.학번
      ,a.이름
      ,b.수강내역번호
FROM 학생 a
INNER JOIN 수강내역 b
on(a.학번 = b.학번);

SELECT a.학번
      ,a.이름
      ,b.수강내역번호
      ,c.과목이름
FROM 학생 a
INNER JOIN 수강내역 b
ON(a.학번 = b.학번)
INNER JOIN 과목 c
USING(과목번호); -- on 대신 컬럼명이 동일하다면 using을 쓸 수도 있음, 이렇게 하면 셀렉트 문에서도 바꿔줘야 함
                 -- 테이블에 as 해서 별칭 주는 것도 안됨
                 
--ANSI OUTER JOIN
--LEFT OUTER JOIN or RIGHT OUTER JOIN

-- 일반 outer join
SELECT *
FROM 학생 a
    ,수강내역 b
WHERE a.학번 = b.학번(+);

SELECT *
FROM 학생 a
LEFT OUTER JOIN
수강내역 b
ON(a.학번= b.학번); --학생이 왼쪽에 위치한다


SELECT *
FROM 수강내역 b
RIGHT OUTER JOIN
학생 a
ON(a.학번= b.학번); --학생이 오른쪽에 위치한다

-- 매년 국가지역(Americans, Asia)의 총 판매 금액을 출력
-- sales, customers, countries 테이블 사용
-- 국가는 country_region, 판매금액은 amount_sold
-- join을 써서

SELECT * FROM sales; --cust id
SELECT * FROM customers; --country_id / --cust id
SELECT * FROM countries; -- country_id

SELECT TO_CHAR(sales_date, 'YYYY') as 년도
      ,country_region as 국가
      ,SUM(amount_sold) as 판매금액
FROM   countries a,customers b, sales c
WHERE a.country_id = b.country_id
AND b.cust_id = c.cust_id
AND country_region IN ('Americas', 'Asia')
GROUP BY TO_CHAR(sales_date, 'YYYY'),country_region
ORDER BY 2;

--DML(데이터 조작어) (SELECT,INSERT,DELETE,UPDATE,MERGE) 중  MERGE문 (병합) 

/*  MERGE(병합)
    특정 조건에 따라 대상테이블에 대해
    INSERT or UPDATE or DELETE를 해야 할 때 1개의 sql로 처리 가능
*/
--과목테이블에 머신러닝 과목이 없으면 INSERT 학점은 2점으로
--                             있으면 UPDATE 학점은 3점으로                       


-- MERGE 1. 대상테이블이 비교 테이블인 경우(동일 테이블에서 merger쓸 때)
SELECT * FROM 과목;

MERGE INTO 과목 a
    USING DUAL -- 비교 테이블 dual 은 대상테이블 = 비교테이블 인경우
    ON(a.과목이름='머신러닝') -- MATCH 조건
WHEN MATCHED THEN
    UPDATE SET a.학점 = 3        -- merge문 insert와 update( where )는 테이블 기입 안함
WHEN NOT MATCHED THEN
    INSERT (a.과목번호, a.과목이름, a.학점)
    values((SELECT MAX(NVL(a.과목번호,0)+1)
                    FROM 과목)
                  ,'머신러닝',2);

--MERGE 2. 다른 테이블에 MATCH 조건이 들어갈 경우
-- (1) 사원테이블에서 관리자 사번 146인 사원번호가 일치하는
--     직원의 보너스 금액을 급여의 1%로 업데이트
--     사번과 일치하는게 없다면 급여가 8000 미만인 사원만 0.1%로 인설트
-- 체크는 employees 테이블에서 쓰고 업데이트 인설트 등은 emp_info에서 된다.

CREATE TABLE emp_info(
    emp_id NUMBER
   ,bonus NUMBER DEFAULT 0);
   
INSERT INTO emp_info(emp_id)
SELECT a.employee_id
FROM employees a
WHERE a.emp_name LIKE '%L%';

SELECT a.employee_id, a.salary*0.01, a.manager_id
FROM employees a
WHERE manager_id = 146
AND employee_id IN (SELECT emp_id
                    FROM emp_info);


SELECT a.employee_id, a.salary*0.001, a.manager_id
FROM employees a
WHERE manager_id = 146
AND employee_id NOT IN (SELECT emp_id
                    FROM emp_info);

MERGE INTO emp_info a
USING( SELECT employee_id, salary, manager_id
       FROM employees
       WHERE manager_id = 146) b
    ON(a.emp_id = b.employee_id) --match 조건
WHEN MATCHED THEN
    UPDATE SET a.bonus = a.bonus + b.salary*0.01
WHEN NOT MATCHED THEN
    INSERT(a.emp_id, a.bonus) VALUES(b.employee_id, b.salary *0.001)
    WHERE (b.salary < 8000);

SELECT * FROM emp_info;
SELECT * FROM tb_info;
SELECT * FROM INFO;

-- 있으면( mbti, team )update
-- 없으면 insert team
MERGE INTO tb_info a
USING ( SELECT info_no
              ,team
              ,mbti
        FROM info)b
ON(a.info_no = b.info_no) --매치 조건
WHEN MATCHED THEN
    UPDATE SET a.mbti = b.mbti
              ,a.team = b.team
WHEN NOT MATCHED THEN
    INSERT(a.INFO_NO, a.NM, a.EMAIL, a.MBTI, a.PC_NO)
    VALUES(0, '이앞길','leeapgil@gamil.com','ENFJ');

SELECT NM
      ,MBTI
      ,CASE 
       WHEN SUBSTR(MBTI,1,1) = 'I' THEN '내향형'
       WHEN SUBSTR(MBTI,1,1) = 'E' THEN '외향형'
       END AS 에너지방향
       ,CASE 
       WHEN SUBSTR(MBTI,2,1) = 'N' THEN '직관형'
       WHEN SUBSTR(MBTI,2,1) = 'S' THEN '감각형'
       END AS 인식기능
       ,CASE 
       WHEN SUBSTR(MBTI,3,1) = 'T' THEN '사고형'
       WHEN SUBSTR(MBTI,3,1) = 'F' THEN '감정형'
       END AS 판단기능
       ,CASE 
       WHEN SUBSTR(MBTI,4,1) = 'J' THEN '판단형'
       WHEN SUBSTR(MBTI,4,1) = 'P' THEN '인식형'
       END AS 생활양식
       
FROM tb_info
WHERE MBTI != '?';



SELECT DISTINCT 
       SUBSTR(MBTI,1,1),  
       SUBSTR(MBTI,2,1),
       SUBSTR(MBTI,3,1),
       SUBSTR(MBTI,4,1),
       COUNT(a.mbti)
FROM( SELECT    
       nm
      ,MBTI
      ,CASE 
       WHEN SUBSTR(MBTI,1,1) = 'I' THEN '내향형'
       WHEN SUBSTR(MBTI,1,1) = 'E' THEN '외향형'
       END AS 에너지방향
       ,CASE 
       WHEN SUBSTR(MBTI,2,1) = 'N' THEN '직관형'
       WHEN SUBSTR(MBTI,2,1) = 'S' THEN '감각형'
       END AS 인식기능
       ,CASE 
       WHEN SUBSTR(MBTI,3,1) = 'T' THEN '사고형'
       WHEN SUBSTR(MBTI,3,1) = 'F' THEN '감정형'
       END AS 판단기능
       ,CASE 
       WHEN SUBSTR(MBTI,4,1) = 'J' THEN '판단형'
       WHEN SUBSTR(MBTI,4,1) = 'P' THEN '인식형'
       END AS 생활양식
       FROM tb_info
       WHERE MBTI != '?') a
       
GROUP BY SUBSTR(MBTI,1,1),  
         SUBSTR(MBTI,2,1),
         SUBSTR(MBTI,3,1),
         SUBSTR(MBTI,4,1)
ORDER BY 1;
 