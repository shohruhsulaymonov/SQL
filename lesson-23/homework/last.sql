---Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output.

select *,
	format(Dt, 'MM') as MonthPrefixedWithZero  
from Dates

--Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals columns for each Id and RId. For more details please see the sample input and expected output.
with CTEUnique as(
select distinct
	id,
	rid,
	max(Vals) over (partition by id) Max
from MyTabel
)
select 
	count(id) Distinct_Ids ,
	max(rid) Rid,
	sum(max) TotalOfMaxVals 
from CTEUnique

--Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. Please see the sample input and expected output.

select *
from TestFixLengths
where len(Vals) between 6 and 10

--Puzzle 4: In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. The Challenge is to do that in a SINGLE SELECT. Please check out sample input and expected output.
select id,
	Item,
	vals
from (
	select
		id,
		Item,
		vals,
		row_numBER() over (Partition by id order by vals desc) rownum
	from TestMaximum tm1
	) t where rownum = 1
--Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data using Id only. Can you do this both in a single SELECT ?. Please check out sample input and expected output.
select 
	id,
	sum(maxval) SumofMax
from (
	select distinct
		DetailedNumber,
		max(vals) over (partition by DetailedNumber, id) MaxVal,
		id
	from SumOfMax
	) t
group by id
--Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the sample input and the expected output.

select
	*,
	case when cast(a - b as varchar) = 0 then '' 
	else cast(a - b as varchar)
	end as OUTPUT
from TheZeroPuzzle

--7. What is the total revenue generated from all sales?
select 
	sum(Quantitysold*unitprice) TotalRevenue
from Sales
--8. What is the average unit price of products?
select 
	avg(unitprice) AvgPrice
from Sales
--9. How many sales transactions were recorded?
select 
	count(*)
from Sales
--10. What is the highest number of units sold in a single transaction?
select 
	max(quantitysold) MaxUnitsSold
from Sales
--11. How many products were sold in each category?
select
	Category,
	count(distinct Product) ProductCount
from Sales
group by Category
--12. What is the total revenue for each region?
select 
	Region,
	sum(QuantitySold*UnitPrice) as TotalRevenue
from Sales
group by Region
--13. What is the total quantity sold per month?
select 
	format(Saledate, 'yyyy-MM') Month,
	sum(QuantitySold) TotalQuantity
from Sales
group by format(Saledate, 'yyyy-MM')
--14. hich product generated the highest total revenue?
select top 1
	Product,
	sum(QuantitySold*UnitPrice) TotalRevenue
from Sales
group by Product
order by TotalRevenue desc
--15. Compute the running total of revenue ordered by sale date.
select 
	SaleDate,
	(QuantitySold*UnitPrice) SaleAmount,
	sum(QuantitySold*UnitPrice) over (order by saledate) RunnigTotal
from Sales
--16. How much does each category contribute to total sales revenue?
select distinct
	Category,
	CAST(CAST(100*(sum(QuantitySold*UnitPrice) over (partition by category))/(sum(QuantitySold*UnitPrice) over ()) AS int) AS varchar) + '%' as ContributionPercent
from Sales

--17. Show all sales along with the corresponding customer names
select
	s.*, 
	CustomerName
from Sales s
join Customers c
on s.CustomerID = c.CustomerID
--18. List customers who have not made any purchases
select *
from Customers c
where not exists (
	select distinct 1 
	from Sales s
	where c.CustomerID = s.CustomerID
	)
--19. Compute total revenue generated from each customer
select
	CustomerName,
	sum(QuantitySold*UnitPrice) Revenue
from Sales s
join Customers c
on s.CustomerID = c.CustomerID
group by CustomerName
--20. Find the customer who has contributed the most revenue
select top 1
	CustomerName,
	sum(QuantitySold*UnitPrice) Revenue
from Sales s
join Customers c
on s.CustomerID = c.CustomerID
group by CustomerName
order by Revenue desc
--21. Calculate the total sales per customer per month
select 
	CustomerID,
	datename(month, SaleDate) Month,
	sum(QuantitySold*UnitPrice) TotalSales
from Sales
group by
	CustomerID,
	datename(month, SaleDate)

--22. List all products that have been sold at least once
select distinct
	Product
from Sales
--23. Find the most expensive product in the Products table
select distinct top 1
	Product,
	UnitPrice
from Sales
order by UnitPrice desc
--24. Show each sale with its corresponding cost price from the Products table
select s.*, CostPrice
from Sales s
join Products p
on s.ProductID = p.ProductID
--25. Find all products where the selling price is higher than the average selling price in their category
with CTEAvg as(
select 
	*,
	avg(sellingprice) over (partition by category) AvgPrice
from Products
)
select * 
from CTEAvg
where SellingPrice > AvgPrice
