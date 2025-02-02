/*
WITH절: 별칭으로 사용한 SELECT 문을 다른 SELECT 문에서 별칭으로 참조 가능
        반복보다는 서브쿼리가 있다면 변수처럼 한번 불러와서 사용
        복잡한 통계쿼리나 텓이블을 탐색할 때 많이 사용
        temp 라는 임시테이블을 사용해서 장시간 걸리는 쿼리의 결과를 저장해놓고
        저장해놓은 데이터를 엑세스하기 때문에 성능이 좋을 수 있음
*/
WITH a AS  (-- 별칭
           SELECT *
           FROM employees
           )
SELECT * FROM a;

-- 8 ~ 14 자리, 대문자1, 소문자1, 특수문자1
WITH test_data AS(
    SELECT 'asda' AS pw FROM dual UNION ALL
    SELECT 'abcd!A' AS pw FROM dual UNION ALL
    SELECT 'abcdasdas' AS pw FROM dual UNION ALL
    SELECT 'abcdAdds!' AS pw FROM dual
)

SELECT pw
FROM test_data
WHERE LENGTH(pw) BETWEEN 8 AND 14
AND REGEXP_LIKE(pw, '[A-Z]')
AND REGEXP_LIKE(pw, '[a-z]')
AND REGEXP_LIKE(pw, '[^a-zA-Z0-9가-힣]');


-- 고객중 카트 사용횟수가 가장 많은 고객과 가장 적은 고객의 정보를 출력하시오
-- (구매 이력이 있는 고객중)


SELECT *
FROM(
        SELECT a.mem_id
            , a.mem_name
            , COUNT(DISTINCT b.cart_no) cnt
            FROM member a
                ,cart b
            WHERE a.mem_id = b.cart_member
            GROUP BY a.mem_id, a.mem_name
        )

where cnt = (SELECT max(cnt)
             FROM(
                SELECT a.mem_id
                     , a.mem_name
                     , COUNT(DISTINCT b.cart_no) cnt
                FROM member a
                    ,cart b
                WHERE a.mem_id = b.cart_member
                GROUP BY a.mem_id, a.mem_name
                )
             )
OR cnt = ( SELECT min(cnt)
            FROM(SELECT a.mem_id
                      , a.mem_name
                      , COUNT(DISTINCT b.cart_no) cnt
                  FROM member a, cart b
                  WHERE a.mem_id = b.cart_member
                  GROUP BY a.mem_id, a.mem_name
                  ) 
            );



--위의 내용을 with 사용

WITH T1 as(SELECT a.mem_id
            , a.mem_name
            , COUNT(DISTINCT b.cart_no) cnt
            FROM member a
                ,cart b
            WHERE a.mem_id = b.cart_member
            GROUP BY a.mem_id, a.mem_name)
            
   ,T2 AS(SELECT MAX(t1.cnt) as max_cnt, MIN(t1.cnt)as min_cnt
          FROM T1)

SELECT t1.mem_id, t1.mem_name, cnt
FROM t1, t2
WHERE t1.cnt = t2.max_cnt
OR t1.cnt = t2.min_cnt;


/*
 2000년도 이탈리아의 '연평균 매출액'보다 큰 '월의 평균 매출액'
 이었던 '년월', '매출액' 을 출력(소수점은 반올림)
*/
SELECT cust_id, sales_month, amount_sold
FROM sales;

SELECT cust_id, country_id
FROM customers;

SELECT country_id, country_name
FROM countries;

--연평균
SELECT ROUND(AVG(a.amount_sold)) as year_avg
FROM sales a, customers b, countries c
WHERE a.cust_id= b.cust_id
AND b.country_id = c.country_id
AND a.sales_month LIKE '%2000%'
AND c.country_name = 'Italy';

-- 월평균
SELECT a.sales_month
      ,ROUND(AVG(a.amount_sold)) as year_avg
FROM sales a, customers b, countries c
WHERE a.cust_id= b.cust_id
AND b.country_id = c.country_id
AND a.sales_month LIKE '%2000%'
AND c.country_name = 'Italy'
GROUP BY a.sales_month;


