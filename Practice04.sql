SELECT
    COUNT(salary)
FROM
    employees
WHERE
    salary < (SELECT avg(salary) FROM employees);
    
SELECT
    emp.employee_id,
    emp.first_name,
    emp.salary,
    emp2.a,
    emp2.b
FROM 
    employees emp,(SELECT AVG(salary)a,MAX(salary)b FROM employees) emp2
WHERE
    salary >= (SELECT AVG(salary) FROM employees) 
AND
    salary <= (SELECT MAX(salary) FROM employees)
ORDER BY
    salary;


    
SELECT
    location_id,
    street_address,
    postal_code,
    city,
    state_province,
    country_id
FROM
    locations
WHERE 
    location_id = (SELECT
    location_id
FROM
    departments
WHERE
    department_id = 
    (SELECT department_id FROM employees 
    WHERE first_name = 'Steven' AND last_name = 'King'));
    
SELECT
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    salary <any(
        SELECT salary FROM employees WHERE job_id = 'ST_MAN'
    )
ORDER BY salary DESC;

SELECT
    employee_id,
    first_name,
    salary,
    department_id
FROM    
    employees
WHERE
    (salary,department_id) in (
        SELECT MAX(salary),department_id FROM employees GROUP BY department_id
    )
ORDER BY 
    salary desc;
    
SELECT
    employee_id,
    first_name,
    salary,
    emp.department_id
FROM    
    employees emp JOIN (SELECT MAX(salary)a,department_id FROM employees GROUP BY department_id) emp2
ON
    emp2.department_id = emp.department_id
AND 
    emp.salary = emp2.a
ORDER BY
    salary desc;
    
SELECT
    jb.job_id,
    jb.job_title,
    emp.총합
FROM
     jobs jb,(
        SELECT
            job_id,
            sum(salary*12)총합
        FROM
            employees
        where
            job_id is not null
        GROUP BY
            job_id
            ) emp
WHERE
    jb.job_id = emp.job_id
ORDER BY
    총합 desc;
    
SELECT
    emp.employee_id,
    emp.first_name,
    salary
FROM 
    employees emp,(SELECT
                        department_id,
                        avg(salary) ab
                    FROM
                        employees
                    WHERE 
                        department_id is not null
                    GROUP BY
                        department_id
                    ORDER BY
                        department_id) emp2
WHERE
    emp.department_id = emp2.department_id
AND
    emp.salary > emp2.ab;
    
SELECT * FROM(
SELECT 
    rownum as rn,
    employee_id,
    first_name,
    salary,
    hire_date
FROM 
    (SELECT 
        *
    FROM
        employees
    ORDER BY hire_date)
    )
WHERE 
    rn >= 11
AND 
    rn <=15;
