USE DB_Educacion_IT
GO
IF NOT EXISTS
(
	SELECT TOP 1 1 FROM SYS.TABLES WHERE NAME = 'Tmp_Ejemplo_Transaccion'
)
BEGIN
	CREATE TABLE Tmp_Ejemplo_Transaccion
	(
		nombre VARCHAR(50) NOT NULL
	)
END
ELSE
	TRUNCATE TABLE Tmp_Ejemplo_Transaccion
GO
--MUESTRO TABLA ANTES DE LA TRANSACCION
SELECT * FROM Tmp_Ejemplo_Transaccion


--DECLARACION DE VARIABLES PARA RAISERROR 
DECLARE @V_Message NVARCHAR(2048)
DECLARE @V_Error_Number INT
DECLARE @V_Severity INT
DECLARE @V_State INT
DECLARE @V_Error_Line INT
DECLARE @V_Error_Procedure VARCHAR(128)

/*Cuando SET XACT_ABORT está en ON, si una instrucción sql genera un error en tiempo de ejecución, toda la transacción se revierte*/
/*Cuando SET IMPLICIT_TRANSACTIONS OFF; significa que trabajamos con transacciones explicitas*/
SET IMPLICIT_TRANSACTIONS OFF;
SET XACT_ABORT ON
BEGIN TRY
      BEGIN TRANSACTION;
		  --INSERTO datos en la tabla
		  INSERT INTO Tmp_Ejemplo_Transaccion  (nombre) values ('Emiliano')
		  
		  --MODIFICO DATOS EN LA TABLA
		  UPDATE Tmp_Ejemplo_Transaccion
		  SET nombre = 'Juan'
		  WHERE nombre = 'Emiliano'

		  --genero un error
		  select 1/0
      COMMIT TRANSACTION; --para confirmar transaccion 
END TRY
BEGIN CATCH
	 --verifico si hay un error 
     IF @@TRANCOUNT > 0
	 BEGIN
           --Deshacer la transacción
		   ROLLBACK TRANSACTION;
	 END
	 --obtengo mensajes de error
	 SET @V_Message = ERROR_MESSAGE();
	 SET @V_Error_Number = ERROR_NUMBER();
	 SET @V_Severity = ERROR_SEVERITY();
	 SET @V_State = ERROR_STATE();
	 SET @V_Error_Line = ERROR_LINE();
	 SET @V_Error_Procedure = ERROR_PROCEDURE();
	 
	 select 
	 V_Message = @V_Message, 
	 V_Severity = @V_Severity, 
	 V_State = @V_State, 
	 V_Error_Number = @V_Error_Number, 
	 V_Error_Procedure = @V_Error_Procedure
END CATCH
SET XACT_ABORT OFF

--MUESTRO TABLA despues DE LA TRANSACCION
SELECT * FROM Tmp_Ejemplo_Transaccion