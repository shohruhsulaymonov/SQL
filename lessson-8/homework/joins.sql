
--## 🟢 Easy-Level Tasks (10)

--1. Write a query to join Employees and Departments using an INNER JOIN, and apply a WHERE clause to show only employees whose salary is greater than 5000.
select * from employees e inner join departments d on e.departmentid = d.departmentid where salary > 5000
--2. Write a query to join Customers and Orders using an INNER JOIN, and apply the WHERE clause to return only orders placed in 2023.
select * from customers c inner join orders o on c.customerid = o.customerid where year(orderdate) = 2023
--3. Write a query to demonstrate a LEFT OUTER JOIN between Employees and Departments, showing all employees and their respective departments (including employees without departments).
select * from Employees e left outer join Departments d on e.departmentid = d.departmentid
--4. Write a query to perform a RIGHT OUTER JOIN between Products and Suppliers, showing all suppliers and the products they supply (including suppliers without products).
select * from Products p right join Suppliers s on p.ProductID = s.productID
--5. Write a query to demonstrate a FULL OUTER JOIN between Orders and Payments, showing all orders and their corresponding payments (including orders without payments and payments without orders).
select * from orders o full outer join Payments p on o.OrderID = p.orderID
--6. Write a query to perform a SELF JOIN on the Employees table to display employees and their respective managers (showing EmployeeName and ManagerName).
select e1.EmployeeName, e2.EmployeeName from Employees e1 left join Employees e2 on e1.manager_id = e2.Employee_ID
--7. Write a query to demonstrate the logical order of SQL query execution by performing a JOIN between Products and Sales, followed by a WHERE clause to filter products with sales greater than 100.
select * from products p join sales s on p.productid = s.productid where SaleAmount > 100
--8. Write a query to join Students and Courses using INNER JOIN, and use the WHERE clause to show only students enrolled in 'Math 101'.
select * from Students s inner join Courses c on s.course_id = c.course_id where course_name = 'Math 101'
--9. Write a query that uses INNER JOIN between Customers and Orders, and filters the result with a WHERE clause to show customers who have placed more than 3 orders.
select * from Customers c inner join orders o on c.CustomerID = o.CustomerID where o.customerid in (select customerid from Orders group by CustomerID having count(*) > 3)
--10. Write a query to join Employees and Departments using a LEFT OUTER JOIN and use the WHERE clause to filter employees in the 'HR' department.
select * from employees e left outer join departments d on e.departmentid = d.DepartmentID where DepartmentName = 'HR'



--## 🟠 Medium-Level Tasks (10)

--11. Write a query to perform an INNER JOIN between Employees and Departments, and use the WHERE clause to show employees who belong to departments with more than 10 employees.
select * from Employees e join Departments d on e.DepartmentID = d.DepartmentID where e.DepartmentID in (select DepartmentID from Employees group by DepartmentID having count(*) > 10)
--12. Write a query to perform a LEFT OUTER JOIN between Products and Sales, and use the WHERE clause to filter only products with no sales.
select * from products p left outer join sales s on p.ProductID = s.productid where saleID is null
--13. Write a query to perform a RIGHT OUTER JOIN between Customers and Orders, and filter the result using the WHERE clause to show only customers who have placed at least one order.
select * from Customers c right outer join orders o on c.CustomerID = o.CustomerID where o.CustomerID in (select CustomerID from orders group by CustomerID having count(*) >= 1)
--14. Write a query that uses a FULL OUTER JOIN between Employees and Departments, and filters out the results where the department is NULL.
select * from employees e full outer join Departments d on e.DepartmentID = d.DepartmentID where d.Departmentid is null
--15. Write a query to perform a SELF JOIN on the Employees table to show employees who report to the same manager.
select * from employees e1 join Employees e2 on e1.MANAGER_ID = e2.EMPLOYEE_ID order by e2.Name
--16. Write a query that uses the logical order of SQL execution to perform a LEFT OUTER JOIN between Orders and Customers, followed by a WHERE clause to filter orders placed in the year 2022.
select * from orders o left outer join customers c on o.CustomerID = c.CustomerID where year(o.OrderDate) = 2022
--17. Write a query to use the ON clause with INNER JOIN to return only the employees from the 'Sales' department whose salary is greater than 5000.
select * from Employees e inner join Departments d on e.DepartmentID = d.DepartmentID where d.DepartmentName = 'Sales' and e.salary > 5000
--18. Write a query to join Employees and Departments using INNER JOIN, and use WHERE to filter employees whose department's DepartmentName is 'IT'.
select * from Employees e inner join Departments d on e.DepartmentID = d.DepartmentID where d.DepartmentName = 'IT'
--19. Write a query to join Orders and Payments using a FULL OUTER JOIN, and use the WHERE clause to show only the orders that have corresponding payments.
select * from Orders o full outer join Payments p on o.orderid = p.order_id where payment_id is not null
--20. Write a query to perform a LEFT OUTER JOIN between Products and Orders, and use the WHERE clause to show products that have no orders.
select * from Products p left outer join orders o on p.ProductID = o.productID where o.OrderID is null
-----

