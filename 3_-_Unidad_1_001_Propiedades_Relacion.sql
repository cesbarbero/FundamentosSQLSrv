--0) CREAR BASE DE DATOS
USE master
GO
DROP DATABASE DB_Educacion_IT
GO
CREATE DATABASE DB_Educacion_IT
GO

--1) GRADO: UNARIO
USE DB_Educacion_IT
GO
declare @empleado table
(
id_empleado int not null,
nombre varchar(50) not null,
id_empleado_supervisa int,
primary key(id_empleado)
)

insert into @empleado
(
id_empleado,
nombre,
id_empleado_supervisa
)
values(1,'Juan',null),
(2,'Jorge',1),
(3,'Maria',1),
(4,'Mariana',null)

select * from @empleado

--------------------------------------
--2) GRADO: BINARIO 
--CONDICIONALIDAD: Con Relación obligatoria
DECLARE @PAIS TABLE
(
id_pais int not null,
nombre varchar(50) not null,
primary key(id_pais)
)

insert into @PAIS(id_pais, nombre)
values(10,'Argentina'),
(11,'España')

DECLARE @PROVINCIA TABLE
(
id_provincia INT NOT NULL,
nombre varchar(50) not null,
id_pais INT NOT NULL,
PRIMARY KEY(id_provincia)
)

INSERT INTO @PROVINCIA(id_provincia, nombre, id_pais)
values(100,'CABA',10),
(101,'Mendoza',10),
(102,'Cordoba',10),
(200, 'Barcelona', 11),
(201, 'Madrid', 11)

select * from @PAIS
select * from @PROVINCIA


--CONDICIONALIDAD: Con Relación opcional (HAY Personas que pueden no tener coches, pero un coche siempre tiene una persona)
DECLARE @PERSONA TABLE
(
id_persona int not null,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY(id_persona)
)

DECLARE @COCHE TABLE
(
id_coche INT NOT NULL,
modelo VARCHAR(50) NOT NULL,
id_persona INT NOT NULL,
PRIMARY KEY(id_coche)
)

INSERT INTO @PERSONA (id_persona, nombre)
VALUES (10, 'Jose Altamira'),
(11, 'Maria Fernandez'),
(12, 'Mariano Moreno')

INSERT INTO @COCHE (id_coche, modelo, id_persona)
VALUES(100,'Ford Focus', 11)

select * from @PERSONA
select * from @COCHE



------------------------------------
--3) GRADO: TERNARIO
DECLARE @AULA TABLE
(
id_aula INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY(id_aula)
)

DECLARE @ALUMNO TABLE
(
id_alumno int not null,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(30) NOT NULL,
PRIMARY KEY(id_alumno)
)

DECLARE @PROFESOR TABLE
(
id_profesor INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(30) NOT NULL,
PRIMARY KEY(id_profesor)
)

DECLARE @CURSO TABLE
(
id_aula INT NOT NULL,
id_profesor INT NOT NULL,
id_alumno INT NOT NULL,
PRIMARY KEY(id_aula, id_profesor,id_alumno)
)

INSERT INTO @AULA (id_aula,nombre)
VALUES(1,'Aula Media'),
(2,'Aula Pequeña')

INSERT INTO @ALUMNO (id_alumno, nombre, apellido)
VALUES(10,'Jose', 'Perez'),
(11,'Andrea', 'Benitez'),
(12,'Marcelo', 'Jeremias'),
(13,'Graciela', 'Almiron'),
(14,'Sofia', 'Maidana'),
(15,'Pablo', 'Maidana')

INSERT INTO @PROFESOR(id_profesor, nombre, apellido)
VALUES (1,'Juan', 'Solano'),
(2,'Marcela', 'Palino')

INSERT INTO @CURSO(id_aula, id_profesor, id_alumno)
VALUES(1,1,11),
(1,1,12),
(1,1,13),
(2,2,14),
(2,2,15),
(2,2,11),
(1,2,15),
(2,1,10),
(2,1,13)

SELECT * FROM @AULA
SELECT * FROM @PROFESOR
SELECT * FROM @ALUMNO
SELECT * FROM @CURSO

