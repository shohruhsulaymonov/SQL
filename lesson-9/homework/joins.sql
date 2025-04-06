--1. Using Products, Suppliers table List all combinations of product names and supplier names.
select ProductName, supplierName from products cross join suppliers
--2. Using Departments, Employees table Get all combinations of departments and employees.
select DepartmentName, Name from departments cross join employees
--3. Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
select ProductName, SupplierName from products p join suppliers s on p.SupplierID = s.SupplierID
--4. Using Orders, Customers table List customer names and their orders ID.
select CustomerName, OrderID from orders o join customers c on o.CustomerID = c.customerID
--5. Using Courses, Students table Get all combinations of students and courses.
select coursename, name from courses cross join students
--6. Using Products, Orders table Get product names and orders where product IDs match.
select ProductName, o.* from products p join orders o on p.productID = o.ProductID
--7. Using Departments, Employees table List employees whose DepartmentID matches the department.
select * from employees e join departments d on e.departmentID = d.departmentID
--8. Using Students, Enrollments table List student names and their enrolled course IDs.
select Name, CourseID from students s join enrollments e on s.StudentID = e.studentID
--9. Using Payments, Orders table List all orders that have matching payments.
select * from payments p join orders o on p.orderID = o.OrderID
--10. Using Orders, Products table Show orders where product price is more than 100.
select * from orders o join products p on o.productID = P.productID where price > 100
--11. Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
select * from employees e join departments d on e.departmentID <> d.departmentID
--12. Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
select * from orders o join products p on o.ProductID = p.productID where Quantity > StockQuantity
--13. Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
select CustomerName, ProductID from customers c join sales s on c.customerID = s.CustomerID where saleamount >= 500
--14. Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
select Name, Coursename from courses c join enrollments e on c.courseID = e.courseID full join students s on e.studentID = s.StudentID
--15. Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
select ProductName, SupplierName from products p join suppliers s on p.SupplierID = s.SupplierID where SupplierName like '%Tech%'
--16. Using Orders, Payments table Show orders where payment amount is less than total amount.
select * from orders o join payments p on o.OrderID = p.orderID where Amount < TotalAmount
--17. Using Employees table List employee names with salaries greater than their manager’s salary.
select 
	e1.Name 
from employees e1 
join employees e2 
on e1.managerID = e2.employeeID 
where e1.salary > e2.salary
--18. Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
select ProductName, CategoryName from products p join categories c on p.categoryID = c.categoryID where CategoryName in('Electronics', 'Furniture')
--19. Using Sales, Customers table Show all sales from customers who are from 'USA'.
select * from sales s join customers c on s.customerID = c.CustomerID where country = 'USA'
--20. Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
select * from orders o join customers c on o.CustomerID = c.customerID where country = 'Germany' and TotalAmount > 100

--21. Using Employees table List all pairs of employees from different departments.
select e1.Name, e2.Name from Employees e1 join Employees e2 on e1.DepartmentID <> e2.DepartmentID
--22. Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
select pay.* from Products pro join Orders ord on pro.ProductID = ord.ProductID join Payments pay on ord.OrderID = pay.OrderID where pay.Amount <> ord.Quantity*pro.Price
--23. Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
select s.* from students s full join Enrollments e on s.StudentID = e.StudentID where e.CourseID is null
--24. Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
select e1.Name from Employees e1 join Employees e2 on e1.employeeID = e2.ManagerID where e1.Salary <= e2.Salary
--25.Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
select c.* from orders o left join Payments p on o.OrderID = p.OrderID join Customers c on o.CustomerID= c.CustomerID where p.PaymentID is null
