USE DB_Educacion_IT
go
--1) IF .. ELSE

DECLARE @NOMBRE VARCHAR(50) = 'Juan'
DECLARE @EDAD INT = 42
DECLARE @MENSAJE VARCHAR(200) = 'Datos Incorrectos. Ingresar un nombre y una edad mayor a 0'
IF (
		ISNULL(@NOMBRE,'') <> '' AND ISNULL(@EDAD,0) > 0
	)
BEGIN
	SET @MENSAJE = 'Su nombre es ' + @NOMBRE + ' y tiene ' + CAST(@EDAD AS VARCHAR(20)) + ' años'
	SELECT @MENSAJE
END
ELSE
BEGIN
	SELECT @MENSAJE
END

--2) WHILE
DECLARE @NUM INT;
SET @NUM=0 ;
WHILE (@NUM <= 10)
BEGIN
	PRINT @NUM
	IF @NUM=7
	BEGIN
		SET @NUM=@NUM+1;
		PRINT 'ESPERO 5 SEGUNDOS'
		WAITFOR DELAY '00:00:05'
		CONTINUE;
	END
	-- Dos formas de salir forzando el while
	IF @NUM=8 GOTO mensaje;
	IF @NUM=9 BREAK;
	--
	SET @NUM=@NUM+1;
	
END
mensaje:
PRINT 'SALI DEL WHILE POR EL GOTO'

GO

declare @id INT = 0
DECLARE @NOMBRE VARCHAR(50)

WHILE (1 = 1)
BEGIN
	select top 1 
	@id = personId,
	@NOMBRE = personName
	from Person
	where personId > @id

	IF @@ROWCOUNT = 0
		BREAK

	select @id, @NOMBRE
	
END