SELECT Name FROM Production.Product
WHERE PRODUCTSUBCATEGORYID = ANY (
	SELECT PRODUCTsUBCATEGORYid FROM Production.ProductSubcategory
	WHERE Name LIKE '%Wheel%');

SELECT * FROM SALES.Customer
WHERE TerritoryID <> ALL (SELECT TerritoryID FROM SALES.SalesPerson);

SELECT NAME FROM Production.Product
WHERE LISTPRICE >= ANY (
		SELECT MAX(LISTPRICE) FROM Production.Product
		GROUP BY ProductSubcategoryID);