--## 🔴 Hard-Level Tasks (10)

--21. Write a query that explains the logical order of SQL execution by using a JOIN between Employees and Departments, followed by a WHERE clause to show employees whose salary is higher than the average salary of their department.
SELECT e.employeeid, e.firstname, e.lastname, d.departmentname, e.salary FROM Employees e JOIN Departments d ON e.departmentid = d.departmentid WHERE e.salary > (SELECT AVG(salary) FROM Employees WHERE departmentid = e.departmentid)
--22. Write a query to perform a LEFT OUTER JOIN between Orders and Payments, and use the WHERE clause to return all orders placed before 2020 that have not been paid yet.
select * from orders o left outer join Payments p on o.OrderID = p.order_id where year(o.OrderDate) < 2020 and p.[status] <> 'completed'
--23. Write a query to perform a FULL OUTER JOIN between Products and Categories, and use the WHERE clause to filter only products that have no category assigned.
select * from Products p full outer join categories c on p.category_id = c.category_id where p.category_id is null
--24. Write a query to perform a SELF JOIN on the Employees table to find employees who report to the same manager and earn more than 5000.
select * from Employees e1 join Employees e2 on e1.EMPLOYEE_ID = e2.MANAGER_ID where e2.salary >5000 order by e1.Name
--25. Write a query to join Employees and Departments using a RIGHT OUTER JOIN, and use the WHERE clause to show employees from departments where the department name starts with ‘M’.
select * from employees e Right outer join departments d on e.DepartmentID = d.DepartmentID where d.DepartmentName like 'M%'
--26. Write a query to demonstrate the difference between the ON clause and the WHERE clause by joining Products and Sales, and using WHERE to filter only sales greater than 1000.
select * from Products p join Sales s on p.ProductID = s.ProductID where SaleAmount > 1000
--27. Write a query to perform a LEFT OUTER JOIN between Students and Courses, and use the WHERE clause to show only students who have not enrolled in 'Math 101'.
select * from students s left outer join Courses c on s.course_id = c.course_id where c.course_name <> 'Math 101'
--28. Write a query that explains the logical order of SQL execution by using a FULL OUTER JOIN between Orders and Payments, followed by a WHERE clause to filter out the orders with no payment.
select * from orders o full outer join Payments p on o.OrderID = p.order_id where payment_id is null
--29. Write a query to join Products and Categories using an INNER JOIN, and use the WHERE clause to filter products that belong to either 'Electronics' or 'Furniture'.
select * from products2 p inner join categories c on p.category_id = c.category_id where category_name in ('Electronics', 'Furniture')
--30. Write a query to perform a JOIN between Customers and Orders, and use the WHERE clause to filter the result to show customers with more than 2 orders placed in 2023.
select * from Customers c join Orders o on c.CustomerID = o.CustomerID where c.CustomerID in (select CustomerID from Orders group by CustomerID having count(CustomerID) > 2) and OrderDate = 2023
