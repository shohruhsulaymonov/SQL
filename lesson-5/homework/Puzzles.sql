--Write a query that uses an alias to rename the ProductName column as Name in the Products table.
select ProductName as Name from products
--Write a query that uses an alias to rename the Customers table as Client for easier reference.
Select * from Customers as Client
--Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
select ProductName from Products
union
select ProductName from Products_discounted
--Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
select ProductName from Products
intersect
select ProductName from Products_discounted
--Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
select distinct 
  concat(firstname, ' ', lastname), 
  city 
from customers
--Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
select *, 
	case 
		when Price > 1000 then 'High'
		else 'Low'
	end
from Products
--Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
select *, 
  iif(StockQuantity > 100, 'Yes', 'No') 
from Products_Discounted

--Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
select ProductName from Products
union
select ProductName from OutOfStock
--Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
select * from Products
except
select * from products_discounted
--Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
select *, 
  iif(Price > 1000, 'Expensive', 'Affordable') 
from Products
--Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
select * 
from Employees 
where Age < 25 or Salary > 60000
--Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
update Employees
set salary = salary*1.1
where departmentname ='HR' or EmployeeID = 5

--Use INTERSECT to show products that are common between Products and Products_Discounted tables.
select ProductName from Products
intersect
select ProductName from Products_Discounted

--Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
select *,
	case
		when saleamount > 500 then 'Top Tier'
		when saleamount between 200 and 500 then 'Mid Tier'
		else 'Low Tier'
	end
from sales
--Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.
select customerID from Orders 
except
select customerID from Invoices
--Write a query that uses a CASE statement to determine the discount percentage 
--based on the quantity purchased. Use orders table. Result set should show 
--customerid, quantity and discount percentage. The discount should be applied as follows: 
--1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%

select customerid, quantity,
	case
		when quantity = 1 then '3%'
		when quantity between 1 and 3 then '5%'
		else '7%'
	end as [discount percentage]
from Orders
