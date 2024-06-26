USE DB_Educacion_IT
go
--CREO ESTRUCTURA DE TABLAS A UTILIZAR
IF OBJECT_ID('dbo.ALUMNO') IS NOT NULL
	DROP TABLE dbo.ALUMNO
go
CREATE TABLE dbo.ALUMNO
(
id INT NOT NULL,
nombre VARCHAR(50)
)
go
IF OBJECT_ID('dbo.MATERIA') IS NOT NULL
	DROP TABLE dbo.MATERIA

CREATE TABLE dbo.MATERIA
(
id INT NOT NULL,
descripcion VARCHAR(30)
)
GO

--CREO EJEMPLO TRANSACCION SAVE TRANSACTION
BEGIN TRAN altas
DECLARE @TranCounter INT = 0
BEGIN TRY
	--INSERTO ALUMNO
	INSERT INTO dbo.ALUMNO (id, nombre)
	VALUES(1,'Juan Perez')

	SAVE TRAN PuntoSaveAlumno

	SET @TranCounter = 1
	
	--error provocado
	select 1/0

	--INSERTO MATERIA
	INSERT INTO dbo.MATERIA (id, descripcion)
	VALUES (30,'Matematica')

	COMMIT TRAN altas
END TRY
BEGIN CATCH
	IF @TranCounter = 0
	BEGIN
		ROLLBACK TRAN;
	END
	ELSE
	BEGIN
		ROLLBACK TRAN PuntoSaveAlumno
		COMMIT TRAN altas
	END
END CATCH
--SELECT * FROM ALUMNO
--SELECT * FROM MATERIA