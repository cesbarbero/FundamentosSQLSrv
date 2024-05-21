SELECT P.FIRSTNAME, P.LASTNAME, E.JobTitle
FROM PERSON.PERSON P
INNER JOIN HumanResources.Employee E
ON P.BusinessEntityID = E.BusinessEntityID
WHERE E.JobTitle = 'Sales Representative'
ORDER BY P.LASTNAME

SELECT c.ContactTypeID, c.Name AS ContactTypeName, COUNT(*) AS N_contacts
 FROM Person.BusinessEntityContact AS bec
 JOIN Person.ContactType AS c ON c.ContactTypeID = bec.ContactTypeID
 GROUP BY c.ContactTypeID, c.Name
 ORDER BY COUNT(*) DESC

 SELECT c.ContactTypeID, c.Name AS ContactTypeName, COUNT(*) AS N_contacts
 FROM Person.BusinessEntityContact AS bec
 JOIN Person.ContactType AS c ON c.ContactTypeID = bec.ContactTypeID
 GROUP BY c.ContactTypeID, c.Name
 HAVING COUNT(*) > 100
 ORDER BY COUNT(*) DESC

 SELECT P.NAME, PD.Comments
 FROM Production.Product P
 LEFT JOIN Production.ProductReview PD
 ON P.ProductID = PD.ProductID

SELECT DISTINCT p.Name Producto, p.ListPrice Precio, sd.UnitPrice 'Precio Vta'
FROM Sales.SalesOrderDetail AS sd
JOIN Production.Product AS p ON sd.ProductID = p.ProductID
AND sd.UnitPrice < p.ListPrice
WHERE p.ProductID = 718;
