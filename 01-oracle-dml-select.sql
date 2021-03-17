-- 현재 계정 내에 어떤 테이블이 있는가?
SELECT * FROM tab;

--테이블의 구조 확인 DESC
DESC employees;

--모든 컬럼 확인
-- 테이블에 정의된 컬럼의 순서대로 출력
SELECT * FROM employees;

DESC departments;

SELECT * FROM departments;

SELECT first_name,phone_number,salary FROM employees;

SELECT first_name,phone_number,salary FROM employees;

SELECT first_name,last_name,phone_number,salary,hire_date FROM employees;

SELECT 3.14159 * 3 * 3 FROM dual;   --단순 계산식은 dual(가상테이블)을 이용

SELECT first_name,salary,salary*12 FROM employees;

--계산식에 null 이 들어있으면 결과는 null
SELECT first_name,
    salary,
    salary + (salary * commission_pct)
FROM employees;

--nvl함수 : null -> 다른 기본값으로 치환
--null을 처리할때는 항상 유의하자 
--nvl(a,b) -> a가 null이라면 b값으로 대체한다
SELECT first_name,
    salary+(salary * nvl(commission_pct,0))
FROM employees;

--문자열의 연결 (||)
--별칭(alias)
-- AS없어도 된다
-- 공백,특수문자가 포함되어 있으면 별칭을 "로 묶음
SELECT first_name || ' ' || last_name as "FULL NAME"
FROM employees;

--이름
--입사일
--전화번호
--급여
--연봉

SELECT
    first_name || ' ' || last_name as "이름",
    hire_date 입사일 ,
    phone_number 전화번호,
    salary 급여,
    salary * 12 연봉
FROM employees;

--WHERE : 조건에 맞는 레코드 추출을 위한 조건 비교
/*
급여가 15000 이상인 사원들의 이름과 연봉을 출력하십시오
07/01/01 일 이후 입사자들의 이름과 입사일을 출력하십시오
이름이 'LEX'인 사원의 연봉과 입사일 , 부서 id 를 출력하십시오
부서 id가 10인 사원의 명단이 필요합니다
*/

SELECT 
    first_name || ' ' || last_name as 이름,
    salary * 12 as 연봉
FROM 
    employees
WHERE
    salary >= 15000;
    
SELECT
    first_name || ' ' || last_name as 이름,
    hire_date as 입사일
FROM
    employees
WHERE
    hire_date>='07/01/01';
    
SELECT 
    first_name || ' ' || last_name as 이름,
    salary * 12 as 연봉,
    hire_date as 입사일,
    department_id as 부서ID
FROM 
    employees
WHERE
    first_name = 'Lex';
    
SELECT 
    first_name || ' ' || last_name as 이름,
    salary * 12 as 연봉,
    hire_date as 입사일,
    department_id as 부서ID
FROM 
    employees
WHERE
    department_id = 10;
    
--급여가 14000이하이거나 17000이상인 사원의 이름과 급여를 출력
--부서 id 가 90인 사원중, 급여가 20000이상인 사원을 출력

SELECT
    first_name as 이름,
    salary as 급여
FROM
    employees
WHERE 
    salary <=14000 or salary >= 17000;
    
SELECT 
    first_name,salary
FROM   
    employees
WHERE salary BETWEEN 14000 and 17000;

SELECT * FROM
employees
WHERE
    hire_date >= '07/01/01' AND hire_date <= '07/12/31';
    
SELECT * FROM
employees
WHERE
    hire_date BETWEEN '07/01/01' AND '07/12/31';
    
SELECT
    first_name as 이름,
    salary as 급여
FROM
    employees
WHERE
    department_id = 90 and salary >= 20000;
    
--IN 연산
SELECT
    first_name
FROM
    employees
WHERE
    department_id = 10 or department_id =20 or department_id=40;
    
SELECT
    first_name
FROM
    employees
WHERE
    department_id in (10,20,40);
    
SELECT
    *
FROM
    employees
WHERE manager_id = 100 or manager_id = 120 or manager_id = 147;


