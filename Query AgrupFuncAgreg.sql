SELECT MAX(ORDERDATE) FECHARECIENTE FROM SALES.SalesOrderHeader

SELECT MIN(LISTPRICE) PRECIO FROM Production.Product WHERE NAME LIKE '%BIKE%'

SELECT MAX(BIRTHDATE) FECHANACIMIENTO FROM HumanResources.Employee

SELECT AVG(LISTPRICE) PROMEDIO FROM Production.Product

SELECT COUNT(LINETOTAL) CANTIDADVENTAS, SUM(LINETOTAL) TOTALVENDIDO FROM SALES.SalesOrderDetail