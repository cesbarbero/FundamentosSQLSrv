/*
--**********************************************************************
--      SENTENCIAS DCL
--**********************************************************************
*/

--1) ******************GRANT***********************************
    --CREAR LOGIN PARA CONECTARSE AL SQL SERVER 
    USE DB_Educacion_IT
    go
    IF NOT EXISTS 
    (
    SELECT name 
    FROM master.sys.server_principals
    WHERE name = 'usr_prueba'
    )
    BEGIN
        CREATE LOGIN usr_prueba
        WITH PASSWORD = 'Cas1nO433!'
    END
    --INTENTAR CONECTARSE CON EL LOGIN usr_prueba (NO TENDREMOS ACCESO A NINGUNA BASE DE DATOS)
    go

    --ASIGNO PERMISOS SOBRE LAS TABLAS DE LA BASE DB_Educacion_IT
    USE DB_Educacion_IT
    GO
    IF NOT EXISTS
    (
        select 
        name as username,
        create_date,
        modify_date,
        type_desc as type,
        authentication_type_desc as authentication_type
        from sys.database_principals
        where type not in ('A', 'G', 'R', 'X')
        and sid is not null
        and name = 'usr_prueba'
    )
    BEGIN
        CREATE USER usr_prueba
        FOR LOGIN usr_prueba
        
        --Permiso para conectarse
        GRANT CONNECT TO usr_prueba;
        
        --PERMISOS DE SELECT, INSERT, UPDATE Y DELETE SOBRE TABLA TMP_Persona
        GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.TMP_Persona TO usr_prueba;
    END

--2) ******************REVOKE***********************************
    REVOKE INSERT, UPDATE, DELETE ON dbo.TMP_Persona FROM usr_prueba;
go
/*
--**********************************************************************
--      SENTENCIAS DML
--**********************************************************************
*/

USE DB_Educacion_IT
GO
--1) ******************INSERT**********************************

INSERT INTO TMP_Persona 
( 
persona_dni, 
persona_nombre, 
persona_apellido, 
persona_edad, 
persona_direccion, 
persona_telefono 
) 
VALUES 
( 
25644231, 
'Juan', 
'Aguirre', 
44, 
'Mario Bravo 422', 
'4532-2533' 
), 
( 
27632112, 
'Maria', 
'Serrano', 
42, 
'Mitre 253', 
'4352-8823' 
)

--2) ******************SELECT**********************************
SELECT * FROM TMP_Persona

--OFFSET: Retorna todo el contenido de la tabla a excepción de los 3 primeros registros (necesita order by)
SELECT * 
FROM TMP_Persona
ORDER BY persona_id
OFFSET 3 ROWS;

--OFFSET: Se posiciona en el segundo registro y retorna los 3 siguientes
SELECT * 
FROM TMP_Persona
ORDER BY persona_id
OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;

--TOP: RETORNO LOS PRIMEROS 3 REGISTROS
SELECT TOP 3 *
FROM TMP_Persona

--ALIAS:
--opcion 1
SELECT
id = persona_id,
dni = persona_dni
FROM TMP_Persona

--opcion 2
SELECT
persona_id AS id,
persona_dni AS dni
FROM TMP_Persona

--LITERALES
SELECT
persona_id,
persona_dni,
Literal = 'Esto es una Prueba',
'Otra Prueba' AS Literal_2
FROM TMP_Persona

--3) ******************DELETE**********************************
DELETE FROM TMP_Persona WHERE persona_id = 2

--4) ******************UPDATE**********************************
UPDATE TT 
SET TT.persona_nombre = 'Juan Carlos' 
FROM TMP_Persona TT 
WHERE TT.persona_id = 1

GO

