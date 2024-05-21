use DB_Educacion_IT
GO
/*
--************************ FUNCIONES INTEGRADAS ****************************
*/
--1) FUNCIONES MATEMATICAS

--A) SIGN:	DEVUELVE "-1" SI ES NEGATIVO 
--		DEVULEV "1" SI ES POSITIVO
--		DEVULEV "0" SI ES 0
SELECT NEGATIVO = SIGN(-5), POSITIVO = SIGN(5), CERO = SIGN(0)

--B) FLOOR:	REDONDEA UN NUMERO HACIA ABAJO HASTA EL PROXIMO NUMERO ENTERO
SELECT FLOOR(10.9), FLOOR(-10.1)


--2) FUNCIONES DE FECHA

--A) DATENAME: devuelve una cadena de caracteres que representa el parametro datepart especificado (ej:month, weekday)
SELECT 
MES_ACTUAL = DATENAME(month,getdate()), 
DIA_DE_HOY = DATENAME(WEEKDAY,getdate())

--B) DATEPART: Permite obtener partes de una fecha
SELECT 
AÑO_ACTUAL = DATEPART(year, getdate()), 
MES_ACTUAL = DATEPART(month, getdate()), 
DIA_ACTUAL = DATEPART(day, getdate()),
HORA_ACTUAL = DATEPART(HOUR, getdate())

--C) DAY, MONTH, YEAR
SELECT
AÑO_ACTUAL = DAY(getdate()), 
MES_ACTUAL = MONTH(getdate()), 
DIA_ACTUAL = YEAR(getdate())

--D) GETDATE: FUNCION QUE DEVUELVE EL DIA Y LA HORA ACTUAL
SELECT GETDATE()


--E) DATEDIFF: se utiliza paqra calcular la diferencia entre dos fechas
SELECT 
DIF_AÑO = DATEDIFF(YEAR, '2022-01-01', '2024-12-31'),
DIF_MESES = DATEDIFF(MONTH, '2022-01-01', '2024-01-01')

SELECT 
DIF_HS = DATEDIFF(HOUR, '2022-01-01 09:23:30', '2022-01-01 19:00:00')

--G) DATEADD: suma o resta un intervalo de tiempo a una fecha
SELECT 
HOY = GETDATE(), 
HOY_MAS_UN_DIA = DATEADD(day,1,GETDATE()), 
HOY_MENOS_DOS_AÑOS = DATEADD(year,-2,GETDATE())

--3) FUNCIONES DE TEXTO
--A) RIGHT: devuelve caracteres contando desde la parte derecha de una cadena
SELECT RIGHT('ES UN EJEMPLO',3)

--B) LEFT: devuelve caracteres contando desde la parte izquierda de una cadena
SELECT LEFT('ES UN EJEMPLO',6)

--C) SUBSTRING: Devuelve parte de una cadena
--DEVUELVO DESDE EL CARACTER 1 AL 10
SELECT SUBSTRING('ESTA ES UNA CADENA',1,10)

--D) CHARINDEX: VERIFICA SI UN TEXTO O CARACTER ESTA DENTRO DE UNA CADENA. Y DEVUELVE LA PRIMER POSICIÓN DONDE LA ENCONTRO
SELECT CHARINDEX('ALUMNOS', 'SALUDOS ALUMNOS COMO ESTAS')
SELECT CHARINDEX('A', 'SALUDOS ALUMNOS COMO ESTAS')

--E) REPLACE: Reemplaza un texto o caracter por otro, en una cadena
SELECT REPLACE('EMPLEADOS-2000','-',' ')
SELECT REPLACE('EMPLEADOS-2000','2000','2023')

--F) LEN: devuelve el numero de caracteres de una cadena (excluyendo espacios en blanco finales)
SELECT LEN('PRUEBA'), LEN('PRUEBA    ')

--G) LTRIM Y RTRIM: quita los espacios en blanco hacia la izquierda (LTRIM) o hacia la derecha (RTRIM)
DECLARE @MENSAJE VARCHAR(50) = '    FUNCIONA       '
SELECT TEXTO = @MENSAJE,					--'    FUNCIONA       '
TEXTO_SIN_ESPACIOS_IZQ = LTRIM(@MENSAJE),	--'FUNCIONA       '
TEXTO_SIN_ESPACIOS_DER = RTRIM(@MENSAJE)	--'    FUNCIONA'

