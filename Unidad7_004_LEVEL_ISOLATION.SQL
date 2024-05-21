use DB_Educacion_IT
go
IF NOT EXISTS
(
	SELECT TOP 1 1 FROM SYS.TABLES WHERE NAME = 'IsolationTests'
)
BEGIN
	CREATE TABLE IsolationTests
	(
		Id INT IDENTITY,
		Col1 INT,
		Col2 INT,
		Col3 INT
	)
END
TRUNCATE TABLE IsolationTests
INSERT INTO IsolationTests(Col1,Col2,Col3)
SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3

SELECT * FROM IsolationTests


------------------------------------------------------------------------------------------------------------
/*
--0) ************* Si uno desea comprobar que nivel de aislamiento (uncommited, commited, etc) se está ejecutando, deberá ejecutar:**************
DBCC useroptions
*/
--EJEMPLO DE COMO CAMBIAR EL NIVEL DE AILAMIENTO A READ UNCOMMITED
USE DB_Educacion_IT
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT Col1 FROM IsolationTests

DBCC useroptions

------------------------------------------------------------------------------------------------------------

/*
--1)*************************READ UNCOMMITTED ************************
¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-El Query2 no esperará a que el Query1 termine, muestra lo que había en ese momento
-El Query2 devuelve datos sucios (aunque luego el Query1 realiza un rollback)
*/

--A) VENTANA 1:
--QUERY 1
use DB_Educacion_IT
go
BEGIN TRAN
	UPDATE IsolationTests SET Col1 = 2
	WAITFOR DELAY '00:00:10'
ROLLBACK

select Col1 from IsolationTests


--B) VENTANA 2:
--QUERY 2
use DB_Educacion_IT
go
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select Col1 from IsolationTests

------------------------------------------------------------------------------------------------------------

/*
--2)*************************READ COMMITTED ************************
*/


/*
--CASO 1: EJEMPLO DE QUE NO RETORNA LECTURAS SUCIAS
¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-El Query2 esperará a que el Query1 termine, y ambos mostrarán lo mismo
-El Query2 no devuelve datos sucio
*/
--A) VENTANA 1:
use DB_Educacion_IT
go
BEGIN TRAN
	UPDATE IsolationTests SET Col1 = 2
	WAITFOR DELAY '00:00:10'
ROLLBACK

select Col1 from IsolationTests

--B) VENTANA 2
use DB_Educacion_IT
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
select Col1 from IsolationTests



/*
--CASO 2: Observar como el nivel de aislamiento READ COMMITTED genera lecturas fantasmas (ya que permite insertar registros desde otras 
transacciones, provocando que puedan retornarse lecturas diferentes)

¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-Observar que el Query1 retorna resultados diferentes en los selects ejecutados en la transacción
-El Query2 no esperar a que finalice el Query1, esto genera lecturas fantasmas
*/
--A) VENTANA 1:
--QUERY 1
use DB_Educacion_IT
go
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
	SELECT * FROM IsolationTests
	WAITFOR DELAY '00:00:10'
	SELECT * FROM IsolationTests
ROLLBACK

--B) VENTANA 2:
--QUERY 2
use DB_Educacion_IT
go
BEGIN TRANSACTION
insert IsolationTests (Col1,Col2,Col3) VALUES(99,99,99)
COMMIT
select * from IsolationTests


------------------------------------------------------------------------------------------------------------

/*
--3)*************************REPEATABLE READ ************************
*/

/*
--CASO 1: EJEMPLO DE QUE NO PERMITE LECTURAS DIFERENTES CUANDO LOS DATOS SON MODIFICADOS DESDE OTRA TRANSACCION
¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-Observar que el Query1 devuelve los mismos datos para ambas consultas select
-El Query2 debió esperar a que finalice el Query1, debido a los bloqueos generados por el nivel de aislamiento REPEATABLE READ
*/

