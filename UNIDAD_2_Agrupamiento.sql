USE DB_Educacion_IT
GO
--GENERO UNA NUEVA TABLA PARA REALIZAR LOS EJEMPLOS DE AGRUPAMIENTO
IF NOT EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'Visitantes'
)
BEGIN
	CREATE TABLE dbo.Visitantes
	(
	id_visitante INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	edad SMALLINT NOT NULL,
	sexo CHAR(1) NOT NULL,
	domicilio VARCHAR(200) NOT NULL,
	ciudad VARCHAR(100) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	montocompra DECIMAL(8,2) NULL
	)
END
TRUNCATE TABLE dbo.Visitantes
INSERT INTO dbo.Visitantes VALUES
('Marcela Morales', 43, 'F', 'Colon 456', 'Cordoba', '911924321', 8520.20),
('Alexander Fuentes', 20, 'M', 'Grau 423', 'Ferreñafe', '917967148', 10320.50),
('Maria Alejandra', 21, 'F', 'Ilo 234', 'Cordoba', '983292389', 11234.20),
('Jose Eduardo', 22, 'M', 'Prada 112', 'Cordoba', '980345234', 4572.70),
('Jorge Medina', 34, 'M', 'Bolivar 222', 'Ferreñafe', '945234678', 15341.21),
('Flor Mespmes', 37, 'F', 'Juana Castro de Bulnes 980', 'Ferreñafe', '923456789', 4567.20),
('Nancy Torres', 41, 'F', 'Union 999', 'Chiclayo', '987209142', 3567.20),
('Stephano Sanchez', 21, 'M', 'Satelite 772', 'Chiclayo', '911289345', 19332.20),
('Flor Samame', 44, 'F', 'La Victoria 432', 'Chiclayo', '933124552', 67342.20),
('Yadhira Carrillo', 45, 'F', 'Balta 490', 'Chiclayo', '965842312', 2300.50)

--PARA TODOS LOS CASOS: Listar la cantidad de personas por ciudad y sexo

----------------------------------------GROUP BY ROLLUP-------------------------------------------------------
--OBSERVAR QUE obtengo subtotales de la cantidad de personas a nivel de ciudad y un total general de las personas, de todas las ciudades
SELECT
CIUDAD,
SEXO,
CANTIDAD_PERSONAS = COUNT(id_visitante)
FROM dbo.Visitantes
GROUP BY CIUDAD, SEXO
WITH ROLLUP

--como ponerle títulos a los nulos? RTA: Usando la sentencia CASE
SELECT
CIUDAD = CASE WHEN CIUDAD IS NULL THEN 'TOTAL' ELSE CIUDAD END,
SEXO =	CASE 
		WHEN SEXO IS NULL AND CIUDAD IS NOT NULL THEN 'SUBTOTAL' 
		WHEN SEXO IS NULL AND CIUDAD IS NULL THEN 'TOTAL' 
		ELSE SEXO END,
CANTIDAD_PERSONAS = COUNT(id_visitante)
FROM dbo.Visitantes
GROUP BY CIUDAD, SEXO
WITH ROLLUP


----------------------------------------GROUP BY CUBE-------------------------------------------------------

--GENERA TODAS LAS COMBINACIONES POSIBLES PARA LAS COLUMNAS SELECCIONADAS EN EL CUBO
SELECT
CIUDAD,
SEXO,
CANTIDAD_PERSONAS = COUNT(id_visitante)
FROM dbo.Visitantes
GROUP BY CUBE(CIUDAD, SEXO)


--como ponerle títulos a los nulos? RTA: Usando la sentencia CASE
SELECT
CIUDAD =	CASE 
			WHEN CIUDAD IS NULL AND SEXO IS NOT NULL THEN 'TOTAL_CIUDADES_SEXO' 
			WHEN CIUDAD IS NULL AND SEXO IS NULL THEN 'TOTAL_GENERAL' 
			ELSE CIUDAD END,
SEXO =	CASE 
		WHEN SEXO IS NULL AND CIUDAD IS NOT NULL THEN 'TOTAL_CIUDAD' 
		WHEN SEXO IS NULL AND CIUDAD IS NULL THEN 'TOTAL GENERAL' 
		ELSE SEXO END,