SELECT
    *
FROM
    employees
WHERE manager_id IN (100,120,147);


--커미션을 받지 않는 사원의 목록 
-- IS NULL
SELECT * FROM employees
where commission_pct is null;

SELECT * FROM employees
where commission_pct is not null;


--LIKE 연산
--%임의의 길이 (0일 수 있다) 의 문자열
-- _1개의 임의 문자

--이름에 AM 을포함한 모든 사원들 %
SELECT
    first_name ,salary
FROM
    employees
WHERE first_name LIKE '%am%';

--이름의 두 번째 글자가 a인 사원의 목록
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '_a%';

--order by

SELECT first_name , salary , department_id
FROM employees
ORDER BY department_id;

SELECT first_name , salary
FROM employees
WHERE salary >= 10000
ORDER BY salary desc;

SELECT department_id ,salary , first_name
FROM employees
ORDER BY department_id asc, salary desc, first_name;


-------
--단일행 함수
--개별 레코드에 적용되는 함수

--문자열 단일행 함수
SELECT first_name ,last_name,
    CONCAT(first_name, CONCAT(' ', last_name)) name,   --문자열 합치기
    INITCAP(first_name || ' '|| last_name) name2,   --각단어의 첫글자를 대문자로
    LOWER(first_name),  --전부소문자
    UPPER(first_name),  --전부 대문자
    LPAD(first_name,10,'*'),
    RPAD(first_name,10,'*')
FROM
    employees;
    
    
    --first_name 에 am이 포함된 사원의 이름 출력
    SELECT first_name FROM employees
    WHERE first_name LIKE '%am%';
    
    SELECT first_name FROM employees;
    
    SELECT first_name FROM employees
    WHERE UPPER(first_name) LIKE '%AM%';
    
    --정제
    SELECT '   Oracle ' , '*****Database*****'
    FROM dual;
    
    SELECT LTRIM('    Oracle    '),
           RTRIM('    Oracle    '),
        TRIM('*' FROM '*****DATABASE*****'), --문자열 내에서 특정 문자를 제거
        SUBSTR('Oracle Database',8,8)
    FROM dual;
    
    --수치형 단일행 함수
    SELECT ABS(-3.14), --절대값
        CEIL(3.14), --올림
        FLOOR(3.14), --내림
        MOD(7,3),    --나눗셈의 몫
        POWER(2,4),  --제곱(A의 B제곱)
        ROUND(3.5), --소숫점 첫자리 반올림
        ROUND(3.5678,2),    --소숫점 둘째자리까지 표시 , 소숫점 셋째자리에서 반올림
        TRUNC(3,5),     --소숫점 버림
        TRUNC(3.5678,2),    --소숫점 둘째자리까지표시
        SIGN(-10)       --부호 함수(음수면 -1,0이면0 , 양수면1)
    FROM dual;
    
    SELECT first_name,
    (salary +(salary*commission_pct))* 12
    FROM employees;
    
    --날짜형 단일행 함수
    SELECT sysdate FROM dual;   --시스템 가상 테이블 -> 1개
    
    SELECT sysdate FROM employees;  --테이블 내의 레코드 수 만큼 출력
    
    SELECT sysdate,
        ADD_MONTHS(sysdate,2),  --오늘부터 2개월후
        MONTHS_BETWEEN(TO_DATE('1999-12-31','YYYY-MM-DD'),sysdate), --개월 차
        NEXT_DAY(sysdate,6), --오늘 이후 첫번째 금요일(일요일1~토요일7)
        ROUND(sysdate,'MONTH'),  --날짜 반올림
        TRUNC(sysdate,'MONTH')
    FROM
        dual;
    
    --사원들이 입사한지 얼마나 지났는지
    SELECT first_name,hire_date,
        ROUND(MONTHS_BETWEEN(sysdate, hire_date),0)
    FROM
        employees;
    
    
--    TO_CHAR(O,fmt) : Number or Date -> Varchar
--    TO_NUMBER(S,fmt) : Varchar -> number
--    TO_DATE(s,fmt) : Varchar -> Date

