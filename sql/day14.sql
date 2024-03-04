/*
WITHÀý: º°ÄªÀ¸·Î »ç¿ëÇÑ SELECT ¹®À» ´Ù¸¥ SELECT ¹®¿¡¼­ º°ÄªÀ¸·Î ÂüÁ¶ °¡´É
        ¹Ýº¹º¸´Ù´Â ¼­ºêÄõ¸®°¡ ÀÖ´Ù¸é º¯¼öÃ³·³ ÇÑ¹ø ºÒ·¯¿Í¼­ »ç¿ë
        º¹ÀâÇÑ Åë°èÄõ¸®³ª ¶ÀÌºíÀ» Å½»öÇÒ ¶§ ¸¹ÀÌ »ç¿ë
        temp ¶ó´Â ÀÓ½ÃÅ×ÀÌºíÀ» »ç¿ëÇØ¼­ Àå½Ã°£ °É¸®´Â Äõ¸®ÀÇ °á°ú¸¦ ÀúÀåÇØ³õ°í
        ÀúÀåÇØ³õÀº µ¥ÀÌÅÍ¸¦ ¿¢¼¼½ºÇÏ±â ¶§¹®¿¡ ¼º´ÉÀÌ ÁÁÀ» ¼ö ÀÖÀ½
*/
WITH a AS  (-- º°Äª
           SELECT *
           FROM employees
           )
SELECT * FROM a;

-- 8 ~ 14 ÀÚ¸®, ´ë¹®ÀÚ1, ¼Ò¹®ÀÚ1, Æ¯¼ö¹®ÀÚ1
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
AND REGEXP_LIKE(pw, '[^a-zA-Z0-9°¡-ÆR]');


-- °í°´Áß Ä«Æ® »ç¿ëÈ½¼ö°¡ °¡Àå ¸¹Àº °í°´°ú °¡Àå ÀûÀº °í°´ÀÇ Á¤º¸¸¦ Ãâ·ÂÇÏ½Ã¿À
-- (±¸¸Å ÀÌ·ÂÀÌ ÀÖ´Â °í°´Áß)


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



--À§ÀÇ ³»¿ëÀ» with »ç¿ë

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
 2000³âµµ ÀÌÅ»¸®¾ÆÀÇ '¿¬Æò±Õ ¸ÅÃâ¾×'º¸´Ù Å« '¿ùÀÇ Æò±Õ ¸ÅÃâ¾×'
 ÀÌ¾ú´ø '³â¿ù', '¸ÅÃâ¾×' À» Ãâ·Â(¼Ò¼öÁ¡Àº ¹Ý¿Ã¸²)
*/
SELECT cust_id, sales_month, amount_sold
FROM sales;

SELECT cust_id, country_id
FROM customers;

SELECT country_id, country_name
FROM countries;

--¿¬Æò±Õ
SELECT ROUND(AVG(a.amount_sold)) as year_avg
FROM sales a, customers b, countries c
WHERE a.cust_id= b.cust_id
AND b.country_id = c.country_id
AND a.sales_month LIKE '%2000%'
AND c.country_name = 'Italy';

-- ¿ùÆò±Õ
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
    ºÐ¼®ÇÔ¼ö: ·Î¿ì¼Õ½Ç ¾øÀÌ Áý°è°ªÀ» »êÃâ ÇÒ ¼ö ÀÖÀ½ (over Å°¿öµå°¡ µé¾î°¨)
    ³í¸®Àû ±âÁØ or ·Î¿ì¼ø¼­±âÁØÀ¸·Î ºÎºÐÁý°è¸¦ ÇÒ ¼ö ÀÖÀ½
    (ex ¿ùº° ´©ÀûÇÕ°è)  
    ÇÔ¼öÁ¾·ù: avg, sum, max, min, count, dense_rank, rank, lag.....
    PARTITION BY:  ±×·ì  
                    -> ('±×·ì º°' 'Áý°è') ÇÒ ¶§ »ç¿ë partition »©¸é ÀüÃ¼ Áý°è°¡ ³ª¿È
    ORDER BY : Á¤·ÄÁ¶°Ç
    WINDOW: ±×·ì¾È¿¡ »ó¼¼ÇÑ ±×·ìÀ¸·Î ºÐÇÒ ÇÒ ¶§
*/


-- ºÎ¼­º° ÀÌ¸§¼øÀ¸·Î °¡Àå Ã¹¹øÂ° Á÷¿øÀ» Ãâ·ÂÇÏ½Ã¿À
SELECT *
FROM(SELECT department_id, emp_name
      ,ROW_NUMBER() OVER (PARTITION BY department_id
                          ORDER BY emp_name) as dep_rownum
     FROM employees)
