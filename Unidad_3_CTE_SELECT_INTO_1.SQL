USE DB_Educacion_IT
GO
--1) EJEMPLO CTE con SELECT INTO

--OBTENER EL PROMEDIO DE EDAD MASCULINO Y FEMENINO E INSERTARLO EN UNA TABLA TEMPORAL
IF OBJECT_ID(N'tempdb..#TMP_EDADES_PROMEDIO') IS NOT NULL
BEGIN		
	DROP TABLE #TMP_EDADES_PROMEDIO
END

;WITH CTE_PROM_EDAD (sexo, edad_promedio)
AS
(
	SELECT 
	sexo,
	EDAD = AVG(edad)
	FROM dbo.Visitantes
	GROUP BY sexo
)
SELECT * 
INTO #TMP_EDADES_PROMEDIO
FROM CTE_PROM_EDAD

SELECT * FROM #TMP_EDADES_PROMEDIO

GO
USE DB_Educacion_IT
GO
--2) EJEMPLO SELECT INTO

--SI EXISTE LA TABLA TMP_Visitantes, LA ELIMINO
IF EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'TMP_Visitantes'
)
BEGIN
	DROP TABLE dbo.TMP_Visitantes
END

SELECT 
*
INTO TMP_Visitantes
FROM dbo.Visitantes
where id_visitante > 6 

sp_help 'dbo.Visitantes'
go
--OBSERVAR QUE NO SE CREO EL INDICE PK DE LA COLUMNA id_visitante
sp_help 'dbo.TMP_Visitantes'