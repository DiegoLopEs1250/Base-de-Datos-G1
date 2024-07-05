create database pruebatriggersG1;
use pruebatriggersG1;
--Usar triggers 

create table empleado(
idempleado int not null primary key,
nombreempleado varchar(30) not null,
apellido1 varchar (15) not null,
apellido2 varchar (15),
salario money not null
);
go

create or alter trigger tg_1
on empleado
after insert
as
 begin
  print'Se ejecuto el trigger, en el evento insert'
 end;

 select * from empleado

 insert into empleado
 values(1,'Diego','Lopez','Espinoza',120000);

 drop trigger tg_1


 create or alter trigger tg_2
 on empleado
 after insert 
 as 
 begin
  select * from inserted
  select * from deleted
 end;

 insert into empleado
 values (2,'Rocio','Cruz','Cervantes',82000)

  drop trigger tg_2


 create or alter trigger tg_3
 on empleado
 after delete 
 as 
  begin
    select * from inserted
    select * from deleted
  end

  insert into empleado
  values (2,'Rocio','Cruz','Cervantes',82000)

  delete empleado
  where idempleado=2

  create or alter trigger tg_4
  on empleado
  after update 
  as 
    begin
	   select * from inserted
       select * from deleted
	end

	update empleado
	set nombreempleado= 'Larry'
	where idempleado=1

	--******************************
	create or alter trigger tg_5
	on empleado
	after insert, delete
	as 
	begin
	  if exists(select 1 from inserted)
	  begin
	     print 'Se realizo un registro'
	  end
	  else if exists( select 1 from deleted) and
	  not exists (select 1 from inserted)
	  begin
	    print 'Se realizo un delete'
	  end
	end;

	insert into empleado
	values (2,'Leslie','Jimenez','Neri',100000)

	delete from empleado
	where idempleado=2

	drop trigger t