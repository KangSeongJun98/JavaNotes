/*
WITH��: ��Ī���� ����� SELECT ���� �ٸ� SELECT ������ ��Ī���� ���� ����
        �ݺ����ٴ� ���������� �ִٸ� ����ó�� �ѹ� �ҷ��ͼ� ���
        ������ ��������� ���̺��� Ž���� �� ���� ���
        temp ��� �ӽ����̺��� ����ؼ� ��ð� �ɸ��� ������ ����� �����س���
        �����س��� �����͸� �������ϱ� ������ ������ ���� �� ����
*/
WITH a AS  (-- ��Ī
           SELECT *
           FROM employees
           )
SELECT * FROM a;

-- 8 ~ 14 �ڸ�, �빮��1, �ҹ���1, Ư������1
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
AND REGEXP_LIKE(pw, '[^a-zA-Z0-9��-�R]');


-- ���� īƮ ���Ƚ���� ���� ���� ���� ���� ���� ���� ������ ����Ͻÿ�
-- (���� �̷��� �ִ� ����)


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



--���� ������ with ���

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
 2000�⵵ ��Ż������ '����� �����'���� ū '���� ��� �����'
 �̾��� '���', '�����' �� ���(�Ҽ����� �ݿø�)
*/
SELECT cust_id, sales_month, amount_sold
FROM sales;

SELECT cust_id, country_id
FROM customers;

SELECT country_id, country_name
FROM countries;

--�����
SELECT ROUND(AVG(a.amount_sold)) as year_avg
FROM sales a, customers b, countries c
WHERE a.cust_id= b.cust_id
AND b.country_id = c.country_id
AND a.sales_month LIKE '%2000%'
AND c.country_name = 'Italy';

-- �����
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
    �м��Լ�: �ο�ս� ���� ���谪�� ���� �� �� ���� (over Ű���尡 ��)
    ���� ���� or �ο������������ �κ����踦 �� �� ����
    (ex ���� �����հ�)  
    �Լ�����: avg, sum, max, min, count, dense_rank, rank, lag.....
    PARTITION BY:  �׷�  
                    -> ('�׷� ��' '����') �� �� ��� partition ���� ��ü ���谡 ����
    ORDER BY : ��������
    WINDOW: �׷�ȿ� ���� �׷����� ���� �� ��
*/


-- �μ��� �̸������� ���� ù��° ������ ����Ͻÿ�
SELECT *
FROM(SELECT department_id, emp_name
      ,ROW_NUMBER() OVER (PARTITION BY department_id
                          ORDER BY emp_name) as dep_rownum
     FROM employees)
where dep_rownum =1;


-- rank ���� ���� ���� �� �ǳ� ��
-- dense_rank �ǳʶ��� ����

SELECT department_id , emp_name, salary
     ,RANK()OVER(PARTITION BY department_id
                 ORDER BY salary DESC) as rnk
     ,DENSE_RANK()OVER(PARTITION BY department_id
                 ORDER BY salary DESC) as dense_rnk
FROM employees;

-- �л����� ������ ����(��������)�� �������� ������ ����Ͻÿ�
SELECT �̸�,����,����
      ,RANK()OVER(PARTITION BY ����
                  ORDER BY ���� DESC) as ����������
      ,RANK()OVER(ORDER BY ���� DESC) as ��ü����
FROM �л�;

-- �м��Լ����� �����Լ�
SELECT emp_name, salary, department_id
      ,SUM(salary) OVER (PARTITION BY department_id) as �μ����հ�
      ,SUM(salary) OVER() as ��ü�հ�
FROM employees;

-- ������ �л����� �������� ������ ���Ͻÿ�
SELECT ����
      ,�л���
      ,RANK()OVER(ORDER BY �л��� DESC) as ����������
FROM(
        SELECT ����
              ,COUNT(����) as �л���
        FROM �л�
        GROUP BY ����
       );  
       
-- ���� �������� �����ϰ� �� �ٷ� ����       
SELECT ����
      ,COUNT(*) as �л���
      ,RANK()OVER(PARTITION BY ����
                  ORDER BY COUNT(*) DESC ) as �������л���
FROM �л�
GROUP BY ����;

-- ��ǰ�� ���Ǹűݾװ� ����
-- ���� 10�� ��ǰ