--A) VENTANA 1:
--QUERY 1
use DB_Educacion_IT
go
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
	SELECT * FROM IsolationTests
	WAITFOR DELAY '00:00:10'
	SELECT * FROM IsolationTests
ROLLBACK

--B) VENTANA 2:
--QUERY 2
use DB_Educacion_IT
go
UPDATE IsolationTests SET Col1 = -1

select * from IsolationTests



/*
--CASO 2: Observar como el nivel de aislamiento REPEATABLE READ genera lecturas fantasmas (ya que permite insertar registros desde otras 
transacciones, provocando que puedan retornarse lecturas diferentes)
¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-Observar que el Query1 retorna resultados diferentes en los selects ejecutados en la transacción
-El Query2 no esperar a que finalice el Query1, esto genera lecturas fantasmas
*/
--A) VENTANA 1:
--QUERY 1
use DB_Educacion_IT
go
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
	SELECT * FROM IsolationTests
	WAITFOR DELAY '00:00:10'
	SELECT * FROM IsolationTests
ROLLBACK

--B) VENTANA 2:
--QUERY 2
use DB_Educacion_IT
go
insert IsolationTests (Col1,Col2,Col3) VALUES(55,55,55)
select * from IsolationTests


------------------------------------------------------------------------------------------------------------

/*
--4)*************************SERIALIZABLE ************************
¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-Observar que el Query1 devuelve los mismos datos para ambas consultas select
-El Query2 debió esperar a que finalice el Query1, debido a los bloqueos generados por el nivel de aislamiento SERIALIZABLE
*/

--A) VENTANA 1
--QUERY 1
use DB_Educacion_IT
go
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
	SELECT * FROM IsolationTests
	WAITFOR DELAY '00:00:10'
	SELECT * FROM IsolationTests
ROLLBACK


--B) VENTANA 2
--QUERY 2
use DB_Educacion_IT
go
insert IsolationTests (Col1,Col2,Col3) VALUES(100,100,100)

select * from IsolationTests


------------------------------------------------------------------------------------------------------------


/*
--6)*************************SNAPSHOT ************************
¿Como lo ejecuto?
deberá ejecutarse el query1 y correr rápidamente el query 2 en la otra solapa

¿Cual será el resultado?
-Observar que el Query1 devuelve los mismos datos para ambas consultas select
-El Query2 NO debió esperar a que finalice el Query1, debido a QUE NO HAY bloqueos generados por el nivel de aislamiento SNAPSHOT
*/
DROP DATABASE [DB_Snpashot_Emi]
CREATE DATABASE [DB_Snpashot_Emi]


/*I) EJECUTAR LO SIGUIENTE PARA HABILITAR LA BASE AL NIVEL DE AISLAMIENTO SNAPSHOT*/
ALTER DATABASE [DB_Snpashot_Emi]
SET ALLOW_SNAPSHOT_ISOLATION ON
GO
/*II) CREAR LA TABLA y IsolationTests en la base DB_Snapshot_Emi, e insertar registros*/

use [DB_Snpashot_Emi]
go
IF NOT EXISTS
(
	SELECT TOP 1 1 FROM SYS.TABLES WHERE NAME = 'IsolationTests'
)
BEGIN
	CREATE TABLE IsolationTests
	(
		Id INT IDENTITY,
		Col1 INT,
		Col2 INT,
		Col3 INT
	)
END
TRUNCATE TABLE IsolationTests
INSERT INTO IsolationTests(Col1,Col2,Col3)
SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3
UNION ALL SELECT 1,2,3

--III) VENTANA 1:
use [DB_Snpashot_Emi]
go
BEGIN TRAN
	SELECT * FROM IsolationTests
	WAITFOR DELAY '00:00:10'
	SELECT * FROM IsolationTests
ROLLBACK

--IV) VENTANA 2

--QUERY 2
use [DB_Snpashot_Emi]
go
insert IsolationTests (Col1,Col2,Col3) VALUES(100,100,100)

select * from IsolationTests