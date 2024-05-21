USE AdventureWorks2019
go
--1) OPERADOR: ANY

--LISTA LOS PRODUCTOS Y PRECIOS QUE SUPERAN EL PRECIO PROMEDIO TOTAL
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > ANY	(
							 SELECT AVG(ListPrice) Promedio
							 FROM Production.Product
						 );

--2) OPERADOR ALL

--LISTA LOS PRODUCTOS CUYO PRECIO SEA DISTINTO AL PROMEDIO TOTAL
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice <> ALL	(
							SELECT AVG(ListPrice) Promedio
							FROM Production.Product
						 );

--3) OPERADOR EXISTS

--LISTA LAS PERSONA QUE NO SON VENDEDORES
SELECT FirstName, LastName
FROM Person.Person P
WHERE NOT EXISTS 
(
	SELECT BusinessEntityID
	FROM Sales.SalesPerson S
	WHERE P.BusinessEntityID= S.BusinessEntityID
 );


 --4) OPERADOR IN
 
 --LISTA LAS PERSONAS QUE SON VENDEDORES
 SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (
							 SELECT BusinessEntityID
							 FROM Sales.SalesPerson
						  );
