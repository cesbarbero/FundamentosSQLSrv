/*
--***********************************************************
--                  TIPOS DE JOINS
--***********************************************************
*/
--0) CREO ESTRUCTURA PARA TRABAJAR CON LOS JOINS
USE DB_Educacion_IT
go 
IF EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'Person'
)
BEGIN
    drop TABLE Person	 
END

IF EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'Company'
)
BEGIN
    drop TABLE Company
END



IF NOT EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'Company'
)
BEGIN
    CREATE TABLE Company (
        companyId INT NOT NULL IDENTITY(1,1),   
    	companyName VARCHAR(100), 
    	zipcode VARCHAR(10),
        CONSTRAINT PK_Company PRIMARY KEY (companyId)
    )
END

GO

IF NOT EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'Person'
)
BEGIN
    CREATE TABLE Person (
        personId INT NOT NULL IDENTITY(1,1),   
    	personName VARCHAR(100),
        companyId INT NULL,
    	salary DECIMAL(8,2),
        CONSTRAINT PK_Person PRIMARY KEY (personId)
    )
END
GO
--CARGAR DATOS
IF NOT EXISTS
(
    SELECT TOP 1 1 FROM Company
)
BEGIN
    insert Company
    select 'ABC Company', '19808' union
    select 'XYZ Company', '08534' union
    select '123 Company', '10016' union
    select '456 Company', '20017'
END

IF NOT EXISTS
(
    SELECT TOP 1 1 FROM Person
)
BEGIN
    insert Person
    select 'Alan', 1, 150320.25 union
    select 'Bobby', 1, 180320.45 union
    select 'Chris', 1, 250002.10 union
    select 'Xavier', 2, 330522.00 union
    select 'Yoshi', 2, 210522.00 union
    select 'Zambrano', 2, 130522.00 union
    select 'Player 1', 3, 420522.00 union
    select 'Player 2', 3, 95522.00 union
    select 'Player 3', 3, 130222.00 union
    select 'Juan', null, 236000.00 union
    select 'Pablo', null, 116000.00 
END

select * from Company
select * from Person

--1)*************** RELACIÓN: INNER JOIN**************************
--TRAEMOS LOS REGISTROS QUE TIENEN EN COMÚN LA TABLA Person y Company
select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
INNER JOIN  Person P ON P.companyId = C.companyId

--2)*************** RELACIÓN: LEFT JOIN**************************
--A) Solo mostramos los registros de la tabla Company, tengan o no relación con la tabla B (Observar que la empresa con id = 4 no tiene persona asociada)
select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
LEFT JOIN  Person P ON P.companyId = C.companyId

--B) Solo mostramos los registros de la tabla Company, excluyendo los registros que tienen relación con la tabla Person (Observar que solo retorna la empresa con id = 4)
select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
LEFT JOIN  Person P ON P.companyId = C.companyId
WHERE P.companyId IS NULL

--3)*************** RELACIÓN: RIGHT JOIN**************************
--A) Solo mostramos los registros de la tabla Person (porque esta a la derecha), tengan o no relación con la tabla Company (Observar que las personas con id 4 y 5 no tienen empresa asociada)
select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
RIGHT JOIN  Person P ON P.companyId = C.companyId

--B) Solo mostramos los registros de la tabla Person, excluyendo los registros que tienen relación con la tabla Company (Observar que solo retorna las personas con id 4 y 5)

select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
RIGHT JOIN  Person P ON P.companyId = C.companyId
WHERE C.companyId IS NULL

--4)*************** RELACIÓN: FULL JOIN**************************
--A) Trae todos los registros de ambas tablas, incluyendo los que tiene en común
select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
FULL OUTER JOIN  Person P ON P.companyId = C.companyId

--B) Trae todos los registros de ambas tablas, excluyendo los que tiene en común
select 
IdEmpresa = C.companyId, 
NombreEmpresa = C.companyName, 
IdPersona = P.personId, 
NombrePresona = P.personName
from Company C
FULL OUTER JOIN  Person P ON P.companyId = C.companyId
WHERE C.companyId is null OR P.companyId is null