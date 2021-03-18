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
    
----------------
--AGGREGATION (집계)
--------------
--여러개의 값을 집계하여 하나의 결과값을 산출
--COUNT : 숫자 세기 함수
SELECT
    COUNT(*)
FROM
    employees;      --전체 레코드 카운트
    
SELECT
    COUNT(commission_pct)
FROM    
    employees; -- 특정 컬럼을 명시하면 null 인 것은 집계에서 제외


SELECT
count(*) 
from employees 
where commission_pct is not null; -- 위의것과같은의미

--사원들이 받는 급여의 총합
SELECT SUM(salary) FROM employees;
--평균 급여 산정
SELECT AVG(salary) FROM employees;
--사원들이 받는 평균 커미션 비율
SELECT AVG(commission_pct) FROM employees;
SELECT AVG(nvl(commission_pct,0)) FROM employees;
--null 이 포함된 집계는 null 값을 포함할 것인지 아닌지를 결정하고 집계

--salary 의 최솟값 최대값 평균값 중앙값
SELECT MIN(salary), MAX(salary), AVG(salary), MEDIAN(salary)
FROM employees;

--흔히 범하는 오류
--부서의 아이디, 급여 평균을 출력하고자
SELECT department_id, round(AVG(salary),2) FROM employees group by department_id order by department_id;

--부서별 평균 급여를 산출 평균 급여가 2000이상인 부서를 출력
SELECT
    department_id,round(AVG(salary),2) sal
FROM
    employees
 group by 
    department_id
HAVING
    avg(salary) >= 2000;


--ROULLUP
--GROUP BY 절과 함께 사용
--GROUP BY 의 결과에 좀 더 상세한 요약을 제공하는 기능 수행(Item Subtotal)
--부서별 급여의 합계 추출(부서아이디,직업아이디)
SELECT
    department_id,
    job_id,
    sum(salary)
FROM
    employees
GROUP BY
    department_id,job_id
ORDER BY
    department_id;

SELECT
    department_id,
    job_id,
    sum(salary)
FROM
    employees
GROUP BY
    ROLLUP(department_id,job_id);
--cube 함수
--CrossTable 에 대한 Summary를 함께 제공
--ROLLUP 함수로 추출된 SubTotal에
--COLUMN TOTAL 값을 추출할 수 있다.
SELECT
    department_id,
    job_id,
    sum(salary)
FROM
    employees
GROUP BY
    CUBE(department_id,job_id);
    
--SUBQUERY
--하나의 SQL 이 다른 SQL 질의의 일부에포함되는경우

--DEN 보다 급여를 많이받는사원의 이름과 급여는?
--1. DAN이 얼마나급여를받는지 -A
--2. A보다 많은 급여를 받는 사람은?
SELECT salary FROM employees WHERE first_name = 'Den';
SELECT first_name,salary FROM employees WHERE salary > 11000;
--두개를 합친다
SELECT
    first_name,
    salary
FROM employees
WHERE
    salary>
        (SELECT salary FROM employees WHERE first_name='Den');

--연습
--급여의 중앙값보다 많이 받는 직원
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary <
        (SELECT
            median(salary) 
        FROM
            employees);
            
--급여를 가장 적게 받는 사람의 이름, 급여,사원번호를 출력하시오
SELECT 
    first_name,
    salary,
    employee_id
FROM
    employees
WHERE
    salary = (SELECT MIN(salary) FROM EMPLOYEES);
    
--다중행 서브쿼리
--서브쿼리 결과 레코드가 둘 이상인 경우 , 단순 비교 불가능
--집합 연산에 관련된 in, any, all ,exsist 등을 이용해야 한다.

--110번 부서의 직원이 받는 급여는 얼마인가
SELECT 
    salary
FROM
    employees
WHERE
    department_id = 110;

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary = (
            SELECT
                salary
            FroM    
                employees 
            WHERE
                department_id=110);--error :서브쿼리의 결과 레코드는 2개
                                   -- 2개의 결과와 단일행 salary의 값을 비교할 수 없다

--fix
            
--IN , =ANY -> OR와 비슷
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary in (SELECT salary FROM employees WHERE department_id=110);

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary =any 
        (SELECT
            salary
        FROM
            employees
        WHERE 
            department_id=110);

--ALL-> AND와 비슷
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > all(
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id=110);

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > ANY(
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110);-- -> 'salary>12008 or salary>8300' 과 동일하다
--Correlated query
--포함한 (outer query) , 포함된커리(inner query)가 서로 연관관계를 맺는 쿼리
SELECT
    first_name,
    salary,
    department_id
FROM
    employees emp -- Outer
WHERE
    salary > (
        SELECT 
            AVG(salary)
        FROM
            employees
        WHERE
            department_id = emp.department_id);
--서브쿼리(inner query)가 수행되기 위해서는 outer 의 컬럼값이 필요하고,
--outer query 수행이 완료되기 위해서는 서브쿼리(inner query)의 결과값이 필요하다

