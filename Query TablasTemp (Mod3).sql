SELECT NAME, LISTPRICE, COLOR
INTO #PRODUCTOS
FROM Production.PRODUCT
SELECT * FROM #PRODUCTOS;

SELECT BusinessEntityID, FirstName, LastName
		DROP TABLE #Productos;
GO
		DROP TABLE #Personas;
GO
OrderDate)
AS
(
	SELECT SalesPersonID, SalesOrderID, OrderDate
	FROM SALES.SalesOrderHeader
)
SELECT * FROM CTE_ORDVTA

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)  
AS    
(  
    SELECT  SalesPersonID, SalesOrderID, YEAR(OrderDate) AS Anio  
	FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)  
SELECT SalesPersonID, SalesOrderID, SalesYear FROM [Sales_CTE] 