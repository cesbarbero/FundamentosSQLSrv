--***********************************************************************
--CASO 1: ESTRUCTURA SIMPLE CURSOR
--***********************************************************************
use DB_Educacion_IT
GO
--1) Declaramos el cursor y le indicamos sobre que consulta va a trabajar
DECLARE Cursor_Visitantes CURSOR GLOBAL FORWARD_ONLY 
FOR
select * from dbo.TMP_Visitantes

--2) ABRIMOS EL CURSOR EN MEMORIA
OPEN Cursor_Visitantes

--3) RECORREMOS EL CURSOR UTILIZANDO DISTINTAS INSTRUCCIONES: 
--USANDO FETCH NEXT (muestra fila por fila, la consulta cargada en el cursor. Siempre hacia adelante)
FETCH NEXT FROM Cursor_Visitantes

--4) CERRAMOS EL CURSOR (pero el cursor sigue en memoria. Podría volver a ejecutar el paso 2)
Close Cursor_Visitantes

--5) SACO EL CURSOR DE MEMORIA RAM
DEALLOCATE Cursor_Visitantes


------------------------------------
GO

--***********************************************************************
--CASO 2: ESTRUCTURA SIMPLE CURSOR CON SCROLL 
--***********************************************************************
use DB_Educacion_IT
GO
--1) Declaramos el cursor y le indicamos sobre que consulta va a trabajar
DECLARE Cursor_Visitantes CURSOR GLOBAL SCROLL
FOR
select * from dbo.TMP_Visitantes

--2) ABRIMOS EL CURSOR EN MEMORIA
OPEN Cursor_Visitantes

--3) RECORREMOS EL CURSOR UTILIZANDO DISTINTAS INSTRUCCIONES: 
--USANDO FETCH NEXT (muestra fila por fila, la consulta cargada en el cursor. Siempre hacia adelante)
FETCH NEXT FROM Cursor_Visitantes
--VOLVER HACIA ATRAS DE A UN REGISTRO
FETCH PRIOR FROM Cursor_Visitantes
--IR AL PRIMER REGISTRO
FETCH FIRST FROM Cursor_Visitantes
--IR AL ULTIMO REGISTRO
FETCH LAST FROM Cursor_Visitantes

--4) CERRAMOS EL CURSOR (pero el cursor sigue en memoria. Podría volver a ejecutar el paso 2)
Close Cursor_Visitantes

--5) SACO EL CURSOR DE MEMORIA RAM
DEALLOCATE Cursor_Visitantes


------------------------------------
GO



--***********************************************************************
----CASO 3: EJEMPLO CURSOR - RECORRER REGISTROS
--***********************************************************************

--DECLARO VARIABLES PARA RECORRER EL CURSOR
DECLARE @ID_VISITANTE INT
DECLARE @NOMBRE VARCHAR(50)
DECLARE @EDAD SMALLINT

--1) Declaramos el cursor y le indicamos sobre que consulta va a trabajar
DECLARE Cursor_Visitantes CURSOR GLOBAL FORWARD_ONLY 
FOR
select id_visitante, nombre, edad from dbo.TMP_Visitantes

--2) ABRIMOS EL CURSOR EN MEMORIA
OPEN Cursor_Visitantes

--3) RECORREMOS EL CURSOR USANDO FETCH (muestra fila por fila, la consulta cargada en el cursor. Siempre hacia adelante)
--y cargamos los datos en las variables
FETCH NEXT FROM Cursor_Visitantes INTO @ID_VISITANTE, @NOMBRE, @EDAD

WHILE (@@FETCH_STATUS = 0) --Devuleve 0 si FETCH se ejecuto correctamente, -1 si hubo un error
BEGIN
	PRINT CAST(@ID_VISITANTE AS VARCHAR) + ' ' + @NOMBRE + ' ' + CAST(@EDAD AS VARCHAR)
	--BUSCO EL SIGUIENTE REGISTRO
	FETCH NEXT FROM Cursor_Visitantes INTO @ID_VISITANTE, @NOMBRE, @EDAD
END
--4) CERRAMOS EL CURSOR (pero el cursor sigue en memoria. Podría volver a ejecutar el paso 2)
Close Cursor_Visitantes

--5) SACO EL CURSOR DE MEMORIA RAM
DEALLOCATE Cursor_Visitantes

GO
------------------------------------
GO



--***********************************************************************
----CASO 4: EJEMPLO CURSOR - ACTUALIZAR DATOS
--***********************************************************************
--DECLARO VARIABLES PARA RECORRER EL CURSOR
DECLARE @ID_VISITANTE INT
DECLARE @NOMBRE VARCHAR(50)
DECLARE @EDAD SMALLINT

--1) Declaramos el cursor y le indicamos sobre que consulta va a trabajar
DECLARE Cursor_Visitantes CURSOR GLOBAL FORWARD_ONLY
FOR
select id_visitante, nombre, edad from dbo.TMP_Visitantes 
FOR UPDATE

--2) ABRIMOS EL CURSOR EN MEMORIA
OPEN Cursor_Visitantes

--3) RECORREMOS EL CURSOR USANDO FETCH (muestra fila por fila, la consulta cargada en el cursor. Siempre hacia adelante)
--y cargamos los datos en las variables
FETCH NEXT FROM  Cursor_Visitantes INTO @ID_VISITANTE, @NOMBRE, @EDAD

WHILE (@@FETCH_STATUS = 0) --Devuleve 0 si FETCH se ejecuto correctamente, -1 si no se ejecuto correctamente y  -2 si hubo un error en la fila recuperada
BEGIN
	--ACTUALIZO LA TABLA
	UPDATE dbo.TMP_Visitantes 
	SET domicilio = 'Id ' + CAST(@ID_VISITANTE AS VARCHAR) + ' - ' + domicilio
	WHERE current of Cursor_Visitantes
	
	--BUSCO EL SIGUIENTE REGISTRO
	FETCH NEXT FROM  Cursor_Visitantes INTO @ID_VISITANTE, @NOMBRE, @EDAD
END
--4) CERRAMOS EL CURSOR (pero el cursor sigue en memoria. Podría volver a ejecutar el paso 2)
Close Cursor_Visitantes

--5) SACO EL CURSOR DE MEMORIA RAM
DEALLOCATE Cursor_Visitantes


