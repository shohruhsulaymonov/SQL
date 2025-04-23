--Easy Tasks

--1.Create a numbers table using a recursive query.
with cte as(
select 1 as n
union all
select n+1 from cte
where n < 100
)
select * from cte
--2.Beginning at 1, this script uses a recursive statement to double the number for each record
with cte as(
select 1 as n
union all
select n*2 from cte
where n < 1000
)
select * from cte
--3.Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select 
	FirstName,
	LastName, 
	(
		select 
			sum(salesamount) 
		from Sales 
		where sales.EmployeeID = Employees.EmployeeID
	) TotalSales 
from Employees
--4.Create a CTE to find the average salary of employees.(Employees)
go
with average as(
select AVG(salary) AvgSalary from Employees
)
select * from average
--5.Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select ProductName, (select Max(salesamount) from Sales where sales.ProductID = Products.ProductID) MaxSales from Products
--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
select FirstName, LastName from Employees where employeeid in (select EmployeeID from Sales group by EmployeeID having count(*) > 1)
--7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
go
with CTESales as(
	select 
		ProductName as Total 
	from sales s 
	join Products p 
	on s.productID = p.ProductID 
	group by ProductName 
	having sum(salesamount) > 500
	)
select * from CTESales 
--8.Create a CTE to find employees with salaries above the average salary.(Employees)
with cte as(
select FirstName, LastName, Salary from Employees where Salary > (select Avg(salary) from Employees)
)

select * from cte
--9.Write a query to find the total number of products sold using a derived table.(Sales, Products)
select ProductName, (select count(*) from Sales where products.ProductID = sales.ProductID) QtySold from Products
--10.Use a CTE to find the names of employees who have not made any sales.(Sales, Employees)
with cte as (select 
	FirstName, 
	LastName 
from Employees e 
full join sales s 
on e.EmployeeID = s.EmployeeID 
where s.EmployeeID is null)
select * from cte
--Medium Tasks
go
--1.This script uses recursion to calculate factorials
with CTEFactorial as(
select 1 as n, 1 as Factorial
union ALL
select n + 1, (n + 1) * Factorial
from CTEFactorial
where n < 10)

select * from CTEFactorial
	
	
--2.This script uses recursion to calculate Fibonacci numbers
go
with Fibonacci as (
select 0 as fib1, 1 as fib2, 1 as step

union all 

select 
	fib1 + fib2, fib1,
	step + 1 
from Fibonacci
where step < 10
)

select fib1	 from Fibonacci
go
--3.This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
with cte as(
	select 
		left('abcdefghijklmnopqrstuvwxyz',1) one, 
		substring('abcdefghijklmnopqrstuvwxyz', 2, len('abcdefghijklmnopqrstuvwxyz')) rest
	union all
	select
		left(rest, 1), 
		substring(rest, 2, len(rest)) 
	from cte
	where len(rest) > 0
)

select one from cte
--4.Create a CTE to rank employees based on their total sales.(Employees, Sales)
go
with cte as(
	select 
		FirstName, 
		LastName, 
		sum(salesamount) Sale
	from Sales s 
	join Employees e 
	on s.EmployeeID = e.EmployeeID 
	group by FirstName, LastName
	)
select *, RANK() over (order by Sale desc) as Rank from cte
--5.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select FirstName, LastName from Employees where EmployeeID in (select top 5 EmployeeID from Sales group by EmployeeID order by COUNT(*) desc)
--6.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
	
with cte1 as (
select datename(month, SaleDate) Month, sum(salesamount) SaleAmount from Sales
group by datename(month, SaleDate)),
cte2 as (
select *, lag(SaleAmount) over (order by month) as Prev from cte1)
select month, saleamount - prev from cte2

--7.Write a query using a derived table to find the sales per product catery.(Sales, Products)

select 
	CateryID, 
	SUM(salesamount) TotalSales
from Sales s
join (select ProductID, CateryID from Products) p
on s.ProductID = p.ProductID
group by CateryID

--8.Use a CTE to rank products based on total sales in the last year.(Sales, Products)
with cte as (
	select 
		productname, 
		sum(salesamount) [Sum]
	from Sales s 
	join Products p 
	on s.ProductID = p.ProductID 
	where year(saledate) = dateadd(year, -1, year(getdate())) 
	group by ProductName 
)