SELECT * FROM cart;
SELECT * FROM prod;

SELECT *
FROM(
        SELECT b.prod_id
              ,prod_name
              ,SUM(b.prod_sale* a.cart_qty) as �հ�
              ,RANK()OVER(ORDER BY SUM(b.prod_sale* a.cart_qty) DESC ) as ����
        FROM cart a, prod b
        WHERE a.cart_prod = b.prod_id
        GROUP BY b.prod_id, prod_name
        ORDER BY 3 DESC
    )
WHERE rownum <= 10;

--NTILE(expr) ��Ƽ�Ǻ��� expr�� ��õȸ�ŭ ���� ����
--NTILE(3) 1~3���� ���� ��ȯ: �����ϴ� ���� '��Ŷ ��'��� ��
--�ο� �� ������ ū ���� ����ϸ� ��ȯ�Ǵ� ���� ���õ�
-- NTILE(3) = 3���� �Ѵ�
SELECT emp_name, department_id, salary
      ,NTILE(3) OVER(PARTITION BY department_id
                     ORDER BY salary) as nt
FROM employees
WHERE department_id IN (30,60);


/*
    LAG ���� �ο��� ���� �����ͼ� ��ȯ
    LEAD ���� �ο��� ���� �����ͼ� ��ȯ
    �־��� �׷�� ������ ���� �ο쿡 �ִ� Ư�� �÷��� ���� ������ �� ���
*/
SELECT emp_name, department_id, salary
        -- '1'�ܰ� ���� ���� ������ 'emp_name'�� ��µǰ� ������ '���� ����'�� ��µ�
      ,LAG(emp_name, 1 ,'�������') OVER ( PARTITION BY department_id
                                            ORDER BY salary DESC) as lag
      ,LEAD(emp_name , 1, '���峷��') OVER (PARTITION BY department_id
                                            ORDER BY salary DESC) as leads
FROM employees
WHERE department_id IN (30, 60);

-- �������� �� �л��� �������� �Ѵܰ� �ٷ� ���� �л����� ���� ���̸� ���


SELECT ����, �̸�, ����
      ,LAG(�̸�, 1, '1��') OVER (PARTITION BY ����
                                ORDER BY ���� DESC) as ���������л�
      ,LAG(����,1 ,����) OVER (PARTITION BY ����
                                        ORDER BY ���� DESC)-���� as ��������                          
FROM �л�;

/* kor_loan_status ���̺� �ִ� �����͸� �̿���
    '������' ������' ���� ���� ������ ���� ���ÿ� �ܾ�
    1. ������ �������� �����͸��� �� �ٸ�
         - ������ ���� ū ���� ����.
    2. ������ �������� ������� �����ܾ��� ���� ū �ݾ��� ����
         - 1���� �����Ͽ� ���� ū �ܾ��� ����   
    3. ����, ������ �����ܾװ� 2�� ����� ���� �ݾ��� ���� ���� ���
        - 2�� �����Ͽ� �� �ݾ��� ���� ���� ���ÿ� �ܾ� ���
*/

SELECT  SUBSTR(PERIOD,1,4) as ����
       ,RANK()OVER(PARTITION BY PERIOD
                   ORDER BY TO_NUMBER(SUBSTR(PERIOD,5,2))) as ��
FROM kor_loan_status;



RANK()OVER(PARTITION BY ����
                   ORDER BY loan_jan_amt DESC) as ��
     
     
SELECT ���, ����, �ܾ�
FROM(
    WITH a AS(
    SELECT TO_NUMBER(SUBSTR(PERIOD,1,4)) as ���
          ,MAX(TO_NUMBER(SUBSTR(PERIOD,5,2))) as ��
    FROM kor_loan_status
    GROUP BY TO_NUMBER(SUBSTR(PERIOD,1,4))
    )
    SELECT ���||�� as ���
          ,region as ����
          ,SUM(loan_jan_amt) as �ܾ�
          ,RANK()OVER(PARTITION BY ���||��
                       ORDER BY SUM(loan_jan_amt) DESC) as ����
    FROM a, kor_loan_status b
    WHERE a.���||�� = b.period
    GROUP BY ���||��, region
)
where ���� = 1;



SELECT * FROM kor_loan_status