SELECT *
FROM(
    SELECT a.sales_month
          ,ROUND(AVG(a.amount_sold)) as month_avg
    FROM sales a, customers b, countries c
    WHERE a.cust_id= b.cust_id
    AND b.country_id = c.country_id
    AND a.sales_month LIKE '%2000%'
    AND c.country_name = 'Italy'
    GROUP BY a.sales_month
)
WHERE month_avg >(
                    SELECT ROUND(AVG(a.amount_sold)) as year_avg
                    FROM sales a, customers b, countries c
                    WHERE a.cust_id= b.cust_id
                    AND b.country_id = c.country_id
                    AND a.sales_month LIKE '%2000%'
                    AND c.country_name = 'Italy'
                );
                
------

WITH T1 as(
            SELECT a.sales_month
                  ,a.amount_sold
                FROM sales a, customers b, countries c
                WHERE a.cust_id= b.cust_id
                AND b.country_id = c.country_id
                AND a.sales_month LIKE '%2000%'
                AND c.country_name = 'Italy')
    ,T2 as(SELECT AVG(t1.amount_sold) as year_avg
            FROM t1)
    ,T3 as (SELECT t1.sales_month
                  ,ROUND(AVG(t1.amount_sold)) as month_avg
            FROM t1
            GROUP BY t1.sales_month)
SELECT t3.sales_month, t3.month_avg
FROM t2, t3
WHERE t3.month_avg > t2.year_avg;
                
                
/*
    분석함수: 로우손실 없이 집계값을 산출 할 수 있음 (over 키워드가 들어감)
    논리적 기준 or 로우순서기준으로 부분집계를 할 수 있음
    (ex 월별 누적합계)  
    함수종류: avg, sum, max, min, count, dense_rank, rank, lag.....
    PARTITION BY:  그룹  
                    -> ('그룹 별' '집계') 할 때 사용 partition 빼면 전체 집계가 나옴
    ORDER BY : 정렬조건
    WINDOW: 그룹안에 상세한 그룹으로 분할 할 때
*/


-- 부서별 이름순으로 가장 첫번째 직원을 출력하시오
SELECT *
FROM(SELECT department_id, emp_name
      ,ROW_NUMBER() OVER (PARTITION BY department_id
                          ORDER BY emp_name) as dep_rownum
     FROM employees)
where dep_rownum =1;


-- rank 동일 순위 있을 시 건너 뜀
-- dense_rank 건너뛰지 않음

SELECT department_id , emp_name, salary
     ,RANK()OVER(PARTITION BY department_id
                 ORDER BY salary DESC) as rnk
     ,DENSE_RANK()OVER(PARTITION BY department_id
                 ORDER BY salary DESC) as dense_rnk
FROM employees;

-- 학생들의 전공별 평점(내림차순)을 기준으로 순위를 출력하시오
SELECT 이름,전공,평점
      ,RANK()OVER(PARTITION BY 전공
                  ORDER BY 평점 DESC) as 전공별순위
      ,RANK()OVER(ORDER BY 평점 DESC) as 전체순위
FROM 학생;

-- 분석함수에서 집계함수
SELECT emp_name, salary, department_id
      ,SUM(salary) OVER (PARTITION BY department_id) as 부서별합계
      ,SUM(salary) OVER() as 전체합계
FROM employees;

-- 전공별 학생수를 기준으로 순위를 구하시오
SELECT 전공
      ,학생수
      ,RANK()OVER(ORDER BY 학생수 DESC) as 전공별순위
FROM(
        SELECT 전공
              ,COUNT(전공) as 학생수
        FROM 학생
        GROUP BY 전공
       );  
       
-- 위의 쿼리문을 간략하게 한 줄로 쓰기       
SELECT 전공
      ,COUNT(*) as 학생수
      ,RANK()OVER(PARTITION BY 전공
                  ORDER BY COUNT(*) DESC ) as 전공별학생수
FROM 학생
GROUP BY 전공;

-- 상품별 총판매금액과 순위
-- 상위 10개 상품

