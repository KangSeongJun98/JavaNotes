-- ���ڿ� ���ϱ�--
SElECT pc_no ||'['|| nm ||']' as info
FROM tb_info;

/* oralce ������ �Լ� (���� �Լ�) 
    ����Ŭ �Լ��� Ư¡�� select ���� ���Ǿ�� �ϱ� ������
    ������ ��ȯ���� ����( void ����)
    �����Լ��� �� Ÿ�̺� ����� �� �ִ� �Լ��� ����(�Լ� �� �� �Ű����� Ÿ�� ���������)
*/
-- 1. ���ڿ� �Լ� --
-- LOWER, UPPER --
SELECT LOWER('I LIKE MAC') as lowers
    ,UPPER('i like mac') as uppers
FROM dual; 
--�׽�Ʈ�� �ӽ� ���̺�(sql ���� ���߱� ����)

SELECT emp_name
FROM employees
WHERE LOWER(emp_name) = LOWER('WIlliam smith');

-- select �� ���� ����
-- (1)FROM -> (2)WHERE -> (3)GROUP BY -> (4)HAVING -> (5)SELECT -> (6)ORDER BY
SELECT 'hi'
FROM employees; -- ���̺� �Ǽ���ŭ ��ȸ��.

--SELECT emp_name
--FROM employees
--WHERE LOWER(emp_name) LIKE LOWER('%WILLIAM%');
-- �ؿ����� ������

SELECT emp_name
FROM employees
WHERE LOWER(emp_name) LIKE '%' || LOWER('WILLIAM') || '%';

--SUBSTR(char, pos, len) ����ڿ� char�� pos��°���� len ���̸�ŭ �ڸ���
--pos�� 0���� 1�� �� (1�� ����Ʈ)
--pos�� ������ ���� ���ڿ��� �� ������ ������ ����� ��ġ(-1�� �� ������)
--len�� �����Ǹ� pos��° ���� ������ ��� ���ڸ� ��ȯ
SELECT SUBSTR('ABCD EFG', 1, 4) as ex1
        ,SUBSTR('ABCD DFG',4) as ex2
        ,SUBSTR('ABCD DFG',-3,3) as ex3
FROM dual;


--INSTR ��� ���ڿ��� ��ġ ã��
--�Ű����� �� 4�� 2���� �ʼ� �ڿ��� ����Ʈ 1,1
--(p1, p2, p3, p4) p1����ڿ�, p2ã�� ����, p3ã�� ������ ��ġ, p4 ã�������� ���° ����
SELECT INSTR ('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����') as ex1
    ,  INSTR ('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',5) as ex2
    ,  INSTR ('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',1, 2) as ex3 --2��° ������ ã�°���
    ,  INSTR ('���� ���� �ܷο� ����, ���� ���� ���ο� ����','��') as ex4 -- ������ 0
FROM dual;

SELECT nm 
    ,  email
    ,  SUBSTR(email, 1 , INSTR(email,'@')-1 ) as ���̵�
    ,  SUBSTR(email,(INSTR(email,'@'))+1 ) as ������
FROM tb_info;