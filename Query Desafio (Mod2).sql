SELECT DISTINCT JOBTITLE FROM HumanResources.Employee ORDER BY JobTitle

SELECT CURRENCYCODE FROM [Sales].[Currency]
UNION
SELECT CURRENCYCODE FROM [Sales].[CountryRegionCurrency]

SELECT NAME, SUM(SALESYTD) TOTALSALESYTD
	FROM SALES.SalesTerritory
	WHERE CountryRegionCode = 'US'
	GROUP BY Name

SELECT ProductID
 FROM Production.Product
EXCEPT
SELECT ProductID
 FROM Production.WorkOrderSELECT NAME, SUM(SALESYTD) TOTALSALESYTD
	FROM SALES.SalesTerritory
	WHERE CountryRegionCode = 'US'
	GROUP BY Name WITH ROLLUP