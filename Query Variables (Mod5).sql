DECLARE @Totalventas MONEY;
SET @Totalventas = (SELECT SUM(LINETOTAL) FROM SALES.SalesOrderDetail);
SELECT @Totalventas;

DECLARE @Promedio MONEY;
SET @Promedio = (SELECT AVG(LISTPRICE) FROM Production.Product);
SELECT LISTPRICE, PRODUCTID FROM Production.Product WHERE ListPrice < @Promedio;

UPDATE Production.Product
SET LISTPRICE = LISTPRICE*1.1
WHERE ListPrice<@Promedio

DECLARE @VariableTabla TABLE (CATEGORIA VARCHAR(50), SUBCATEGORIA VARCHAR(50));
INSERT INTO @VariableTabla
SELECT PC.NAME, PS.NAME FROM Production.ProductCategory PC
	INNER JOIN Production.ProductSubcategory PS ON 
	PC.ProductCategoryID = PS.ProductCategoryID;
SELECT * FROM @VariableTabla;

DECLARE @Promedio MONEY;
SET @Promedio = (SELECT AVG(LISTPRICE) FROM Production.Product);
IF @Promedio < 500
	PRINT 'PROMEDIO BAJO'
ELSE
	PRINT 'PROMEDIO ALTO';