where dep_rownum =1;


-- rank µ¿ÀÏ ¼øÀ§ ÀÖÀ» ½Ã °Ç³Ê ¶Ü
-- dense_rank °Ç³Ê¶ÙÁö ¾ÊÀ½

SELECT department_id , emp_name, salary
     ,RANK()OVER(PARTITION BY department_id
                 ORDER BY salary DESC) as rnk
     ,DENSE_RANK()OVER(PARTITION BY department_id
                 ORDER BY salary DESC) as dense_rnk
FROM employees;

-- ÇÐ»ýµéÀÇ Àü°øº° ÆòÁ¡(³»¸²Â÷¼ø)À» ±âÁØÀ¸·Î ¼øÀ§¸¦ Ãâ·ÂÇÏ½Ã¿À
SELECT ÀÌ¸§,Àü°ø,ÆòÁ¡
      ,RANK()OVER(PARTITION BY Àü°ø
                  ORDER BY ÆòÁ¡ DESC) as Àü°øº°¼øÀ§
      ,RANK()OVER(ORDER BY ÆòÁ¡ DESC) as ÀüÃ¼¼øÀ§
FROM ÇÐ»ý;

-- ºÐ¼®ÇÔ¼ö¿¡¼­ Áý°èÇÔ¼ö
SELECT emp_name, salary, department_id
      ,SUM(salary) OVER (PARTITION BY department_id) as ºÎ¼­º°ÇÕ°è
      ,SUM(salary) OVER() as ÀüÃ¼ÇÕ°è
FROM employees;

-- Àü°øº° ÇÐ»ý¼ö¸¦ ±âÁØÀ¸·Î ¼øÀ§¸¦ ±¸ÇÏ½Ã¿À
SELECT Àü°ø
      ,ÇÐ»ý¼ö
      ,RANK()OVER(ORDER BY ÇÐ»ý¼ö DESC) as Àü°øº°¼øÀ§
FROM(
        SELECT Àü°ø
              ,COUNT(Àü°ø) as ÇÐ»ý¼ö
        FROM ÇÐ»ý
        GROUP BY Àü°ø
       );  
       
-- À§ÀÇ Äõ¸®¹®À» °£·«ÇÏ°Ô ÇÑ ÁÙ·Î ¾²±â       
SELECT Àü°ø
      ,COUNT(*) as ÇÐ»ý¼ö
      ,RANK()OVER(PARTITION BY Àü°ø
                  ORDER BY COUNT(*) DESC ) as Àü°øº°ÇÐ»ý¼ö
FROM ÇÐ»ý
GROUP BY Àü°ø;

-- »óÇ°º° ÃÑÆÇ¸Å±Ý¾×°ú ¼øÀ§
-- »óÀ§ 10°³ »óÇ°

SELECT * FROM cart;
SELECT * FROM prod;

SELECT *
FROM(
        SELECT b.prod_id
              ,prod_name
              ,SUM(b.prod_sale* a.cart_qty) as ÇÕ°è
              ,RANK()OVER(ORDER BY SUM(b.prod_sale* a.cart_qty) DESC ) as ¼øÀ§
        FROM cart a, prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY b.prod_id, prod_name
        ORDER BY 3 DESC
    )
WHERE rownum <= 10;

--NTILE(expr) ÆÄÆ¼¼Çº°·Î expr¿¡ ¸í½ÃµÈ¸¸Å­ °ªÀ» ºÐÇÒ
--NTILE(3) 1~3»çÀÌ ¼ö¸¦ ¹ÝÈ¯: ºÐÇÒÇÏ´Â ¼ö¸¦ '¹öÅ¶ ¼ö'¶ó°í ÇÔ
--·Î¿ì °Ç ¼öº¸´Ù Å« ¼ö¸¦ ¸í½ÃÇÏ¸é ¹ÝÈ¯µÇ´Â ¼ö´Â ¹«½ÃµÊ
-- NTILE(3) = 3ºÐÇÒ ÇÑ´Ù
SELECT emp_name, department_id, salary
      ,NTILE(3) OVER(PARTITION BY department_id
                     ORDER BY salary) as nt
FROM employees
WHERE department_id IN (30,60);


