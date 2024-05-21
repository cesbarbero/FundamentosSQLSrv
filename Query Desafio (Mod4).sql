SELECT * FROM PRODUCTION.Product
WHERE LISTPRICE = (
		SELECT LISTPRICE FROM Production.Product
		WHERE NAME LIKE 'Mountain-500 Black, 52')

SELECT * FROM Production.Product PP
WHERE NOT EXISTS (
		SELECT * FROM Production.ProductSubcategory PS
		WHERE PP.ProductSubcategoryID = PS.ProductSubcategoryID
		AND NAME LIKE 'Wheels')

SELECT OH.SalesOrderID, OH.OrderDate, (SELECT MAX(OD.UnitPrice)
		FROM Sales.SalesOrderDetail OD
		WHERE OH.SalesOrderID = OD.SalesOrderID) MaxUnitPrice
FROM Sales.SalesOrderHeader OH

SELECT LastName, FirstName FROM PERSON.Person PP --Version mia
INNER JOIN SALES.SalesPerson SP ON PP.BusinessEntityID = SP.BusinessEntityID

SELECT LastName, FirstName -- Version de Alumni
 FROM Person.Person
 WHERE BusinessEntityID IN
(SELECT BusinessEntityID FROM HumanResources.Employee
 WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM Sales.SalesPerson))
SELECT DISTINCT P.LastName, P.FirstName, E.BusinessEntityID
 FROM Person.Person P
 JOIN HumanResources.Employee E ON E.BusinessEntityID = P.BusinessEntityID
 WHERE 5000.00 IN (SELECT Bonus FROM Sales.SalesPerson SP
		WHERE E.BusinessEntityID = SP.BusinessEntityID)