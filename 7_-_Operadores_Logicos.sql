USE DB_Educacion_IT
go
--1) OBTENER LAS PERSONAS, CUYOS NOMBRES COMIENCEN CON LA LETRA "E" O TERMINEN CON LA LETRA "Z". Y QUE NO TENGAN TELEFONO
SELECT * 
FROM TMP_Persona 
WHERE (persona_nombre like 'E%' OR persona_nombre LIKE '%Z') AND persona_telefono IS NULL

--2) OBTENER LAS PERSONAS, CUYA EDAD ESTE EN EL RANGO DE 30 A 42. 
--O si su edad es mayor a 50, que el apellido empiece con la letra G
SELECT *
FROM TMP_Persona
WHERE (persona_edad between 30 AND 42) OR (persona_edad > 50 AND  persona_apellido LIKE 'G%')

--3) OBTENER LAS PERSONAS QUE TENGAN UN TELEFONO O UNA DIRECCION
SELECT *
FROM TMP_PERSONA
WHERE persona_telefono IS NOT NULL OR persona_direccion IS NOT NULL


--4) OBTENER LAS PERSONAS QUE TENGAN EL ID 1, 3 Y 5
select *
FROM TMP_PERSONA
WHERE persona_id IN(1,3,5)

--5) OBTENER LAS PERSONAS QUE NO TENGAN EL ID 1, 3 Y 5
select *
FROM TMP_PERSONA
WHERE persona_id NOT IN(1,3,5)
