--1) VARIABLES ESCALARES 
--EJEMPLO 1
DECLARE @Texto VARCHAR(50) = 'PRUEBA'
SELECT Mensaje = @Texto

--EJEMPLO 2
DECLARE @Numero INT
SET @Numero = 10
SELECT Respuesta = @Numero


--EJEMPLO 3
DECLARE @NOW DATETIME
SELECT @NOW = GETDATE()
SELECT FECHA_DE_HOY = @NOW


--2) VARIABLES TIPO TABLA
DECLARE @ALUMNO TABLE
(
id_alumno INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
edad INT NOT NULL
)
SELECT * FROM @ALUMNO


--3) VARIABLES DE SISTEMA

--A) @@ROWCOUNT: Retorna la cantidad de filas leidas
select * from TMP_EMPRESA
SELECT @@ROWCOUNT

--B) @@IDENTITY: Devuelve el último ID insertado en una columna identity de una tabla, en la misma conexion
DECLARE @MATERIA TABLE
(
id_materia INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
)
INSERT INTO @MATERIA (nombre)
VALUES ('Matematica'), ('Lenguas'),('Fisica')

SELECT [IDENTITY] = @@IDENTITY

select * from @MATERIA

--C) @@SERVERNAME: Retorna el nombre del servidor local
SELECT @@SERVERNAME

--D) @@SPID: se puede usar para identificar el número de proceso del servidor en la salida de sp_who.
SELECT @@SPID

sp_who2 active