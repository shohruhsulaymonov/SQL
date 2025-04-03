--1. Define and explain the purpose of BULK INSERT in SQL Server. 
--Bulk insert allows us to insert data from .txt and .csv to an existing table
--2. List four file formats that can be imported into SQL Server.
--.txt, .csv, .xlsx and json
--3. Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)). 
create table Products(
	ProductID INT PRIMARY KEY, 
	ProductName VARCHAR(50), 
	Price DECIMAL(10,2)
	CategoryID int
);
--4. Insert three records into the Products table using INSERT INTO.
insert into Products values
(1, 'Smartphone', 500),
(2, 'Headphones', 100),
(3, 'Fishing rod', 150)
--5. Explain the difference between NULL and NOT NULL with examples.
--NULL means that values in a column can have NULL values, whereas NOT NULL constraint prohibits the insertion of the NULL value
--6. Add a UNIQUE constraint to the ProductName column in the Products table. 
alter table products
add unique(ProductName)
--7. Write a comment in a SQL query explaining its purpose.
-- Comments are notes in SQL that a user can write to explain what a specific part of the code does, or to help readers understand it or for pretty much anything . The system will not recognize it as a code but will ignore it when executing.
--8. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
create table Categories(
	CategoryID int primary key,
	CategoryName varchar(50) unique
);
--9. Explain the purpose of the IDENTITY column in SQL Server. 
--In SQL Server IDENTITY() constraint automatically fills a column with number that increments by a constant, so we don't have to insert values inot that column manually. We only use it when a the next numbers increase or decrese by one number for each row
--10. Use BULK INSERT to import data from a text file into the Products table.
bulk insert Poducts
from 'C:\Users\User\Documents\Products.txt'
with (firstrow = 2,
fieldterminator = '\t',
rowterminator = '\n')
--11. Create a FOREIGN KEY in the Products table that references the Categories table.
alter table Products
add foreign key (CategoryID) references Categories(CategoryID)
--12. Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.
-- Primary key is a unique identifier of a row, i.e each row has its unique primary key value that belongs to that row only and does not repeat in the entire table. On the other hand, column with a unique constraint can contain only values that do not duplicate or repeat in the column
--The main difference between these two is that while Unique key can contain NULL value (butonly one for the colum), Primary key cannot s we cannot identify a row with NULL value
--13. Add a CHECK constraint to the Products table ensuring Price > 0.
alter table Products
add check(Price > 0)


--14. Modify the Products table to add a column Stock (INT, NOT NULL).
alter table Products
add Stock int not null


--15. Use the ISNULL function to replace NULL values in a column with a default value. 
alter table
--16. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
--The purpose of the FOREIGN KEY constraint is to connect two or more tables with eachother. Instead of storing all the data in one table, its more convenient and memory-saving to split it into several tables connected with PRIMARY and FOREIGN KEYS. FOREIGN KEY is inseparable with the PRIMARY KEY as we need to connect the former to the latter. Without the PRIMARY KEY, FOREIGN KEY makes no sense.

--17. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
	Age int,
    Location VARCHAR(100),
    LoyaltyStatus VARCHAR(50),
	check (Age >= 18)
);
--18. Create a table with an IDENTITY column starting at 100 and incrementing by 10.
create table Users(
	ID int identity(100, 10) primary key,
	Name varchar(50),
	Age int,
	Gender varchar(50)
)
--19. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
create table OrderDetails(
	OrderID int,
	ProductName varchar(50),
	Qty int,
	SaleAmount float,
	Primary key(OrderID, ProductName)
);
--20. Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
--isnull() function return specified value if the expression is null. Ex. SELECT ISNULL(NULL, 'Example'); in this case the function returns the second arguments as the expression in the first is null.
--coalesce() function returns the first non-null values from the list of expressions. Ex. SELECT COALESCE(NULL, NULL, NULL, 'Text', NULL, 'Not Null'). As we can see there are two non-null values, but it will retrieve only thefirst one i.e 'Text'
--21. Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    HireDate DATE,
	Email varchar(50) unique
	)
--22. Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
create table students(
	StudentID int primary key,
	Name varchar(50)
);
create table StudentDetails(
	StudentID int primary key,
	Age int,
	Email varchar(50),
	Gender varchar(20),
	Country varchar(50),
	City varchar(50))
	foreign key (StudentID) references Students(StudentID)
	on delete cascade 
	on update cascade
);
