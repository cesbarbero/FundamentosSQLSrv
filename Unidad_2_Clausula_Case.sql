use DB_Educacion_IT
GO
--EJEMPLOS DE UTILIZACIÓN DE CASE

IF NOT EXISTS
(
    SELECT TOP 1 1 FROM sys.tables WHERE name = 'TMP_PRODUCTO'
)
BEGIN
    CREATE TABLE dbo.TMP_PRODUCTO
    (
        id INT NOT NULL IDENTITY(1,1),
        descripcion VARCHAR(50),
		precio NUMERIC(9,2) NOT NULL
    )
END

TRUNCATE TABLE dbo.TMP_PRODUCTO

INSERT INTO dbo.TMP_PRODUCTO(descripcion, precio)
VALUES('Camisa tipo polo', 5560),
('Corbata a puntos', 2700),
('Corbata diney', 3900),
('Pantalon de Vestir Slim Fit', 12563),
('Pantalon de Vestir Hombre', 8600),
('Pantalon Vaquero 1230', 7900),
('remera mujer', 1850),
('Pantalon vestir recto', 5100)

--1) SELECT
SELECT
id,
descripcion,
precio,
[Rango_Precio] =	CASE
					WHEN precio <= 4000 THEN 'Hasta $4000'
					WHEN precio > 4000 and precio <= 8000 THEN 'Entre $4001 y $8000'
					WHEN precio > 8000 and precio <= 11000 THEN 'Entre $8001 y $11000'
					ELSE 'Mas de $11000'
					END
FROM dbo.TMP_PRODUCTO

--2) ORDER BY
--ORDENAMOS LOS PRODUCTOS SEGUN LA DESCRIPCION. EN PRIMER LUGAR PONEMOS LOS PANTALONES, LUEGO LAS CORBATAS Y RESTO
SELECT
id,
descripcion,
precio
FROM dbo.TMP_PRODUCTO
ORDER BY	CASE
			WHEN descripcion like 'Pantalon%' THEN 1
			WHEN descripcion like 'Corbata%' THEN 2
			ELSE 3
			END ASC

--3) UPDATE
--SUPONGAMOS QUE QUEREMOS AUMENTAR UN 20% LOS PRECIOS QUE SEAN MENORES A $6000 Y UN 10% AL RESTO
select 'ANTES', * FROM dbo.TMP_PRODUCTO

UPDATE TT
SET Precio = Precio +	CASE
						WHEN Precio <= 6000 THEN (Precio * 0.2)
						ELSE (Precio * 0.1)
						END
FROM dbo.TMP_PRODUCTO TT

select 'DESPUES', * FROM dbo.TMP_PRODUCTO

--4) SET
--BUSCO EN LA TABLA TMP_PRODUCTO, SI EL NOMBRE DEL PRODUCTO, CONTIENE EL TEXTO PASADO COMO PARAMETRO.
DECLARE @V_TEXTO VARCHAR(20) = 'Pantalon'--'MANZANA'
DECLARE @EXISTE_PRODUCTO BIT
SET @EXISTE_PRODUCTO =	CASE
						WHEN EXISTS(SELECT id FROM dbo.TMP_PRODUCTO WHERE descripcion like '%'+@V_TEXTO+'%')
						THEN CAST(1 AS BIT)
						ELSE CAST(0 AS BIT)
						END
SELECT 
TEXTO = @V_TEXTO,
EXISTE_DESCRIPCION_PRODUCTO = CASE WHEN @EXISTE_PRODUCTO = CAST(1 AS BIT) THEN 'SI' ELSE 'NO' END

--5) HAVING
--SE AGREGÓ LA CLAUSULA CASE AL HAVING
IF OBJECT_ID(N'tempdb..#tmp_producto_new') IS NOT NULL
BEGIN		
	DROP TABLE #tmp_producto_new
END

SELECT 
id,
descripcion,
precio,
tipo_producto =	CASE 
				WHEN descripcion like 'Pantalon%' THEN 'PANTALON'
				WHEN descripcion like 'Camisa%' THEN 'CAMISA'
				ELSE 'VARIOS'
				END
INTO #tmp_producto_new
FROM dbo.TMP_PRODUCTO 

SELECT * FROM #tmp_producto_new

SELECT
tipo_producto,
cantidad_productos = COUNT(tipo_producto),
Monto = SUM(precio)
FROM #tmp_producto_new PP
GROUP BY tipo_producto
HAVING	CASE 
		WHEN 
		(
			(COUNT(tipo_producto) > 4 AND SUM(precio) > 45000)
			OR
			(COUNT(tipo_producto) > 3 AND SUM(precio) > 36000)
		)
		THEN 100
		ELSE NULL
		END = 100

---------------------------------
--EJEMPLO VISTO EN CLASE
IF OBJECT_ID(N'tempdb..#tmp_alumnos') IS NOT NULL
BEGIN		
	DROP TABLE #tmp_alumnos
END

DECLARE @TMP_ALUMNOS TABLE
(
NOMBRE VARCHAR(50),
NOTA INT
)

INSERT INTO @TMP_ALUMNOS (NOMBRE, NOTA)
VALUES ('PEPE', 9),
('MARIA', 3),
('JOSE', 2),
('JUAN', 8),
('MARIO', 5)

--<= 3 REPROBADO
--ENTRE 4 Y 6 APROBADO
--ENTRE 7 Y 10 SOBRESALIENTE

SELECT 
NOMBRE,
NOTA,
RESULTADO =	CASE
			WHEN NOTA <= 3 THEN 'REPROBADO'
			WHEN NOTA >= 4 AND NOTA <= 6 THEN 'APROBADO'
			ELSE 'SOBRESALIENTE'
			END
INTO #tmp_alumnos
FROM @TMP_ALUMNOS

SELECT * FROM #tmp_alumnos
SELECT 
RESULTADO,
CANT_ALUMNOS = COUNT(RESULTADO)
FROM #tmp_alumnos
GROUP BY RESULTADO 
HAVING RESULTADO = 'APROBADO'