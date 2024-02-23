-- EXISTS �����ϴ��� üũ
-- EXISTS ���������� ���̺� �˻������� �����Ͱ� �����ϸ�
--        �����ϴ� �����Ϳ� ���ؼ� ������������ ��ȸ

SELECT a.department_id
      ,a.department_name
FROM departments a
WHERE EXISTS ( SELECT * -- select�κ��� ���� ���� ��� ����
               FROM job_history b
               WHERE b.department_id = a.department_id);



SELECT a.department_id
      ,a.department_name
FROM departments a
WHERE NOT EXISTS ( SELECT 1 -- NOT EXISTS �������� �ʴ�
               FROM job_history b
               WHERE b.department_id = a.department_id);

-- �����̷��� ���� �л��� ��ȸ�Ͻÿ�
SELECT*
FROM �л� a
WHERE NOT EXISTS ( SELECT *
                   FROM ��������
                   WHERE �й� = a.�й�);
               
               
-- ���̺� ����    
CREATE TABLE emp_temp AS
SELECT *
FROM employees;
-- update�� ��ø���� ���
-- �� ����� �޿��� ��ձݾ����� ����
UPDATE emp_temp
SET salary = (SELECT AVG(salary)
              FROM emp_temp);
ROLLBACK;
SELECT* FROM emp_temp;               

-- ��� �޿����� ���� �޴� ��� ����
DELETE emp_temp
WHERE salary >= (SELECT AVG(salary)
                 FROM emp_temp);
                 

-- �ǹ����� ���� ����
SELECT a.�й�
      ,a.�̸�
      ,b.����������ȣ
FROM �л� a, �������� b
WHERE a.�й� = b.�й�;


-- �̱� ���� ǥ�� ��ȸ ANSI
-- FROM ���� join�� ��
-- inner join(equi-join)�� ǥ�� ANSI JOIN �������
-- ANSI JOIN�� WHERE���� �Ȱ��� FROM������ ���� �� ������
SELECT a.�й�
      ,a.�̸�
      ,b.����������ȣ
FROM �л� a
INNER JOIN �������� b
on(a.�й� = b.�й�);

SELECT a.�й�
      ,a.�̸�
      ,b.����������ȣ
      ,c.�����̸�
FROM �л� a
INNER JOIN �������� b
ON(a.�й� = b.�й�)
INNER JOIN ���� c
USING(�����ȣ); -- on ��� �÷����� �����ϴٸ� using�� �� ���� ����, �̷��� �ϸ� ����Ʈ �������� �ٲ���� ��
                 -- ���̺� as �ؼ� ��Ī �ִ� �͵� �ȵ�
                 
--ANSI OUTER JOIN
--LEFT OUTER JOIN or RIGHT OUTER JOIN

-- �Ϲ� outer join
SELECT *
FROM �л� a
    ,�������� b
WHERE a.�й� = b.�й�(+);

SELECT *
FROM �л� a
LEFT OUTER JOIN
�������� b
ON(a.�й�= b.�й�); --�л��� ���ʿ� ��ġ�Ѵ�


SELECT *
FROM �������� b
RIGHT OUTER JOIN
�л� a
ON(a.�й�= b.�й�); --�л��� �����ʿ� ��ġ�Ѵ�

-- �ų� ��������(Americans, Asia)�� �� �Ǹ� �ݾ��� ���
-- sales, customers, countries ���̺� ���
-- ������ country_region, �Ǹűݾ��� amount_sold
-- join�� �Ἥ

SELECT * FROM sales; --cust id
SELECT * FROM customers; --country_id / --cust id
SELECT * FROM countries; -- country_id

SELECT TO_CHAR(sales_date, 'YYYY') as �⵵
      ,country_region as ����
      ,SUM(amount_sold) as �Ǹűݾ�
FROM   countries a,customers b, sales c
WHERE a.country_id = b.country_id
AND b.cust_id = c.cust_id
AND country_region IN ('Americas', 'Asia')
GROUP BY TO_CHAR(sales_date, 'YYYY'),country_region
ORDER BY 2;

--DML(������ ���۾�) (SELECT,INSERT,DELETE,UPDATE,MERGE) ��  MERGE�� (����) 

/*  MERGE(����)
    Ư�� ���ǿ� ���� ������̺� ����
    INSERT or UPDATE or DELETE�� �ؾ� �� �� 1���� sql�� ó�� ����
*/
--�������̺� �ӽŷ��� ������ ������ INSERT ������ 2������
--                             ������ UPDATE ������ 3������                       


