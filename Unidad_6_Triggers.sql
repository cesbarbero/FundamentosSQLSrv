--1) CREAMOS LA ESTRUCTURA:
IF NOT EXISTS (
	SELECT TOP 1 1 FROM sys.databases where name = 'db_inventario'
)
	CREATE DATABASE db_inventario

go
USE db_inventario
go
CREATE TABLE productos
(
id_cod int not null identity primary key,
cod_prod varchar(4) not null,
nombre varchar(50) not null,
existencia int not null
)
go
create table historial
(
fecha date,
cod_prod varchar(4),
descripcion varchar(100),
usuario varchar(20)
)
GO
create table ventas
(
cod_prod varchar(4) NOT NULL,
precio money,
cantidad int
)
go
--2) VERIFICAMOS QUE NO EXISTE INFORMACIÓN EN LAS TABLAS
SELECT * FROM historial
SELECT * FROM productos


--3) CREAMOS UN TRIGGER QUE SE DISPARARA CUANDO INSERTEMOS EN LA TABLA PRODUCTOS, EL CUAL GUARDARA CIERTA INFORMACION EN LA TABLA HISTORIAL
CREATE TRIGGER TR_Producto_Insertado
ON productos FOR INSERT
AS
	SET NOCOUNT ON
	DECLARE @cod_prod VARCHAR(4)
	--obtengo el codigo del producto insertado de la tabla inserted
	SELECT @cod_prod = cod_prod	FROM inserted
	
	INSERT INTO historial
	(
	fecha,
	cod_prod,
	descripcion,
	usuario
	)
	VALUES
	(
	getdate(),
	@cod_prod,
	'registro insertado', 
	SYSTEM_USER
	)
go

--4) REALIZAMOS UN INSERT SOBRE LA TABLA PRODUCTO, Y ESTO DEBERA EJECUTAR EL TRIGGER TR_Producto_Insertado
insert into productos values ('A001', 'MEMORIA USB 32GB',175)
insert into productos values ('A002', 'DISCO DURO 2TB',15)
insert into productos values ('A003', 'AIRE COMPRIMIDO',250)
insert into productos values ('A004', 'ESPUMA LIMPIADORA',300)
insert into productos values ('A005', 'FUNDA MONITOR',500)
insert into productos values ('A006', 'FUNADA TECLADO',700)
insert into productos values ('A007', 'SILLA',11)
insert into productos values ('A008', 'ALFOMBRA PARA SILLA',25)
insert into productos values ('A009', 'LAMPARA ESCRITORIO',7)
--5) Verificamos que el trigger se ejecuto correctamente
SELECT * FROM productos
SELECT * FROM historial


--6) CREAMOS UN TRIGGER QUE SE DISPARARA CUANDO ELIMINEMOS EN LA TABLA PRODUCTOS, EL CUAL GUARDARA CIERTA INFORMACION EN LA TABLA HISTORIAL
CREATE TRIGGER TR_Producto_Deleted
ON productos FOR DELETE
AS
	SET NOCOUNT ON
	DECLARE @cod_prod VARCHAR(4)
	--obtengo el codigo del producto insertado de la tabla deleted
	SELECT @cod_prod = cod_prod	FROM deleted
		
	INSERT INTO historial
	(
	fecha,
	cod_prod,
	descripcion,
	usuario
	)
	VALUES
	(
	getdate(),
	@cod_prod,
	'registro eliminado', 
	SYSTEM_USER
	)
go

--7) Eliminamos el codigo de producto A003 de la tabla productos
DELETE FROM productos WHERE cod_prod = 'A003'

--8) Verificamos que el trigger de borrado se ejecuto correctamente
SELECT * FROM productos
SELECT * FROM historial

--9) CREAMOS TRIGGER PARA HACER UPDATE
CREATE TRIGGER TR_Producto_Update
ON productos FOR UPDATE
AS
	SET NOCOUNT ON
	DECLARE @cod_prod VARCHAR(4)
	--obtengo el codigo del producto que se actualizó (y tiene los datos actualizados)
	SELECT @cod_prod = cod_prod	FROM inserted
	
	INSERT INTO historial
	(
	fecha,
	cod_prod,
	descripcion,
	usuario
	)
	VALUES
	(
	getdate(),
	@cod_prod,
	'registro actualizado', 
	SYSTEM_USER
	)
go
--10) Realizamos el update sobre el código de producto 'A002'
UPDATE productos
SET existencia = 180
WHERE COD_PROD = 'A001'

--11) Verificamos que el trigger de actualización se ejecuto correctamente
SELECT * FROM productos
SELECT * FROM historial

--12) Crearemos un trigger asociado a la tabla ventas. La idea es que cuando realicemos una venta, disminuya la existencia del producto

CREATE TRIGGER TR_Ventas_Insertado
ON ventas FOR INSERT
AS
	SET NOCOUNT ON
	
	--obtengo el codigo del producto vendido de la tabla inserted, y actualizo la existencia de la tabla productos
	UPDATE TT
	SET TT.existencia = TT.existencia - V.cantidad
	from productos TT
	inner join inserted V on V.cod_prod = TT.cod_prod

go

--13) Agrego una venta para el producto 'A005'
--obtengo la existencia actual del producto A005
SELECT * FROM productos WHERE cod_prod = 'A005'

INSERT INTO ventas (cod_prod,precio,cantidad)
VALUES('A005',385.23,5)
GO
--14) VERIFICO LAS TABLAS

SELECT * FROM productos WHERE cod_prod = 'A005'
SELECT * FROM historial WHERE cod_prod = 'A005'
select * from ventas where cod_prod = 'A005'


---------------------------------------------------------------------------------
--TRIGGER QUE EVITA HACER DROP TABLE EN UNA BASE DE DATOS
USE db_inventario
GO
CREATE TRIGGER drop_safe
ON DATABASE 
FOR DROP_TABLE 
AS 
   PRINT 'You must disable Trigger "drop_safe" to drop table!' 
   ROLLBACK
;
GO
--AHORA SI CREO UNA TABLA E INTENTO DROPEARLA, NO ME VA A DEJAR
create table tmp_prueba(id int)
GO
--ACA DARA ERROR POR EL TRIGGER drop_safe
DROP TABLE tmp_prueba