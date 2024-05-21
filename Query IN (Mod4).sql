SELECT * FROM SALES.SalesOrderHeader SO
WHERE SO.TerritoryID IN (
	SELECT ST.TerritoryID FROM SALES.SalesTerritory ST
	WHERE ST.CountryRegionCode = 'US')

SELECT * FROM SALES.SalesOrderHeader SO
WHERE SO.TerritoryID IN (
	SELECT ST.TerritoryID FROM SALES.SalesTerritory ST
	WHERE ST.CountryRegionCode IN ('US', 'FR', 'GB'))

SELECT * FROM Production.Product
	WHERE LISTPRICE IN (
			SELECT TOP 10 ListPrice FROM PRODUCTION.PRODUCT
			ORDER BY LISTPRICE DESC)

SELECT * FROM Production.Product
WHERE ProductID IN (
	SELECT ProductID FROM SALES.SalesOrderDetail
	WHERE OrderQty >= 20)
order by Name                                 