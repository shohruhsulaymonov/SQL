--Using Products table, find the total number of products available in each category.
select category, count(*) NumOfProducts from Products group by category
--Using Products table, get the average price of products in the 'Electronics' category.
select category, avg(price) Avg from Products where category = 'Electronics' group by category
--Using Customers table, list all customers from cities that start with 'L'.
select * from customers where city like 'L%'
--Using Products table, get all product names that end with 'er'.
select * from Products where ProductName like '%er'
--Using Customers table, list all customers from countries ending in 'A'.
select * from Customers where Country like '%A'
--Using Products table, show the highest price among all products.
select max(price) MaxPrice from products
--Using Products table, use IIF to label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
select *, iif(Stockquantity < 30, 'Low', 'Sufficient') QuantityStatus from Products
--Using Customers table, find the total number of customers in each country.
select Country, count(*) NumOfCustomers from Customers group by Country
--Using Orders table, find the minimum and maximum quantity ordered.
select min(Quantity) Min, max(Quantity) Max from Orders

--Medium-Level Tasks
--Using Orders and Invoices tables, list customer IDs who placed orders in 2023 (using EXCEPT) to find those who did not have invoices.
select CustomerID from Orders where year(OrderDate) = 2023
except
select CustomerID from Invoices
--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
select productname from Products
union all
select productname from Products_Discounted
--Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
select productname from Products
union
select productname from Products_Discounted
--Using Orders table, find the average order amount by year.
select year(Orderdate) year, avg(Quantity) Avg from orders group by year(Orderdate)
select * from orders
--Using Products table, use CASE to group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
select
	productName,
	case
		when price < 100 then 'Low'
		when price between 100 and 500 then 'Mid'
		else 'High'
	end as Pricegroup
from Products
--Using Customers table, list all unique cities where customers live, sorted alphabetically.
select distinct city from Customers order by city
--Using Sales table, find total sales per product Id.
select ProductID, sum(SaleAmount) TotalSales from sales group by ProductID
--Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
select ProductName from Products where ProductName like '%oo%'
--Using Products and Products_Discounted tables, compare product IDs using INTERSECT.
select ProductID from Products
intersect
select ProductID from Products_Discounted

--Hard-Level Tasks
--Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
select top 3 CustomerID, sum(totalamount) Totalspent from Invoices group by CustomerID order by Totalspent desc
--Find product ID and productname that are present in Products but not in Products_Discounted.
select productID, productname from Products
except
select productID, productname from Products_Discounted
--Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
select ProductName, count(SaleID) NumOfSales from Products p full join Sales s on p.ProductID = s.ProductID group by ProductName
--Using Orders table, find top 5 products (by ProductID) with the highest order quantities.
select top 5 * from Orders order by Quantity desc
