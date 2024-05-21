SELECT * FROM HumanResources.Employee H
INNER JOIN SALES.SalesPerson S
ON H.BusinessEntityID = S.BusinessEntityID

SELECT P.LASTNAME, P.FIRSTNAME FROM PERSON.Person P
INNER JOIN HumanResources.Employee H
ON H.BusinessEntityID = P.BusinessEntityID
ORDER BY P.LastName ASC, P.FirstName

SELECT H.LOGINID, TERRITORYID, BONUS FROM SALES.SALESPERSON S
INNER JOIN HUMANRESOURCES.EMPLOYEE H
ON H.BusinessEntityID = S.BusinessEntityID

SELECT S.Name FROM PRODUCTION.Product P
INNER JOIN PRODUCTION.ProductSubcategory S
ON S.ProductSubcategoryID = P.ProductSubcategoryID
WHERE S.Name ='Wheels'

SELECT S.Name FROM PRODUCTION.Product P
INNER JOIN PRODUCTION.ProductSubcategory S
ON S.ProductSubcategoryID = P.ProductSubcategoryID
WHERE S.Name NOT LIKE '%Bike%'

SELECT DISTINCT P.ProductID, P.NAME PRODUCTO, P.ListPrice PRECIO_LISTA, S.UnitPrice PRECIO_VTA_RECOMENDADO
FROM SALES.SalesOrderDetail S
INNER JOIN Production.Product P
ON S.ProductID = P.ProductID AND s.UnitPrice < p.ListPrice
ORDER BY P.Name

SELECT PRI.ProductID, PRI.Name, PRI.ListPrice, SEG.ProductID, SEG.Name, SEG.ListPrice
FROM PRODUCTION.Product PRI
INNER JOIN Production.Product SEG
ON PRI.ListPrice = SEG.ListPrice
WHERE PRI.ProductID > SEG.ProductID --Aquí comparamos con el inmediato posterior
ORDER BY PRI.ListPrice DESC

SELECT  pp.Name as Producto, pe.Name  Proveedor -- PARA VER DESC DE UNA TABLA: SOMBREAR TABLA Y ALT+F1
FROM Production.Product pp
INNER JOIN Purchasing.ProductVendor pv 
ON pp.ProductID = pv.ProductID
INNER JOIN Purchasing.Vendor pe		--INNER JOIN CON 3 TABLAS
ON pv.BusinessEntityID = pe.BusinessEntityID
WHERE pp.ProductSubcategoryID = 15;

SELECT P.FirstName NOMBRE, P.LastName APELLIDO, H.LoginID
FROM Person.Person P
LEFT JOIN HumanResources.Employee H
ON P.BusinessEntityID = H.BusinessEntityID

