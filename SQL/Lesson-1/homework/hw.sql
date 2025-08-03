Easy. 1. Define the following terms: data, database, relational database, and table.

annswers:

1. data - это информация которая нужна каждому физическому и юридическому лицу для всего, для анализа, для обработки, ее можно хранить, с помошью ее можно делать выводы, она может быть в виде таблицы и в других видах.        
2. database - это хранилище данных, где все данные хранятся. ее можно обновлять пополнять и можно коллекционировать данные.
3. relational database - это тип базы данных в которой данные хранятся в виде связанных таблиц.
4. table - это таблицы, я думаю это основной вид хранения данных, она состоит из строк и столбцов.

Easy. 2. List five key features of SQL Server.

answers:

2. 5 key features of SQL Server:

- Поддержка транзакций.
- Безопасность и управление доступом.
- Интеграция с другими Microsoft продуктами.
- Надежное резервное копирование и восстановление.
- Производительная обработка больших объемов данных.

Easy. 3.What are the different authentication modes available when connecting to SQL Server? (Give at least 2)

answers:

1. Windows Authentication: Вход через учётную запись Windows.
2. SQL Server Authentication: Вход с логином и паролем, созданными в SQL Server.



Medium
Medium. 4. Create a new database in SSMS named SchoolDB.

answers:

create database SchoolIDB;
use SchoolIDB; maybe it is not needed it is for using this database

Medium. 5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).

answers:

create table Students (StudentID int PRIMARY KEY, Name varchar (50), Age int);


Medium. 6. Describe the differences between SQL Server, SSMS, and SQL.

answers:

SQL Server: Программное обеспечение для управления базами данных.

SSMS: Графическая среда для работы с SQL Server (редактирование, запросы, администрирование).

SQL (Structured Query Language): Язык программирования для управления и работы с базами данных.


Hard
Hard. 7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

answers:

DQL	- Data Query Language -	SELECT - Запрос данных из таблиц
DML	- Data Manipulation Language - INSERT, UPDATE, DELETE - Работа с содержимым таблиц
DDL	- Data Definition Language -	CREATE, ALTER, DROP	- Создание/изменение структуры БД
DCL	- Data Control Language	- GRANT, REVOKE -	Управление доступом
TCL	- Transaction Control Language	- BEGIN, COMMIT, ROLLBACK	- Управление транзакциями

Hard. 8. Write a query to insert three records into the Students table.

answers:

insert into table Students values (1, 'Sam', 12), (2, 'John', 14), (3, 'Robert', 10);


Hard. 9. Restore AdventureWorksDW2022.bak file to your server. 
(write its steps to submit) You can find the database from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak

answers:

Steps to restore AdventureWorksDW2022.bak:

1. I downloaded the .bak file from the official GitHub link.
2. I moved the file to my SQL Server backup folder.
3. I opened SQL Server Management Studio (SSMS) and connected to my server.
4. I right-clicked on "Databases" → Restore Database.
5. I selected "Device" and added the .bak file.
6. I chose the database name as AdventureWorksDW2022.
7. I verified the file paths and options.
8. I clicked OK to complete the restore process.

