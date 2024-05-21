use DB_Educacion_IT
go
/*
--ELIMINAR FK Y LUEGO DROPEAR LAS TABLAS
ALTER TABLE dbo.EMPLEADO
DROP CONSTRAINT FK_EMPLEADO_PERSONA

ALTER TABLE dbo.CLIENTE
DROP CONSTRAINT FK_CLIENTE_PERSONA

ALTER TABLE dbo.CAJERO
DROP CONSTRAINT FK_CAJERO_EMPLEADO

ALTER TABLE dbo.SECRETARIA
DROP CONSTRAINT FK_SECRETARIA_EMPLEADO

DROP TABLE dbo.PERSONA
DROP TABLE dbo.EMPLEADO
DROP TABLE dbo.CLIENTE
DROP TABLE dbo.CAJERO
DROP TABLE dbo.SECRETARIA
*/
--****************CREAR ENTIDADES**********************
--1) CREAMOS ENTIDAD PERSONA
 IF NOT EXISTS
 (
     SELECT TOP 1 1 FROM sys.tables WHERE name = 'PERSONA'
 )
 BEGIN
     CREATE TABLE dbo.PERSONA
     (
         id_persona INT NOT NULL,
         nombre VARCHAR(100) NOT NULL,
		 calle VARCHAR(200) NULL,
		 activo BIT NOT NULL DEFAULT CAST(1 AS BIT),
		 CONSTRAINT PK_PERSONA PRIMARY KEY CLUSTERED(id_persona)
     )
 END

--2) CREAMOS ENTIDAD EMPLEADO
 IF NOT EXISTS
 (
     SELECT TOP 1 1 FROM sys.tables WHERE name = 'EMPLEADO'
 )
 BEGIN
     CREATE TABLE dbo.EMPLEADO
     (
         id_empleado INT NOT NULL IDENTITY(1,1),
		 id_persona INT NOT NULL,
         sueldo DECIMAL(18,2) NOT NULL,
		 CONSTRAINT FK_EMPLEADO_PERSONA FOREIGN KEY(id_persona)
		 REFERENCES PERSONA (id_persona)
		 ON UPDATE CASCADE		--ACEPTA MODIFICACIONES EN CASCADA DEL id_persona (desde la tabla PERSONA)
		 ON DELETE NO ACTION,   --NO PERMITE BORRAR EL ID_PERSONA (en la tabla PERSONA)
		 CONSTRAINT PK_EMPLEADO PRIMARY KEY CLUSTERED(id_empleado)
     )
END

--3) CREAMOS ENTIDAD CAJERO
 IF NOT EXISTS
 (
     SELECT TOP 1 1 FROM sys.tables WHERE name = 'CAJERO'
 )
 BEGIN
     CREATE TABLE dbo.CAJERO
     (
         id_empleado INT NOT NULL,
		 numero_caja VARCHAR(50) NOT NULL,
		 horas_trabajadas SMALLINT NOT NULL,
		 CONSTRAINT FK_CAJERO_EMPLEADO FOREIGN KEY(id_empleado)
		 REFERENCES EMPLEADO (id_empleado)
		 ON UPDATE CASCADE		--ACEPTA MODIFICACIONES EN CASCADA DEL id_empleado (desde la tabla EMPLEADO)
		 ON DELETE NO ACTION,   --NO PERMITE BORRAR EL ID_EMPLEADO (en la tabla EMPLEADO)
		 CONSTRAINT PK_CAJERO PRIMARY KEY CLUSTERED(id_empleado)
     )
END

--4) CREAMOS ENTIDAD SECRETARIA
 IF NOT EXISTS
 (
     SELECT TOP 1 1 FROM sys.tables WHERE name = 'SECRETARIA'
 )
 BEGIN
     CREATE TABLE dbo.SECRETARIA
     (
         id_empleado INT NOT NULL,
		 horas_trabajadas SMALLINT NOT NULL,
		 CONSTRAINT FK_SECRETARIA_EMPLEADO FOREIGN KEY(id_empleado)
		 REFERENCES EMPLEADO (id_empleado)
		 ON UPDATE CASCADE		--ACEPTA MODIFICACIONES EN CASCADA DEL id_empleado (desde la tabla EMPLEADO)
		 ON DELETE NO ACTION,   --NO PERMITE BORRAR EL ID_EMPLEADO (EN LA TABLA EMPLEADO)
		 CONSTRAINT PK_SECRETARIA PRIMARY KEY CLUSTERED(id_empleado)
     )
