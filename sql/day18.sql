-- �ܼ�����
DECLARE
    vn_num NUMBER := 2;
    vn_cnt NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(vn_num ||'X'||vn_cnt || '='|| vn_num*vn_cnt);
        vn_cnt := vn_cnt +1; 
        EXIT WHEN vn_cnt > 9; --�ܼ������� EXIT WHEN ���� ������ Ż������ �������� ��
    END LOOP;
END;
  


-- ���� ����
DECLARE
    vn_num NUMBER := 2;
    vn_cnt NUMBER;
BEGIN
    LOOP
        vn_cnt := 1;
        DBMS_OUTPUT.PUT_LINE(vn_num ||'��');
            LOOP
                DBMS_OUTPUT.PUT_LINE(vn_num || 'X' ||vn_cnt || '=' || vn_num*vn_cnt);
                vn_cnt := vn_cnt +1; 
                EXIT WHEN vn_cnt > 9; --�ܼ������� EXIT WHEN ���� ������ Ż������ �������� ��
            END LOOP;
        vn_num := vn_num+1;
        EXIT WHEN vn_num > 9;
    END LOOP;
END;

-- for��
DECLARE
    dan NUMBER := 2;
BEGIN
    FOR i IN 1..9
    LOOP
        CONTINUE WHEN i=5;
        DBMS_OUTPUT.PUT_LINE(dan || '*' || i || '=' || (dan*i));
    END LOOP;
END;

-- ����� ���� �Լ�
-- oracle �Լ��� ������ ���ϰ��� 1�� �־�� ��
CREATE OR REPLACE FUNCTION my_mode(num1 NUMBER, num2 NUMBER)
RETURN NUMBER --��ȯ Ÿ�� ����

IS
    vn_remainder NUMBER := 0; --��Ȱ�� ������
    vn_quotient NUMBER := 0; --��
BEGIN
    vn_quotient := FLOOR(num1/num2);
    vn_remainder := num1 - (num2 * vn_quotient);
    RETURN vn_remainder; --�������� ��ȯ
END;

SELECT my_mode(4,2)
      ,mod(4,2)
FROM dual;

DROP FUNCTION my_mode;



/*
mem_id �� �Է¹޾� ����� �����ϴ� �Լ�
( vip: ���ϸ��� 5000 �̻�
  gold: 3000�̻� 5000�̸�
  silver: ������
  �Ű�����: mem_id(varchar2) ���ϰ� : ���(varchar2)
)
*/

CREATE OR REPLACE FUNCTION fn_grade(p_mem_id VARCHAR2)
    RETURN VARCHAR2
IS
    grade VARCHAR2(20);
    mlg NUMBER(10);
BEGIN
    SELECT mem_mileage
    INTO mlg
    FROM member a
    where mem_id = p_mem_id; 
    
    IF mlg>=5000 THEN 
        grade:='vip';
    ELSIF mlg >= 3000 AND mlg <5000 THEN 
        grade:='gold'; 
    ELSE   
        grade:= 'silver';
    END IF;
    RETURN grade;
END;

SELECT mem_name, mem_mileage, fn_grade(mem_id)
FROM member;