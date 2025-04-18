--🟢 Lesson 4 Easy-Level Tasks (10)

--1. Write a query to select the top 5 employees from the Employees table.
select top 5 * from employees
--2. Use SELECT DISTINCT to select unique ProductName values from the Products table.
SELECT DISTINCT ProductName FROM Products
--3.  Write a query that filters the Products table to show products with Price > 100.
SELECT * FROM Products WHERE Prrice > 100
--4. Write a query to select all CustomerName values that start with 'A' using the LIKE operator.
SELECT CustomerName from Customers where CustomerName like 'A%'
--5. Order the results of a Products query by Price in ascending order.
select * from Products order by Price;
--6. Write a query that uses the WHERE clause to filter for employees with Salary >= 5000 and Department = 'HR'.
select * from Employees where Salary >= 60000 and DepartmentName = 'HR'
--7. Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".
select isnull(Email, 'noemail@example.com') from Employees
--8. Write a query that shows all products with Price BETWEEN 50 AND 100.
select * from Products where price BETWEEN 50 AND 100
--9. Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName from Products
--10. Order the results by ProductName in descending order.
SELECT DISTINCT ProductName from Products order by ProductName desc;

--🟠 Lesson 4 Medium-Level Tasks (10)

--1. Write a query to select the top 10 products from the Products table, ordered by Price DESC.
select top 10 * from products order by price desc
--2. Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
select coalesce(first_name, last_name) as result from employees
--3. Write a query that selects distinct Category and Price from the Products table.
select distinct category, price from products
--4. Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
select * from employees where age between 30 and 40 or Department = 'Marketing'
--5. Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
select * from employees order by salary desc offset 10 rows fetch next 10 rows only
--6. Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
select * from products where Price <= 1000 and StockQuantity > 50 order by StockQuantity
--7. Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
select * from products where ProductName like '%e%'
--8. Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
select * from Employees where department in('HR', 'IT', 'Finance')
--9. Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.
select * from Customers order by city asc, PostalCode desc

--🔴 Lesson 4 Hard-Level Tasks (10)

--1. Write a query that selects the top 10 products with the highest sales, using TOP(10) and ordered by SalesAmount DESC.
select top 10 * from sales order by saleamount desc
--2. Use COALESCE to combine FirstName and LastName into one column named FullName in the Employees table.
select coalesce(first_name, ' ',last_name) as FullName from Employees
--3. Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
select distinct category, ProductName, price from products where price > 50
--4. Write a query that selects products whose Price is within 10% of the average price in the Products table.
select * from products where price < (select avg(price) * 0.1 from products)
--5. Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
select * from Employees where Age < 30 and DepartmentName in('HR' or 'IT')
--6. Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
select * from Customers where email like '%@gmail.com%'
--7. Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
select * from employees where salary > all(select salary from employees where departmentname = 'Sales')
--8. Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and GETDATE().
select * from orders where OrderDate between DATEADD(DAY, -180, GETDATE()) AND GETDATE()

