--1. Compute Running Total Sales per Customer
select 
	Customer_id,
	order_date,
	sum(total_amount) over (partition by customer_id order by order_date) RunningSales
from sales_data
--2. Count the Number of Orders per Product Category
select distinct
	product_category,
	count(*) over (partition by product_category)
from sales_data
--3. Find the Maximum Total Amount per Product Category
select distinct
	product_category,
	max(total_amount) over (partition by product_category) MaximumTotal
from sales_data
--4. Find the Minimum Price of Products per Product Category
select distinct
	product_category,
	min(unit_price) over (partition by product_category) MinimumPrice
from sales_data
--5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
select 
	*,
	case 
		when FIRST_VALUE(sale_id) over (order by order_date rows between unbounded preceding and unbounded following) = sale_id then null
		when LAST_VALUE(sale_id) over (order by order_date rows between unbounded preceding and unbounded following) = sale_id then null
		else
		avg(total_amount) over (order by order_date rows between 1 preceding and 1 following)
		end as MA
from sales_data
--6. Find the Total Sales per Region
select distinct
	region,
	sum(total_amount) over (partition by region) TotalSales
from sales_data
--7. Compute the Rank of Customers Based on Their Total Purchase Amount
with CTETotal as(
	select
		customer_id,
		customer_name,
		sum(total_amount) Total
	from sales_data
	group by customer_id,
		customer_name
)
select 
	*,
	rank() over (order by Total desc) Rank
from CTETotal
--8. Calculate the Difference Between Current and Previous Sale Amount per Customer
select *,
	isnull(total_amount - lag(total_amount) over (partition by customer_id order by order_date), 0) Diff
from sales_data
--9. Find the Top 3 Most Expensive Products in Each Category
with CTERank as(
	select distinct
		product_name,
		product_category,
		rank() over (partition by Product_category order by unit_price desc) rank
	from sales_data
)
select *
from CTERank
where rank in(1, 2, 3)
order by product_category, rank
--10. Compute the Cumulative Sum of Sales Per Region by Order Date
select *,
	sum(total_amount) over (partition by region order by order_date rows between unbounded preceding and current row) CumulativeSum
from sales_data
--11. Compute Cumulative Revenue per Product Category
select *,
	sum(total_amount) over (partition by product_category order by order_date) CumulativeSum
from sales_data
--12. Here you need to find out the sum of previous values. Please go through the sample input and expected output.
select
	ID,
	sum(ID) over (order by (select null) rows between unbounded preceding and current row) SumPreValues 
from tbl
--13. Sum of Previous Values to Current Value
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select *,
	sum(Value) over (order by (select null) rows between 1 preceding and current row) [Sum of Previous]
from OneColumn

--15. Find customers who have purchased items from more than one product_category
with Dist as(
select distinct
	customer_id,
	product_category
from sales_data
),
Count as(
select 
	customer_id,
	count(*) over (partition by customer_id) cnt
from Dist
)
select distinct *
from Count
where cnt > 1
--16. Find Customers with Above-Average Spending in Their Region
with CTEAvg as(
select distinct
	customer_id,
	customer_name,
	region,
	sum(total_amount) over (partition by customer_id) total,
	avg(total_amount) over (partition by region) AvgByRegion
from sales_data
)
select 
	customer_id,
	customer_name
from CTEAvg
where total > AvgByRegion
--17. Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank (dense ranking).
with CTETotal as(
select distinct
	customer_id,
	customer_name,
	region,
	sum(total_amount) over (partition by customer_id) TotalSpending
from sales_data
)
select 
	*,
	DENSE_RANK() over (partition by region order by totalSpending desc) Rank
from CTETotal
--18. Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
select
	customer_id,
	customer_name,
	total_amount,
	sum(total_amount) over (partition by customer_id order by order_date) RunningTotal
from sales_data
--19. Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
with CTETotal as (
	select 
		format(order_date, 'yyyy-MM') as Month,
		sum(total_amount) Total
	from sales_data
	group by format(order_date, 'yyyy-MM')
),
CTEPrev as(
	select *,
	lead(total) over (order by month desc) Prev
	from ctetotal
)

select
	Month,
	Total,
	case 
		when Prev is null then null
		else 
		round(((Total - prev)/Prev)*100, 2)
	end as GrowthRate
from CTEPrev
--20. Identify customers whose total_amount is higher than their last order's total_amount.(Table sales_data)
with LastOrder as(
select
	customer_id,
	customer_name,
	total_amount,
	lead(total_amount) over (partition by customer_id order by order_date desc) PrevOrder
from sales_data
)
select *
from lastorder
where total_amount > PrevOrder

-- 21. Identify Products that prices are above the average product price
with CTEAvg as(
select
	product_name,
	unit_price,
	avg(unit_price) over () AveragePrice
from sales_data
)
select 
	product_name,
	unit_price
from CTEAvg
where unit_price > AveragePrice
--22. In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output.

select *,
	case
		when FIRST_VALUE(id) over (partition by grp order by (select null)) != id then null
		else
		sum(Val1+Val2) over (partition by grp)
	end as Tot
from MyData

--23. Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.
select
	id,
	sum(cost) Cost,
	sum(distinct quantity) Quantity
from TheSumPuzzle 
group by id
