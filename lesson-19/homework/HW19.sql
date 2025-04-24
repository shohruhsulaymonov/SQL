--Retrieve Employees with Salary Greater than Average Salary
select * 
from #Employees 
where Salary > (
	select 
		avg(salary) 
	from #Employees
	);
--Write a query to check if there are any employees in Department 1 using the EXISTS clause
if exists (
	select 1 
	from #Employees 
	where DepartmentID = 1
)
	print 'Employee found';
else
	print 'Employee not found';

--Write a query to return employees who work at the same department with Rachel Collins
select *
from #Employees
where DepartmentID = (
	select 
		DepartmentID 
	from #Employees
	where FirstName = 'Rachel' 
	and LastName = 'Collins'
);
--Retrieve employees who were hired after the last hired person for the department 2
select *
from #Employees
where HireDate > (
	select 
		max(hiredate) 
	from #Employees 
	where DepartmentID = 2
	);
--Find all employees whose salary is higher than the average salary of their respective department
select * 
from #Employees e1
where salary > (
	select 
		avg(Salary) 
	from #Employees e2 
	where e1.DepartmentID = e2.DepartmentID
	);
--Write a query to get the count of employees in each department using a subquery. Return the result right after each employee
select distinct
	departmentID, 
	(
	select count(*) 
	from #Employees e2 
	where e2.DepartmentID = e1.DepartmentID
	) CntOfEmp
from #Employees e1;
--Find the person who gets the minimum salary
select * 
from #Employees 
where Salary = (
	select 
		min(salary) 
	from #Employees
	);
--Find all employees who work in departments where the average salary is greater than $65,000
select * 
from #Employees 
where DepartmentID in(
	select 
		departmentID
	from #Employees 
	group by DepartmentID 
	having AVG(Salary) > 65000
	);
--List employees who were hired in the last 3 years from the last hire_date

select * 
from #Employees 
where HireDate 
between dateadd(year, -3, (select max(hiredate) from #Employees)) 
and (select max(hiredate) from #Employees);
--If there is anyone earning more than or equal to $80000, return all employees from that department
select * 
from #Employees 
where DepartmentID in(
	select
		DepartmentID 
	from #Employees 
	where Salary >= 80000
	);
--Return the employees who earn the most in each department

with cte as (
	select *, 
		rank() over (partition by departmentID order by salary desc) rnk
	from #Employees
	)
select 
	EmployeeID, 
	FirstName, 
	LastName, 
	DepartmentID, 
	Salary, 
	HireDate 
from cte 
where rnk = 1

--Get the names of the latest hired employee in each deparmtent. Return Departmentname, Firstname, Lastname, and hire date
with cte as (
	select *, 
		rank() over (partition by departmentID order by hiredate desc) rnk
	from #Employees
	)
select 
	EmployeeID, 
	FirstName, 
	LastName, 
	DepartmentName, 
	Salary, 
	HireDate 
from cte 
join #Departments d
on cte.DepartmentID = d.DepartmentID
where rnk = 1
--Find the average salary for employees in each department based on its location. Return the Location, DepartmentName, and AverageSalary
select 
	Location, 
	DepartmentName, 
	avg(salary) as AverageSalary
from #Employees e
join #Departments d
on e.DepartmentID = d.DepartmentID
group by Location, DepartmentName
--Check if there is anyone who gets the same as the average salary. If so, return everyone from that department

with cte as(
select *, 
	avg(salary) over (partition by departmentID order by (select null)) avg 
from #Employees
)

select * 
from #Employees 
where DepartmentID in (
	select 
		DepartmentID 
	from cte 
	where Salary = avg
	);	
--List all departments that have fewer employees than the overall average number of employees per department.
with cte as(
select 
	DepartmentID, 
	count(*) emp 
from #Employees 
group by DepartmentID
)
select *
from cte
where emp < (
	select avg(cast(emp as float)) 
	from cte
	);
--Retrieve the names of employees who do not work in the department with the highest average salary.
with cte as(
select 
	DepartmentID,
	avg(salary) avgsalary 
from #Employees 
group by DepartmentID
),
cte2 as(
select top 1 *
from cte 
order by avgsalary desc
)
select FirstName, LastName 
from #Employees 
where DepartmentID != (
	select DepartmentID 
	from cte2
	);
--Create a query that returns the names of departments that do have employees using the EXISTS clause
select 
	DepartmentName 
from #Departments d 
where exists (
	select 
		EmployeeID 
	from #Employees 
	where DepartmentID = d.DepartmentID
	);
--Return departments which have more seniors than juniors. Juniors are those who have work experience less than 3 years, seniors more than 3 years. Consider the latest hire_date to calculate the years of experience
with cte as(
select 
	DepartmentID, 
	case 
		when datediff(year, HireDate, (select max(HireDate) from #employees)) >= 3 then 'Senior'
		else null		
	end as Senior,
	case 
		when datediff(year, HireDate, (select max(HireDate) from #employees)) < 3 then 'Junior'
		else null		
	end as Junior	
from #Employees
)

select 
	DepartmentName
from cte, #Departments d
where cte.DepartmentID = d.DepartmentID
group by DepartmentName
having count(Senior) > Count(Junior)
--Return employees of the department with the most number of people
with MaxNum as(
select top 1 with ties 
	DepartmentID 
from #Employees 
group by DepartmentID 
order by count(*) desc
)
select e.* 
from #Employees e 
join MaxNum mn
on e.DepartmentID = mn.DepartmentID

--For each department, find the difference between the highest and lowest salaries
select distinct 
	DepartmentName,
	MaxMinSalDiff
from #Departments d
join (
	select 
		departmentid, 
		max(salary) - min(salary) as MaxMinSalDiff
	from #Employees
	group by DepartmentID
	) dt
on dt.DepartmentID = d.DepartmentID


