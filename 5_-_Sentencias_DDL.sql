USE DB_Educacion_IT
GO
--1) ******************CREATE TABLE***********************************
    --a) TABLA: TMP_Persona
    IF NOT EXISTS
    (
        SELECT 1 FROM SYS.tables WHERE NAME = 'TMP_Persona'
    )
    BEGIN
        CREATE TABLE [dbo].[TMP_Persona](
            persona_id INT NOT NULL IDENTITY(1,1),
            persona_dni INT NOT NULL,
            persona_nombre VARCHAR(200) NOT NULL,
            persona_apellido VARCHAR(100) NOT NULL,
            persona_edad TINYINT NOT NULL,
            persona_direccion VARCHAR(255) NULL,
            persona_telefono VARCHAR(50) NULL,
            CONSTRAINT [PK_TMP_Persona] PRIMARY KEY CLUSTERED 
            (
                Persona_id ASC
            )
        ) ON [PRIMARY]
    END

	INSERT INTO [dbo].[TMP_Persona] (persona_dni, persona_nombre, persona_apellido, persona_edad, persona_direccion, persona_telefono)
    VALUES (24233522, 'Jose', 'Suarez', 35, NULL, '1523252356'),
    (25443251, 'Maria', 'Gutierrez', 45, 'Moldes 3052 8 f', NULL),
    (28332258, 'Esteban', 'Martiniano', 32, NULL, NULL),
    (26421126, 'Ramiro', 'Benitez', 42, NULL, NULL),
    (5665221, 'Carlos', 'Hernandez', 78, NULL, NULL),
    (5643246, 'Mercedez', 'Gonzalez', 76, NULL, NULL)
    GO
    --b) TABLA: TMP_Tabla_Prueba
    IF NOT EXISTS
    (
        SELECT 1 FROM SYS.tables WHERE NAME = 'TMP_Tabla_Prueba'
    )
    BEGIN
        CREATE TABLE [dbo].[TMP_Tabla_Prueba](
            id INT NOT NULL IDENTITY(1,1),
            nombre VARCHAR(200) NOT NULL,
            CONSTRAINT [PK_TMP_Tabla_Prueba] PRIMARY KEY CLUSTERED 
            (
                id ASC
            )
        ) ON [PRIMARY]
    END
    
 
--2) ******************DROP TABLE***********************************
    --TABLA: TMP_Tabla_Prueba
    IF EXISTS
    (
    SELECT 1 FROM SYS.tables WHERE NAME = 'TMP_Tabla_Prueba'
    )
    BEGIN
        DROP TABLE TMP_Tabla_Prueba
    END

--3) ******************ALTER TABLE***********************************
    --a) AGREGAR COLUMNA
    IF NOT EXISTS (
        SELECT TOP 1 1
        FROM sys.columns 
        WHERE object_id = OBJECT_ID(N'TMP_Persona') 
        AND name = 'persona_correo'
    )
    BEGIN
        ALTER TABLE TMP_Persona
        ADD persona_correo VARCHAR(20)
    END
    
    --MODIFICAR COLUMNA
    IF EXISTS (
    SELECT TOP 1 1
    FROM sys.columns 
    WHERE object_id = OBJECT_ID(N'TMP_Persona') 
    AND name = 'persona_correo'
    )
    BEGIN
        ALTER TABLE TMP_Persona
        ALTER COLUMN persona_correo VARCHAR(30)
    END
    
    --ELIMINAR COLUMNA
    IF EXISTS (
        SELECT TOP 1 1
        FROM sys.columns 
        WHERE object_id = OBJECT_ID(N'TMP_Persona') 
        AND name = 'persona_correo'
    )
    BEGIN
        ALTER TABLE TMP_Persona
        DROP COLUMN persona_correo
    END

--4) ******************CREATE VIEW***********************************
    IF EXISTS
    (
        SELECT *
        FROM sys.views WHERE name = 'VW_TMP_Persona' AND type = 'v'
    )
        DROP VIEW [dbo].[VW_TMP_Persona];
    GO
    
    CREATE VIEW [dbo].[VW_TMP_Persona] 
    AS
    SELECT persona_id, persona_dni, persona_nombre, persona_apellido
    FROM [TMP_Persona]
    where persona_id > 3

	select * from [dbo].[VW_TMP_Persona] 
--5) ******************DROP VIEW***********************************
    IF EXISTS
    (
        SELECT *
        FROM sys.views WHERE name = 'VW_TMP_Persona' AND type = 'v'
    )
        DROP VIEW [dbo].[VW_TMP_Persona];
    GO

--6) ******************CREATE INDEX***********************************
	SELECT * FROM TMP_Persona
    IF NOT EXISTS ( 
        SELECT * 
        FROM sys.indexes 
        WHERE name='IX_TMP_Persona' AND object_id = OBJECT_ID('TMP_Persona') 
    ) 
    BEGIN 
        CREATE UNIQUE INDEX IX_TMP_Persona 
        ON TMP_Persona (persona_dni) 
    END

	--NO PERMITIRÁ AGREGAR QUE LOS DNI (persona_dni) SE REPITAN. 
	--EJ: intentar asignarle a la persona con id_persona = 5, el dni del id_persona = 6  --> NO DEBERIA PERMITIRLO
	UPDATE TMP_Persona
	SET persona_dni = '5643246'
	WHERE persona_id = 5

--7) ******************DROP INDEX***********************************

    IF EXISTS ( 
        SELECT * 
        FROM sys.indexes 
        WHERE name='IX_TMP_Persona' AND object_id = OBJECT_ID('TMP_Persona') 
    ) 
    BEGIN 
        DROP INDEX IX_TMP_Persona 
        ON TMP_Persona 
    END