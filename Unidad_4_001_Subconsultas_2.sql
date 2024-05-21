USE AdventureWorks2019
go
--1) SUBCONSULTA EN SELECT

--SE LISTA EL PRECIO DE CADA UNO DE LOS PRODUCTOS Y EL PRECIO PROMEDIO GLOBAL
SELECT 
Id_Prod = ProductID, 
Precio_Prod = ListPrice,
Precio_Prom_Global = (SELECT AVG(ListPrice) FROM Production.Product)
FROM Production.Product;

--2) SUBCONSULTA EN FROM
--SE LISTA EL PRECIO DE CADA UNO DE LOS PRODUCTOS Y EL PRECIO PROMEDIO DE VENTA PARA CADA UNO DE LOS MISMOS
SELECT 
ProductID = pp.ProductID, 
ListPrice = pp.ListPrice, 
PROMEDIO_VENTA = x.promedio
FROM Production.Product pp
INNER JOIN 
(
	SELECT 
	ProductID, 
	promedio = AVG(LineTotal) 
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID
) x
ON pp.ProductID=x.ProductID;

--3) SUBCONSULTA EN WHERE

--SE LISTAN LOS PRECIOS QUE SON INFERIORES AL PRECIO PROMEDIO DE VENTA DE TODOS LOS PRODUCTOS
SELECT 
ProductID, 
ListPrice
FROM Production.Product
WHERE ListPrice < ( SELECT AVG(LineTotal) FROM Sales.SalesOrderDetail);

--4) SUBCONSULTA CORRELACIONADAS
--(son aquellas que se evalúan por cada registro de la tabla)
--MUESTRA EL PRODUCTO MAS BARATO DE CADA SUBCATEGORIA
SELECT 
p1.ProductSubcategoryID, 
p1.ProductID,
p1.ListPrice
FROM Production.Product p1
WHERE ListPrice =	(
						SELECT ListPrice = MIN(ListPrice)
						FROM Production.Product p2
						WHERE p2.ProductSubcategoryID = p1.ProductSubcategoryID
					 )
ORDER BY p1.ProductSubcategoryID;