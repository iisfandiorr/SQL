1. BULK INSERT is a SQL command used to import large amounts of data from an external data file into a SQL Server database table or view. 
It's the go-to tool for high-performance, bulk data loading.
The primary purpose of BULK INSERT is to load large volumes of data quickly and efficiently. 
It bypasses the row-by-row processing and extensive logging that happens with standard INSERT statements, leading to significant performance gains. 
BULK INSERT is ideal for scenarios involving large-scale data imports, such as:
Initial Data Population: Loading initial data into a new application or data warehouse.
ETL Processes: As a high-speed "Load" step in an ETL pipeline, where data from external systems is regularly imported. For example, loading daily sales figures 
from a flat file into a reporting database.
Data Migration: Moving large tables from another database system or from an older version of SQL Server.
example:
bulk insert Emails2 from 'C:\SQL LESSONS\Emails.csv' 
	with (firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n',
	tablock
	);

2. You can import various file formats into SQL Server, each suited for different types of data and sources. Here are four common formats:
1. CSV (Comma-Separated Values)

This is one of the most common and straightforward formats. Each line in a CSV file represents a row of data, and the values in each row are separated by a comma or another specified delimiter. 
It's a simple text file, making it highly compatible with numerous applications, including spreadsheet programs like Excel.

2. JSON (JavaScript Object Notation)

JSON has become a popular format for data exchange, especially from web applications and APIs. It uses a human-readable text format to represent data as key-value pairs and arrays. 
SQL Server has built-in functions like OPENJSON to parse JSON text and transform it into a relational format.
Use Case: Perfect for importing semi-structured data from web services, NoSQL databases, or application configurations.

3. XML (eXtensible Markup Language)

XML is another widely used format for data interchange. It uses tags to define the structure and elements of the data. SQL Server provides robust support for XML,
including a native XML data type and functions for querying and shredding XML documents directly into tables.
Use Case: Commonly used for configuration files, data exchange between different platforms, and importing data with a complex hierarchical structure.

4. Fixed-Width Text File

In a fixed-width text file, each field is allocated a specific number of characters, regardless of the actual data's length. There are no delimiters between fields. 
A separate format file is often required during import to tell SQL Server where each column begins and ends.
Use Case: Often used for importing data from older, legacy systems like mainframes, which frequently export data in this format.


3. create table Products (ProductID int Primary key, ProductName varchar (50), Price Decimal(10,2));

4. insert into Products values (1, 'Laptop', 200), (2, 'Phone', 200), (3, 'Airpods', 250)


5. NULL and NOT NULL are opposites that define whether a column in a database table can be left empty.

NULL
NULL represents the absence of a value. It means the data for a specific field in a row is unknown, missing, or not applicable. It's a placeholder for nothing. 
It is important to remember that NULL is not the same as zero (0) or an empty string (''). Zero is a specific number, and an empty string is a specific (empty) piece of text, 
whereas NULL is the complete lack of any value.

NOT NULL
NOT NULL is a constraint that forces a column to always have a value. When you define a column as NOT NULL, 
the database ensures that you cannot insert a new row or update an existing one without providing a value for that column.

6. ALTER TABLE Products
ADD CONSTRAINT UC_Products_ProductName UNIQUE (ProductName);

7. There are two common ways to add comments in SQL: using two hyphens (--) for single lines or using /* ... */ for single or multi-line blocks.

Single-Line Comments (--)
This is the most common method. The comment begins with two hyphens (--) and continues to the end of the line. It's perfect for brief notes or explaining a specific line of code.

Example:

SQL

-- Selects the employee ID and full name from the Employees table
SELECT
    EmployeeID,
    FirstName,
    LastName
FROM
    Employees
WHERE
    Department = 'Sales'; -- Filters the results to include only the Sales department
Multi-Line Comments (/* ... */)
This type of comment starts with /* and ends with */. Anything between these markers is ignored by the SQL engine. This is useful for longer explanations, documenting the query's purpose, or temporarily disabling a block of code for debugging.

Example:

SQL

/*
  Query Purpose: Retrieve all products that are low on stock for reordering.
  Author: Alex Smith
  Date: 2025-08-07
  This query identifies products with fewer than 10 units remaining.
*/
SELECT
    ProductName,
    UnitsInStock
FROM
    Products
WHERE
    UnitsInStock < 10;

8. ALTER TABLE Products
ADD CategoryID INT;

9. CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

10. The IDENTITY property in SQL Server is used to automatically generate a sequence of unique numbers for a column. Its main purpose is to create a surrogate primary key.

