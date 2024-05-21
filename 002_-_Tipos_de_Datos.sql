/*
--***********************************************************
--                  TIPOS DE DATOS
--***********************************************************
*/

--1)*************** GRUPO: NUMERICO**************************
	--A) BIGINT (8 BYTES)
		DECLARE @NUM BIGINT = 9223372036854775807
		SELECT @NUM
    
	--B) INT (4 BYTES)
		DECLARE @NUM1 INT = 2147483647
		SELECT @NUM1
    
	--C) SMALLINT (2 BYTES)
		DECLARE @NUM2 SMALLINT = 32767
		SELECT @NUM2
    
	--D) TINYINT (1 BYTE)
		DECLARE @NUM3 TINYINT = 255
		SELECT @NUM3

	--E) NUMERIC | DECIMAL
	/*
	--EXPLICACIÓN: 
	LOS TIPOS DE DATOS NUMERIC y DECIMAL: Permiten definir una cantidad fija de dígitos (=precisión) para la parte entera y la parte decimal 
	(su parte decimal siempre debe ser exacta)
					
	PRECISIÓN	        NUMERIC ALMACENADO COMO		DECIMAL	ALMACENADO COMO			
	1 a 4 digitos	    SMALLINT (2 BYTES)			INTEGER (4 BYTES)
	5 a 9 digitos	    INTEGER  (4 BYTES)			INTEGER (4 BYTES)
	10 a 18 digitos	    BIGINT   (8 BYTES)			BIGINT  (8 BYTES)
	*/

	--4 DIGITOS: 2 ENTEROS + 2 DECIMALES
	DECLARE @NUM4 NUMERIC(4,2) = 11.22 
	SELECT @NUM4

	--SI CANTIDAD DE DECIMALES > 2 --> SE REDONDEA EL VALOR, PARA SIEMPRE TENER 2 DECIMALES
	DECLARE @NUM5 NUMERIC(4,2) = 11.228 
	SELECT @NUM5

	--SI CANTIDAD DE NROS ENTEROS > 2 --> DARA ERROR PORQUE NO PUEDE MOSTRAR 2 DIGITOS DECIMALES
	DECLARE @NUM6 NUMERIC(4,2) = 111.22
	SELECT @NUM6

	--1 DIGITO ENTERO SIN DECIMAL
	DECLARE @NUM9 Numeric(1,0) = 5
	SELECT @NUM9

	--1 DIGITO DECIMAL (LA PARTE ENTERA SIEMPRE SERA 0)
	DECLARE @NUM10 NUMERIC(1,1)=0.3
	SELECT @NUM10

	--F) SMALLMONEY (4 BYTES) | MONEY (8 BYTES)
	/*
	--EXPLICACIÓN:
	EL TIPO DE DATO SMALLMONEY: puede tener hasta 10 dígitos y solo 4 de ellos puede ir luego del separador decimal.
	EL TIPO DE DATO MONEY: puede tener hasta 19 dígitos y solo 4 de ellos puede ir luego del separador decimal.
	*/

	--10 DIGITOS: 6 ENTEROS + 4 DECIMALES
	DECLARE @NUM20 SMALLMONEY = 111111.2222 
	SELECT @NUM20

	--SI CANTIDAD DE DECIMALES > 4 --> SE REDONDEA EL VALOR, PARA SIEMPRE TENER 4 DECIMALES
	DECLARE @NUM21 SMALLMONEY = 111111.222298
	SELECT @NUM21

	--SI CANTIDAD DE NROS ENTEROS > 6 --> DARA ERROR PORQUE NO PUEDE MOSTRAR 4 DIGITOS DECIMALES
	DECLARE @NUM22 SMALLMONEY = 1111117.22
	SELECT @NUM22

    --19 DIGITOS: 15 ENTEROS + 4 DECIMALES
	DECLARE @NUM30 MONEY = 111111111111111.2222 
	SELECT @NUM30

	--SI CANTIDAD DE DECIMALES > 4 --> SE REDONDEA EL VALOR, PARA SIEMPRE TENER 4 DECIMALES
	DECLARE @NUM31 MONEY = 111111111111111.222298
	SELECT @NUM31

	--SI CANTIDAD DE NROS ENTEROS > 6 --> DARA ERROR PORQUE NO PUEDE MOSTRAR 4 DIGITOS DECIMALES
	DECLARE @NUM32 MONEY = 1111111111111119.2222 
	SELECT @NUM32

	--G) BIT
	/*
	--EXPLICACIÓN:
	EL TIPO DE DATO BIT: solo acepta los siguientes valores: 1, 0 o NUL
	*/
	DECLARE @Flag1 BIT = 1
	DECLARE @Flag2 BIT = 0
	DECLARE @Flag3 BIT = NULL
	SELECT Flag1 = @Flag1, Flag2 = @Flag2, Flag3 = @Flag3

	--H) FLOAT / REAL
	/*
	--EXPLICACIÓN: 
	EL TIPO DE DATO FLOAT(24) O REAL: se utilizan para almacenar valores numéricos con decimales hasta un nivel de precisión de 7 dígitos totales (enteros + decimales)
	EL TIPO DE DATO FLOAT(53) O FLOAT: se utilizan para almacenar valores numéricos con decimales, hasta un nivel de precisión de 15 dígitos totales (enteros + decimales)

	 TIPO PRECISIÓN      VALOR 	    PRECISIÓN	    ALMACENADO COMO		TIPO DE DATO
									NUM
		 Single          1-24	    7 digitos	    4 bytes				FLOAT(24) O REAL
		 Double          25-53	    15 digitos	    8 bytes				FLOAT(53) O FLOAT
	*/

	--I) SIMPLE PRECICION: FLOAT(24) O REAL 
	--A) observar que hasta 7 digitos no redondea
	declare @p float(24) = 45.12345
	select @p

	declare @p1 REAL = 45.12345
	select @p1

	--B) Si agrego mas de 7 digitos, se redondea
	declare @p8 float(24) = 45.123457
	select @p8

	declare @p7 REAL = 45.123457
	select @p7


	--II) DOBLE PRECISION: FLOAT O FLOAT(53)

	--A) observar que hasta 15 digitos no redondea
	declare @p3 float(53) = 45.1234569952136
	select @p3

	declare @p4 float = 45.1234569952136
	select @p4

	--B) Si agrego mas de 15 digitos, se redondea
	declare @p5 float(53) = 45.12345699521369
	select @p5

	declare @p6 float = 45.12345699521369
	select @p6
        
