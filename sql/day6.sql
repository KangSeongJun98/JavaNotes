/*
집계함수: 대상 데이터를 특정 그룹으로 묶은 다음 
그룹에대한 총합, 평균, 최대값, 최소값 등을 구하느 함수
*/
--count 로우 수를 반환하는 집계함수
SELECT COUNT(*)                 --null포함
    ,  COUNT(department_id)     -- default ALL
    ,  COUNT(ALL department_id) -- 중복 포함, null은 제외
    ,  COUNT(DISTINCT department_id) --중복제거
    ,  COUNT(employee_id)
FROM employees;

SELECT COUNT(mem_id)
    ,  COUNT(*)
FROM member;

SELECT SUM(salary) as 합계
      ,ROUND(AVG(salary),2) as 평균
      ,MAX(salary) as 최대
      ,MIN(salary) as 최소
      ,COUNT(employee_id) as 직원수
   -- ,employee_id 집계함수 쓸 땐 다른 컬럼 못씀
FROM employees;

--group by
SELECT 
      department_id --group by절에 나오는건 컬럼에 추가할 수 있음
      ,SUM(salary) as 합계
      ,ROUND(AVG(salary),2) as 평균
      ,MAX(salary) as 최대
      ,MIN(salary) as 최소
      ,COUNT(employee_id) as 직원수
FROM employees
GROUP BY department_id;


-- where + group by
SELECT 
      department_id --group by절에 나오는건 컬럼에 추가할 수 있음
      ,SUM(salary) as 합계
      ,ROUND(AVG(salary),2) as 평균
      ,MAX(salary) as 최대
      ,MIN(salary) as 최소
      ,COUNT(employee_id) as 직원수
FROM employees
WHERE department_id IN(30,60,90)
GROUP BY department_id;

select * from member;

SELECT
        mem_job as 직업
       ,COUNT(mem_id) as 회원수
       ,SUM(mem_mileage) as 합계
       ,ROUND(AVG(mem_mileage),2) as 평균
       ,MIN(mem_mileage)  as 최소
       ,MAX(mem_mileage)  as 최대
FROM member
GROUP BY mem_job
ORDER BY AVG(mem_mileage) DESC;


DESC kor_loan_status;
SELECT 
       PERIOD
      ,SUM(LOAN_JAN_AMT) as 총잔액
FROM kor_loan_status
where PERIOD LIKE '%2013%'
GROUP BY PERIOD
ORDER BY PERIOD;

-- 기간별, 지역별 대출 총 합계
SELECT 
       REGION
      ,PERIOD
      ,SUM(LOAN_JAN_AMT) as 총잔액
FROM kor_loan_status
where PERIOD LIKE '%2013%'
GROUP BY PERIOD, REGION
ORDER BY 1;


SELECT 
       SUBSTR(period,1,4) as 년도
      ,REGION
      ,SUM(LOAN_JAN_AMT) as 총잔액
FROM kor_loan_status
where region = '대전'
GROUP BY SUBSTR(period,1,4), REGION
ORDER BY 1;


DESC employees

SELECT TO_CHAR(hire_date, 'YYYY') as 년도
      ,COUNT(hire_date)           as 직원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 년도 ; 
-- select가 가장 먼저 실행되기 때문에 가장 마지막에 실행되는 order by에서 as된 이름을 쓸 수 있음


-- 집계데이터에 대해서 검색 조건을 사용하려면 HAVING 사용
SELECT TO_CHAR(hire_date, 'YYYY') as 년도
      ,COUNT(*)           as 직원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(*) >= 10
ORDER BY 년도 ;

-- group by가 지나야 집계가 되는데 where 는 group by 앞에서 시작되기 떄문에 적용 못함
-- 그래서 HAVING을 써야 함

desc member

SELECT MEM_JOB 
      ,ROUND(avg(MEM_MILEAGE),2) as 마일리지
FROM MEMBER
GROUP BY MEM_JOB
HAVING avg(MEM_MILEAGE) >=3000
ORDER BY 2 DESC;

SELECT * FROM customers;

SELECT COUNT(cust_id) as 전체회원수
      ,SUM(DECODE(cust_gender, 'F', 1, 0)) as 여자
      ,SUM(DECODE(cust_gender, 'M', 1, 0)) as 남자     
--    ,COUNT(DECODE(cust_gender, 'F','여자')) as 여자
--    ,COUNT(DECODE(cust_gender, 'M', '남자')) as 남자
FROM customers;