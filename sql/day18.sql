-- 단순루프
DECLARE
    vn_num NUMBER := 2;
    vn_cnt NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(vn_num ||'X'||vn_cnt || '='|| vn_num*vn_cnt);
        vn_cnt := vn_cnt +1; 
        EXIT WHEN vn_cnt > 9; --단순루프는 EXIT WHEN 으로 무조건 탈출조건 만들어줘야 함
    END LOOP;
END;
  


-- 이중 루프
DECLARE
    vn_num NUMBER := 2;
    vn_cnt NUMBER;
BEGIN
    LOOP
        vn_cnt := 1;
        DBMS_OUTPUT.PUT_LINE(vn_num ||'단');
            LOOP
                DBMS_OUTPUT.PUT_LINE(vn_num || 'X' ||vn_cnt || '=' || vn_num*vn_cnt);
                vn_cnt := vn_cnt +1; 
                EXIT WHEN vn_cnt > 9; --단순루프는 EXIT WHEN 으로 무조건 탈출조건 만들어줘야 함
            END LOOP;
        vn_num := vn_num+1;
        EXIT WHEN vn_num > 9;
    END LOOP;
END;

-- for문
DECLARE
    dan NUMBER := 2;
BEGIN
    FOR i IN 1..9
    LOOP
        CONTINUE WHEN i=5;
        DBMS_OUTPUT.PUT_LINE(dan || '*' || i || '=' || (dan*i));
    END LOOP;
END;

-- 사용자 정의 함수
-- oracle 함수는 무조건 리턴값이 1개 있어야 함
CREATE OR REPLACE FUNCTION my_mode(num1 NUMBER, num2 NUMBER)
RETURN NUMBER --반환 타입 정의

IS
    vn_remainder NUMBER := 0; --반활할 나머지
    vn_quotient NUMBER := 0; --몫
BEGIN
    vn_quotient := FLOOR(num1/num2);
    vn_remainder := num1 - (num2 * vn_quotient);
    RETURN vn_remainder; --나머지를 반환
END;

SELECT my_mode(4,2)
      ,mod(4,2)
FROM dual;

DROP FUNCTION my_mode;



/*
mem_id 를 입력받아 등급을 리턴하는 함수
( vip: 마일리지 5000 이상
  gold: 3000이상 5000미만
  silver: 나머지
  매개변수: mem_id(varchar2) 리턴값 : 등급(varchar2)
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