--****************OPERADORES DE COMPARACION***************
--1) IGUAL A (=)
SELECT * FROM TMP_Persona WHERE persona_id = 3

--2) MAYOR QUE (>) o MAYOR O IGUAL QUE (>=)
SELECT * FROM TMP_Persona WHERE persona_id > 2
SELECT * FROM TMP_Persona WHERE persona_id >= 2

--3) MENOR QUE (<) o MENOR O IGUAL QUE (<=)
SELECT * FROM TMP_Persona WHERE persona_id < 4
SELECT * FROM TMP_Persona WHERE persona_id <= 4

--4) NO ES IGUAL A: <> o !=
SELECT * FROM TMP_Persona WHERE persona_id <> 5
SELECT * FROM TMP_Persona WHERE persona_id != 5

--5) NO ES MENOR QUE (!<)
SELECT * FROM TMP_Persona WHERE persona_id !< 3

--6) NO ES MAYOR QUE (!<)
SELECT * FROM TMP_Persona WHERE persona_id !> 4

--7) VERIFICACION QUE LOS OPERADORES DE COMPARACION NO FUNCIONAN CUANDO EL TIPO DE DATO ES TEXT, NTEXT O IMAGE
declare @familiares table
(
id int not null,
codigo ntext,
nombre text,
foto image
)

insert into @familiares
values(1, '0010', 'papa', 'papa.jpg'),
(2, '0020', 'mama', 'mama.jpg')

select * from @familiares where nombre <> 'papa'
select * from @familiares where codigo = '0010'
select * from @familiares where foto <> 'papa.jpg'