/*
    프로시저 PROCEDURE
    함수와 비슷하게 특정 로직을 수행하기 위해 사용되는데
    다른점은 db server에 등록되어 실행되기 때문에 안전하며 빠르다.
    리턴이 0 ~ n개일 수 있음
    
    내부사용 매개변수는 IN (default)
    내부에서 사용 후 리턴되는 변수는 IN OUT
    내부에서 사용할 수 없고 리턴만 가능한 변수는 OUT

*/
CREATE OR REPLACE PROCEDURE test_proc(
    p_var1 VARCHAR2 
   ,p_var2 OUT VARCHAR2
   ,p_var3 IN OUT VARCHAR2
)
IS      --선언부
BEGIN   --실행부
    DBMS_OUTPUT.PUT_LINE('p_var1:'||p_var1);
    DBMS_OUTPUT.PUT_LINE('p_var2:'||p_var2);
    DBMS_OUTPUT.PUT_LINE('p_var3:'||p_var3);
    -- 리턴 가능한 out과 in out 변수인 test2, test3만 변수에 저장돼서 사용 가능
    p_var2 := 'B2';
    p_var3 := 'C2';
END;


--test
DECLARE 
    test1 VARCHAR2(10) := 'A';
    test2 VARCHAR2(10) := 'B';
    test3 VARCHAR2(10) := 'C';
BEGIN
    test_proc(test1, test2, test3); -- 프로시저 호출
    DBMS_OUTPUT.PUT_LINE('test2:' || test2);
    DBMS_OUTPUT.PUT_LINE('test3:' || test3);
END;


CREATE OR REPLACE PROCEDURE haksa_proc(
    p_hak_no NUMBER
   ,p_nm     VARCHAR2
)
IS
BEGIN
    INSERT INTO 학생(학번, 이름)
    VALUES (p_hak_no, p_nm);
    COMMIT;
END;

-- 내부 변수로만 돼있는 프로시져는 이렇게 실행 가능
-- EXEC 또는 EXCUTE
EXEC haksa_proc(1, '팽하');
EXECUTE haksa_proc(2, '동길');
SELECT * FROM 학생;

--프로시저 삭제
DROP PROCEDURE haksa_proc;

