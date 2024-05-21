CREATE PROCEDURE dbo.HR @INICIAL VARCHAR(1)
AS
	SELECT BusinessEntityID, FirstName, LastName, EmailAddress
	FROM HumanResources.vEmployee WHERE LEFT(FIRSTNAME,1) = @INICIAL
EXEC DBO.HR 'B'
GO


CREATE PROCEDURE dbo.ProductoVendido @Producto INT
AS
	IF EXISTS ( SELECT 1 FROM Sales.SalesOrderDetail WHERE ProductID = @Producto)
		PRINT 'El PRODUCTO HA SIDO VENDIDO'
	ELSE 
		PRINT 'El PRODUCTO NO HA SIDO VENDIDO'

EXECUTE dbo.ProductoVendido 707;
GO


CREATE PROCEDURE dbo.ActualizaPrecio @Producto INT, @Precio MONEY
AS
	UPDATE Production.Product
	SET ListPrice = @Precio
	WHERE PRODUCTID = @Producto

	SELECT ProductID, Name, ListPrice
	FROM Production.Product
	WHERE ProductID=@Producto;

EXECUTE dbo.ActualizaPrecio 707, 500;
GO