SELECT * FROM cart;
SELECT * FROM prod;

SELECT *
FROM(
        SELECT b.prod_id
              ,prod_name
              ,SUM(b.prod_sale* a.cart_qty) as 합계
              ,RANK()OVER(ORDER BY SUM(b.prod_sale* a.cart_qty) DESC ) as 순위
        FROM cart a, prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY b.prod_id, prod_name
        ORDER BY 3 DESC
    )
WHERE rownum <= 10;

--NTILE(expr) 파티션별로 expr에 명시된만큼 값을 분할
--NTILE(3) 1~3사이 수를 반환: 분할하는 수를 '버킷 수'라고 함
--로우 건 수보다 큰 수를 명시하면 반환되는 수는 무시됨
-- NTILE(3) = 3분할 한다
SELECT emp_name, department_id, salary
      ,NTILE(3) OVER(PARTITION BY department_id
                     ORDER BY salary) as nt
FROM employees
WHERE department_id IN (30,60);


/*
    LAG 선행 로우의 값을 가져와서 반환
    LEAD 후행 로우의 값을 가져와서 반환
    주어진 그룹과 순서에 따라 로우에 있는 특정 컬럼의 값을 참조할 때 사용
*/
SELECT emp_name, department_id, salary
        -- '1'단계 이전 행이 있으면 'emp_name'이 출력되고 없으면 '가장 높음'이 출력됨
      ,LAG(emp_name, 1 ,'가장높음') OVER ( PARTITION BY department_id
                                            ORDER BY salary DESC) as lag
      ,LEAD(emp_name , 1, '가장낮음') OVER (PARTITION BY department_id
                                            ORDER BY salary DESC) as leads
FROM employees
WHERE department_id IN (30, 60);

-- 전공별로 각 학생의 평점보다 한단계 바로 높은 학생과의 평점 차이를 출력


SELECT 전공, 이름, 평점
      ,LAG(이름, 1, '1등') OVER (PARTITION BY 전공
                                ORDER BY 평점 DESC) as 나보다위학생
      ,LAG(평점,1 ,평점) OVER (PARTITION BY 전공
                                        ORDER BY 평점 DESC)-평점 as 평점차이                          
FROM 학생;

/* kor_loan_status 테이블에 있는 데이터를 이용해
    '연도별' 최종월' 기준 가장 대출이 많은 도시와 잔액
    1. 연도별 최종월은 데이터마다 다 다름
         - 연도별 가장 큰 월을 구함.
    2. 연도별 최종월을 대상으로 대출잔액이 가장 큰 금액을 추출
         - 1번과 조인하여 가장 큰 잔액을 구함   
    3. 월별, 지역별 대출잔액과 2의 결과를 비교해 금액이 같은 건을 출력
        - 2와 조인하여 두 금액이 같은 건의 도시와 잔액 출력
*/

SELECT  SUBSTR(PERIOD,1,4) as 연도
       ,RANK()OVER(PARTITION BY PERIOD
                   ORDER BY TO_NUMBER(SUBSTR(PERIOD,5,2))) as 월
FROM kor_loan_status;



RANK()OVER(PARTITION BY 지역
                   ORDER BY loan_jan_amt DESC) as 월
     
     
SELECT 년월, 지역, 잔액
FROM(
    WITH a AS(
    SELECT TO_NUMBER(SUBSTR(PERIOD,1,4)) as 년월
          ,MAX(TO_NUMBER(SUBSTR(PERIOD,5,2))) as 월
    FROM kor_loan_status
    GROUP BY TO_NUMBER(SUBSTR(PERIOD,1,4))
    )
    SELECT 년월||월 as 년월
          ,region as 지역
          ,SUM(loan_jan_amt) as 잔액
          ,RANK()OVER(PARTITION BY 년월||월
                       ORDER BY SUM(loan_jan_amt) DESC) as 순위
    FROM a, kor_loan_status b
    WHERE a.년월||월 = b.period
    GROUP BY 년월||월, region
)
where 순위 = 1;



SELECT * FROM kor_loan_status

