--🟢 Easy-Level Tasks (10)

--1. Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--🔁 Expected Output: EmployeeName, Salary, DepartmentName
select Name, Salary, DepartmentName from Employees e join Departments d on e.DepartmentID = d.DepartmentID
--2. Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--🔁 Expected Output: FirstName, LastName, OrderDate
select FirstName, LastName, OrderDate from Customers c join Orders o on c.CustomerID = o.CustomerID and year(OrderDate) = 2023
--3. Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
--🔁 Expected Output: EmployeeName, DepartmentName
select e.Name, d.DepartmentName from Employees e left outer join Departments d on e.DepartmentID = e.DepartmentID 
--4. Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--🔁 Expected Output: SupplierName, ProductName
select SupplierName, ProductName from Products p right join Suppliers s on p.SupplierID = s.SupplierID
--5. Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
--🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount
select o.OrderID, OrderDate, PaymentDate, Amount from Orders o full outer join Payments p on o.OrderID = p.OrderID
--6. Using the Employees table, write a query to show each employee's name along with the name of their manager.
--🔁 Expected Output: EmployeeName, ManagerName
select e1.Name EmployeeName, e2.Name ManagerName from Employees e1 left join Employees e2 on e1.ManagerID = e2.EmployeeID
--7. Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Output: StudentName, CourseName
select Name, CourseName from Students s join Enrollments e on s.StudentID = e.StudentID join Courses c on e.CourseID = c.CourseID and CourseName = 'Math 101'
--8. Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
--🔁 Expected Output: FirstName, LastName, Quantity
select FirstName, LastName, Quantity from Customers c join Orders o on c.CustomerID = o.CustomerID and Quantity > 3
--9. Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Output: EmployeeName, DepartmentName
select Name, DepartmentName from Employees e join Departments d on e.DepartmentID = d.DepartmentID and DepartmentName = 'Human Resources'

--🟠 Medium-Level Tasks (9)

--1. Using the Employees and Departments tables, write a query to return department names that have more than 10 employees.
--🔁 Expected Output: DepartmentName, EmployeeCount
select DepartmentName, count(*) EmployeeCount from Employees e join Departments d on e.DepartmentID = d.DepartmentID group by DepartmentName having count(*) > 10
--2. Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Output: ProductID, ProductName
select p.ProductID, ProductName from Products p left join Sales s on p.ProductID = s.ProductID where SaleID is null
--3. Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Output: FirstName, LastName, TotalOrders
select FirstName, LastName, count(*) TotalOrders from Customers c join Orders o on c.CustomerID = o.CustomerID group by FirstName, LastName
--4. Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Output: EmployeeName, DepartmentName
select * from Employees e join Departments d on e.DepartmentID = d.DepartmentID
--5. Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Output: Employee1, Employee2, ManagerID
select e1.Name Employee1, e2.Name Employee2, e2.ManagerID from Employees e1 join Employees e2 on e1.ManagerID = e2.ManagerID and e1.EmployeeID <> e2.EmployeeID
--6. Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Output: OrderID, OrderDate, FirstName, LastName
select OrderID, OrderDate, FirstName, LastName from Orders o join Customers c on o.CustomerID = c.CustomerID where year(OrderDate) = 2022
--7. Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Output: EmployeeName, Salary, DepartmentName
select Name, Salary, DepartmentName from Employees e join Departments d on e.DepartmentID = d.DepartmentID and DepartmentName = 'Sales' and Salary > 60000
--8. Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount
select o.OrderID, OrderDate, PaymentDate, Amount from Orders o join Payments p on o.OrderID = p.OrderID
--9. Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Output: ProductID, ProductName
select p.ProductID, ProductName from Products p left join Orders o on p.ProductID = o.ProductID where OrderID is null

--🔴 Hard-Level Tasks (9)

--1. Using the Employees table, write a query to find employees whose salary is greater than the average salary of all employees.
--🔁 Expected Output: EmployeeName, Salary
select Name, Salary from employees where salary > (select avg(salary) from Employees)
--2. Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Output: OrderID, OrderDate
select o.OrderID, OrderDate from orders o left join Payments p on o.OrderID = p.OrderID where year(OrderDate) < 2020 and PaymentID is null
--3. Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Output: ProductID, ProductName
select ProductID, ProductName from Products p left join Categories c on p.categoryID = c.CategoryID where c.CategoryID is null
--4. Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Output: Employee1, Employee2, ManagerID, Salary
select 
	e1.Name Employee1, 
	e1.Salary, 
	e2.name Employee2, 
	e2.Salary, 
	e3.Name Manager 
from Employees e1 
join Employees e2 
on e1.ManagerID = e2.ManagerID 
and e1.EmployeeID <> e2.EmployeeID 
join Employees e3 
on e2.ManagerID = e3.EmployeeID 
where e1.Salary > 60000 and e2.Salary > 60000
--5. Using the Employees and Departments tables, write a query to return employees who work in departments whose name starts with the letter 'M'.
--🔁 Expected Output: EmployeeName, DepartmentName
select Name, DepartmentName from Employees e join Departments d on e.DepartmentID = d.DepartmentID where DepartmentName like 'M%'
--6. Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Output: SaleID, ProductName, SaleAmount
select SaleID, ProductName, SaleAmount from Products p join Sales s on p.ProductID = s.ProductID and SaleAmount > 500
--7. Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Output: StudentID, StudentName
select * from Students s join Enrollments e on s.StudentID = e.StudentID join Courses c on e.CourseID = c.CourseID and c.CourseName <> 'Math 101'
--8. Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Output: OrderID, OrderDate, PaymentID
select o.OrderID, OrderDate, PaymentID from Orders o left join Payments p on o.OrderID = p.OrderID and PaymentID is null
--9. Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Output: ProductID, ProductName, CategoryName
select ProductID, ProductName, CategoryName from Products p join Categories c on p.CategoryID = c.CategoryID and c.CategoryName in ('Electronics', 'Furniture')