--5) ******************MERGE**********************************
    
    --a) Se crearán dos tablas para poder mostrar como trabaja el MERGE
    IF NOT EXISTS
    (
        SELECT 1 FROM SYS.tables WHERE NAME = 'TMP_EMPRESA'
    )
    BEGIN
        CREATE TABLE TMP_EMPRESA
        (
            id int not null identity primary key,
            nombre varchar(50) not null,
            observacion varchar(500)
        )
    END
    ELSE
        TRUNCATE TABLE TMP_EMPRESA
    GO
    IF NOT EXISTS
    (
        SELECT 1 FROM SYS.tables WHERE NAME = 'EMPRESA'
    )
    BEGIN
        CREATE TABLE EMPRESA
        (
        id int not null  identity primary key,
        nombre varchar(50) not null,
        observacion varchar(500)
        )
    END
    GO
    
    --b) inserto registros en la tabla 
    INSERT INTO TMP_EMPRESA (nombre,observacion) values ('General Motor','empresa 1')
    INSERT INTO TMP_EMPRESA (nombre,observacion) values ('Epidata', 'empresa 2')
    SELECT * FROM TMP_EMPRESA
	SELECT * FROM EMPRESA
	GO
    
    --c) Utilizo la instrucción MERGE para insertar o actualizar datos en la tabla EMPRESA, según la info existente en la tabla TMP_EMPRESA
    
    MERGE EMPRESA AS TARGET
    USING TMP_EMPRESA AS SOURCE
    ON
    (
    	TARGET.id = SOURCE.id
    )
    WHEN MATCHED THEN
    	UPDATE
    	SET 
    	TARGET.nombre  = SOURCE.nombre,
    	TARGET.observacion = SOURCE.observacion
    WHEN NOT MATCHED BY TARGET THEN
    	INSERT	(nombre, observacion) values(SOURCE.nombre, SOURCE.observacion);

    --d) Verifico que se hayan insertado los registros sobre la tabla EMPRESA
    SELECT * FROM EMPRESA
    
    --e) Modifico la observacion de la tabla TMP_EMPRESA para el id_empresa = 2
    UPDATE TMP_EMPRESA
    SET observacion = 'funciona vieron'
    WHERE id = 2
    
    select * from TMP_EMPRESA
    
    --f) Vuelvo a ejecutar el merge del paso c)
    
    --g) Consulto la tabla EMPRESA y debería haber aplicado el cambio
    
    select * from TMP_EMPRESA
    
    
--3) ******************COMMIT Y ROLLBACK***********************************
   USE DB_Educacion_IT
 GO
 --Lista de Severity: https://docs.microsoft.com/en-us/sql/relational-databases/errors-events/database-engine-error-severities?view=sql-server-ver15
 
 /*Cuando SET XACT_ABORT está en ON, si una instrucción sql genera un error en tiempo de ejecución, toda la transacción se revierte*/
 SET XACT_ABORT ON
 BEGIN TRY
     BEGIN TRANSACTION;
         --modifico datos en la tabla
         UPDATE TMP_PERSONA
         SET persona_nombre = 'emiliano'
         WHERE persona_nombre = 'Juan Carlos'

         --genero un error
         select 1/0
     COMMIT TRANSACTION; --para confirmar transaccion 
 END TRY
 BEGIN CATCH
    DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
	DECLARE @ERROR_SEVERITY INT
	DECLARE @ERROR_STATE INT

  SELECT @ERROR_MESSAGE = ERROR_MESSAGE() + ' Line ' + CAST(ERROR_LINE() as nvarchar(5)), @ERROR_SEVERITY = ERROR_SEVERITY(), @ERROR_STATE = ERROR_STATE();
	 
	--verifico si hay un error 
    IF @@TRANCOUNT > 0
    BEGIN
        --Deshacer la transacción
        ROLLBACK TRANSACTION;
		--THROW 50000, @ERROR_MESSAGE, 1;				
    END
    --SELECT @ERROR_MESSAGE
	--RAISERROR(@ERROR_MESSAGE, @ERROR_SEVERITY, @ERROR_STATE);	
	 
 END CATCH
 SET XACT_ABORT OFF

GO
