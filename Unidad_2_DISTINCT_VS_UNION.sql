USE DB_Educacion_IT
GO
--1) ***********DISTINCT****************
DECLARE @NUMEROS_ALEATORIOS TABLE
(
valor INT
)

INSERT INTO @NUMEROS_ALEATORIOS (valor)
VALUES(10),(20),(10),(15),(20),(8),(9),(8)

--SELECT 'TABLA @NUMEROS_ALEATORIOS: LISTA COMPLETA'
SELECT valor FROM @NUMEROS_ALEATORIOS order by valor

--SELECT 'TABLA @NUMEROS_ALEATORIOS: DISTINCT'
SELECT DISTINCT valor FROM @NUMEROS_ALEATORIOS order by valor

------------------------------------------------------------------------------------

--2) ***********UNION****************
DECLARE @PERSONA_EMPRESA_1 TABLE
(
id_persona INT NOT NULL IDENTITY(1,1),
nombre_1 VARCHAR(50) NOT NULL,
apellido_1 VARCHAR(30) NOT NULL
)

DECLARE @PERSONA_EMPRESA_2 TABLE
(
id_persona INT NOT NULL IDENTITY(1,1),
nombre_per VARCHAR(50) NOT NULL,
apellido_per VARCHAR(30) NOT NULL,
edad SMALLINT NOT NULL
)

--INSERTO REGISTROS EN @PERSONA_EMPRESA_1
INSERT INTO @PERSONA_EMPRESA_1(nombre_1, apellido_1)
VALUES('ANTONIO','PEREZ'),
('ANTONIO','GARCIA'),
('PEDRO','RUIZ'),
('LEO','MESSI')

--INSERTO REGISTROS EN @PERSONA_EMPRESA_2
INSERT INTO @PERSONA_EMPRESA_2(nombre_per, apellido_per,edad)
VALUES('JUAN','APARICIO',52),
('ANTONIO','GARCIA',41),
('LUIS','LOPEZ',26)


SELECT 'UNION: EXCLUYE DUPLICADOS'
SELECT
nombre = nombre_1,
apellido = apellido_1
FROM @PERSONA_EMPRESA_1
UNION
SELECT
nombre = nombre_per,
apellido = apellido_per
FROM @PERSONA_EMPRESA_2
ORDER BY 1,2

SELECT 'UNION ALL: INCLUYE DUPLICADOS'
SELECT
nombre = nombre_1,
apellido = apellido_1
FROM @PERSONA_EMPRESA_1
UNION ALL
SELECT
nombre = nombre_per,
apellido = apellido_per
FROM @PERSONA_EMPRESA_2
ORDER BY 1,2