CANTIDAD_PERSONAS = COUNT(id_visitante)
FROM dbo.Visitantes
GROUP BY CUBE(CIUDAD, SEXO)


----------------------------------------GROUP BY GROUPING SETS-------------------------------------------------------
--COMO PUEDO PERSONALIZAR LA AGRUPACION:
--VAMOS A GENERAR TOTALES POR: CIUDAD Y SEXO, SOLO POR CIUDAD, SOLO POR SEXO Y UN TOTAL GENERAL
SELECT 
CIUDAD, 
SEXO,
CANTIDAD_PERSONAS = COUNT(id_visitante)
FROM dbo.Visitantes
GROUP BY GROUPING SETS((CIUDAD, SEXO), (CIUDAD), (SEXO), ())

--como ponerle títulos a los nulos? RTA: Usando la sentencia CASE
SELECT 
CIUDAD =	CASE
			WHEN ciudad IS NULL AND SEXO IS NOT NULL THEN 'TOTAL_POR_SEXO'
			WHEN ciudad IS NULL AND SEXO IS NULL THEN 'TOTAL_GENERAL'
			ELSE ciudad
			END, 
SEXO =	CASE
		WHEN sexo IS NULL AND ciudad IS NOT NULL THEN 'TOTAL_POR_CIUDAD'
		WHEN sexo IS NULL AND ciudad IS NULL THEN 'TOTAL_GENERAL'
		ELSE sexo
		END,
CANTIDAD_PERSONAS = COUNT(id_visitante)
FROM dbo.Visitantes
GROUP BY GROUPING SETS((CIUDAD, SEXO), (CIUDAD), (SEXO), ())


----------------------------------------GROUPING Y GROUPING_ID-------------------------------------------------------
--FUNCIONES QUE PERMITEN IDENTIFICAR LOS DISTINTOS TIPOS DE AGRUPACIONES (ROLLUP, CUBE O GROUPING SET)
--1) EJEMPLO GROUPING: 
						--0 SIGNIFICA QUE NO HAY NULOS 
						--1 SIGNIFICA QUE HAY NULOS 
SELECT 
CIUDAD, 
SEXO,
CANTIDAD_PERSONAS = COUNT(id_visitante),
TIPO_FILA =	CASE 
			WHEN GROUPING(ciudad) = 0 and GROUPING(sexo) = 1 THEN 'TOTAL CIUDAD'	--CIUDAD NO TIENE NULOS Y SEXO TIENE NULOS
			WHEN GROUPING(ciudad) = 1 and GROUPING(sexo) = 0 THEN 'TOTAL SEXO'		--CIUDAD TIENE NULOS Y SEXO NO TIENE NULOS
			WHEN GROUPING(ciudad) = 1 and GROUPING(sexo) = 1 THEN 'TOTAL GENERAL'	--CIUDAD TIENE NULOS Y SEXO TIENE NULOS
			ELSE 'FILA NORMAL'
			END
FROM dbo.Visitantes
GROUP BY GROUPING SETS((CIUDAD, SEXO), (CIUDAD), ())

--2) EJEMPLO GROUPING_ID:
--TENIENDO EN CUENTA GROUP BY CUBE(CIUDAD, SEXO), DECIMOS QUE: 1 = CIUDAD | 2 = SEXO | 3 = TOTAL GENERAL (ESTE ULTIMO SIEMPRE APARECE)
SELECT
CIUDAD,
SEXO,
CANTIDAD_PERSONAS = COUNT(id_visitante),
TIPO_FILA =	CASE
			WHEN GROUPING_ID(CIUDAD, SEXO) = 1 THEN 'TOTAL_CIUDAD'
			WHEN GROUPING_ID(CIUDAD, SEXO) = 2 THEN 'TOTAL_SEXO'
			WHEN GROUPING_ID(CIUDAD, SEXO) = 3 THEN 'TOTAL_GENERAL'
			ELSE 'FILA NORMAL'
			END
FROM dbo.Visitantes
GROUP BY CUBE(CIUDAD, SEXO)
