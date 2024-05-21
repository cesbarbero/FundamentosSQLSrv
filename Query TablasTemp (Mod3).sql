SELECT NAME, LISTPRICE, COLOR
INTO #PRODUCTOS
FROM Production.PRODUCT
SELECT * FROM #PRODUCTOS;

SELECT BusinessEntityID, FirstName, LastNameINTO #PERSONASFROM PERSON.PersonWHERE 1=2SELECT * FROM #PERSONAS;EXEC TEMPDB..SP_HELP #PERSONAS;IF OBJECT_ID (N'tempdb..#Productos', N'U') IS NOT NULL
		DROP TABLE #Productos;
GOIF OBJECT_ID (N'tempdb..#Personas', N'U') IS NOT NULL
		DROP TABLE #Personas;
GO;WITH CTE_ORDVTA (SalesPersonID, SalesOrderID,
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
