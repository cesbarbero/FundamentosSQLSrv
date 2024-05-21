SELECT ContactTypeID, Name
 FROM Person.ContactType
 WHERE Name LIKE '%Manager%'
 ORDER BY Name DESC

SELECT BusinessEntityID, Gender, MaritalStatus, JobTitle
 FROM [HumanResources].[Employee]
 WHERE JobTitle IN ('Marketing Manager', 'Senior Tool Designer')

SELECT Name, Size, Color
 FROM Production.Product
 WHERE Size IS NOT NULL AND Color IS NOT NULL;

SELECT SalesOrderID AS #FACTURA, OrderDate AS FECHA, TotalDue AS TOTAL
 FROM SALES.SalesOrderHeader
 WHERE ORDERDATE BETWEEN '2011-06-01' AND '2011-07-31'

SELECT SalesOrderID AS #FACTURA, OrderDate AS FECHA, TotalDue AS TOTAL, TotalDue*.21 AS IVA
 FROM SALES.SalesOrderHeader
 WHERE ORDERDATE BETWEEN '2011-06-01' AND '2011-07-31'