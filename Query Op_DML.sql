SELECT PRODUCTID, NAME, COLOR, LISTPRICE
INTO PRODUCTOS
FROM Production.Product

UPDATE PRODUCTOS
SET LISTPRICE = LISTPRICE*1.2

UPDATE P
SET LISTPRICE = LISTPRICE*1.2
FROM PRODUCTOS P
INNER JOIN Purchasing.ProductVendor PV
ON P.ProductID = PV.ProductID
WHERE PV.BusinessEntityID = 1540;

DELETE FROM PRODUCTOS WHERE ListPrice = 0;

INSERT INTO PRODUCTOS (COLOR, NAME, LISTPRICE)
VALUES ('Red', 'Mountain Bike', 4000);

UPDATE PRODUCTOS
SET LISTPRICE = LISTPRICE*1.15 WHERE NAME like '%pedal%';

DELETE FROM PRODUCTOS WHERE NAME LIKE 'm%';

TRUNCATE TABLE PRODUCTOS;

DROP TABLE PRODUCTOS;

