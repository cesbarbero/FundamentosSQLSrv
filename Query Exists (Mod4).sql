SELECT ProductSubcategoryID, Name
FROM Production.Product
WHERE EXISTS (	SELECT * 
				FROM Production.ProductSubcategory
				WHERE ProductSubcategoryID = Production.Product.ProductSubcategoryID AND Name like '%Wheels%'
			 );

SELECT p.ProductID, p.Name producto
FROM Production.Product p
WHERE NOT EXISTS( SELECT 1 FROM Sales.SalesOrderDetail sod WHERE p.ProductID = sod.ProductID );

SELECT COUNT(*) FROM PERSON.Person PP
	WHERE NOT EXISTS (
		SELECT 1 FROM SALES.SalesPerson SS
		WHERE PP.BusinessEntityID = SS.BusinessEntityID)

SELECT FIRSTNAME, LASTNAME FROM PERSON.Person PP
	WHERE EXISTS (
		SELECT 1 FROM SALES.SalesPerson SS
		WHERE PP.BusinessEntityID = SS.BusinessEntityID
		AND SS.TerritoryID IS NULL)

