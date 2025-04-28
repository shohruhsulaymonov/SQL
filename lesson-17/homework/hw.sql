--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue

select
	s.ProductID, 
	Sum(quantity) TotalQuantity, 
	sum(Quantity*Price) TotalRevenue
	into #MonthlySales
from Sales s
join Products p
on s.ProductID = p.ProductID
where month(saledate) = MONTH(GETDATE())
group by s.ProductID

--2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold
create view vw_ProductSalesSummary as
select p.ProductID, ProductName, Category, sum(quantity) TotalQuantitySold
from Products p 
join Sales s
on p.ProductID = s.ProductID
group by p.ProductID, ProductName, Category;

--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID
create function fn_GetTotalRevenueForProduct2(@ProductID INT)
returns float
begin
declare @result float
set @result =
	(select sum(quantity*price) TotalRevenue
	from Sales s
	join Products p
	on s.ProductID = p.ProductID
	where s.ProductID = @ProductID)
	return @result
	end
select dbo.fn_GetTotalRevenueForProduct2(4) as TotalRevenue
--4. Create a function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
go
Create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as
return(
	select
		ProductName, 
		Sum(quantity) TotalQuantity, 
		sum(Quantity*Price) TotalRevenue
	from Sales s
	join Products p
	on s.ProductID = p.ProductID
	where Category = @Category
	group by ProductName
);
go

--5. You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:

create function dbo.fn_IsPrime (@Number INT)
Returns varchar(3)
as
begin
	declare @divisor int = 2
	declare @IsPrime bit = 1
	declare @result varchar(3)
	if @Number < 2
		begin
			set @IsPrime = 0
		end
	else if @Number = 2
		begin 
			set @IsPrime = 1
		end
	else
		begin
			while @divisor < @Number
				begin
					if @Number % @divisor = 0
					begin 
						set @IsPrime = 0
						break;
					end
				set @divisor += 1
			end
		end

	 IF @IsPrime = 1
       Set @result = 'Yes'
    ELSE
       Set @result = 'No'

	return @result
end;

go

--6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:

create function fn_GetNumbersBetween(@start int, @end int)
returns table
as 
return(
	with cte as (
	select @Start as Number
	union all
	select Number + 1
	from cte
	where Number < @end
	)
	select * from cte
)
--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.

create FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        select salary as [getNthHighestSalary(2)] 
		from (
        select distinct Salary,
            dense_rank() over (order by salary desc) rnk
        from Employee
        ) t
        where rnk = @N
    );
END
--8. Write a SQL query to find the person who has the most friends.
with cte as(
	select 
		requester_id, 
		count(requester_id) Cnt 
	from RequestAccepted 
	group by requester_id
),
cte2 as(
	select 
		accepter_id, 
		count(accepter_id) Cnt
	from RequestAccepted 
	group by accepter_id
),
cte3 as(
select 
	coalesce(requester_id, accepter_id) id, 
	isnull(cte.Cnt, 0) + isnull(cte2.Cnt, 0) num
from cte 
full join cte2 
on cte.requester_id = cte2.accepter_id
),
cte4 as(
select *,
		DENSE_RANK() over (order by num desc)
		rnk
from cte3
)
select id, num from cte4 where rnk = 1 

--9. Create a View for Customer Order Summary.

create view vw_CustomerOrderSummary as
with cte as(
select 
	customer_id, 
	count(*) total_orders , 
	sum(amount) total_amount,
	max(order_date) last_order_date 
from Orders
group by customer_id
)
select 
	cte.customer_id, 
	name,
	total_orders , 
	total_amount,
	last_order_date
from cte
join Customers c
on cte.customer_id = c.customer_id

--10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.

select 
	RowNumber, 
	max(testcase) over (order by rownumber rows between unbounded preceding and current row) Workflow 
from gaps