--TO_CHAR
SELECT first_name,
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') 입사일
FROM
    employees;

--현재 시간을 년-월-일 오전/오후 시:분:초 형식으로 출력
SELECT sysdate,TO_CHAR(sysdate,'YYYY-MM-DD PM HH:MI:SS')
FROM dual;


SELECT first_name,
    TO_CHAR(salary * 12,'$999,999.99') 연봉
FROM employees;

--TO_NUMBER :문자열 -> 숫자정보
SELECT
    TO_NUMBER('$1,500,500.90' , '$999,999,999.99')
FROM dual;

--TO_DATE : 날짜 형태를 지닌 문자열 ->DATE
SELECT
    '2021-03-16 15:07',
    TO_DATE('2021-03-16 15:07','YYYY-MM-DD HH24:MI')
FROM dual;

--날짜연산
--Date +(-) Number : 날짜에 일수를 더하거나 뺀다 -> Date
--Date - Date : 두 날짜 사이의 일수
--Date + Number /24 : 날짜에 시간을 더하거나 뺄 때는 Number/24 를 더하거나 뺀다

SELECT TO_CHAR(sysdate , 'YYYY-MM-DD HH24:MI'),
    TO_CHAR(sysdate - 8, 'YYYY-MM-DD HH24:MI'),     --8일전
    TO_CHAR(sysdate + 8 , 'YYYY-MM-DD HH24:MI'),    --8일후
    sysdate - TO_DATE('1999-12-31', 'YYYY-MM-DD'),   --1999년12월31일 이후로 몇일이 지났는가?
    TO_CHAR(sysdate + 12/24, 'YYYY-MM-DD')
FROM
    dual;
    
--NULL 관련
--NULL이 산술계산에 포함되면 NULL
--NULL은 잘 처리해주자
SELECT
    first_name,
    salary,
    nvl(salary * commission_pct,0) commission --nvl:첫번째 인자가 null-> 두번째 인자값사용
FROM
    employees;
--nvl2 : 첫번째 인자가 not null 이면 두번째인자 null 이면 세번째 인자를사용
SELECT
    first_name,
    salary,
    nvl2(commission_pct , salary * commission_pct,0) commission 
FROM
    employees;
    
--CASE Function
--보너스를 지급
--AD관련 직원 -> 20% SA관련 직원 10%, IT관련 직원 8% , 나머지는 3%를 지급하기로 결정

SELECT
    first_name ,
    job_id  ,
    SUBSTR(job_id,1,2)
From 
    employees;

SELECT 
    first_name,
    job_id,
    SUBSTR(JOB_ID,1,2) 직종,
    salary,
    CASE SUBSTR(job_id,1,2)
        WHEN 'AD' THEN salary * 0.2 --if
        WHEN 'SA' THEN salary * 0.1 --ELSE IF
        WHEN 'IT' THEN salary * 0.08 
        ELSE salary * 0.03
    END as bonus
FROM
    employees;
    
--DECODE
SELECT 
    first_name,
    job_id,
    SUBSTR(job_id,1,2) 직종,
    salary,
    DECODE(SUBSTR(job_id,1,2),
    'AD', salary *0.2,
    'SA', salary *0.1,
    'IT', salary *0.08,
    salary * 0.03) bonus
FROM
    employees;
    
    
--연습문제 
--회사에서 체육대회 진행 그룹을지어야한다
--직원의 이름,부서,팀을 출력하되 팀은 코드로 결정하여 
--부서코드가 10~30이면 a그룹 40~50사이면 b그룹 60~100이면 c그룹 나머지는 remainder


SELECT 
    first_name,
    department_id,
    CASE 
        WHEN department_id >= 10 AND department_id <=30 THEN 'A-GROUP'
        WHEN department_id <=50 THEN 'B-GROUP'
        WHEN department_id <=100 THEN 'C-GROUP'
        ELSE 'REMAINDER'
    END Team
FROM
    employees
ORDER BY TEAM;
