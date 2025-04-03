--1. Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
create table Employees(
	EmpID INT, 
	Name VARCHAR(50),
	Salary DECIMAL(10,2)
);
--2. Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
insert into Employees values (1, 'Steve', 50000)
insert into Employees values 
(2, 'Alice', 60000),
(3, 'Adam', 40000)
--3. Update the Salary of an employee where EmpID = 1.
update Employees
set Salary = 55000
where EmpID = 1
--4. Delete a record from the Employees table where EmpID = 2.
delete from Employees
where EmpID = 2
--5. Demonstrate the difference between DELETE, TRUNCATE, and DROP commands on a test table.
delete from test_table where condition
--deletes records where the condition is fulfilled. if no condition is given deletes all records, but leaves the table structure untouched
truncate test_table
-- deletes all records from a table without altering the structure of the table
drop test_table
-- deletes the table altogether; both data and the structure itself
--6. Modify the Name column in the Employees table to VARCHAR(100).
alter table Employees
alter column [Name] varchar(100)
--7. Add a new column Department (VARCHAR(50)) to the Employees table.
alter table Employees
add Department varchar(50)
--8. Change the data type of the Salary column to FLOAT.
alter table Employees
alter column Salary float
--9. Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
create table Departments(
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(50)
);
--10. Remove all records from the Employees table without deleting its structure.
truncate table employees

--11. Insert five records into the Departments table using INSERT INTO SELECT from an existing table.
CREATE TABLE Dept (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100));
INSERT INTO Dept (DepartmentID, DepartmentName) VALUES
(1, 'Sales'),
(2, 'Human Resources'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Finance');

insert into Departments select * from dept
--12. Update the Department of all employees where Salary > 5000 to 'Management'.
update Employees
set Department = 'Management'
where Salary > 5000
--13. Write a query that removes all employees but keeps the table structure intact.
truncate table employees
--14. Drop the Department column from the Employees table.
alter table Employees
drop column Department
--15. Rename the Employees table to StaffMembers using SQL commands.
exec sp_rename 'Employees', 'StaffMembers'
--16. Write a query to completely remove the Departments table from the database.
drop table Departments
--17. Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products(
	ProductID int primary key,
	ProductName varchar(50),
	Category varchar(50),
	Color varchar(50),
	Supplier varchar(50),
	Price decimal
);
--18. Add a CHECK constraint to ensure Price is always greater than 0.
alter table Products
add check (price > 0)
--19. Modify the table to add a StockQuantity column with a DEFAULT value of 50.
alter table Products 
add StockQuantity int default(50)
--20. Rename Category to ProductCategory
exec sp_rename 'Products.Category', 'ProductCategory', 'column'
--21. Insert 5 records into the Products table using standard INSERT INTO queries.
insert into Products values
(1, 'Laptop','Electronics', 'Navy', 'HP', 1000, 200),
(2, 'Smartphone', 'Electronics', 'Golden', 'YouPhone', 500, 300),
(3, 'Tablet', 'Electronics', 'White', 'Xiaomi', 400, 150),
(4, 'Monitor','Electronics', 'Black', 'Razor', 300, 100),
(5, 'Keyboard','Accessories', 'White', 'Logitech', 200, 200)
--22. Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
select *
into Products_Backup
from Products
--23. Rename the Products table to Inventory.
exec sp_rename 'Products', 'Inventory'
--24. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
alter table Inventory
alter column Price float
--25. Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5.
alter table Inventory
add ProductCode int identity(1000, 5)
