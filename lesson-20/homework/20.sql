--1. Find customers who purchased at least one item in March 2024 using EXISTS
select CustomerName 
from Sales s1 
where exists (
	select 
		CustomerName 
	from Sales s2 
	where SaleDate >= '2024-03-01'
	and SaleDate < '2024-04-01'
	and s2.CustomerName = s1.CustomerName
	)
--2. Find the product with the highest total sales revenue using a subquery.
select 
	Product, 
	(
		select sum(Quantity*Price)
		from Sales s2 
		where s2.Product = s1.Product
	) as TotalSales
from Sales s1
--3. Find the second highest sale amount using a subquery
select * 
from (
	select 
		Quantity*Price as Sale,
		rank() over (order by Quantity*Price desc) as Rnk
	from Sales
	) t
where Rnk = 2
--4. Find the total quantity of products sold per month using a subquery
select distinct
	datename(month, saledate) Month, 
	(select sum(quantity) from Sales s2 where datename(month, s2.SaleDate) = datename(month, s1.SaleDate)) Qty
from Sales s1
--5. Find customers who bought same products as another customer using EXISTS
select CustomerName, Product
from Sales s1
where exists (select 1 from Sales s2 where s1.Product = s2.Product and s1.CustomerName <> s2.CustomerName)
order by Product

--6. Return how many fruits does each person have in individual fruit level
select 
	Name,
	sum(case when fruit = 'Apple' then 1 else 0 end) as Apple,
	sum(case when fruit = 'Orange' then 1 else 0 end) as Orange,
	sum(case when fruit = 'Banana' then 1 else 0 end) as Banana
from Fruits 
group by Name 
--7. Return older people in the family with younger ones
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

select 
	f1.ParentID as PID, 
	f2.ChildID as CHID 
from Family f1, Family f2 
where f1.ParentId < f2.ChildID
order by PID

--8. Write an SQL statement given the following requirements. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas
select o2.*
from #Orders o1
join #Orders o2
on o1.CustomerID = o2.CustomerID
and o1.DeliveryState = 'CA'
and o2.DeliveryState = 'TX'

--9. Insert the names of residents if they are missing
select resid, fullname,
	case
		when CHARINDEX(fullname, address) = 0
			then stuff(address, CHARINDEX(' age', address), 0 , ' name=' + fullname)
		else address
	end as address
from #residents

		--10. Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
		
		select * 
		from #Routes r1
		right join #Routes r2
		on r1.ArrivalCity = r2.DepartureCity
		full join #Routes r3
		on r2.ArrivalCity = r3.DepartureCity

		--11. Rank products based on their order of insertion.

		select *,
			rank() over (order by ID) rnk
		from RankingPuzzle
		--12. You have to return Ids, what number of the letter would be next if inserted, the maximum length of the consecutive occurence of the same digit

--13. Find employees whose sales were higher than the average sales in their department
with cte as(
select *, 
	avg(salesamount) over (partition by department) Average
from #EmployeeSales
)
select *
from cte
where SalesAmount > Average

--14. Find employees who had the highest sales in any given month using EXISTS
with cte as(
select EmployeeID, EmployeeName, SalesMonth, sum(salesamount) Salesamount
from #EmployeeSales es1
group by EmployeeID, EmployeeName, SalesMonth
),
cte2 as (
select *, rank() over (partition by salesmonth order by Salesamount desc) rnk
from cte
)
select EmployeeID, EmployeeName, Salesamount, SalesMonth
from cte2 
where rnk = 1

		--15. Find employees who made sales in every month using NOT EXISTS

--16. Retrieve the names of products that are more expensive than the average price of all products.

select 
	Name 
from Products
where Price > (
	select 
		avg(price) 
	from Products
	)
--17. Find the products that have a stock count lower than the highest stock count.

select 
	* 
from Products
where Stock < (
	select
		max(stock)
	from Products
)

--18. Get the names of products that belong to the same category as 'Laptop'.

select 
	Name
from Products
where Category = (
	select 
		category
	from Products
	where Name = 'Laptop'
	)
--19. Retrieve products whose price is greater than the lowest price in the Electronics category.

select 
	*
from Products
where Price > (
	select 
		min(Price)
	from Products
	where Category = 'Electronics'
)

--20. Find the products that have a higher price than the average price of their respective category.
with cte as(
	select *,
		avg(Price) over (partition by category) avg
	from Products
)
select 
	ProductID, 
	Name,
	Category,
	Price,
	Stock
from cte
where Price > avg

--21. Find the products that have been ordered at least once.
select
	ProductID
from Orders
--if a product exists in a table named 'Orders' it must be ordered at least once, otherwise it wouldn't be there
--22. Retrieve the names of products that have been ordered more than the average quantity ordered.
select Name 
from Orders o
join products p
on o.ProductID = p.productID
where Quantity > (
	select avg(Quantity) 
	from Orders
)

--23. Find the products that have never been ordered.
select p.* 
from Orders o
full join products p
on o.ProductID = p.productID
where o.ProductID is null

--24. Retrieve the product with the highest total quantity ordered.
select top 1 
	Name, 
	sum(quantity) TotalQuantity
from Orders o 
join Products p
on o.ProductID = p.ProductID
group by Name
order by TotalQuantity desc

--25. Find the products that have been ordered more times than the average number of orders placed.
with cte as(
select 
	ProductID,
	count(OrderID) cnt
from Orders
group by ProductID
)

select p.*
from cte
join products p
on p.productID = cte.ProductID
where cnt > (
	select
		avg(cnt)
	from cte
)