select *, rank() over (order by [sum] desc) Rank from cte
--9.Create a derived table to find employees with sales over $5000 in each quarter.(Sales, Employees)
select tbl.EmployeeID, FirstName, LastName, Quarter, TotalSales from employees e join
	(select 
		EmployeeID, 
		concat('Q', datepart(quarter, saledate)) Quarter, 
		sum(salesamount) TotalSales 
		from Sales 
		group by 
			EmployeeID, 
			datepart(quarter, saledate)
		having sum(salesamount) > 5000
		) tbl
on e.EmployeeID = tbl.EmployeeID
--10.Use a derived table to find the top 3 employees by total sales amount in the last month.(Sales, Employees)
select FirstName, LastName from Employees where employeeid in (select top 3
	employeeid 
from sales 
where datepart(month, SaleDate) = datepart(month, dateadd(month, -2, getdate())) 
group by EmployeeID 
order by sum(salesamount) desc)
--Difficult Tasks

--1.Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
with cte as(
	select cast(1 as varchar(10)) as n , 2 as m
	union all
	select cast(concat(n, m) as varchar(10)), m + 1 from cte
	where m <= 5 
)
select n from cte
--2.Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
select
	FirstName, 
	LastName, 
	SaleAmount 
from employees e 
join (
	select 
		EmployeeID, 
		sum(salesamount) SaleAmount
	from Sales 
	where SaleDate between dateadd(month, -6, getdate()) and getdate()
	group by EmployeeID) dt
on e.EmployeeID = dt.EmployeeID
order by SaleAmount Desc
--3.This script uses recursion to display a running total where the sum cannot be higher than 10 or lower than 0.(Numbers)

with cteRec as (
select ID,
		Stepnumber,
		Count,
		case when count < 0 then 0  
		when count > 10 then 10 else count end as Numbers 
		from Numbers
		where stepnumber = 1

		union all 

		select n.Id , 
		n.StepNumber ,
		n.Count,
		case 
			when cr.Numbers + n.Count < 0 then 0
			when cr.Numbers + n.Count > 10 then 10 
			else cr.Numbers + n.Count 
		end as runningtotal
   		from cteRec cr
		join numbers n on n.Id = cr.id 
		and n.StepNumber = cr.stepnumber + 1 
)
select * from cteRec
order by id, stepnumber
--4.Given a table of employee shifts, and another table of their activities, merge the two tables and write an SQL statement that produces the desired output. If an employee is scheduled and does not have an activity planned, label the time frame as “Work”. (Schedule,Activity)




with cte1 as (
	select 
		a.ScheduleID as acScheduleID,
		'Work' as ActivityName, 
		a.EndTime as WorkStartTime,
		coalesce(lead(a.StartTime) over (partition by a.scheduleid order by a.starttime),s.endtime) as WorkEndTime 
	from Activity a
	join Schedule s on a.ScheduleID = s.ScheduleID
),
cte2 as (
	select 
		a.ScheduleID, 
		min(a.StartTime) as MinTime 
	from Activity a
	join Schedule s 
	on a.ScheduleID = s.ScheduleID 
	group by a.ScheduleID),
cte3 as (
	select 
		cte2.ScheduleID as ScheduleID,
			case 
				when s.StartTime = MinTime then null 
				else s.StartTime 
			end as WorkStartTime, 
		MinTime from cte2
	join Schedule s 
	on cte2.ScheduleID = s.ScheduleID
)
select 
	acScheduleID ScheduleID, 
	ActivityName, 
	WorkStartTime StartTime, 
	WorkEndTime EndTime 
from cte1

union all 

select 
	ScheduleID, 
	'Work' as ActivityName, 
	WorkStartTime as StartTime, 
	MinTime as EndTime 
from cte3
where WorkStartTime is not null

union all

select * 
from Activity
order by scheduleID, starttime



--5. Create a complex query that uses both a CTE and a derived table to calculate sales totals for each department and product.(Employees, Sales, Products, Departments)

with cteEmp as(
	select 
		e.DepartmentID,
		ProductID, 
	sum(salesamount) SaleAmount 
	from Sales s
	join Employees e
	on s.EmployeeID = e.EmployeeID
	group by 
		e.DepartmentID,
		ProductID
),

CTEProducts as(
	select
		DepartmentID,
		ProductName, 
		SaleAmount
	from cteEmp
	join (select ProductName, ProductID from Products) p
	on p.productID = cteEmp.productid
)


select DepartmentName, ProductName, SaleAmount 
from CTEProducts cte
join Departments d
on cte.DepartmentID = d.DepartmentID
order by DepartmentName, SaleAmount desc





