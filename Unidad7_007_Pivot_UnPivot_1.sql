USE DB_Educacion_IT
GO
IF OBJECT_ID('dbo.TMP_TABLA_PIVOTE') IS NOT NULL
    DROP TABLE dbo.TMP_TABLA_PIVOTE
GO

CREATE TABLE dbo.TMP_TABLA_PIVOTE
(
[year] INT NOT NULL,
[month] SMALLINT NOT NULL,
total DECIMAL(9,2)
)

TRUNCATE TABLE dbo.TMP_TABLA_PIVOTE

INSERT INTO dbo.TMP_TABLA_PIVOTE ([year], [month],[total])
VALUES (2021,1, 822.12),(2022,5, 2151.23),(2022,8, 4582.15),(2022,11, 32512.27),
(2022,1, 52.12),(2022,2, 58415.33),(2022,3, 32.56),(2022,4, 1523.26),(2022,5, 15658),(2022,6, 251.28),(2022,7, 6554.16),(2022,8, 654.75),(2022,9, 991.33),(2022,10, 45.25),(2022,11, 1612.27),(2022,12, 1941.62),
(2023,1, 210.5),(2023,2, 415.25),(2023,3, 5132.5),(2023,4, 12.2),(2023,5, 15),(2023,6, 450.2),(2023,7, 754.06),(2023,8, 55.69),(2023,9, 994.50),(2023,10, 45.25),(2023,11, 211.33),(2023,12, 842.67)

--PIVOT: SIGNIFICA CONVERTIR UNA TABLA DE FORMA VERTICAL A FORMA HORIZONTAL
--UNPIVOT: VUELVE LA TABLA A SU ESTADO ORIGINAL (ES DECIR, PARTIENDO DE UNA TABLA HORIZONTAL, LA CONVIERTE EN VERTICAL)

/*
--TABLA VERTICAL

--------------------------
| Year	| Month	| Total |
--------------------------
|		|		|		|

--TABLA HORIZONTAL

----------------------------------------------------------------------------------------------------------------------------
| Year	| January	| February | March | April | May | June | July | August | September | October | November | December |
----------------------------------------------------------------------------------------------------------------------------
| 2021	|  210.50	|			
| 2022	|  210.50	|	
| 2023	|  822.12	|	

*/
--*********************************
--EJEMPLO PIVOT
--*********************************
SELECT 
[year] = P.[year],
January = ISNULL(P.[1], 0),
February = ISNULL(P.[2], 0),
March = ISNULL(P.[3], 0),
April = ISNULL(P.[4],0),
May = ISNULL(P.[5],0),
June = ISNULL(P.[6],0),
July = ISNULL(P.[7],0),
August = ISNULL(P.[8],0),
September = ISNULL(P.[9],0),
October = ISNULL(P.[10],0),
November = ISNULL(P.[11],0),
December = ISNULL(P.[12],0)
FROM 
(
	SELECT *
	FROM dbo.TMP_TABLA_PIVOTE
) X
PIVOT (
	MAX(TOTAL)
	--FOR [month] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) --Como los datos de la column Month son numericos, los pongo entre corchetes
	FOR [month] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) --Como los datos de la column Month son numericos, los pongo entre corchetes
) P

--*********************************
--EJEMPLO UNPIVOT
--*********************************
SELECT UP.*
FROM 
(
	SELECT *
	FROM dbo.TMP_TABLA_PIVOTE
) X
PIVOT (
	MAX(TOTAL)
	--FOR [month] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) --Como los datos de la column Month son numericos, los pongo entre corchetes
	FOR [month] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) --Como los datos de la column Month son numericos, los pongo entre corchetes
) P
UNPIVOT (
	TOTAL
	FOR [month] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) --Como los datos de la column Month son numericos, los pongo entre corchetes
) UP
