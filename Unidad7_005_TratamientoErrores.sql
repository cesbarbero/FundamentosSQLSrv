--**********************************************
--@@ERROR
--**********************************************
--EJ1:
DECLARE @Error_code_1 INT
BEGIN TRY
	DECLARE @RESULT INT
	SET @RESULT = 1/0	
END TRY
BEGIN CATCH
	SELECT @Error_code_1 = @@ERROR
	SELECT Codigo_Error = @Error_code_1
	SELECT top 1 * FROM master.sys.sysmessages where error = @Error_code_1
END CATCH
GO
---------------------------------
--EJ2: 
DECLARE @Error_code_2 INT
BEGIN TRY
	DECLARE @TMP TABLE (ID INT)
	DECLARE @PRUEBA VARCHAR(50) = 'HOLA'
	INSERT INTO @TMP (ID) VALUES(@PRUEBA)
END TRY
BEGIN CATCH
	SELECT @Error_code_2 = @@ERROR
	SELECT Codigo_Error = @Error_code_2
	SELECT top 1 * FROM master.sys.sysmessages where error = @Error_code_2
END CATCH





--**********************************************
--THROW
--**********************************************
CREATE OR ALTER PROC dbo.Divide_Con_THROW
(
	@dividendo INT,
	@divisor INT
)
AS
SET NOCOUNT ON
DECLARE @RESULT AS INT
BEGIN TRY
	SET @RESULT = @dividendo / @divisor
	SELECT 'El resultado es ' + CAST(@RESULT AS VARCHAR(50))
END TRY
BEGIN CATCH
	PRINT 'ANTES ERROR';
	
	--opcion 1: SQL captura el error y lo muestra
	THROW;
	
	--Opcion2: Se puede agregar un mensaje propio: ESTRUCTURA THROW: CODIGO_ERROR, MENSAJE_ERROR Y CODIGO_ESTADO_ERROR 
	--                                                               (>50000)                       (de 0 a 255)
	--THROW 50001, 'No puede dividir por 0',1;
	
	PRINT 'DESPUES ERROR - No debería imprimirse';
END CATCH
GO
--EJEMPLO SIN ERROR
exec dbo.Divide_Con_THROW 10, 2
GO
--EJEMPLO CON ERROR (NO IMPRIME: 'DESPUES ERROR - No debería imprimirse'; )
exec dbo.Divide_Con_THROW 10, 0

GO

--CODIGOS DE ERROR_SEVERITY(): QUE SIGNIFICA CADA UNO EN EL SIGUIENTE LINK: "https://learn.microsoft.com/es-es/sql/relational-databases/errors-events/database-engine-error-severities?view=sql-server-ver16"
--**********************************************
--RAISERROR
--**********************************************
CREATE OR ALTER PROC dbo.Divide_Con_RAISERROR
(
	@dividendo INT,
	@divisor INT
)
AS
SET NOCOUNT ON
DECLARE @RESULT AS INT
BEGIN TRY
	SET @RESULT = @dividendo / @divisor
	SELECT 'El resultado es ' + CAST(@RESULT AS VARCHAR(50))
END TRY
BEGIN CATCH
	DECLARE @ErrMessage NVARCHAR(2048)
	DECLARE @ErrSeverity INT
	DECLARE @ErrState INT

	--capturo errores
	SELECT @ErrMessage = ERROR_MESSAGE(),
	@ErrSeverity = ERROR_SEVERITY(),
	@ErrState = ERROR_STATE()

	--Muestro error 
	PRINT 'ANTES ERROR';
	--opcion 1: SQL captura y muestra el error
	RAISERROR(@ErrMessage, @ErrSeverity, @ErrState)	
	
	--opcion 2: Se puede agregar un mensaje propio:: ESTRUCTURA RAISERROR: MENSAJE_ERROR,  CODIGO_SEVERITY,      CODIGO_ESTADO_ERROR)
	--                                                                       (>50000)     (GRAVEDAD DEL ERROR)   (de 0 a 255)
	--RAISERROR('50001 - No puede dividir por 0', 16, 1)	
	
	PRINT 'DESPUES ERROR - No debería imprimirse';
END CATCH
GO
--EJEMPLO SIN ERROR
exec dbo.Divide_Con_RAISERROR 10, 2
GO
--EJEMPLO CON ERROR (IMPRIME: 'DESPUES ERROR - No debería imprimirse'; )
exec dbo.Divide_Con_RAISERROR 10, 0
