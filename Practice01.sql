SELECT
    first_name || ' ' || last_name as 이름,
    salary 월급,
    phone_number 전화번호,
    hire_date 입사일
FROM 
    employees
ORDER BY hire_date asc;

SELECT * FROM locations;
SELECT * FROM COUNTRIES;
SELECT * FROM employees;
SELECT * FROM JOBS;

SELECT
    job_title 업무이름,
    max_salary 최고월급
FROM
    JOBS
ORDER BY max_salary desc;

SELECT
    first_name || ' ' || last_name as 이름,
    manager_id 매니저,
    commission_pct 커미션비율,
    salary 월급
FROM 
    employees
WHERE
    manager_id is not null 
AND
    commission_pct is null
AND
    salary>3000;
    
SELECT
    job_title 업무이름,
    max_salary 최고월급
FROM
    JOBS
WHERE
    max_salary>=10000
ORDER BY 
    max_salary desc;
    
SELECT
    first_name || ' ' || last_name as 이름,
    salary 월급,
    nvl(commission_pct,0) 커미션퍼센트
FROM
    employees
WHERE
    salary BETWEEN 9999 and 14000
ORDER BY
    월급 desc;
    
SELECT
    first_name || ' ' || last_name as 이름,
    salary 월급,
    TO_CHAR(hire_date, 'YYYY-MM') 입사일,
    department_id 부서번호
FROM
    employees
WHERE
    department_id in(10,90,100);
    
SELECT
    first_name || ' ' || last_name as 이름,
    salary 월급
FROM
    employees
WHERE
    UPPER(first_name) LIKE '%S%'; 
    
SELECT
    department_name
FROM
    departments
ORDER BY 
    LENGTH(department_name) desc;
    

SELECT
    UPPER(country_name) 나라이름
FROM
    COUNTRIES
ORDER BY country_name;


SELECT
    first_name || ' ' || last_name as 이름,
    salary 월급,
    replace(phone_number,'.','-') 전화번호,
    hire_date 입사일
FROM 
    employees
WHERE
    hire_date <= '03/12/31';

    
    
