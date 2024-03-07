/*
    PL/SQL ������ ���� ������ ����� Ư¡�� ��� ������ ����.
    Ư�� ����� ó���ϴ� �Լ�, ���ν���, Ʈ���� ���� ���� �� ����
    DB���ο� ������� �Ϲ� ���α׷��� ���� ����
*/
--�⺻ ������ ����̶�� �ϸ� ����� �̸���, �����, �����(����ó����)�� ���� �� 

SET SERVEROUTPUT ON;
--PL/SQL ���� ����� ��ũ��Ʈ�� ���
--�̰� �ƴϸ� ����-> DBMS��¿��� +��ư ������ ���ӱ��� �������

DECLARE--                      <-- �͸���
 vi_num NUMBER;                -- ���� ����
BEGIN
 vi_num:=100;                  -- �� �Ҵ�
 DBMS_OUTPUT.PUT_LINE(vi_num); -- ����Ʈ
 END;
 -- PL/sql ������ ��ü ����� ���� �� �����ؾ� ��.
 
 --����ο��� DML���� �� �� ����
 DECLARE
    vs_emp_name VARCHAR2(80); -- number�� ������ �Ƚᵵ ��
    vs_dep_name departments.department_name%TYPE; -- ���̺� �÷��� Ÿ���� �����ͼ� Ÿ������ ����
BEGIN
    SELECT a.emp_name, b.department_name       -- ����Ʈ ������ �����°� 
        INTO vs_emp_name, vs_dep_name          -- ������ ����
    FROM employees a, departments b
    WHERE a.department_id = b.department_id
    AND a.employee_id = 100;                   -- �ϳ��� �������� 1���� �� ���� �Ҵ� ����
    DBMS_OUTPUT.PUT_LINE(vs_emp_name || ':' || vs_dep_name);
END;

-- ������ �ʿ� ���ٸ� ����θ� ���� ����
BEGIN 
 DBMS_OUTPUT.PUT_LINE('3*3='|| 3*3);
END;


-- IF ��
DECLARE
    vn_num1 NUMBER := 5;
    vn_num2 NUMBER := :num; -- ���ε�
BEGIN
    IF vn_num1 > vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE('vn_num1 �� ŭ');
    ELSIF vn_num1 = vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE('����');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('vn_num2 �� ŭ');
    END IF; --end�� �� �ݾ���� ��
END;
-- pl/sql���� else�� ������ �ȵǴµ� null �� �ָ� ��



DECLARE
    vn_this_year VARCHAR2(4) := TO_CHAR(SYSDATE, 'YYYY');
    vn_max_hak_no NUMBER;
    vn_make_hak_no NUMBER;
BEGIN
-- ���� ū �� ��ȸ
-- �� �� ��ȣ ����
   SELECT MAX(�й�) 
   INTO vn_max_hak_no
   FROM �л�;
   DBMS_OUTPUT.PUT_LINE(vn_max_hak_no);
   
     IF vn_this_year = SUBSTR(vn_max_hak_no,1,4) THEN
        vn_make_hak_no := (vn_max_hak_no+1);
        DBMS_OUTPUT.PUT_LINE('�⵵ ����');
     ELSE
        vn_make_hak_no := vn_this_year ||'000001';
     END IF;
     
     DBMS_OUTPUT.PUT_LINE('������ȣ:'||vn_make_hak_no);
     INSERT INTO �л�(�й�, �̸�, ����) VALUES (vn_make_hak_no, :nm, :sub);
     COMMIT;
END;

select * from �л�;