-- MERGE 1. ������̺��� �� ���̺��� ���(���� ���̺��� merger�� ��)
SELECT * FROM ����;

MERGE INTO ���� a
    USING DUAL -- �� ���̺� dual �� ������̺� = �����̺� �ΰ��
    ON(a.�����̸�='�ӽŷ���') -- MATCH ����
WHEN MATCHED THEN
    UPDATE SET a.���� = 3        -- merge�� insert�� update( where )�� ���̺� ���� ����
WHEN NOT MATCHED THEN
    INSERT (a.�����ȣ, a.�����̸�, a.����)
    values((SELECT MAX(NVL(a.�����ȣ,0)+1)
                    FROM ����)
                  ,'�ӽŷ���',2);

--MERGE 2. �ٸ� ���̺� MATCH ������ �� ���
-- (1) ������̺��� ������ ��� 146�� �����ȣ�� ��ġ�ϴ�
--     ������ ���ʽ� �ݾ��� �޿��� 1%�� ������Ʈ
--     ����� ��ġ�ϴ°� ���ٸ� �޿��� 8000 �̸��� ����� 0.1%�� �μ�Ʈ
-- üũ�� employees ���̺��� ���� ������Ʈ �μ�Ʈ ���� emp_info���� �ȴ�.

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
    ON(a.emp_id = b.employee_id) --match ����
WHEN MATCHED THEN
    UPDATE SET a.bonus = a.bonus + b.salary*0.01
WHEN NOT MATCHED THEN
    INSERT(a.emp_id, a.bonus) VALUES(b.employee_id, b.salary *0.001)
    WHERE (b.salary < 8000);

SELECT * FROM emp_info;
SELECT * FROM tb_info;
SELECT * FROM INFO;

-- ������( mbti, team )update
-- ������ insert team
MERGE INTO tb_info a
USING ( SELECT info_no
              ,team
              ,mbti
        FROM info)b
ON(a.info_no = b.info_no) --��ġ ����
WHEN MATCHED THEN
    UPDATE SET a.mbti = b.mbti
              ,a.team = b.team
WHEN NOT MATCHED THEN
    INSERT(a.INFO_NO, a.NM, a.EMAIL, a.MBTI, a.PC_NO)
    VALUES(0, '�̾ձ�','leeapgil@gamil.com','ENFJ');

SELECT NM
      ,MBTI
      ,CASE 
       WHEN SUBSTR(MBTI,1,1) = 'I' THEN '������'
       WHEN SUBSTR(MBTI,1,1) = 'E' THEN '������'
       END AS ����������
       ,CASE 
       WHEN SUBSTR(MBTI,2,1) = 'N' THEN '������'
       WHEN SUBSTR(MBTI,2,1) = 'S' THEN '������'
       END AS �νı��
       ,CASE 
       WHEN SUBSTR(MBTI,3,1) = 'T' THEN '�����'
       WHEN SUBSTR(MBTI,3,1) = 'F' THEN '������'
       END AS �Ǵܱ��
       ,CASE 
       WHEN SUBSTR(MBTI,4,1) = 'J' THEN '�Ǵ���'
       WHEN SUBSTR(MBTI,4,1) = 'P' THEN '�ν���'
       END AS ��Ȱ���
       
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
       WHEN SUBSTR(MBTI,1,1) = 'I' THEN '������'
       WHEN SUBSTR(MBTI,1,1) = 'E' THEN '������'
       END AS ����������
       ,CASE 
       WHEN SUBSTR(MBTI,2,1) = 'N' THEN '������'
       WHEN SUBSTR(MBTI,2,1) = 'S' THEN '������'
       END AS �νı��
       ,CASE 
       WHEN SUBSTR(MBTI,3,1) = 'T' THEN '�����'
       WHEN SUBSTR(MBTI,3,1) = 'F' THEN '������'
       END AS �Ǵܱ��
       ,CASE 
       WHEN SUBSTR(MBTI,4,1) = 'J' THEN '�Ǵ���'
       WHEN SUBSTR(MBTI,4,1) = 'P' THEN '�ν���'
       END AS ��Ȱ���
       FROM tb_info
       WHERE MBTI != '?') a
       
GROUP BY SUBSTR(MBTI,1,1),  
         SUBSTR(MBTI,2,1),
         SUBSTR(MBTI,3,1),
         SUBSTR(MBTI,4,1)
ORDER BY 1;
 