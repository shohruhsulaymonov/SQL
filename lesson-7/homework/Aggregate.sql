--Easy-Level Tasks (10)
--1. Write a query to find the minimum (MIN) price of a product in the Products table.
select min(price) from products
--2. Write a query to find the maximum (MAX) Salary from the Employees table.
select max(salary) from employees
--3. Write a query to count the number of rows in the Customers table using COUNT(*).
select count(*) from customers
--4. Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.
select count(distinct Category) from products
--5. Write a query to find the total (SUM) sales amount for the product with id 7 in the Sales table.
select sum(SaleAmount) from sales where ProductID = 7
--6. Write a query to calculate the average (AVG) age of employees in the Employees table.
select avg(age) employees
--7. Write a query that uses GROUP BY to count the number of employees in each department.
select DepartmentName, count(EmployeeID) from Employees group by DepartmentName
--8. Write a query to show the minimum and maximum Price of products grouped by Category.
select category, min(price) MinPrice, max(price) MaxPrice from Products group by category
--9. Write a query to calculate the total (SUM) sales per Customer in the Sales table.
select CustomerID, sum(SaleAmount) Total from sales group by CustomerID
--10. Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.
select DepartmentName, count(*) as CountOfEmp from Employees group by DepartmentName having count(*) > 5

--● Medium-Level Tasks (10) 
    --11. Write a query to calculate the total sales and average sales for each product category from the Sales table.
    select Category, sum(sales) Total, avg(sales) Average from Sales group by Category
--12. Write a query that uses COUNT(columnname) to count the number of employees with a specific JobTitle.
select Count(Employeename) CountOfEmp from Employees where Departmentname = 'HR'
--13. Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.
select DepartmentName, min(Salary) MinSalary, max(Salary) MaxSalary from Employees group by DepartmentName
--14. Write a query that uses GROUP BY to calculate the average salary per Department.
select DepartmentName, avg(salary) AvgSalary from Employees group by DepartmentName
--15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.
select DepartmentName, avg(salary) AvgSalary, count(*) CountOfEmp from Employees group by DepartmentName
--16. Write a query that uses HAVING to filter product categories with an average price greater than 400.
select Category, avg(Price) AvgPrice from Products group by Category having avg(Price) > 400
--17. Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.
select year(SaleDate) Year, sum(Saleamount) from Sales group by year(SaleDate)
--18. Write a query that uses COUNT to show the number of customers who placed at least 3 orders.
select CustomerID, count(*) NumOfOrders from Orders group by CustomerID having count(*) >= 3
--19. Write a query that uses COUNT to show the number of customers who placed orders in each region.
select location, count(*) from customers group by location
--20. Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 100,000.
select DepartmentName, sum(Salary) from Employees group by DepartmentName having not sum(Salary) > 500000


--Hard-Level Tasks (10) 
--21. Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.
select category, avg(price) from products group by category having avg(price) > 200
--22. Write a query to calculate the total (SUM) sales for each employee, then filter the results using HAVING to include only employees with total sales over 5000.
select employeeid, sum(salary) from employees group by employeeid having sum(salary) > 5000
--23. Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 6000. 
select departmentid, sum(salary) Sum , avg(salary) Average from employees group by departmentid having avg(salary) > 6000
--24. Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50. 
select customerid, max(saleamount) MaxValue, min(saleamount) MinValue from Sales group by CustomerID, saleamount having saleamount > 50
--25. Write a query that calculates the total sales (SUM) and counts distinct products sold in each Region, and then applies HAVING to filter regions with more than 10 products sold.
select region, sum(saleamount) TotalSales, count(distinct productid) Amount from sales group by region having count(productid) > 10
--26. Write a query to find the MIN and MAX order quantity per product, and then use GROUP BY to group the results by ProductCategory.
select productid, category, min(stockquantity), max(stockquantity) from products group by productid, category
--27. Write a query to pivot the Sales table by Year and show the sum of SalesAmount for each Region.
SELECT * 
FROM (
    SELECT 
        Region, 
        YEAR(SaleDate) AS Year, 
        SaleAmount
    FROM Sales2
) AS SourceTable
PIVOT (
    SUM(SaleAmount) 
    FOR Year IN ([2020], [2021], [2022], [2023], [2024])
) AS PivotTable;
--28. Write a query to unpivot the Sales table, converting Q1, Q2, Q3, and Q4 columns into rows showing total sales per quarter. 

--29. Write a query to count the number of orders per product, filter those with more than 50 orders using HAVING, and group them by ProductCategory. 
select category, productid, count(*) NoOfProduct from products group by category, productid having sum(stockquantity) > 50
--30. Write a query to pivot the EmployeeSales table, displaying the total sales per employee for each quarter (Q1, Q2, Q3, Q4).
