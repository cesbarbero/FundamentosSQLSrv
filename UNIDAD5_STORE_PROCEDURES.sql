USE DB_Educacion_IT
GO
--****************************************
-- EJEMPLO STORE EXTENDIDOS
--******************************************
--ELIMINO Y CREO UNA CARPETA DESDE SQL SERVER
/*
Explicación:
RMDIR [/S] [/Q] [<unidad>:]<ruta>
<unidad>:	Especifica la unidad (A:, B:, C:, D:...) de disco.
<ruta>	Especifica la ruta (camino) del directorio.
/S	Quita (elimina) todos los directorios y archivos contenidos en el directorio especificado, además de eliminar dicho directorio.
/Q	No pide confirmación a la hora de eliminar (quitar) un árbol de directorios con /S.
*/
DECLARE @cmd_create nvarchar(500)
DECLARE @cmd_del nvarchar(500)
DECLARE @folderName varchar(100) = 'PRUEBA_20230118'
SET @cmd_del = 'rmdir C:\F\' + @folderName + ' /S /Q'
SET @cmd_create = 'mkdir C:\F\' + @folderName

--elimina la carpeta si existe
EXEC master..xp_cmdshell @cmd_del
--crea la carpeta
EXEC master..xp_cmdshell @cmd_create
--crear un archivo txt
exec master..xp_cmdshell 'echo hello > C:\F\PRUEBA_20230118\peoples.txt'
/*
--SI HAY UN ERROR, DEBE EJECUTARSE LO SIGUIENTE:(PARA HABILITAR LOS PERMISOS)

EXEC sp_configure 'show advanced options', '1'
RECONFIGURE
-- this enables xp_cmdshell
EXEC sp_configure 'xp_cmdshell', '1' 
RECONFIGURE

*/


--****************************************
-- EJEMPLO STORE DE SISTEMA
--******************************************

SP_DATABASES
sp_columns 'EMPRESA'
sp_tables 'EMPRESA'


--****************************************
-- EJEMPLO STORE DEFINIDOS POR EL USUARIO
--******************************************

--1) STORE QUE RETORNA TODOS LOS DATOS DE LA TABLA [DB_Educacion_IT].[dbo].[Visitantes]
IF OBJECT_ID('dbo.LISTAR_VISTANTES', 'P') IS NOT NULL
	DROP PROCEDURE dbo.LISTAR_VISTANTES
GO
CREATE PROCEDURE dbo.LISTAR_VISTANTES
AS
SELECT 
[id_visitante],
[nombre],
[edad],
[sexo],
[domicilio],
[ciudad],
[telefono],
[montocompra]
FROM [DB_Educacion_IT].[dbo].[Visitantes]
ORDER BY 1, 2
GO
EXEC dbo.LISTAR_VISTANTES

GO

----------------------------------------------------------------------------------------------------------------------------------------------------

 --2) STORE QUE RETORNA TODOS LOS DATOS DE LA TABLA [DB_Educacion_IT].[dbo].[Visitantes], FILTRANDO POR NOMBRE, EDAD O ID_VISITANTE
IF OBJECT_ID('dbo.LISTAR_VISTANTES_FILTRO', 'P') IS NOT NULL
	DROP PROCEDURE dbo.LISTAR_VISTANTES_FILTRO
GO
CREATE PROCEDURE LISTAR_VISTANTES_FILTRO
(
--OBLIGATORIOS
@EDAD_DESDE INT,
@EDAD_HASTA INT,
--OPCIONALES
@ID INT = NULL,
@NOMBRE VARCHAR(50) = NULL
)
AS
BEGIN
	SELECT 
	[id_visitante],
	[nombre],
	[edad],
	[sexo],
	[domicilio],
	[ciudad],
	[telefono],
	[montocompra]
	FROM [DB_Educacion_IT].[dbo].[Visitantes]
	WHERE (@ID IS NULL OR [id_visitante] = @ID)
	AND (@NOMBRE IS NULL OR nombre like '%'+@NOMBRE+'%')
	AND edad BETWEEN @EDAD_DESDE AND @EDAD_HASTA
	ORDER BY 1, 2
END
GO
--OPCION 1:
EXEC LISTAR_VISTANTES_FILTRO 22, 50

--OPCION 2:
EXEC LISTAR_VISTANTES_FILTRO 22, 50, NULL, 'jo'

--OPCION 3:
EXEC LISTAR_VISTANTES_FILTRO 22, 50, 5, 'jo'

--OPCION 4:
EXEC LISTAR_VISTANTES_FILTRO 22, 50, 10



----------------------------------------------------------------------------------------------------------------------------------------------------

--3) STORE QUE FILTRA POR CIUDAD, Y RETORNA LA CANTIDAD DE VISITANTES EXISTENTES
IF OBJECT_ID('dbo.LISTAR_VISTANTES_FILTRO_CANTIDAD', 'P') IS NOT NULL
	DROP PROCEDURE dbo.LISTAR_VISTANTES_FILTRO_CANTIDAD
GO
CREATE PROCEDURE dbo.LISTAR_VISTANTES_FILTRO_CANTIDAD
(
@CIUDAD VARCHAR(50),
@TOTAL_REGISTROS INT OUTPUT
)
AS
BEGIN
	SELECT @TOTAL_REGISTROS = COUNT(id_visitante)
	FROM [DB_Educacion_IT].[dbo].[Visitantes]
	WHERE ciudad like '%' + @CIUDAD + '%'

	--SELECT @TOTAL_REGISTROS
END

GO
DECLARE @TOT_REG INT
EXEC dbo.LISTAR_VISTANTES_FILTRO_CANTIDAD 'CORD', @TOT_REG OUTPUT
--EXEC dbo.LISTAR_VISTANTES_FILTRO_CANTIDAD 'CORD', @TOTAL_REGISTROS = @TOT_REG OUTPUT
SELECT @TOT_REG
