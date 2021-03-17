SELECT
    emp.employee_id 사번,
    first_name 이름,
    last_name 성,
    department_name 부서명
FROM
    employees emp , departments dept
WHERE
    emp.department_id = dept.department_id;
    
select * from employees;
    
SELECT
    emp.employee_id 사번,
    first_name 이름,
    salary,
    department_name,
    job_title
FROM employees emp,departments dept,jobs jb
WHERE emp.department_id = dept.department_id (+)
and emp.job_id = jb.job_id
order by emp.employee_id;


SELECT
    lc.location_id,
    street_address,
    department_name,
    department_id
FROM 
    locations lc join departments dept
on 
    lc.location_id = dept.location_id
ORDER BY
    lc.location_id;
    
SELECT
    lc.location_id,
    city,
    department_name,
    department_id
FROM 
    locations lc  join departments dept
on 
    lc.location_id  = dept.location_id (+)
ORDER BY
    lc.location_id;    
    
SELECT
    region_name,
    country_name
FROM
    regions reg join countries coun
ON
    reg.region_id = coun.region_id
ORDER BY
    region_name,
    country_name;
    
SELECT
    emp.employee_id 사번,
    emp.first_name 이름,
    emp.hire_date 채용일,
    man.first_name 매니저이름,
    man.hire_date 매니저입사일
FROM    
    employees emp JOIN employees man
ON
    emp.manager_id = man.employee_id
WHERE 
    emp.hire_date < man.hire_date;
    
SELECT
    country_name,
    coun.country_id,
    city,
    lc.location_id,
    department_name,
    department_id
FROM    
    countries coun, locations lc, departments dept
WHERE 
    coun.country_id = lc.country_id
and
    lc.location_id = dept.location_id
ORDER BY
    coun.country_name;
    
SELECT
    jh.employee_id,
    first_name || ' ' || last_name,
    emp.job_id,
    start_date,
    end_date
FROM
    employees emp join job_history jh
ON
    emp.employee_id = jh.employee_id
WHERE
    jh.job_id = 'AC_ACCOUNT';
    
SELECT
    dept.department_id,
    department_name,
    first_name 매니저,
    city,
    country_name,
    region_name
FROM
    departments dept , employees emp , locations lc , countries coun, regions reg
WHERE
    dept.manager_id = emp.employee_id
AND
    dept.location_id = lc.location_id
AND 
    lc.country_id = coun.country_id
AND 
    reg.region_id = coun.region_id;
    

SELECT
    emp.employee_id,
    emp.first_name,
    department_name,
    man.first_name 매니저
FROM
    employees emp , departments dept, employees man  
WHERE
    emp.department_id = dept.department_id (+)
AND
    emp.manager_id = man.employee_id