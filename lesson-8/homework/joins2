--## 🟢 Easy-Level Tasks (10)

--1. Write a query to join the Customers and Orders tables using an INNER JOIN to get the CustomerName and their OrderDate.
select c.customername, o.orderdate from Customers c inner join Orders o on c.CustomerID = o.CustomerID
--2. Write a query to demonstrate a One to One relationship between the EmployeeDetails and Employees tables by joining them.
select * from Employees e1 join EmployeeDetails e2 on e1.EmployeeID = e2.EmployeeID
--3. Write a query to join the Products and Categories tables to show ProductName along with CategoryName using INNER JOIN.
select product_name, category_name from Products2 p inner join Categories c on p.category_id = c.category_id
--4. Write a query to show all Customers and the corresponding OrderDate using LEFT JOIN between Customers and Orders.
select c.customername, o.orderdate from Customers c left join orders o on c.CustomerID = o.CustomerID
--5. Write a query that demonstrates a Many to Many relationship between Orders and Products tables using an intermediate OrderDetails table.
select o.customer_name, p.product_name, d.quantity, p.price, p.price * d.quantity as TotalPrice, o.order_date from orders o join orderdetails d on o.order_id = d.order_id join products p on p.product_id = d.product_id
--6. Write a query to perform a CROSS JOIN between Products and Categories, showing all possible combinations of products and categories.
select * from products cross join Categories
--7. Write a query to demonstrate the One to Many relationship between Customers and Orders using INNER JOIN.
select * from orders o inner join Customers c on o.CustomerID = c.CustomerID
--8. Write a query to filter a CROSS JOIN result using the WHERE clause, showing only combinations of Products and Orders where OrderAmount > 500.
select * from Products, orders where OrderAmount > 500
--9. Write a query that uses INNER JOIN to join the Employees and Departments tables, showing employee names and their corresponding department names.
select FirstName + ' ' + LastName as EmployeeName, DepartmentName from Employees e inner join Departments d on e.DepartmentID = d.DepartmentID
--10. Write a query that uses the ON clause with a <> operator to join two tables and return rows where the values in the two columns are not equal.
select * from Employees e join Departments d on e.DepartmentID <> d.DepartmentID

-----

--## 🟠 Medium-Level Tasks (10)

--11. Write a query to demonstrate a One to Many relationship by joining the Customers and Orders tables using INNER JOIN, showing the CustomerName and the total number of orders.
select customername, count(*) Number_of_Orders from Customers c inner join orders o on c.CustomerID = o.CustomerID group by CustomerName
--12. Write a query to demonstrate a Many to Many relationship between Students and Courses by joining through the StudentCourses table.
select student_name, course_name from students s join studentcourses sc on s.student_id = sc.student_id join courses c on sc.course_id = c.course_id;
--13. Write a query to use a CROSS JOIN between Employees and Departments tables, and filter the results by Salary > 5000 using the WHERE clause.
select * from employees cross join Departments where Salary > 5000
--14. Write a query to demonstrate a One to One relationship by joining the Employee and EmployeeDetails tables, showing each employee’s name and their details.
select * from Employees e join EmployeeDetails ed on e.EmployeeID = ed.EmployeeID
--15. Write a query to perform an INNER JOIN between Products and Suppliers and use the WHERE clause to filter only products supplied by 'Supplier A'.
select * from products p inner join Suppliers s on p.ProductID = s.product_id where supplier_name = 'Supplier A'
--16. Write a query to perform a LEFT JOIN between Products and Sales, and display all products along with their sales quantity (including products with no sales).
select ProductName, Sales_Quantity from Products p left join Sales s on p.ProductID = s.ProductID
--17. Write a query to join Employees and Departments using a WHERE clause, and show all employees whose salary is greater than 4000 and who work in the ‘HR’ department.
select * from Employees e join Departments d on e.DepartmentID = d.DepartmentID where Salary > 4000 and DepartmentName = 'HR'
--18. Write a query to show how to use the >= operator in the ON clause to join two tables and return rows where the values meet the condition.
select * from Employees e join Departments d on e.DepartmentID >= d.DepartmentID
--19. Write a query to demonstrate INNER JOIN and use the >= operator to find all products with a price greater than or equal to 50, and their respective suppliers.
select ProductName,price, supplier_name from Products p join Suppliers s on p.ProductID = s.product_id where Price >= 50
--20. Write a query to demonstrate a CROSS JOIN between Sales and Regions, and use the WHERE clause to show only regions with sales greater than 1000.
select Region_name, sum(SaleAmount) from Sales s cross join Regions group by Region_name having Sum(saleamount) > 1000

-----

--## 🔴 Hard-Level Tasks (10)

--21. Write a query that demonstrates a Many to Many relationship between Authors and Books using the intermediate AuthorBooks table, showing the AuthorName and the BookTitle.
select author_name, book_title from authors a join authorbooks ab on a.author_id = ab.author_id join books b on ab.book_id = b.book_id
--22. Write a query to join Products and Categories using INNER JOIN, and filter the result to only include products where the CategoryName is not ‘Electronics’.
select * from Products p inner join Categories c on p.category_id = c.category_id where category_name <> 'Electronics'
--23. Write a query to perform a CROSS JOIN between Orders and Products, and filter the result with a WHERE clause to show only orders where the quantity is greater than 100.
select * from orders o cross join products p where o.orderamount > 100
--24. Write a query that joins the Employees and Departments tables and uses a logical operator in the ON clause to only return employees who have been with the company for over 5 years.
select * from Employees e join Departments d on e.DEPARTMENTID = d.DEPARTMENTID where year(getdate()) - year(hire_date) > 5
--25. Write a query to show the difference between INNER JOIN and LEFT JOIN by returning employees and their departments, ensuring that employees without departments are included in the left join.
select * from employees e inner join departments d on e.DepartmentID = d.DepartmentID
select * from Employees e left join Departments d on e.DepartmentID = d.DepartmentID
--26. Write a query that uses a CROSS JOIN between Products and Suppliers, and filters the result using WHERE to include only suppliers that supply products in 'Category A'.
select * from products2 p cross join Suppliers s WHERE category = 'Category A'
--27. Write a query to demonstrate a One to Many relationship using INNER JOIN between Orders and Customers, and apply the >= operator to filter only customers with at least 10 orders.
select o.customerID, CustomerName from orders o inner join Customers c on o.CustomerID = c.CustomerID group by o.CustomerID, CustomerName having count(*) >= 10
--28. Write a query to demonstrate the Many to Many relationship between Courses and Students, showing all courses and the number of students enrolled using the COUNT function.
select c.course_name, count(*) from students s join studentcourses sc on s.student_id = sc.student_id join courses c on sc.course_id = c.course_id group by c.course_name;
--29. Write a query to use a LEFT JOIN between Employees and Departments tables, and filter the result using the WHERE clause to show only employees in the 'Marketing' department.
select * from Employees e left join Departments d on e.DepartmentID = d.DepartmentID where d.DepartmentName = 'Marketing'
--30. Write a query that uses the ON clause with <= operator to join two tables and return rows where the values in the columns meet the condition.
select * from Employees e join Departments d on e.DepartmentID <= d.DepartmentID
