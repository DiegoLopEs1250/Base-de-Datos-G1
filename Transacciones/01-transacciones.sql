
use NORTHWND

--Transaccion: Las transacciones en sql server son fundamentales
--para asegurar la consistencia y la integridad de los datos en una basa de datos

--Una transacion es una unidad de trabajo que se ejecuta de manera completamnete exitosa
--o no se ejecuta en absoluto.

--Sigue el principio ACID: 
  --Atomicidad: Toda la transaccion se completa o no se realiza nada
  --Concistencia: La transaccion lleva la base de datos de un estado valido
  -- a otro.
  --Aislamiento: Las transacciones concurrentes no interfieren entre si
  --Durabilidad: Una vez que una transaccion se completa los cambios son permanentes.
  --Comandos a utilizar:
  --Bejin transaction: Inicia una nueva transaccion.
  --Commit transaction: Cimfirma todos los cambios realizados durante la transaccion.
  --Rollback transaction: Revierte todos los cambio realizados durante la transaccion.


select * from Categories
go

  begin transaction;

  insert into Categories (CategoryName,Description) values ('Los remediales','Estara muy bien');
  go

  rollback transaction

  commit transaction;


  --elercicio transaccion
create database pruebatransacciones;
use pruebatransacciones;

create table Empleado (
empleadoid int not null,
nombre varchar(30) not null,
salario money not null,
constraint pk_Empleado primary key (empleadoid),
constraint chk_salario check (salario>0.0 and salario<=50000)
);
go 

create or alter proc spu_agregarEmpleado
--Parametros de entrada
@empleadoid int, @nombre varchar(30), @salario money
as
 begin 

  begin try
    begin transaction;
	--inserta en la tabla empleado 
	 insert into Empleado (empleadoid,nombre,salario) values (@empleadoid,@nombre,@salario);
	 --Se completa la transaccion si todo va bien   
	 commit transaction;
   end try

   begin catch
     Rollback transaction;
	 --Obtener el error
	 declare @mensaje_error nvarchar(4000)
	 set @mensaje_error = ERROR_MESSAGE();
	 print @mensaje_error;
   end catch;

 end;
 go

exec spu_agregarEmpleado 1, 'Aleks', 30000.0;
go

select * from Empleado