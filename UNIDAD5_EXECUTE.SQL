USE DB_Educacion_IT
GO
--ejecutar store procedure sin parametros
EXEC( 'dbo.LISTAR_VISTANTES')

--ejecutar store procedure con parametro de input
EXEC ('LISTAR_VISTANTES_FILTRO 22, 50')


--ejecutar store procedure con parametro de ouput
EXEC('
DECLARE @TOT_REG INT  
EXEC dbo.LISTAR_VISTANTES_FILTRO_CANTIDAD ''CORD'', @TOT_REG OUTPUT
SELECT @TOT_REG
')

--EJECUTAR UN STORE DE SISTEMA
EXEC('sp_tables ''%EMPRE%''')

--HAGO UN SELECT A LA TABLA EMPRESA
EXEC('SELECT * FROM dbo.EMPRESA')