/*
    LAG ¼±Çà ·Î¿ìÀÇ °ªÀ» °¡Á®¿Í¼­ ¹ÝÈ¯
    LEAD ÈÄÇà ·Î¿ìÀÇ °ªÀ» °¡Á®¿Í¼­ ¹ÝÈ¯
    ÁÖ¾îÁø ±×·ì°ú ¼ø¼­¿¡ µû¶ó ·Î¿ì¿¡ ÀÖ´Â Æ¯Á¤ ÄÃ·³ÀÇ °ªÀ» ÂüÁ¶ÇÒ ¶§ »ç¿ë
*/
SELECT emp_name, department_id, salary
        -- '1'´Ü°è ÀÌÀü ÇàÀÌ ÀÖÀ¸¸é 'emp_name'ÀÌ Ãâ·ÂµÇ°í ¾øÀ¸¸é '°¡Àå ³ôÀ½'ÀÌ Ãâ·ÂµÊ
      ,LAG(emp_name, 1 ,'°¡Àå³ôÀ½') OVER ( PARTITION BY department_id
                                            ORDER BY salary DESC) as lag
      ,LEAD(emp_name , 1, '°¡Àå³·À½') OVER (PARTITION BY department_id
                                            ORDER BY salary DESC) as leads
FROM employees
WHERE department_id IN (30, 60);

-- Àü°øº°·Î °¢ ÇÐ»ýÀÇ ÆòÁ¡º¸´Ù ÇÑ´Ü°è ¹Ù·Î ³ôÀº ÇÐ»ý°úÀÇ ÆòÁ¡ Â÷ÀÌ¸¦ Ãâ·Â


SELECT Àü°ø, ÀÌ¸§, ÆòÁ¡
      ,LAG(ÀÌ¸§, 1, '1µî') OVER (PARTITION BY Àü°ø
                                ORDER BY ÆòÁ¡ DESC) as ³ªº¸´ÙÀ§ÇÐ»ý
      ,LAG(ÆòÁ¡,1 ,ÆòÁ¡) OVER (PARTITION BY Àü°ø
                                        ORDER BY ÆòÁ¡ DESC)-ÆòÁ¡ as ÆòÁ¡Â÷ÀÌ                          
FROM ÇÐ»ý;

/* kor_loan_status Å×ÀÌºí¿¡ ÀÖ´Â µ¥ÀÌÅÍ¸¦ ÀÌ¿ëÇØ
    '¿¬µµº°' ÃÖÁ¾¿ù' ±âÁØ °¡Àå ´ëÃâÀÌ ¸¹Àº µµ½Ã¿Í ÀÜ¾×
    1. ¿¬µµº° ÃÖÁ¾¿ùÀº µ¥ÀÌÅÍ¸¶´Ù ´Ù ´Ù¸§
         - ¿¬µµº° °¡Àå Å« ¿ùÀ» ±¸ÇÔ.
    2. ¿¬µµº° ÃÖÁ¾¿ùÀ» ´ë»óÀ¸·Î ´ëÃâÀÜ¾×ÀÌ °¡Àå Å« ±Ý¾×À» ÃßÃâ
         - 1¹ø°ú Á¶ÀÎÇÏ¿© °¡Àå Å« ÀÜ¾×À» ±¸ÇÔ   
    3. ¿ùº°, Áö¿ªº° ´ëÃâÀÜ¾×°ú 2ÀÇ °á°ú¸¦ ºñ±³ÇØ ±Ý¾×ÀÌ °°Àº °ÇÀ» Ãâ·Â
        - 2¿Í Á¶ÀÎÇÏ¿© µÎ ±Ý¾×ÀÌ °°Àº °ÇÀÇ µµ½Ã¿Í ÀÜ¾× Ãâ·Â
*/

SELECT  SUBSTR(PERIOD,1,4) as ¿¬µµ
       ,RANK()OVER(PARTITION BY PERIOD
                   ORDER BY TO_NUMBER(SUBSTR(PERIOD,5,2))) as ¿ù
FROM kor_loan_status;



RANK()OVER(PARTITION BY Áö¿ª
                   ORDER BY loan_jan_amt DESC) as ¿ù
     
     
SELECT ³â¿ù, Áö¿ª, ÀÜ¾×
FROM(
    WITH a AS(
    SELECT TO_NUMBER(SUBSTR(PERIOD,1,4)) as ³â¿ù
          ,MAX(TO_NUMBER(SUBSTR(PERIOD,5,2))) as ¿ù
    FROM kor_loan_status
    GROUP BY TO_NUMBER(SUBSTR(PERIOD,1,4))
    )
    SELECT ³â¿ù||¿ù as ³â¿ù
          ,region as Áö¿ª
          ,SUM(loan_jan_amt) as ÀÜ¾×
          ,RANK()OVER(PARTITION BY ³â¿ù||¿ù
                       ORDER BY SUM(loan_jan_amt) DESC) as ¼øÀ§
    FROM a, kor_loan_status b
    WHERE a.³â¿ù||¿ù = b.period
    GROUP BY ³â¿ù||¿ù, region
)
where ¼øÀ§ = 1;



SELECT * FROM kor_loan_status

