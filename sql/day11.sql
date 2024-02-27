/* 
    Á¤±Ô Ç¥Çö½Ä (Regular Expression)
    oracle 10gºÎÅÍ »ç¿ë °¡´É   REGEXP_   <- ·Î ½ÃÀÛÇÏ´Â ÇÔ¼ö
    .(dot) or []´Â ¹®ÀÚ¿­¿¡¼­ 1±ÛÀÚ¸¦ ÀÇ¹ÌÇÔ
    ^´Â ½ÃÀÛ $´Â ³¡À» ¶æ ÇÔ
    [^] ´Â(´ë°ýÈ£ ¾È¿¡ ^) not ÀÇ¹Ì
    
    ¹Ýº¹½ÃÄö½º
    *: 0°³ ÀÌ»ó,  +: 1°³ ÀÌ»ó, ?: 0~1°³
    {n}: n¹ø, {n,}n¹ø ÀÌ»ó {n,m} n¹ø ÀÌ»ó m¹ø ÀÌÇÏ
    
    REGEXP_LIKE: Á¤±Ô½Ä ÆÐÅÏ °Ë»ö
*/
SELECT *
FROM member
WHERE REGEXP_LIKE(mem_comtel, '^..-'); -- ½ÃÀÛÇØ¼­ µÎ±ÛÀÚ µÚ¿¡ -(ÇÏÀÌÇÂ) ³ª¿À´Â ÆÐÅÏ 

SELECT *
FROM member
WHERE REGEXP_LIKE(MEM_MAIL, '^[a-zA-Z]{3,5}@');

--ÇÑ±Û ¶ç¾î¾²±â ¼ýÀÚ ÆÐÅÏ ÃßÃâ
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[°¡-ÆR] [0-9]');

-- ÇÑ±Û·Î ³¡³ª´Â ÆÐÅÏ
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[°¡-ÆR]$');

--ÇÑ±Û¸¸ Æ÷ÇÔµÈ ÆÐÅÏ
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[°¡-ÆR]+$');

--ÇÑ±ÛÀÌ ¾Æ¿¹ ¾ø´Â ÆÐÅÏ
SELECT mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[^°¡-ÆR]+$');

-- |:¶Ç´Â, (): ÆÐÅÏ±×·ì
-- j·Î ½ÃÀÛÇÏ¸ç ,¼¼ ¹øÂ° ¹®ÀÚ°¡ m or n Á÷¿øÀÇ ÀÌ¸§ Á¶È¸
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE (emp_name,'^(J|j).(n|m)');


-- REGEXP_SUBSTR Á¤±Ô½Ä ÆÐÅÏ°ú ÀÏÄ¡ÇÏ´Â ¹®ÀÚ¿­ ¹ÝÈ¯
-- ÀÌ¸ÞÀÏ @¸¦ ±âÁØÀ¸·Î ¾Õ°ú µÚ¸¦ Ãâ·Â
SELECT mem_mail
      ,REGEXP_SUBSTR(mem_mail, '[^@]+' ,1 ,1) as ¾ÆÀÌµð
      ,REGEXP_SUBSTR(mem_mail, '[^@]+' ,1 ,2) as µµ¸ÞÀÎ
FROM member;

SELECT REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 1) as ex1
      ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 2) as ex2
      ,REGEXP_SUBSTR('A-B-C', '[^-]+', 1, 3) as ex3
FROM dual;


SELECT   mem_add1
        ,REGEXP_SUBSTR(mem_add1, '[^ ]+',1, 1) -- ¸Å°³º¯¼ö 3,4¹øÀÇ default°¡ 1,1 ÀÓ
FROM member;

--REGEXP_REPLACE ´ë»ó ¹®ÀÚ¿­¿¡¼­ Á¤±Ô Ç¥Çö½ÄÀ» Àû¿ëÇÏ¿© ´Ù¸¥ ÆÐÅÏÀ¸·Î ´ëÃ¼
--Ellen Hildi smith - > Smith, Ellen Hildi
SELECT REGEXP_REPLACE('Ellen Hildi Smith', '(.*) (.*) (.*)','\3, \1 \2')
FROM dual;

-- °ø¹é 2ÀÚ¸® ÀÌ»óÀ» Ã£¾Æ¼­ 1ÀÚ¸®·Î ´ëÃ¼
SELECT REGEXP_REPLACE('Joe               Smith   Hi', '( ){2,}',' ' )
FROM dual;

-- ´ëÀüÀÇ ÁÖ¼ÒµéÀ» ¸ðµÎ '´ëÀü'À¸·Î Ãâ·ÂÇÏ½Ã¿À
SELECT   mem_add1
        ,REGEXP_REPLACE(mem_add1,'(^´ëÀü½Ã|^´ëÀü±¤¿ª½Ã) (.*)', '´ëÀü \2' )
FROM member
WHERE mem_add1 LIKE '%´ëÀü%'
AND mem_id != 'p001';

--ÀüÈ­¹øÈ£ µÞÀÚ¸®¿¡¼­ µ¿ÀÏÇÑ ¹øÈ£°¡ ¹Ýº¹µÇ´Â »ç¿øÀ» Á¶È¸
--ÆÞ Ç¥±â¹ý \w = [a-zA-Z0-9] , \d = [0-9]
SELECT emp_name, phone_number
FROM employees
WHERE REGEXP_LIKE(phone_number, '(\d\d)\1$'); --\1Àº Ã¹¹øÂ° Ä¸Ã³ ±×·ìÀ» ´Ù½Ã ÂüÁ¶
                                              --Áï ÀÌÀü¿¡ ¸ÅÄªµÈ µÎÀÚ¸® ¼ýÀÚ¿Í
                                              --Á¤È®È÷ ÀÏÄ¡ÇÏ´Â µÎÀÚ¸® ¼ýÀÚ¸¦ ÀÇ¹ÌÇÔ
                                              
                                              
                                              