------------------------------CREO UN LOGIN --------------------------------------
USE master
go
--CHECK_POLICY=OFF --> evito que sql server valide que el password cumpla normas de seguridad (NO HACER ESTO EN PRODUCCION)
--CHECK_EXPIRATION=OFF --> evito que el password expire, y que el sql me obligue a modificarlo (NO HACER ESTO EN PRODUCCION)
CREATE LOGIN emi_freue with password = '123', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go


------------------------------CREO UN USER PARA ASOCIARLO AL LOGIN, EN LA BASE DB_Educacion_IT--------------------------------------
USE DB_Educacion_IT
GO
CREATE USER emi_freue FOR LOGIN emi_freue
WITH DEFAULT_SCHEMA = cursodb  --definimos un schema que todavía no fue creado. Pero si no lo hacemos, sql le asignará el schema DBO (que es el default)
go

------------------------------CREO EL SCHEMA ASOCIADO AL USER --------------------------------------
USE DB_Educacion_IT
GO
CREATE SCHEMA cursodb AUTHORIZATION emi_freue
go

------------------------------DAR PERMISOS DE CREACIÓN DE TABLAS AL USER --------------------------------------
USE DB_Educacion_IT
GO
GRANT CREATE TABLE TO emi_freue
GO

------------------------------NOS CONECTAMOS CON EL USER emi_freue y creamos una tabla --------------------------------------
USE DB_Educacion_IT
GO
create table tmp_prueba(id int not null, nombre varchar(50))



--*****HASTA ACA (NO CONTINUAR)***************************





------------------------------CUANDO SE ES ADMINISTRADOR PODEMOS  --------------------------------------
USE DB_Educacion_IT
GO
--1) Consulto el usuario actual con el que estoy logueado (debería ser dbo)
select user

--2) Puedo cambiar el usuario con el que estoy logueado
execute as user = 'emi_freue'

--3) Si vuelo a validar el usuario con el que estoy logueado, debería aparecer emi_freue
select user

--4) Podría crear otra tabla, pero ya logueado con el user emi_freue
CREATE TABLE TMP_PRUEBA2 (id int not null, nombre varchar(100))

--5) Para regresar a ser nuevamente usuario dbo
revert

--6) Si vuelo a validar el usuario con el que estoy logueado, debería aparecer dbo
select user

/*
--para eliminar todo lo que creamos
--1) Nos conectamos con user con permisos de administrador (o sa)

--2) Eliminamos la tabla creada tmp_prueba
USE DB_Educacion_IT
GO

DROP TABLE cursodb.tmp_prueba
go

--3) Eliminamos el schema cursodb (dado que no tiene otros objetos creados)
USE DB_Educacion_IT
GO
DROP SCHEMA cursodb
go

--4) Eliminamos el user emi_freue de la base DB_Educacion_IT
USE DB_Educacion_IT
GO
DROP USER emi_freue 

--5) Elimino el login emi_freue de la base master (NO DEBE HABER NINGUNA CONEXIÓN ABIERTA DE ESE USUARIO)
USE master
go
DROP LOGIN emi_freue

Si da error, verificar que proceso esta lockeando el login emi_freue
USE master
GO 
SELECT spid, blocked  AS BlockedBy, loginame  AS LogInName, login_time,
last_batch, status
FROM   sys.sysprocesses
WHERE loginame = 'emi_freue'   --Change the loginID you are trying to delete

*/