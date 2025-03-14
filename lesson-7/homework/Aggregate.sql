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



--● Medium-Level Tasks (10) 
--11. Write a query to calculate the total sales and average sales for each product category from the Sales table.
select Category, sum(sales) Total, avg(sales) Average from Sales group by Category
--12. Write a query that uses COUNT(columnname) to count the number of employees with a specific JobTitle.
select Departmentname, Count(Employeename) CountOfEmp from EmployeeDepartments group by Departmentname
--13. Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.
select departmentid, max(salary) MaxSalary, min(salary) MinSalary from employees group by departmentid
--14. Write a query that uses GROUP BY to calculate the average salary per Department.
select departmentid, avg(salary) AvgSalary from employees group by departmentid
--15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.
select departmentid, avg(salary) AvgSalary, count(*) CountOfEmp from employees group by departmentid
--16. Write a query that uses HAVING to filter products with an average price greater than 100.
select Name, avg(price) as AvgPrice from Products group by Name having avg(price) > 100
--17. Write a query to count how many products have sales above 100 units using COUNT(DISTINCT ProductID).
select COUNT(DISTINCT ProductID) from Sales where SaleAmount > 100
--18. Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.
select year(saledate) Year, count(year(saledate)) TotalSales from sales group by year(saledate)
--19. Write a query that uses COUNT to show the number of customers who placed orders in each region.
select location, count(*) from customers group by location
--20. Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 100,000.
select departmentid, sum(salary) from employees group by departmentid having sum(salary) > 100000



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