END

--5) CREAMOS ENTIDAD CLIENTE
 IF NOT EXISTS
 (
     SELECT TOP 1 1 FROM sys.tables WHERE name = 'CLIENTE'
 )
 BEGIN
     CREATE TABLE dbo.CLIENTE
     (
         id_cliente INT NOT NULL IDENTITY(1,1),
		 id_persona INT NOT NULL,
		 calificacion_crediticia SMALLINT NOT NULL,
		 CONSTRAINT FK_CLIENTE_PERSONA FOREIGN KEY(id_persona)
		 REFERENCES PERSONA (id_persona)
		 ON UPDATE CASCADE		--ACEPTA MODIFICACIONES EN CASCADA DEL id_persona (desde la tabla PERSONA)
		 ON DELETE CASCADE,   --PERMITE BORRAR EL ID_PERSONA (en la tabla PERSONA)
		 CONSTRAINT PK_CLIENTE PRIMARY KEY CLUSTERED(id_cliente)
     )
END

--****************INSERTAR REGISTROS**********************
--1) TABLA: dbo.PERSONA
--SI NO EXISTE NINGÚN REGISTRO EN LA TABLA PERSONA, REALIZO LAS INSERCIONES
IF NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.PERSONA
)
BEGIN
	--no inserto en las columnas: 
	--activo: porque por default insertará el valor CAST(1 AS BIT) para indicar que esta activa la persona
	INSERT INTO dbo.PERSONA (id_persona, nombre, calle)
	VALUES (1,'Juan Perez', 'Av Corrientes 2035 8 F'),
	(2,'Maria Andrea Gutierrez', 'Av Cordoba 1801 4 D'),
	(3,'Marcelo Rodriguez', 'Medrano 205'),
	(4,'Rocio Alvarez', 'Scalabrini Ortiz 306 9 C'),
	(5,'Ramiro Benitez', 'Scalabrini Ortiz 306 9 C'),
	(6,'Alfonso Farias', 'Amenabar 4422 8 A'),
	(7,'Baltazar Goldman', 'Moldes 212 1 C'),
	(8,'Sofia Zip', 'Bacacay 2910 PB 3')
END

--2) TABLA: dbo.CLIENTE
--SI NO EXISTE NINGÚN REGISTRO EN LA TABLA CLIENTE, REALIZO LAS INSERCIONES
--SELECT * FROM dbo.PERSONA
--SELECT * FROM dbo.CLIENTE
IF NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.CLIENTE
)
BEGIN
	--no inserto en las columnas: 
	--id_persona porque es un autoincremental
	--activo: porque por default insertará el valor CAST(1 AS BIT) para indicar que esta activa la persona
	INSERT INTO dbo.CLIENTE(id_persona, calificacion_crediticia)
	VALUES(5,10)

	INSERT INTO dbo.CLIENTE(id_persona, calificacion_crediticia)
	VALUES(6,7)

	INSERT INTO dbo.CLIENTE(id_persona, calificacion_crediticia)
	VALUES(7,3)
	
	INSERT INTO dbo.CLIENTE(id_persona, calificacion_crediticia)
	VALUES(8,6)
END


--3) TABLA: dbo.EMPLEADO
--SI NO EXISTE NINGÚN REGISTRO EN LA TABLA EMPLEADO, REALIZO LAS INSERCIONES
--SELECT * FROM dbo.PERSONA
--SELECT * FROM dbo.EMPLEADO
IF NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.EMPLEADO
)
BEGIN
	--no inserto en las columnas: 
	--id_persona porque es un autoincremental
	--activo: porque por default insertará el valor CAST(1 AS BIT) para indicar que esta activa la persona
	INSERT INTO dbo.EMPLEADO(id_persona, sueldo)
	VALUES(1,255323.45)

	INSERT INTO dbo.EMPLEADO(id_persona, sueldo)
	VALUES(2,205233.68)

	INSERT INTO dbo.EMPLEADO(id_persona, sueldo)
	VALUES(3,365000.76)

	INSERT INTO dbo.EMPLEADO(id_persona, sueldo)
	VALUES(4,185000.68)