--H) UPPER, LOWER: Convierte un texto a mayuscula o minuscula
SELECT mayuscula = UPPER('hola'), minuscula = LOWER('ToDo BieNNN')

/*
--************************ FUNCIONES ESCALARES ****************************
*/
--1) DEFINICION: funcion que recibe dos paramtros, y los devuelve en mayúscula y separados por coma
USE DB_Educacion_IT
GO
IF EXISTS
(
	SELECT TOP 1 
	O.[name], m.[definition], o.[type]
	FROM sys.sql_modules AS m
	JOIN sys.objects AS o ON m.object_id = o.object_id
	AND type IN ('FN', 'IF', 'TF')
	AND o.[name] = 'EnMayusculas'
)
	DROP FUNCTION dbo.EnMayusculas
GO
CREATE FUNCTION EnMayusculas
(
@Nombre Varchar(50),
@Apellido Varchar(50)
)
RETURNS Varchar(100)
AS
BEGIN
    RETURN (UPPER(@Apellido) + ', ' + UPPER(@Nombre))
END
go
--EJECUCION
Print dbo.EnMayusculas('damian','ruiz')
go
select dbo.EnMayusculas('damian','ruiz')


--2) AVG: CALCULA EL PROMEDIO DE UN GRUPO DE NUMEROS, PERO EXCLUYE LOS NULOS
DECLARE @TMP_PRUEBA TABLE
(
num int
)
INSERT INTO @TMP_PRUEBA VALUES (10),(8),(NULL)

SELECT * FROM @TMP_PRUEBA

select AVG(NUM)
FROM @TMP_PRUEBA


/*
--************************  FUNCIONES CON VALOR DE TABLA ****************************
*/
--CREO UNA TABLA QUE SERVIRA PARA EL EJEMPLO
USE DB_Educacion_IT
GO
IF EXISTS
(
	SELECT TOP 1 1 FROM SYS.TABLES WHERE [NAME] ='Personas_Fun'
)
	DROP TABLE Personas_Fun
GO
CREATE TABLE Personas_Fun(
    PersId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    PersNombre nvarchar(80) NOT NULL,
    PersFecNacimiento datetime NULL,
    PersActiv bit NOT NULL
)

INSERT INTO Personas_Fun VALUES ('angelica','1991-02-14',1)
INSERT INTO Personas_Fun VALUES ('braulio','1985-12-25',1)
INSERT INTO Personas_Fun VALUES ('carlos','1995-05-04',1)

--A) CREO UNA FUNCION QUE RETORNA UNA TABLA
IF EXISTS
(
	SELECT TOP 1 
	O.[name], m.[definition], o.[type]
	FROM sys.sql_modules AS m
	JOIN sys.objects AS o ON m.object_id = o.object_id
	AND type IN ('FN', 'IF', 'TF')
	AND o.[name] = 'ListaEmpleado'
)
	DROP FUNCTION dbo.ListaEmpleado
GO
--CREO LA FUNCION
CREATE Function ListaEmpleado(@IdEmpleado int)
Returns Table
AS
    Return 
	(
		Select Nombre = PersNombre, 
		PersFecNacimiento, 
		PersActiv
		From Personas_Fun WHERE PersId = @IdEmpleado
	)
go

--EJECUTO FUNCION
Select * From dbo.ListaEmpleado(1)
Select * From dbo.ListaEmpleado(2)


--B) CREO OTRA FUNCIÓN DEFINIENDO LA TABLA
IF EXISTS
(
	SELECT TOP 1 
	O.[name], m.[definition], o.[type]
	FROM sys.sql_modules AS m
	JOIN sys.objects AS o ON m.object_id = o.object_id
	AND type IN ('FN', 'IF', 'TF')
	AND o.[name] = 'ListarSoloNombres'
)
	DROP FUNCTION dbo.ListarSoloNombres
GO
--CREO LA FUNCION
CREATE Function ListarSoloNombres(@IdEmpleado int)
Returns @tmp_nombres TABLE(id_empleado int, Nombre nvarchar(80) NOT NULL)
AS
BEGIN
    INSERT INTO @tmp_nombres
    SELECT PersId, PersNombre
    FROM dbo.Personas_Fun
    WHERE PersId = @IdEmpleado
    
    return
END

go
--ejecuto funcion
SELECT * FROM  ListarSoloNombres(2)