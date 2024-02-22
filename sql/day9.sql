/* ���� ���� 
    2. �ζ��� ��(FROM ��)
    SELECT ���� ���� ����� ��ġ ���̺� ó�� ���*/
SELECT * 
FROM(   SELECT �л�.�й�
       ,�л�.�̸�
       ,�л�.����
       ,COUNT(��������.����������ȣ) as ���������Ǽ�
        FROM �л�, ��������
        where �л�.�й� = ��������.�й�(+)
        GROUP BY �л�.�й�, �л�.�̸�, �л�.����
        ORDER BY 4 DESC) a --FROM ���� ���� select �� �� ���̺�ó�� ����� ����
WHERE ROWNUM =1;


SELECT * 
FROM(SELECT ROWNUM as runm
      , a.* -- a���̺� ��ü�÷�
      FROM( SELECT ROWNUM as subRnum, mem_id, mem_name 
            FROM member
            WHERE mem_name LIKE '%%'
            ORDER BY mem_name
            ) a
            
        ) --where���� ���� ���� �� �� �� ���Ѱ�
          --where rownum�� ������ �ϴϱ� 
WHERE runm BETWEEN 1 AND 10;
--rownum�� select�� �� ������ ������

--�л��� �� ������ ���� ���� 5��

SELECT * 
FROM(
    SELECT �̸�,����
    FROM �л�
    ORDER BY 2 DESC
    )
WHERE ROWNUM <= 5;
-- order by�� ���� �������� ����Ǳ� ������ 
-- �ٷ� where rownum �� ������� ������ �ȵ� ������ ���̺��� ����


-- 5� ��ȸ
-- rownum�� �ϳ��� �÷����� ����� ��� ��
SELECT *
FROM( SELECT   ROWNUM as rnum
               ,a.* 
        FROM(
             SELECT �̸�,����
             FROM �л�
             ORDER BY 2 DESC
             ) a
    )
WHERE rnum = 5;

-- �л����� �濵�п��� ������ ���� ���� �л��� ������ ���
SELECT * FROM �л�;

SELECT  *   
FROM(   SELECT �̸�,����,���� 
        FROM �л�
        where ���� = '�濵��'
        ORDER BY 3 DESC)
WHERE ROWNUM <=1;



-- �л����� '������' '����'�� '�������' �л��� ����
SELECT *
FROM �л�
WHERE(����, ����) IN (SELECT ����, MAX(����)
                      FROM �л�
                      GROUP BY ����);


-- 2000�⵵ �Ǹ�(�ݾ�) �� ��� (sales, employees)
-- �Ǹ� ���� �÷� amount_sold, quantity_sold(�ǸŰ���), sales_data
-- ��Į�󼭺������� �ζ��κ� ���

SELECT * FROM employees;
SELECT * FROM sales;


SELECT *
FROM( SELECT emp_name as �̸�
      ,a.employee_id as ���
      ,TO_CHAR(SUM(amount_sold),'999,999,999.99') as �Ǹűݾ�
      ,COUNT(quantity_sold) as �Ǹż���
      FROM employees a, sales b
      WHERE a.employee_id = b.employee_id
      AND TO_CHAR(sales_date, 'YYYY') = 2000
      GROUP BY emp_name, a.employee_id
      ORDER BY SUM(amount_sold) DESC )
WHERE ROWNUM <=1;