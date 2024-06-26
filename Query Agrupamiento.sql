SELECT PRODUCTSUBCATEGORYID, LISTPRICE MINIMO, PRODUCTID
 FROM Production.Product PP
 WHERE LISTPRICE = (
  SELECT MIN(LISTPRICE) LISTPRICE FROM Production.Product PP1
   WHERE PP.ProductSubcategoryID = PP1.ProductSubcategoryID)
 ORDER BY ProductSubcategoryID;

SELECT PRODUCTID, SUM(ORDERQTY) CANTIDAD FROM SALES.SalesOrderDetail GROUP BY ProductID ORDER BY ProductID;

SELECT PRODUCTID, SUM(LineTotal) TOTAL FROM SALES.SalesOrderDetail GROUP BY ProductID ORDER BY SUM(LINETOTAL) DESC

SELECT SALESORDERID, AVG(LINETOTAL) PROMEDIO FROM SALES.SalesOrderDetail GROUP BY SalesOrderID


SELECT SALESORDERID, SUM(LINETOTAL) TOTAL
	FROM SALES.SalesOrderDetail GROUP BY SalesOrderID HAVING SUM(LineTotal) > 10000

SELECT SALESORDERID, SUM(ORDERQTY)
	FROM SALES.SalesOrderDetail GROUP BY SalesOrderID HAVING SUM(ORDERQTY) > 20

SELECT PRODUCTSUBCATEGORYID, COUNT(PRODUCTSUBCATEGORYID) CANTIDAD
	FROM Production.Product WHERE LISTPRICE > 150 GROUP BY ProductSubcategoryID HAVING COUNT(PRODUCTSUBCATEGORYID) > 1

SELECT PRODUCTSUBCATEGORYID, COUNT(PRODUCTSUBCATEGORYID) CANTIDAD, AVG(LISTPRICE) PROMEDIO
	FROM Production.Product WHERE LISTPRICE > 70 GROUP BY ProductSubcategoryID HAVING AVG(LISTPRICE) > 300


SELECT SalesOrderID, SUM(UNITPRICE*ORDERQTY) TOTAL FROM  SALES.SalesOrderDetail GROUP BY SalesOrderID WITH ROLLUP