--서브쿼리 연습
--각 부서별로 최고 급여를 받는 사람을 출력
SELECT 
    department_id,
    MAX(salary)
FROM
    employees
GROUP BY
    department_id;
    
SELECT 
    department_id,
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    (department_id,salary) IN
    (
        SELECT department_id,max(salary)
        FROM employees
        GROUP BY department_id
    )
ORDER BY
    department_id;
--SUBQUERY : 임시 테이블을 생성
SELECT
    emp.department_id,
    employee_id,
    first_name,
    emp.salary
FROM
    employees emp ,(SELECT
                        department_id,max(salary) ms
                    FROM
                        employees
                    GROUP BY
                        department_id)sal   --임시테이블을 만들어서 sal이라고 별칭을 부여
WHERE
    emp.department_id = sal.department_id
AND
    emp.salary = sal.ms
ORDER BY
    emp.department_id,emp.employee_id;
--correlated query 활용
SELECT
    emp.department_id ,
    employee_id,
    first_name,
    emp.salary
FROM 
    employees emp
WHERE
    emp.salary = (
                    SELECT
                        MAX(salary)
                    FROM
                        employees 
                    WHERE
                        department_id = emp.department_id
                        )
ORDER BY
    department_id;
    
--oracle 은 질의 수행 결과의 행번호를 확인할 수 있는 가상컬럼 rownum을 제공
--2007년 입사자중 급여 순위 5위까지
SELECT rownum,first_name,salary
FROM employees;

SELECT
    rownum,
    first_name,
    salary
FROM 
        EMPLOYEES
WHERE 
    hire_date LIKE '07%' AND rownum <=5;
    
SELECT 
    rownum,
    first_name,
    salary
FROM    
    employees
WHERE 
    hire_date LIKE '07%' 
AND
    rownum <=5
ORDER BY
    salary desc;        --rownum이 정해진 이후 정렬을 수행

--TOK K 쿼리
SELECT
    rownum,
    first_name,
    salary
FROM (
    SELECT
        *
    FROM
        employees
    WHERE
        hire_date LIKE '07%'
    ORDER BY 
        salary desc
    )
WHERE
    rownum <=5;

-- SET(집합)
--UNION(합집합,중복제거)
--UNION ALL (합집합,중복제거X)
--INTERSECT(교집합)
--MINUS(차집합)
SELECT first_name,salary, hire_date FROM employees WHERE hire_date <'05/01/01';
SELECT first_name,salary,hire_date FROM employees WHERE salary>12000;

--교집합
SELECT first_name,salary, hire_date FROM employees WHERE hire_date <'05/01/01'
intersect
SELECT first_name,salary,hire_date FROM employees WHERE salary>12000;
--위와 동일
SELECT first_name,salary,hire_date FROM employees
WHERE hire_date<'05/01/01' and salary>12000;
--합집합
SELECT first_name,salary, hire_date FROM employees WHERE hire_date <'05/01/01'
UNION
SELECT first_name,salary,hire_date FROM employees WHERE salary>12000;
--위와동일
SELECT first_name,salary,hire_date FROM employees
WHERE hire_date<'05/01/01' OR salary>12000;
--차집합
SELECT first_name,salary, hire_date FROM employees WHERE hire_date <'05/01/01'
MINUS
SELECT first_name,salary,hire_date FROM employees WHERE salary>12000;
--입사일이 05/01/01 이전인 사람들 중 , 급여가 12000 이하인 직원들
--위와 동일
SELECT
    first_name,
    salary,
    hire_date
FROM
    employees
WHERE
    hire_date <'05/01/01'
AND
    not salary>12000;

--RANK 함수
SELECT 
    salary,
    first_name,
    RANK() OVER (ORDER BY salary desc) as rank,--중복될경우 중복된 수만큼 건너뜀
    DENSE_RANK() OVER(ORDER BY salary desc) as dense_rank,--중복되어도 다음수는 그대로 진행
    ROW_NUMBER() OVER (ORDER BY salary desc) as row_number,--순위를 매기지않고 그냥 차례대로 진행
    rownum
FROM 
    employees;
    
--hierarchical query : 트리 형태의 구조를 호출
--ROOT 노드 : 조건 START WITH로 설정
--가지 : 연결하기 위한 조건을 CONNECT BY PRIOR 로 설정
--EMPLOYEES 테이블로 조직 그리기
--LEVEL(깊이) 이라는 가상 컬럼을 사용할 수 있다.

SELECT
    level,emp.first_name,emp.manager_id,man.first_name
FROM
    employees emp join employees man
ON 
    emp.manager_id = man.employee_id(+)
START WITH emp.manager_id is null
CONNECT BY PRIOR emp.employee_id = emp.manager_id
ORDER BY
    level;
--위 트리 구조에 매니저의 이름도 출력