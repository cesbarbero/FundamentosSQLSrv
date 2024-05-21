USE DB_Educacion_IT
go

--***********************************************************
--                  CROSS APPLY
--***********************************************************
SELECT 'RESULTADO USANDO CROSS APPLY'
/* using CROSS APPLY: TRAIGO TODAS LAS PERSONAS CON MEJOR SALARIO POR COMPANIA */

SELECT 
C.companyName, PS.personId, PS.personName, PS.salary
FROM Company C
CROSS APPLY 
(
    SELECT TOP 1 
	personId, personName, salary
    FROM Person p
    WHERE p.companyid = c.companyId
	ORDER BY salary desc
) PS

SELECT 'MISMO RESULTADO USANDO INNER JOIN'
/* using INNER JOIN: TRAIGO TODAS LAS PERSONS CON MEJOR SALARIO POR COMPANIA */

SELECT 
C.companyName, PS.personId, PS.personName, PS.salary
FROM Company C
INNER JOIN 
(
    SELECT 
	personId, 
	personName, 
	salary, 
	companyId,
	ord = ROW_NUMBER() OVER (PARTITION BY companyId ORDER BY salary DESC)
    FROM Person p    	
) PS ON PS.companyid = c.companyId
WHERE PS.ord = 1