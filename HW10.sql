--🟢 Easy-Level Tasks (10)
set statistics io on
--1.Write a query to perform an INNER JOIN between Orders and Customers using AND in the ON clause to filter orders placed after 2022.
SELECT * 
FROM Orders o 
INNER JOIN Customers c 
ON o.CustomerID = c.CustomerID 
AND year(o.OrderDate) > 2022;
--2.Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department.
SELECT * 
FROM Employees e 
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID 
AND (d.DepartmentName = 'Sales' 
OR d.DepartmentName = 'Marketing');
--3.Write a query to join a derived table (for example, SELECT * FROM Products WHERE Price > 100) with the Orders table to display products and their corresponding orders.
select p.ProductName, o.* from products p cross apply (select * from Orders where p.ProductID = ProductID) o
--4.Write a query to join a Temp table (for example, Temp_Orders) and the Orders table to show orders that are present in both tables.
select * 
from orders ord 
join #temp_orders temp 
on ord.orderid = temp.orderid
--5.Write a query to demonstrate a CROSS APPLY between Employees and a derived table that shows their department's top-performing sales (e.g., top 5 sales).
--select * 
--from Employees e 
--join departments d 
--on e.departmentid = d.departmentid 
--cross apply (select top 2 s.saleid, s.amount from Sales s where e.employeeid = s.employeeid) s order by d.departmentname, s.amount desc
--?????????????????????????????
--6.Write a query to join Customers and Orders using AND in the ON clause to filter customers who have placed orders in 2023 and have a loyalty status of 'Gold'.
select * 
from Customers c 
join Orders o 
on c.CustomerID = o.CustomerID 
and year(o.OrderDate) = 2023 
and c.LoyaltyStatus = 'Gold';
--7.Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID) with the Customers table to show the number of orders per customer.
select o.customerid, c.CustomerName, c.City, o.[count] 
from Customers c 
cross apply (
SELECT CustomerID, COUNT(*) as [count] 
FROM Orders o 
where o.CustomerID = c.CustomerID 
GROUP BY CustomerID
) o
--8.Write a query to join Products and Suppliers using OR in the ON clause to show products supplied by either 'Supplier A' or 'Supplier B'.
select * 
from Products p 
join Suppliers s 
on p.ProductID = s.product_id 
and (supplier_name = 'Supplier A' 
or supplier_name = 'Supplier B');
--9.Write a query to demonstrate the use of OUTER APPLY between Employees and a derived table that returns each employee's most recent order.
select emp.name, result.orderdate, result.amount
from Employees2 emp
cross apply(
select top 1 * 
from orders 
where emp.employeeid = employeeid
order by orderdate desc
		) result
--10.Write a query to perform a CROSS APPLY between Departments and a table-valued function that returns a list of employees working in that department.
--???????????????????????????????




--🟠 Medium-Level Tasks (10)
--11.Write a query that uses the AND logical operator in the ON clause to join Orders and Customers, and filter customers who placed an order with a total amount greater than 5000.
select * 
from Orders o 
join customers c 
on o.CustomerID = c.CustomerID 
and o.TotalAmount > 5000;
--12.Write a query that uses the OR logical operator in the ON clause to join Products and Sales to filter products that were either sold in 2022 or have a discount greater than 20%.
select * 
from Products p 
join sales s 
on p.ProductID = s.ProductID 
and (year(s.SaleDate) = 2022 
or discount > 20%);
--13.Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount) FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.
select * from products p left join (SELECT ProductID, SUM(SaleAmount) amount FROM Sales GROUP BY ProductID) s on p.ProductID = s.ProductID
--14.Write a query to join a Temp table (Temp_Products) and the Products table to show the products that have been discontinued in the Temp table.
select p.productid, p.productname from products p join #temp_products  t on p.productid = t.productid and is_discontinued = 1
--15.Write a query to demonstrate CROSS APPLY by applying a table-valued function to each row of the Employees table to return the sales performance for each employee.
--?????????????????????????
--16.Write a query to join Employees and Departments using AND in the ON clause to filter employees who belong to the 'HR' department and whose salary is greater than 5000.
select * 
from Employees e 
join Departments d 
on e.DepartmentID = d.DepartmentID 
and d.DepartmentName = 'HR' 
and e.Salary > 5000
--17.Write a query to join Orders and Payments using OR in the ON clause to show orders that have either been paid fully or partially.
select * 
from Orders o 
join Payments p 
on o.OrderID = p.order_id 
and (p.status = 'Paid fully' 
or p.status = 'Paid partially')
--18.Write a query to use OUTER APPLY to return all customers along with their most recent orders, including customers who have not placed any orders.
select c.CustomerID, c.CustomerName, c.City, o.OrderDate 
from Customers c 
outer apply(
select top 1 CustomerID, OrderDate 
from orders
where c.CustomerID = CustomerID 
order by OrderDate desc
		) o
