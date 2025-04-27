--1. Write a query to assign a row number to each sale based on the SaleDate.
select *,
	ROW_NUMBER() over (order by saledate) RowNum
from ProductSales
--2. Write a query to rank products based on the total quantity sold (use DENSE_RANK())
with CTETotal as(
select 
	ProductName,
	sum(quantity) Qty
from ProductSales
group by ProductName
)
select *,
	DENSE_RANK() over (order by Qty desc) Rnk
from CTETotal
--3. Write a query to identify the top sale for each customer based on the SaleAmount.
go
with CTETopSale as(
select *,
	max(saleamount) over (partition by customerid) TopSale
from productsales
)
select 
	SaleID,
	ProductName,
	saledate,
	SaleAmount,
	Quantity,
	CustomerID
from CTETopSale
where saleamount = TopSale
--4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function
select
	SaleDate,
	SaleAmount,
	lead(saleamount) over (order by saledate) NextSale
from ProductSales
--5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function
select
	Saledate,
	saleamount,
	lag(saleamount) over (order by saledate) PrevSale
from ProductSales
--6. Write a query to rank each sale amount within each product category.
select *,
	rank() over (partition by productname order by saleamount desc) rnk
from productsales
--7. Write a query to identify sales amounts that are greater than the previous sale's amount
with CTEAmount as(
select
	*,
	isnull(lag(saleamount) over (order by saledate), 0) PrevSale
from ProductSales
)
select 
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	Quantity,
	CustomerID
from CTEAmount
where SaleAmount > prevSale
--8. Write a query to calculate the difference in sale amount from the previous sale for every product
with CTEPrev as(
select *,
	lag(saleamount) over (order by saledate) PrevSale
from ProductSales
)
select SaleID,
	ProductName,
	Saledate,
	Saleamount,
	Quantity,
	CustomerID,
	SaleAmount - PrevSale as Difference
from CTEPrev
--9. Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
with CTENext as(
select *,  
	lead(saleamount) over (order by saledate) NextSale
from ProductSales
)
select SaleID,
	ProductName,
	Saledate,
	Saleamount,
	Quantity,
	CustomerID,
	cast(((nextsale-saleamount)/SaleAmount)*100 as int) PercentageChange
from CTENext
--10. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
with CTEDivisor as(
select *,
	lag(SaleAmount) over (partition by productname order by saledate) PrevSale
from ProductSales
)
select *,
	round(saleamount/prevsale, 2) as ratio
from CTEDivisor
--11. Write a query to calculate the difference in sale amount from the very first sale of that product.
with CTEFirstSale as(
select *,
	FIRST_VALUE(SaleAmount) over (partition by productNAme order by saledate) FirstSale
from ProductSales
)
select SaleID,
	ProductName,
	Saledate,
	Saleamount,
	Quantity,
	CustomerID,
	saleamount - firstsale Diff
from CTEFirstSale
--12. Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
with CTEPrev as(
select *,
	lag(SaleAmount) over (partition by productname order by saledate) PrevSale
from ProductSales
)
select *
from CTEPrev
where saleamount > prevsale
--13. Write a query to calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales.
select SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	sum(Saleamount) over (order by saledate rows between unbounded preceding and current row) ClosingBalance
from productSales
--14. Write a query to calculate the moving average of sales amounts over the last 3 sales.
select
	SaleDate,
	SaleAmount,
	avg(saleamount) over (order by SaleDate desc rows between current row and 2 following) as MA
from ProductSales
--15. Write a query to show the difference between each sale amount and the average sale amount.
select *,
	saleamount - avg(SaleAmount) over () as Diff
from ProductSales

--16. Find Employees Who Have the Same Salary Rank
with CTERank as(
select *,
	rank() over (order by salary desc) rnk
from Employees1
)
select cte1.*
from CTERank cte1
join CTERank cte2
on cte1.rnk = cte2.rnk
and cte1.EmployeeID <> cte2.EmployeeID

--17. Identify the Top 2 Highest Salaries in Each Department
with CTERank as(
select *,
	rank() over (partition by Department order by salary desc) rnk
from Employees1
)
select *
from CTERank
where rnk in(1, 2)

--18. Find the Lowest-Paid Employee in Each Department
with CTELowest as(
	select *,
		rank() over (partition by department order by salary)  rnk
	from Employees1
)
select *
from CTELowest
where rnk = 1
--19. Calculate the Running Total of Salaries in Each Department
select *,
	sum(Salary) over (partition by department order by hiredate rows between unbounded preceding and current row) RunnigTotal
from Employees1
--20. Find the Total Salary of Each Department Without GROUP BY
select distinct
	Department,
	sum(Salary) over (partition by department) TotalSalary
from Employees1
--21. Calculate the Average Salary in Each Department Without GROUP BY
select distinct
	Department,
	avg(Salary) over (partition by department) Average
from Employees1
--22. Find the Difference Between an Employee’s Salary and Their Department’s Average
select 
	*,
	 Salary - avg(Salary) over (partition by department) Difference
from Employees1
--23. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select *,
	case 
	when first_VALUE(EmployeeID) over (order by hiredate) = EmployeeID then null
	when LAST_VALUE(EmployeeID) over (order by hiredate rows between unbounded preceding and unbounded following) = EmployeeID then null
	else avg(salary) over (order by hiredate rows between 1 preceding and 1 following)
	   end as MA
from Employees1
--24. Find the Sum of Salaries for the Last 3 Hired Employees
select *,
	sum(salary) over (order by hiredate rows between current row and 2 following) SumOfSalaries
from Employees1
