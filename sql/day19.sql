/*
    ���ν��� PROCEDURE
    �Լ��� ����ϰ� Ư�� ������ �����ϱ� ���� ���Ǵµ�
    �ٸ����� db server�� ��ϵǾ� ����Ǳ� ������ �����ϸ� ������.
    ������ 0 ~ n���� �� ����
    
    ���λ�� �Ű������� IN (default)
    ���ο��� ��� �� ���ϵǴ� ������ IN OUT
    ���ο��� ����� �� ���� ���ϸ� ������ ������ OUT

*/
CREATE OR REPLACE PROCEDURE test_proc(
    p_var1 VARCHAR2 
   ,p_var2 OUT VARCHAR2
   ,p_var3 IN OUT VARCHAR2
)
IS      --�����
BEGIN   --�����
    DBMS_OUTPUT.PUT_LINE('p_var1:'||p_var1);
    DBMS_OUTPUT.PUT_LINE('p_var2:'||p_var2);
    DBMS_OUTPUT.PUT_LINE('p_var3:'||p_var3);
    -- ���� ������ out�� in out ������ test2, test3�� ������ ����ż� ��� ����
    p_var2 := 'B2';
    p_var3 := 'C2';
END;


--test
DECLARE 
    test1 VARCHAR2(10) := 'A';
    test2 VARCHAR2(10) := 'B';
    test3 VARCHAR2(10) := 'C';
BEGIN
    test_proc(test1, test2, test3); -- ���ν��� ȣ��
    DBMS_OUTPUT.PUT_LINE('test2:' || test2);
    DBMS_OUTPUT.PUT_LINE('test3:' || test3);
END;


CREATE OR REPLACE PROCEDURE haksa_proc(
    p_hak_no NUMBER
   ,p_nm     VARCHAR2
)
IS
BEGIN
    INSERT INTO �л�(�й�, �̸�)
    VALUES (p_hak_no, p_nm);
    COMMIT;
END;

-- ���� �����θ� ���ִ� ���ν����� �̷��� ���� ����
-- EXEC �Ǵ� EXCUTE
EXEC haksa_proc(1, '����');
EXECUTE haksa_proc(2, '����');
SELECT * FROM �л�;

--���ν��� ����
DROP PROCEDURE haksa_proc;