--19.Write a query to join Products and Sales using AND in the ON clause to filter products that were sold in 2023 and have a rating greater than 4.
select * 
from Products p 
join Sales s 
on p.ProductID = s.ProductID 
and (year(s.SaleDate) = 2023 
and rating > 4);
--20.Write a query to join Employees and Departments using OR in the ON clause to show employees who either belong to the 'Sales' department or have a job title that contains 'Manager'.
select * 
from employees e 
join departments d 
on e.DepartmentID = d.DepartmentID 
and (d.DepartmentName ='sales' 
or e.JobTitle like '%Manager%');



--🔴 Hard-Level Tasks (10)
--21. Write a query to demonstrate the use of the AND logical operator in the ON clause between Orders and Customers, and filter orders made by customers who are located in 'New York' and have made more than 10 orders. 
select * 
from orders o 
join customer c 
on o.customerid = c.customerid 
and c.city = 'New York' 
and o.customerid in (select customerid from orders group by customerid having count(*) > 2)
-- Solution2
select c.customerid 
from orders o 
join customer c 
on o.customerid = c.customerid 
and c.city = 'New York' 
group by c.customerid 
having count(*) > 2
--22. Write a query to demonstrate the use of OR in the ON clause when joining Products and Sales to show products that are either part of the 'Electronics' category or have a discount greater than 15%. 
select * 
from products p 
join sales s 
on p.productid = s.productid 
and (p.category = 'Electronics' 
or s.discount > 15);
--23. Write a query to join a derived table that returns a count of products per category (SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories table to show the count of products in each category. 
select 
	Category_name, 
	[count of items] 
from Categories c join
(select 
	category_id, 
	count(*) [count of items] 
from Products p 
group by category_id
) [count] 
on c.category_id = [count].category_id
--24. Write a query to join a Temp table (Temp_Employees) with the Employees table using a complex condition in the ON clause (e.g., salary > 4000 AND department = 'IT'). 
--??????????????????????????????????
--25. Write a query to demonstrate CROSS APPLY by applying a table-valued function that returns the number of employees working in each department for every row in the Departments table. 
--??????????????????????????????
--26. Orders and Customers using AND in the ON clause to show orders where the customer is from 'California' and the order amount is greater than 1000. 
select * 
from orders o 
join customers c 
on o.CustomerID = c.CustomerID 
and City = 'California' 
and o.OrderAmount > 1000;
--27. Write a query to join Employees and Departments using a complex OR condition in the ON clause to show employees who are in the 'HR' or 'Finance' department, or have an 'Executive' job title. 
select * 
from Employees e 
join Departments d 
on e.DepartmentID = d.DepartmentID 
and (d.DepartmentName in('HR', 'Finance') 
or e.JobTitle = 'Executive');
--28. Write a query to use OUTER APPLY between Customers and a table-valued function that returns all orders placed by each customer, and show customers who have not placed any orders. 
--???????????????????????????????
--29. Write a query to join Sales and Products using AND in the ON clause to filter products that have both a sales quantity greater than 100 and a price above 50. 
select * 
from sales s 
join Products p 
on s.ProductID = p.ProductID 
and s.SaleAmount > 100 
and p.Price > 50;
--30. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department, and with a salary greater than 6000.
select * 
from Employees e 
join Departments d 
on e.DepartmentID = d.DepartmentID
and (d.DepartmentName = 'Sales' or d.DepartmentName = 'Marketing')
and e.Salary > 6000;