--2)*************** GRUPO: FECHA Y HORA**********************
    --A) DATE (3 BYTES)
        /*
        EXPLICACIÓN:
        El tipo de dato DATE: siempre retorna una fecha con el siguiente formato: yyyy-mm-dd 
        */
        declare @now date 
        SET @now = '2021-09-01 15:35:23.000'
        select @now
    
    --B) DATETIME (8 BYTES)
        /*
        EXPLICACIÓN:
        El tipo de dato DATETIME: siempre retorna una fecha y hora. Rango horario de 24 hs: de 00:00:00 a 23:59:59.997
        */
        declare @now1 datetime
        SET @now1 = '2021-09-01 23:59:59.997'
        select @now1
    
    --C) SMALLDATETIME (4 BYTES)
        /*
        EXPLICACIÓN:
        Define una fecha que se combina con una hora del día. La hora está en un formato de día de 24 horas, y llega a nivel de minuto (redondeando)
        */
        declare @now2 smalldatetime
        SET @now2 = '2021-09-01 23:55:33'
        select @now2
    
    --D) TIME (5 BYTE)
        /*
        EXPLICACION:
        Define una hora de un día. La hora no distingue la zona horaria y está basada en un reloj de 24 horas.
        (rango: de 00:00:00.000 a 23:59:59.999)
        
        --time(n) --> "n" (acepta valores de 0 a 7), y especifica el número de dígitos para la parte fraccionaria de segundos
        */
        
        --time(0) no muestra fraccion de segundos
        DECLARE @hora time(0) = getdate()
        select @hora
        
        --time(1) muestra 1 digito de la fraccion de segundos
        DECLARE @hora1 time(1) = getdate()
        select @hora1
        
        --time(2) muestra 2 digito de la fraccion de segundos
        DECLARE @hora2 time(2) = getdate()
        select @hora2
        
        --time(3) muestra 3 digito de la fraccion de segundos
        DECLARE @hora3 time(3) = getdate()
        select @hora3
        
        --time(7) muestra 7 digito de la fraccion de segundos
        DECLARE @hora7 time(7) = getdate()
        select @hora7
        
        
--3)*************** GRUPO: CADENA DE CARACTERES**************

    A) CHAR
        /*
        EXPLICACIÓN:
        El tipo de dato CHAR, define datos de cadena de tamaño fijo
        
        Char(n) --> n define el tamaño de la cadena en bytes (“n” debe ser un valor entre 1 y 8000)
        */
        DECLARE @str CHAR(5) = 'Estimados hablemos'
        select @str
    
    B) VARCHAR    
        /*
        EXPLICACIÓN:
        El tipo de dato VARCHAR, define datos de cadena de tamaño variable
        
        VARCHAR(n) --> n define el tamaño de la cadena en bytes (“n” debe ser un valor entre 1 y 8000)
        VARCHAR(MAX) --> max soporta un tamaño de cadena hasta 2 GB
        */
        
        DECLARE @str1 VARCHAR(MAX) = 'Estimados esto es una prueba y soporta hasta 2 GB de texto'
        select @str1
    
    C) NCHAR
        /*
        EXPLICACIÓN:
        El tipo de dato NCHAR, define datos de cadena de tamaño fijo
        
        NCHAR(n) --> n define el tamaño de la cadena en bytes (“n” debe ser un valor entre 1 y 4000)
        */
        DECLARE @str2 NCHAR(5) = 'Estimados hablemos'
        select @str2
    
    D) NVARCHAR    
        /*
        EXPLICACIÓN:
        El tipo de dato VARCHAR, define datos de cadena de tamaño variable
        
        NVARCHAR(n) --> n define el tamaño de la cadena en bytes (“n” debe ser un valor entre 1 y 4000)
        NVARCHAR(MAX) --> max soporta un tamaño de cadena hasta 2 GB
        */
        
        DECLARE @str3 NVARCHAR(MAX) = 'Estimados esto es una prueba y soporta hasta 2 GB de texto'
        select @str3