--Task 1: De-Group the Data
with cte as(
select 
	product, 
	quantity, 
	1 as count, 
	1  as Qty 
from grouped

union all

select 
	product, 
	quantity, 
	1 + count, 
	1 as Qty 
from cte
where count < quantity
)
select 
	Product, 
	Qty 
from cte
order by product

--Task 2: Region Sales Report

with cte as(
select distinct 
	t1.region, 
	t2.distributor
from #regionsales t1, #regionsales t2
)

select 
	cte.*, 
	isnull(t3.sales, 0) sales 
from cte
left join #regionsales t3
on cte.region = t3.region 
and cte.distributor = t3.distributor
order by distributor

--Task 3: Managers With At Least 5 Reports

CREATE TABLE Employee (
  id INT,
  name VARCHAR(255),
  department VARCHAR(255),
  managerId INT
);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);


with cte as (select e2.id, count(*) reports from Employee e1 join Employee e2 on e1.managerid = e2.id group by e2.id)

select name from Employee e, cte where e.id = cte.id and reports >= 5


--Task 4: Products Ordered in February 2020 (>= 100 units)

with cte as(
	select 
		product_id, 
		sum(unit) unit 
	from Orders 
	where order_date like '2020-02-%' 
	group by product_id
	having sum(unit) >=100
)

select 
	product_name, 
	unit 
from Products p, cte 
where p.product_id = cte.product_id

--Task 5: Most Frequent Vendor Per Customer

go

with CTEVendor as(
select
	customerID, 
	Vendor ,
	count(*) as Frq
from Orders
group by 
	customerID, 
	Vendor
),
CTEVen2 as(
select 
	CustomerID,
	Vendor, 
	Frq, 
	max(Frq) over (partition by customerID) Max
from CTEVendor
)
select 
	CustomerID, 
	Vendor 
from CTEVen2 
where Frq = Max
--Task 6: Prime Number Check Using WHILE

DECLARE @Check_Prime INT = 91
declare @divisor int = 2
declare @result bit = 1

while (@divisor < @Check_Prime)
	begin
		IF @Check_Prime % @divisor = 0
		BEGIN
			SET @result = 0 
			break
		END

		set @divisor = @divisor + 1
end

if @result = 1
	print 'Prime'
else 
	print 'Not Prime'

--Task 7: Signals per Device

with cte as(
select 
	device_id, 
	Locations,
	count(Locations) num_of_location 
from Device 
group by Device_id, Locations
),

ctemax as(
	select *, rank() over (partition by device_id order by num_of_location desc) rnk from cte
)

select 
	device_id,
	(select count(distinct locations) from device d where d.device_id = ctemax.device_id) no_of_location,
	locations,
	(select count(*) from device d where d.device_id = ctemax.device_id) no_of_signals
from ctemax
where rnk = 1

--Task 8: Employees Earning Above Department Average

with cte as(
select *, 
	avg(Salary) over (
		partition by deptID 
		order by deptid desc 
		rows between unbounded preceding 
		and unbounded following) DeptAvg 
from Employee
)

select EmpID, EmpName, Salary
from cte 
where Salary > DeptAvg
order by Salary desc


--Task 9: Office Lottery Winnings

with cte as(
select distinct TicketID, count(t.Number) LuckyNumbers
from Tickets t, WinningNumbers w 
where t.Number = w.Number
group by TicketID 
),
Winnings as(
select '$' + cast(sum(case 
	when LuckyNumbers in(1, 2) then 10
	when LuckyNumbers = 3 then 100
	else 0
	end) as varchar)as [Total Winning]
from cte
)

select * from winnings
