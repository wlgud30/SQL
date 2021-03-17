SELECT COUNT(manager_id) from employees;

select max(salary) 최고임금 , min(salary) 최저임금, (max(salary)-min(salary)) 임금차이
from employees;

select to_char(max(hire_date),'YYYY"년 "MM"월 "DD"일"')
FROM employees;

SELECT
    avg(salary) 평균임금,
    max(salary) 최고임금,
    min(salary) 최저임금,
    department_id
FROM
    employees
WHERE
    department_id is not null
GROUP BY
    department_id
order by
    department_id desc;
    
SELECT
    round(avg(salary),1) 평균임금,
    max(salary) 최고임금,
    min(salary) 최저임금,
    job_id
FROM
    employees
WHERE
    department_id is not null
GROUP BY
    job_id
order by
    최저임금 desc ,평균임금 asc;
    
SELECT
    to_char(MAX(hire_date),'YYYY-MM-DD day')
FROM
    employees;
    
SELECT 
    department_id,
    round(avg(salary),1) 평균임금,
    min(salary) 최저임금,
    (round(avg(salary),1)-min(salary)) 차이
FROM
    employees
where
    department_id is not null
group by 
    department_id
order by
    차이 desc;
    
SELECT
    max(salary)-min(salary) 차이,
    job_id
FROM
    employees
GROUP BY
    job_id
order by
    차이 desc;
    
SELECT
    round(avg(salary),2) 평균임금,
    max(salary) 최고임금,
    min(salary) 최저임금
FROM
    employees
WHERE
    hire_date >= '2005/01/01'
group by
    manager_id
having
    avg(salary) >= 5000
order by
    평균임금 desc;
    
SELECT
    first_name , 
    hire_date,
    CASE 
        WHEN hire_date < '02/12/31' THEN '창립맴버'
        WHEN hire_date <'04/01/01' THEN '03년입사'
        WHEN hire_date <'05/01/01' THEN '04년입사'
        ELSE '상장이후입사'
    END optDate
FROM
    employees
ORDER BY
    hire_date;