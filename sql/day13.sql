/*
    ������ ����
    ����Ŭ���� �����ϰ��ִ� ���
    ������ �����ͺ��̽�(RDB)�� �����ʹ� �������ε����ͷ� �������ִµ�
    ������������ ����� ������ ������ ǥ���� �� ����
    �޴�, �μ�, ���ѵ��� ������ ������ ���� �� ����
*/
SELECT department_id
     ,LPAD(' ', 3 * (LEVEL-1)) || department_name as �μ���
     ,LEVEL             --(����)Ʈ�� ���� � �ܰ谡 �ִ��� ��Ÿ���� ������
     ,parent_id
FROM departments
START WITH parent_id IS NULL                    --��������
CONNECT BY PRIOR department_id = parent_id;     --������ ��� ����Ǵ���

SELECT a.employee_id
      ,a.manager_id
      ,LPAD(' ', 3*(LEVEL-1)) || a.emp_name as �̸�
      ,b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
START WITH a.manager_id IS NULL
CONNECT BY PRIOR a.employee_id = a.manager_id
AND a.department_id = 30; -- �˻������� ������� �������� ����� �� ������ �־�� ��





INSERT INTO departments(
                        department_name
                      , department_id
                      , parent_id) 
VALUES('CHATBOT��', 280,  230);

SELECT a.employee_id
      ,a.manager_id
      ,LPAD(' ', 3*(LEVEL-1)) || a.emp_name as �̸�
      ,b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
START WITH a.manager_id IS NULL
CONNECT BY PRIOR a.employee_id = a.manager_id
-- ORDER BY b.department_id
ORDER SIBLINGS BY b.department_id; -- ���� ���� �ȿ��� �����ϴ� �� SIBLINGS
                                   -- �̷��� ���ϸ� Ʈ�� ����
                                   
                            
                            
/*
������ ������ �Լ�

*/

SELECT department_id
     ,LPAD(' ', 3 * (LEVEL-1)) || department_name as �μ���
     ,LEVEL             --(����)Ʈ�� ���� � �ܰ谡 �ִ��� ��Ÿ���� ������
     ,parent_id
     ,CONNECT_BY_ROOT department_name as rootNm -- root row (�ֻ��� �θ�)�� ����
     ,SYS_CONNECT_BY_PATH(department_name, '>') as pathNm
     ,CONNECT_BY_ISLEAF as leafNm -- ������ ���� 1, �ڽ������� 0
FROM departments
START WITH parent_id IS NULL                    --��������
CONNECT BY PRIOR department_id = parent_id;     --������ ��� ����Ǵ���
                                
CREATE TABLE test_info(
              �̸� VARCHAR(100)  
             ,��å VARCHAR(100)
             ,���� number
             ,�θ𷹺� number);

INSERT INTO test_info values('�̻���', '����', 1, NULL);
INSERT INTO test_info values('�����', '����', 2, 1);
INSERT INTO test_info values('������', '����', 3, 2);
INSERT INTO test_info values('�����', '����', 4, 3);
INSERT INTO test_info values('�̴븮', '�븮', 5, 4);
INSERT INTO test_info values('�ֻ��', '���', 6, 5);
INSERT INTO test_info values('�����', '���', 6, 5);
INSERT INTO test_info values('�ڰ���', '����', 14, 3);
INSERT INTO test_info values('��븮', '�븮', 15, 14);
INSERT INTO test_info values('�ֻ��', '���', 16, 15);

SELECT �̸�
      ,LPAD(' ', 3*(LEVEL-1)) || ��å as ��å 
      ,LEVEL as ����
FROM test_info
START WITH �θ𷹺� IS NULL
CONNECT BY PRIOR ���� = �θ𷹺�;

/*
 ������ ���� ���� (���� ������ ����)
 LEVEL�� ���� ���ν� (CONNECT BY ���� �Բ� ���)
*/

SELECT '2013'||LPAD(LEVEL,2,'0') as ���
FROM dual
CONNECT BY LEVEL <=12;




SELECT a.���
      ,NVL(b.�����հ�,0)
FROM (SELECT '2013'||LPAD(LEVEL,2,'0') as ���
      FROM dual
      CONNECT BY LEVEL <=12) a
      
     ,(
       SELECT period as ���
      ,SUM(loan_jan_amt) as �����հ�
       FROM kor_loan_status
       WHERE period LIKE '%2013%'
       GROUP BY period) b
WHERE a.��� = b.���(+)
ORDER BY 1;


-- connect by level ���
SELECT TO_CHAR(SYSDATE,'YYYY')||LPAD(LEVEL,2,'0') as ���
FROM dual
CONNECT BY LEVEL <=12;


SELECT TO_CHAR(SYSDATE,'YYYY/MM')||'/'||LPAD(LEVEL,2,'0') as ��
FROM dual
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(SYSDATE),'dd');


SELECT NVL(b.���,'�հ�')as ����_��
      ,COUNT(a.���) as ȸ����
FROM(      
       SELECT TO_CHAR(mem_bir,'MM') as ���
       FROM member) a
,
(SELECT LPAD(LEVEL,2,'0') as ���
FROM dual
CONNECT BY LEVEL <=12) b
WHERE b.��� = a.���(+)
GROUP BY ROLLUP (b.���)
ORDER BY 1;
