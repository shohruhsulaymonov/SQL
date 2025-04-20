--1. Find Employees with Minimum Salary
select * 
from Employees 
where salary = (
	select min(salary) 
	from Employees
	)

--2. Retrieve products priced above the average price.
select * 
from products 
where price > (
	select avg(price) 
	from products
	)

--3. Retrieve employees who work in the "Sales" department.

select * 
from Employees 
where department_id = (
	select id 
	from departments 
	where department_name = 'sales'
	)

--4. Retrieve customers who have not placed any orders.
select * 
from customers 
where customer_id not in (
	select Customer_id 
	from orders
	)

--5. Find Products with Max Price in Each Category
select 
	id, 
	product_name, 
	Price, 
	p.Category_id 
from products p 
join (
	select 
		category_id, 
		max(price) MaxPrice
	from products 
	group by category_id) t 
on p.category_id = t.category_id 
and p.Price = t.MaxPrice

--6. Retrieve employees working in the department with the highest average salary.

select * 
from employees 
where departmentid in (
	select top 1 with ties
		departmentid
	from employees 
	group by departmentid 
	order by avg(salary) desc
	)


--7. Retrieve employees earning more than the average salary in their department.
select * from employees e,
(
	select 
		DepartmentID, 
		avg(salary) Average 
	from Employees 
	group by DepartmentID
) d
where e.DepartmentID = d.DepartmentID 
and Salary > Average

--8. Retrieve students who received the highest grade in each course.
select 
	s.student_id, 
	name, 
	course_id, 
	grade 
from students s join
(
	select 
		Student_id, 
		g.course_id, 
		grade 
	from grades g,
	(
		select 
			course_id, 
			max(grade) MaxGrade 
			from grades 
			group by course_id
		) sq
	where g.course_id = sq.course_id 
	and g.grade = sq.MaxGrade
	) sq2
on s.student_id = sq2.student_id


--9. Retrieve products with the third-highest price in each category.
select 
	id, 
	product_name, 
	price, 
	category_id 
from 
	(
	select *,
		rank() over (partition by category_id order by price desc) as rank
	from products
	) t
where rank = 3

--10. Retrieve employees with salaries above the company average but below the maximum in their department.
select 
	Employee_ID, 
	Name, 
	e.Department_ID, 
	Salary, 
	HireDate 
from employees e,
(
	select 
		Department_ID, 
		Max(salary) Maximum 
	from Employees 
	group by Department_ID
) d 
where e.Department_ID = d.Department_ID
and Salary < Maximum
and Salary > (
	select 
		avg(salary) Average 
	from Employees
		)
