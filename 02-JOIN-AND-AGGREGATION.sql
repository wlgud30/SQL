--------
--JOIN--
--------

DESC employees;
DESC departments;

--두테이블의 모든 데이터를 불러올 경우
--cross join : 카티전 프로덕트
--두 테이블의 조합 가능한 모든 레코드의 쌍이 출력된다
SELECT
    employees.employee_id,employees.department_id,departments.department_id,departments.department_name
FROM
    employees ,departments
ORDER BY
    employees.employee_id;
    
--첫번째 테이블의 department_id 정보와 두번째 테이블의 department_id를 일치시켜야함
--inner join , equi join

SELECT
    employee_id,first_name,emp.department_id,dept.department_id,department_name
FROM
    employees emp,departments dept
WHERE
    emp.department_id = dept.department_id
ORDER BY
    employee_id;
    

--INNER JOIN :SIMPLE JOIN

SELECT 
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp, departments dept
WHERE
    emp.department_id = dept.department_id;
    
    
--join되지않은 사원은 누구인가?

SELECT
    first_name,
    department_id
FROM
    employees
WHERE
    department_id is null;
    
SELECT
    first_name,
    department_id,
    department_name
FROM
    employees 
JOIN
    departments
USING
    (department_id);        --join할 컬럼을 명시
    
--JOIN ON
SELECT
    first_name,
    emp.department_id,
    department_name
FROM
    employees emp 
JOIN
    departments dept
ON
    emp.department_id = dept.department_id;     --on -> JOIN문의 WHWER절
    
--Natural Join
--두 테이블에 조인을 할 수 있는 공통 필드가 있을 경우(공통필드가 명확할 때)
SELECT
    first_name,
    department_id,
    department_name
FROM
    employees NATURAL JOIN departments;
    
--Theta JOIN
--임의의 조건을 사용하되 JOIN 조건이 = 조건이 아닌 경우의 조인
SELECT * FROM jobs WHERE job_id = 'AD_ASST';

SELECT first_name, salary FROM employees emp, jobs j
WHERE j.job_id = 'AD_ASST' AND salary BETWEEN j.min_salary AND j.max_salary;

-------
--OUTER JOIN
-------
/*
조건 만족하는 짝이 없는 튜플도 null을 포함해서 출력에 참여시키는 JOIN
모든 레코드를 출력할 테이블의 위치에 따라서 LEFT ,RIGHT ,FULL OUTER JOIN 으로 구분
oralce 의 경우 , null 이 출력되는 조건쪽에 (+)
*/
--LEFT OUTER JOIN : ORACLE SQL
SELECT 
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM 
    employees emp,
    departments dept
WHERE emp.department_id = dept.department_id (+);   --LEFT OUTER JOIN

--LEFT OUTER JOIN : ANSI SQL
SELECT 
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM 
    employees emp 
LEFT OUTER JOIN
    departments dept
ON
    emp.department_id = dept.department_id; --왼쪽 테이블의 모든 레코드는 출력된다
    
--RIGHT OUTER JOIN: oracle
SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp, 
    departments dept
WHERE
    emp.department_id (+) = dept.department_id; --오른쪽 테이블의 모든레코드출력
    
--RIGHT OUTER JOIN : ANSI SQL
SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp
RIGHT OUTER JOIN
    departments dept
ON
    emp.department_id = dept.department_id;
    
--FULL OUTER JOIN 양쪽 테이블 모두 출력에 참여 oracle
--SELECT
--    first_name,
--    emp.department_id,
--    dept.department_id,
--    department_name
--FROM
--    employees emp,
--    departments dept
--WHERE
--    emp.department_id (+) = dept.department_id(+);      --full outer join 은 불가

--FULL OUTER JOIN 양쪽 테이블 모두 출력에 참여 ANSI
SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM
    employees emp
FULL OUTER JOIN
    departments dept
ON
    emp.department_id = dept.department_id;
   
    
--SELF JOIN 자신의 FK가 자신의 PK 를 참조하는 방식의 JOIN
--자신을 두번 호출하므로 반드시 alias 사용해야함
SELECT
    emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM 
    employees emp,
    employees man
WHERE
    emp.manager_id = man.employee_id;
    
--ANSI SQL
SELECT
    emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM
    employees emp 
JOIN
    employees man
ON 
    emp.manager_id = man.employee_id;
    
    