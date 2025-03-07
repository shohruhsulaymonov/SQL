SELECT 'This is SQL Exercise, Practice and Solution';

SELECT name, commission FROM Salesman;

select name, city from Salesman where city = 'Paris';

select ord_date, salesman_id, ord_no, purch_amt from Orders;

SELECT distinct salesman_id FROM Orders;

select year, subject, winner from nobel_win where year = 1970;

select winner from nobel_win where subject = 'Literature' and year = 1971;

select year, subject from nobel_win where winner = 'Dennis Gabor';

select winner from nobel_win where subject = 'Physics' and year >=1950;

select * from nobel_win where subject = 'chemistry' and (year >= 1965 and year <= 1975); 

select * from nobel_win where winner in( 'Menachem Begin', 'Yitzhak Rabin');

select * from nobel_win where winner like 'Louis%';

select * from nobel_win where (subject = 'physics' and year = 1970) or (subject = 'Economics' and year = 1971);

SELECT * FROM nobel_win WHERE year = 1970 AND subject NOT IN ('Physiology ','Economics');

select * from nobel_win where (subject = 'Physiology' and year < 1971)
union
select * from nobel_win where (subject = 'Peace' and year >= 1974);

select * from nobel_win where winner = 'Johannes Georg Bednorz';

select * from nobel_win where subject not like 'P%' order by year desc, winner;

SELECT * FROM nobel_win WHERE year = 1970 ORDER BY CASE WHEN subject in ('Chemistry', 'Economics') THEN 1 ELSE 0 END, subject;

select * from item_mast where Pro_price between 200 and 600;

select AVG (pro_price) from item_mast where pro_com = 16;

select pro_name as [Item Name], pro_price [Price in Rs.] from item_mast where pro_price >= 250 order by pro_price desc, pro_name;

SELECT AVG(pro_price), pro_com FROM item_mast GROUP BY pro_com;

select pro_name, pro_price from item_mast where pro_price = (select min(Pro_price) from item_mast)

select distinct EMP_LNAME from emp_details;

select * from emp_details where emp_lname = 'Snares';

select * from emp_details where emp_dep = 57;






SELECT first_name + ' ' + last_name as FULL_NAME, salary FROM EMPLOYEES WHERE salary < 6000

SELECT first_name, last_name, DEPARTMENT_ID, salary FROM EMPLOYEES WHERE salary > 8000

SELECT first_name, last_name, DEPARTMENT_ID FROM EMPLOYEES WHERE last_name = 'McEwen'	

SELECT * FROM employees where DEPARTMENT_ID is null

SELECT * FROM departments where DEPARTMENT_NAME = 'Marketing' 

SELECT first_name + ' ' + last_name as FULL_NAME, hire_date, salary, department_id FROM employees where first_name not like '%M%' order by department_id

SELECT * FROM employees WHERE salary BETWEEN 8000 AND 12000 AND commission_pct IS NOT NULL OR department_id NOT IN (40 , 120 , 70) AND hire_date < '2003-06-05';

select first_name + ' ' + last_name as FULL_NAME, salary from employees where commission_pct is null 

select first_name + ' ' + last_name as FULL_NAME, phone_number + ' - ' + email as contact_details, salary from employees where salary between 9000 and 17000

SELECT first_name, last_name, salary FROM employees where first_name like '%M'

select first_name + ' ' + last_name as FULL_NAME, salary from employees where salary not between 7000 and 15000 order by FULL_NAME

select first_name + ' ' + last_name as FULL_NAME, job_id, hire_date from employees where hire_	date between '2007-11-05' and '2009-07-05'

select first_name + ' ' + last_name as FULL_NAME, department_id from employees where department_id in (70, 90)

SELECT first_name + ' ' + last_name as FULL_NAME, salary, manager_id FROM EMPLOYEES WHERE manager_id is not null

select * from employees where hire_date < '2002-06-21'

select first_name, last_name, email, salary, manager_ID from employees where manager_ID in(120, 103, 145)

select * from employees where first_name like '%[dsn]%' order by salary desc

select first_name + ' ' + last_name as full_name, hire_date, commission_pct, email + ' - ' + phone_number as contact_details, salary from employees where salary > 11000 or phone_number like '______3%' order by first_name desc

select first_name, last_name, DEPARTMENT_ID from employees where first_name like '__s%'

select employee_id, first_name, job_id, department_id from employees where department_id not in(50, 30, 80)

select employee_id, first_name, job_id, department_id from employees where department_id in(30, 40, 90)

select job_id, count(*) as count, sum(salary) as sum, max(salary) - min(salary) as salary_difference from employees group by job_id

select job_id from employees where (select count(job_id) from employees) >= 2 group by job_id and 

SELECT job_id FROM job_history WHERE end_date-start_date >300 GROUP BY job_id HAVING COUNT(*)>=2;

select country_id, count(city) from locations group by country_id

select manager_id, count(*) from employees group by manager_id

select first_name, last_name, hire_date from employees where job_id in('SA_MAN', 'SA_REP')

select department_id, avg(salary) from employees where commission_pct is not null group by department_id

select department_id from employees group by department_id having count(manager_id) >=4

SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = 0 AND SALARY BETWEEN 7000 AND 12000 and department_id = 50;

select job_id, avg(salary) as avgsalary from employees group by job_id having avg(salary) > 8000

select first_name, last_name from employees where first_name like 'D%' or last_name like 'D%'

select * from employees where hire_date > '1987-09-07'