END

--4) TABLA: CAJERO
IF NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.CAJERO
)
BEGIN
	--SELECT * FROM EMPLEADO
	INSERT INTO CAJERO (id_empleado, numero_caja, horas_trabajadas)
	VALUES(3,'456AB2',8),
	(2,'352CR4',6),
	(1,'352CR3',7)
END

--5) TABLA: SECRETARIA
IF NOT EXISTS
(
	SELECT TOP 1 1
	FROM dbo.SECRETARIA
)
BEGIN
	--SELECT * FROM EMPLEADO
	INSERT INTO SECRETARIA(id_empleado, horas_trabajadas)
	VALUES(4,9)
END

--6) CONSULTAMOS LAS TABLAS
select 'TABLA: PERSONA'
SELECT * FROM dbo.PERSONA

select 'TABLA: CLIENTE'
SELECT * FROM dbo.CLIENTE

select 'TABLA: EMPLEADO'
SELECT * FROM dbo.EMPLEADO

select 'TABLA: CAJERO'
SELECT * FROM dbo.CAJERO

select 'TABLA: SECRETARIA'
SELECT * FROM dbo.SECRETARIA
/*
--4)**************** PROBEMOS FOREIGN KEY*****************************
	--I) ENTRE TABLAS PERSONA Y EMPLEADO
		--A)OBJETIVO: Intentaremos borrar de la tabla PERSONA el id_persona = 1, pero como existe una foreign key en la tabla EMPLEADO que no lo permite. No sera posible eliminar ese registro
		--observar: realizamos un select a las tablas PERSONAS y EMPLEADO, para verificar que el id_persona = 1 exista en ambas
		SELECT * FROM dbo.PERSONA WHERE id_persona = 1
		SELECT * FROM EMPLEADO  WHERE id_persona = 1

		--INTENTAMOS BORRAR EL ID_PERSONA = 1 DE LA TABLA PERSONA (pero como es un empleado, no debería permitirlo)
		DELETE FROM PERSONA WHERE id_persona = 1

		--B) OBJETIVO: INTENTAMOS MODIFICAR ID_PERSONA = 1 DE LA TABLA PERSONA, POR id = 44 (ESTO DEBERÍA PERMITIRLO Y REPLICARSE EN LAS TABLAS RELACIONADAS)
		UPDATE PERSONA SET id_persona = 44 WHERE id_persona = 1
		--observar, que con solo modificar el id_persona en la tabla PERSONA, ese cambio se replica en cascada a las tablas que tengan ese campo como foreign key
		SELECT * FROM dbo.PERSONA WHERE id_persona = 44
		SELECT * FROM EMPLEADO  WHERE id_persona = 44

	--II) ENTRE TABLAS PERSONA Y CLIENTE
		--A)OBJETIVO: Intentaremos borrar de la tabla PERSONA el id_persona = 7, y por mas queo existe una foreign key en la tabla CLIENTE, se definió que permita este tipo de operación. 
		--Por lo tanto, se eliminará el registro con id_persona = 7, tanto de la tabla PERSONA como de la tabla CLIENTE
		--observar: realizamos un select a las tablas PERSONA y CLIENTE, para verificar que el id_persona = 7 exista en ambas
		SELECT * FROM dbo.PERSONA WHERE id_persona = 7
		SELECT * FROM dbo.CLIENTE  WHERE id_persona = 7

		DELETE FROM PERSONA WHERE id_persona = 7
		--observar: realizamos un select a las tablas PERSONAS y EMPLEADO, para verificar que el id_persona = 7 ya NO existe en ambas
		SELECT * FROM dbo.PERSONA WHERE id_persona = 7
		SELECT * FROM EMPLEADO  WHERE id_persona = 7
	
	--III) SI QUIERO INSERTAR EN LA TABLA CAJERO UN ID_EMPLEADO QUE NO EXISTE EN LA TABLA EMPLEADO --> LA FOREIGN KEY NO LO PERMITE
		SELECT * FROM EMPLEADO
		INSERT INTO CAJERO (id_empleado, numero_caja, horas_trabajadas)
		VALUES(99,'456AB2',8)

*/
