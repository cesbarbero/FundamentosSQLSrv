S----------------------------------------------------------------
-- CRITERIOS DE SELECCION
----------------------------------------------------------------


----------------------------------------------------------------
-- LABORATROIO LIKE
----------------------------------------------------------------

--1) Mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas cuyo precio sea  mayor a 100 pesos.
--tablas: Production.Product
--campos: Name, ListPrice, Color
SELECT  Name, ListPrice, Color
FROM Production.Product
WHERE Name LIKE '%Seat%' AND ListPrice>100;

--2) Mostrar los nombre de los productos que tengan cualquier combinación de 'mountain bike'.
--tablas: Production.Product
--campos: Name
SELECT  Name
FROM Production.Product
WHERE Name LIKE '%mountain bike%'; 

--3) Mostrar las personas que su nombre empiece con la letra 'y'. 
--tablas:Person.Person
--campos: FirstName
SELECT  FirstName
FROM Person.Person
WHERE FirstName LIKE 'y%'; 

--4) Mostrar las personas que la segunda letra de su apellido es una s. 
--tablas:Person.Person
--campos: LastName
SELECT  FirstName
FROM Person.Person
WHERE FirstName LIKE '_[s]%'; 

--5) Mostrar el nombre concatenado con el apellido de las personas cuyo apellido tengan terminación española (ez).
--tablas: Person.Person
--campos: FirstName,LastName
SELECT  FirstName, LastName
FROM Person.Person
WHERE LastName LIKE '%ez';

--6) Mostrar los nombres de los productos que terminen en un número. 
--tablas: Production.Product
--campos: Name
SELECT Name
FROM Production.Product
WHERE Name LIKE '%[0-9]'; 

--7) Mostrar las personas cuyo  nombre tenga una C o c como primer carácter, cualquier otro como segundo carácter, 
--ni d ni e ni f ni g como tercer carácter, cualquiera entre j y r o entre s y w como cuarto carácter y el resto sin restricciones. 
--tablas:Person.Person
--campos: FirstName
SELECT  FirstName
FROM Person.Person
WHERE FirstName LIKE '[C-c]_[^d-g][j-w]%'; 

---------------------------------------------------------------
-- LABORATROIO BETWEEN
---------------------------------------------------------------

--1) Mostrar todos los productos cuyo precio de lista esté entre 200 y 300. 
--tablas:Production.Product	
--campos: ListPrice
SELECT ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 200 AND 300;
 
--2) Mostrar todos los empleados que nacieron entre 1970 y 1985. 
--tablas: HumanResources.Employee
--campos: BirthDate
SELECT BirthDate
FROM HumanResources.Employee
WHERE YEAR(BirthDate) BETWEEN 1970 AND 1985;

--3) Mostrar el la fecha,numero de version y subtotal de las ventas efectuadas en los años 2005 y 2006. 
--tablas: Sales.SalesOrderHeader
--campos: OrderDate, AccountNumber, SubTotal
SELECT OrderDate, AccountNumber, SubTotal
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) BETWEEN 2005 AND 2006;

--4) Mostrar todos los productos cuyo precio de lista  no esté entre 50 y 70.
--tablas:Production.Product	
--campos: ListPrice
SELECT ListPrice
FROM Production.Product
WHERE ListPrice NOT BETWEEN 50 AND 70;

---------------------------------------------------------------
-- LABORATROIO IN
---------------------------------------------------------------

--1) Mostrar los códigos de venta y producto, cantidad de venta y precio unitario de los artículos 750, 753 y 770. 
--tablas: Sales.SalesOrderDetail
--campos: SalesOrderID, ProductID, OrderQty, UnitPrice
SELECT  SalesOrderID, ProductID, OrderQty, UnitPrice
FROM Sales.SalesOrderDetail
WHERE ProductID IN (750, 753, 770);

--2) Mostrar todos los productos cuyo color no sea verde, blanco y azul. 
--tablas: Production.Product
--campos: Color
SELECT Color
FROM Production.Product
WHERE Color NOT IN ('Green', 'White', 'Blue');