--Easy-Level Tasks (10)
--1. Write a query to find the minimum (MIN) price of a product in the Products table.
select min(price) from products
--2. Write a query to find the maximum (MAX) Salary from the Employees table.
select max(salary) from employees
--3. Write a query to count the number of rows in the Customers table using COUNT(*).
select count(*) from customers
--4. Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.
select count(distinct price) from products
--5. Write a query to find the total (SUM) sales for a particular product in the Sales table. 
select ProductID , sum(saleamount) from sales group by ProductID
--6. Write a query to calculate the average (AVG) age of employees in the Employees table.
select avg(age) employees
--7. Write a query that uses GROUP BY to count the number of employees in each department.
select DepartmentName, count(EmployeeID) from EmployeeDepartments group by DepartmentName
--8. Write a query to show the minimum and maximum Price of products grouped by Category.
select category, min(price) MinPrice, max(price) MaxPrice from Products2 group by category
--9. Write a query to calculate the total (SUM) sales per Region in the Sales table.
select Region, sum(SaleAmount) from Sales group by Region
--10. Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.
select DepartmentName, count(EmployeeName) CountOfEmp from EmployeeDepartments group by DepartmentName having count(EmployeeName) > 5

