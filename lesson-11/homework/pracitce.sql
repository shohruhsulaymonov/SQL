--Task 1 Retrieve all employee names along with their corresponding department names.
select 
	Name, 
	DepartmentName 
from Employees e 
	join Departments d 
	on e.DepartmentID = d.DepartmentID
-- Task 2 Question: List all students along with their class names, including students who are not assigned to any class.
select 
	s.StudentID, 
	s.StudentName, 
	c.ClassName 
from Students s 
left join Classes c 
on s.ClassID = c.ClassID
--Task 3 List all customers and their orders, including customers who haven’t placed any orders.
select * 
from Orders o 
right join Customers c
on o.CustomerID = c.CustomerID

--Task 4 Retrieve a list of all products and their sales, including products with no sales and sales with invalid product references.
select * 
from Products p 
full outer join Sales s 
on p.ProductID = s.ProductID

--Task 5 Find the names of employees along with the names of their managers.
select 
	e1.Name, 
	e2.Name
from Employees e1 
left join employees e2 
on e1.ManagerID = e2.EmployeeID

--Task 6 Generate all possible combinations of colors and sizes.
select 
	Colorname, 
	SizeName 
from Colors 
cross join Sizes

--Task 7 Find all movies released after 2015 and their associated actors.
select * 
from Movies m 
join Actors a 
on m.MovieID = a.MovieID 
where ReleaseYear > 2015

--Task 8 Retrieve the order date, customer name, and the product ID for all orders.
select 
	o.OrderDate, 
	c.CustomerName, 
	d.ProductID 
from Orders o 
join Customers c 
on o.CustomerID = c.CustomerID 
join OrderDetails d 
on o.OrderID = d.OrderID

--Task 9 Calculate the total revenue generated for each product.
select 
	ProductName, 
	sum(Price*Quantity) as [Total Revenue]
from Products p 
join Sales s 
on p.ProductID = s.ProductID 
group by p.ProductName