When you specify a column as IDENTITY, SQL Server takes control of its values. Every time a new row is inserted into the table, 
the database automatically generates the next number in the sequence and assigns it to that column. This frees you from having to manually generate and manage unique IDs for your records.
How It Works
The IDENTITY property is defined with a seed and an increment value.

IDENTITY(seed, increment)

Seed: This is the starting value for the first row inserted into the table.

Increment: This is the value that is added to the last identity value to generate the next one.

By far the most common configuration is IDENTITY(1,1), which starts at 1 and increments by 1 for each new row.

Example:

Here's how you would create an Employees table where the EmployeeID is automatically generated.

SQL

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    HireDate DATETIME DEFAULT GETDATE()
);


11. BULK INSERT Products
FROM 'C:\Data\Products.txt'
WITH
(
    FIELDTERMINATOR = ',',          
    ROWTERMINATOR = '\n',           
    FIRSTROW = 2, 
);


12. ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

13. Differences Between PRIMARY KEY and UNIQUE KEY
Both PRIMARY KEY and UNIQUE KEY are constraints used in SQL to enforce data integrity, but they have some key differences:

Uniqueness:

PRIMARY KEY: Ensures that all values in the column (or set of columns) are unique and not null.

UNIQUE KEY: Ensures all values are unique, but allows null values (usually one null, depending on the database).

Null Values:

PRIMARY KEY: Cannot have any NULL values.

UNIQUE KEY: Can have NULL values (though multiple nulls are allowed in some databases, like PostgreSQL).

Number Per Table:

PRIMARY KEY: Only one PRIMARY KEY allowed per table.

UNIQUE KEY: You can have multiple UNIQUE KEYs in a table.

Purpose:

PRIMARY KEY: Primarily used to identify each row uniquely in a table. It’s the main identifier.

UNIQUE KEY: Used to enforce uniqueness for a column that isn’t the main identifier.

Index Creation:

Both PRIMARY KEY and UNIQUE KEY automatically create an index on the column(s), 
but the PRIMARY KEY creates a clustered index (in some databases like SQL Server), 
while UNIQUE KEY usually creates a non-clustered index.

Naming:

PRIMARY KEY has a default name or can be named.

UNIQUE KEY can have a custom name, and you can define multiple unique constraints with different names.

14. ALTER TABLE Products
ADD CONSTRAINT CK_Products_Price CHECK (Price > 0);

15. ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

16. SELECT
    ProductName,
    Price, -- This is the original column, which may contain NULLs
    ISNULL(Price, 0) AS DisplayPrice
FROM
    Products;

17. FOREIGN KEY Constraint in SQL Server
Purpose:
The FOREIGN KEY constraint in SQL Server is used to:

Maintain referential integrity between two tables.

Ensure that the value in a column (or a group of columns) in one table matches the value in a column in another table.

Prevent actions that would break the link between the related tables.

It basically creates a relationship between a "child" table (containing the foreign key) and a "parent" table (containing the primary or unique key).

Usage:
A FOREIGN KEY is defined in the child table.

It references a PRIMARY KEY or UNIQUE KEY in the parent table.

SQL Server prevents inserting or updating a value in the child table unless it exists in the parent table.

It can also restrict or cascade DELETE and UPDATE operations.

Syntax Example:
sql
Копировать
Редактировать
-- Parent table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

-- Child table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    DeptID INT,
    CONSTRAINT FK_Employees_Departments
        FOREIGN KEY (DeptID)
        REFERENCES Departments(DeptID)
);



18. CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    CONSTRAINT CHK_Customers_Age CHECK (Age >= 18)
);


19. CREATE TABLE Products (
    ProductID INT IDENTITY(100, 10) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    DateAdded DATETIME DEFAULT GETDATE()
);


20. CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);


21. Both COALESCE and ISNULL are used to replace NULL values with a specified default value. The main difference is that COALESCE is a standardized, 
more flexible function that can accept multiple arguments, while ISNULL is a simpler, SQL Server-specific function that only accepts two.

ISNULL Function
ISNULL is a function specific to T-SQL (Microsoft SQL Server). It checks the first value, and if it's NULL, it returns the second value.

COALESCE Function
COALESCE is part of the ANSI-SQL standard, meaning it works across most database systems (SQL Server, PostgreSQL, Oracle, etc.). 
It evaluates its arguments in order and returns the first non-NULL value it finds.

22. CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE
);

23. ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;







