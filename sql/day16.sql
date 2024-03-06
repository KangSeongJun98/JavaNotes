/*
    �м��Լ��� window�� (group �ȿ� �κ�����)
    ROWS: �� ������ WINDOW ���� ����
    RANGE: ������ ������ WINDOW�� ����
    PRECEDING: ��Ƽ������ ���е� ù��° �ο찡 ������
    FOLLOWING: ��Ƽ������ ���е� ������ �ο찡 ������
    CURRENT ROW: ���� �ο�
*/
SELECT department_id, emp_name, hire_date, salary
      ,SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                         ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW) as first_curr
                         -- ���� �Ի簡 ���� ������� ���� �ο�
FROM employees
WHERE department_id IN (30, 90);



SELECT department_id, emp_name, hire_date, salary
      ,SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                         ROWS BETWEEN CURRENT ROW
                         AND UNBOUNDED FOLLOWING) as curr_last
                         -- ���� �ο���� ��
FROM employees
WHERE department_id IN (30, 90);





SELECT department_id, emp_name, hire_date, salary
      ,SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                         ROWS BETWEEN 1 PRECEDING
                         AND CURRENT ROW) as rowl_curr
                         -- 1������ + ���� �ο�
FROM employees
WHERE department_id IN (30, 90);

-- study ������ reservation, order_info ���̺��� �̿���
-- ���� ���� �ݾ��� ���
-- RAOIO_TO_REPORT:
-- ���� �� �� �׸��� ������ ��� (���� ������ �ش� ���� �����ϴ� ����)

select t1.*
      ,SUM(t1.sales)over(ORDER BY months
                         ROWS BETWEEN  UNBOUNDED
                         preceding and current row) as �����հ�   
      ,ROUND(RATIO_TO_REPORT(t1.sales) OVER () * 100,2) || '%' as ����
FROM(
    SELECT SUBSTR(a.reserv_date, 1, 6) as months
          ,SUM(b.sales) as sales          
    FROM reservation a , order_info b
    WHERE a.RESERV_NO = b.RESERV_NO
    GROUP BY SUBSTR(a.reserv_date, 1, 6)
    ORDER BY 1
) t1;

