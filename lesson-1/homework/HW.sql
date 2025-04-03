
--1. Define the following terms: data, database, relational database, and table.
--DATA is any piece of information about someone or something that can be used to learn about something or make decisions
--DATABASE is used to store data. Usually in a computer 
--RELATIONAL DATABASE is a type of data base where data stored in table forma and is related ot each other via so-called keys
--table is whare data in relational database stored and consists of columns and rows and body(the intersectioins of those columns and rows)

--2. List five key features of SQL Server.
--advanced data security features,integration with other Microsoft technologies, stored procedures, Always Encrypted, Row-Level Security

--3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--Windows Authentication mode and mixed mode

--4. Create a new database in SSMS named SchoolDB.
create database schooDB;
--5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
create table Students(
	StudentID INT PRIMARY KEY, 
	Name VARCHAR(50), 
	Age INT
);
--6. Describe the differences between SQL Server, SSMS, and SQL.
--SQL(Structured Query Language) is a programming language that enables the users to interact with Databases and manipulation data
--SQL Server is a RDBMS(Relational Database Mangement System) created by MIcrosoft for storing and retrieving data and managing databases
--SSMS(SQL Server Management Studio) is a software application developed by Microsoft that provides tools to configure, monitor, and administer instances of SQL Server and databases


--7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--DDL(Data Definition Language) is a collection of commmands that deal with the structure(or definition) of the sql objects. examples include CREATE, ALTER, DROP 
--DML(Data Manipulation language) are commands that enable us to do manipulations with data iself. These include update, delete AND INSERT
--DQL(Data Query Language) is used to retrieve sql data from a database using the SELECT command
--DCL(Data Control Language) are commands used to give permission to users to a database. these are GRANT and REVOKE
--TCL(Transact Control Language) is a set of commands used to manage and control transactions within a database, ensuring data consistency and integrity by allowing you to commit, rollback, or save changes made during a transaction. 
--8. Write a query to insert three records into the Students table.
insert into Students values
(1, 'Steven', 19),
(2, 'Bob', 22),
(3, 'Monica', 21);
--9. Create a backup of your SchoolDB database and restore it. (write its steps to submit)
/*open the ssms and right click on the database to be backed up from the object explorer and select 'Tasks', then 'Backup', choose the destination and and click 'OK'.
To restroe that database, open SSMS, navigate to the database in Object Explorer, right-click on 'databases' folder and select "Restore Database", then choose the backup file*/
