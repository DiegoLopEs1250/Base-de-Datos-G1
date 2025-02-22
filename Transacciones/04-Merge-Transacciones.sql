

--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... �- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE
create database mergeEscuelita;
use NORTHWND
go


CREATE TABLE StudentsC1(
    StudentID INT
    ,StudentName VARCHAR(50)
    ,StudentStatus BIT
);
go

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sof�a Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
go
CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go
select * from StudentsC1
select * from StudentsC2

select * from 
StudentsC1 as c1
inner join StudentsC2 as c2
on c1.StudentID=c2.StudentID

select c1.StudentID,c1.StudentName,c1.StudentStatus from 
StudentsC1 as c1
left join StudentsC2 as c2
on c1.StudentID=c2.StudentID
where c2.StudentID is null

insert into StudentsC2 values (1,'Axel Romero',0)

truncate table studentsc2

-----------------------Store procedure
--Store porcedure que agraga y actualiza los registros nuevos y resgistros modificados de la tabla studentsc1 a studentsc2
--utilizando consultas con left join e inner join y transacciones
go

create or alter proc spu_cargaDelta_s1_s2
as
begin 
  begin transaction;
    begin try;
	  --Insertar nuevos registros de la tabla student1 y student2
	  INSERT INTO StudentsC2 (StudentID,StudentName,StudentStatus)
	  select c1.StudentID,c1.StudentName,c1.StudentStatus 
	  from 
      StudentsC1 as c1
      left join StudentsC2 as c2
      on c1.StudentID=c2.StudentID
      where c2.StudentID is null

	  --Se actualizan los registros que han tenido algun cambio en la tabla source studentc1
	  --y se cambian en la tabla target
	  UPDATE c2 
	  set c2.studentname = c1.StudentName,
	      c2.studentStatus= c1.StudentStatus
	  from 
      StudentsC1 as c1
      inner join StudentsC2 as c2
      on c1.StudentID=c2.StudentID;

	  --Confirmar la transacion

	  commit transaction;
	end try
	begin catch;
	  declare @mensaError varchar (100);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
	end catch;
end;
go

exec spu_cargaDelta_s1_s2

select * from 
StudentsC1 as c1
inner join StudentsC2 as c2
on c1.StudentID=c2.StudentID

select c1.StudentID,c1.StudentName,c1.StudentStatus from 
StudentsC1 as c1
left join StudentsC2 as c2
on c1.StudentID=c2.StudentID
where c2.StudentID is null

select * from StudentsC1
select * from StudentsC2

update StudentsC1
set StudentName = 'Axel Ramero'
where StudentID =1

update StudentsC1
set StudentStatus = '1'
where StudentID = 3

update StudentsC1
set StudentStatus = 0
where StudentID in (1,4,5)

insert into StudentsC1 values (6, 'Monico Hernandez',0);

select @@VERSION


----------------------SP--------------


--Store porcedure que agraga y actualiza los registros nuevos y resgistros modificados de la tabla studentsc1 a studentsc2
--utilizando la funcion merge
go

create or alter proc spu_cargaDelta_s1_s2_merge
as
begin 

  begin transaction;
    begin try;
	    merge into  studentsc2 as TGT
		using (
		 select studentID, Studentname,StudentStatus 
		 from StudentsC1
		) as SRC
		on(
         TGT.studentid = SRC.studentid		
		)
		--Para actualizar
		when matched then 
		update set TGT.StudentName= SRC.studentname, 
		           TGT.studentStatus = SRC.studentstatus
		--Para insertar 
		when not matched then
		insert (studentid,studentname,studentstatus)
		values (SRC.studentid, SRC.studentname,SRC.studentstatus);


	  --Confirmar la transacion
	  commit transaction;
	end try

	begin catch;
	  declare @mensaError varchar (100);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
	end catch;
end;
go
truncate table Studentsc2

select * from StudentsC1
select * from StudentsC2

exec spu_cargaDelta_s1_s2_merge

update StudentsC1 
set StudentName = 'Juana de Armas'
where StudentID = 2

--**************************************SP-Modificado************************--
go
create or alter proc spu_cargaDelta_s1_s2
as
begin 
  begin transaction;
    begin try;
	  --Insertar nuevos registros de la tabla student1 y student2
	  INSERT INTO StudentsC2 (StudentID,StudentName,StudentStatus)
	  select c1.StudentID,c1.StudentName,c1.StudentStatus 
	  from 
      StudentsC1 as c1
      left join StudentsC2 as c2
      on c1.StudentID=c2.StudentID
      where c2.StudentID is null

	  --Se actualizan los registros que han tenido algun cambio en la tabla source studentc1
	  --y se cambian en la tabla target
	  UPDATE c2 
	  set c2.studentname = c1.StudentName,
	      c2.studentStatus= c1.StudentStatus
	  from 
      StudentsC1 as c1
      inner join StudentsC2 as c2
      on c1.StudentID=c2.StudentID;

	  delete from StudentsC2
	  --Confirmar la transacion

	  commit transaction;
	end try
	begin catch;
	  declare @mensaError varchar (100);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
	end catch;
end;
go


--******************************************SP-Modificado-Merge********************************--
create or alter proc spu_cargaDelta_s1_s2_merge
as
begin 

  begin transaction;
    begin try;
	    merge into  studentsc2 as TGT
		using (
		 select studentID, Studentname,StudentStatus 
		 from StudentsC1
		) as SRC
		on(
         TGT.studentid = SRC.studentid		
		)
		--Para actualizar
		when matched then 
		update set TGT.StudentName= SRC.studentname, 
		           TGT.studentStatus = SRC.studentstatus
		--Para insertar 
		when not matched then
		insert (studentid,studentname,studentstatus)
		values (SRC.studentid, SRC.studentname,SRC.studentstatus);


	  --Confirmar la transacion
	  commit transaction;
	end try

	begin catch;
	  declare @mensaError varchar (100);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
	end catch;
end;
go


--------------------------------------------------------------------Tarea-------------------------------------------
--sp que agrega y actualiza los registros nuevos y registros modificados de la tabla studentc1 a studentc2 utilizando merge

create or alter proc spu_carga_delta_s1_s2_merge
--parametros
as
begin
--promgramacion del sp
	begin transaction;
	begin try
		--indicar a donde insertar, actualizar
		merge into StudentsC2 as tgt
		using (
			select studentid, studentname, studentstatus
			from StudentsC1
		)as SRC 
		on (
			tgt.studentid = src.studentid
		)

		--para actualizar
		when matched then 
		update
		set tgt.studentname = src.studentname,
			tgt.studentstatus = src.studentstatus


		--para insertar
		when not matched then
		insert (studentid, studentname, studentstatus)
		values (src.studentid, src.studentname, src.studentstatus);

		--confirmar la transaccion
		commit transaction;

	end try
	begin catch
		rollback transaction;
		
		declare @MensajeError varchar(100);
		set @MensajeError = ERROR_MESSAGE();
		print @MensajeError;
		
	end catch

end;
go

exec spu_carga_delta_s1_s2_merge

truncate table studentsc2

select * from StudentsC1;
select * from StudentsC2;

update StudentsC1 
set StudentName = 'Juana de arco'
where StudentID = 2

go
--1.Que haga las eliminaciones
create or alter proc spu_carga_delta_s1_s2_delete
--parametros
as
begin
--promgramacion del sp
	begin transaction;
	begin try
		--procedimiento a ejecutar de manera exitosa
		--eliminar registros de la tabla studentc1 a studentc2
		delete from StudentsC2 
		select*
		from StudentsC1 as c1
		right join
		StudentsC2 as c2
		on c1.StudentID = c2.StudentID
		where c1.studentid is null

				
		--confirmar la transaccion
		commit transaction;

	end try
	begin catch
		rollback transaction;
		
		declare @MensajeError varchar(100);
		set @MensajeError = ERROR_MESSAGE();
		print @MensajeError;
		
	end catch

end;
go

exec spu_carga_delta_s1_s2_delete

delete from StudentsC1 where StudentID = 7

select*
from StudentsC1 as c1
inner join
StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c1.studentid is null


go
--2.Agreguen al merge
create or alter proc spu_carga_delta_s1_s2_merge_delete
--parametros
as
begin
--promgramacion del sp
	begin transaction;
	begin try
		--indicar a donde eliminar
		merge into StudentsC2 as tgt
		using (
			SELECT studentid, studentname, studentstatus
			FROM StudentsC1
		)as SRC 
		on (
			tgt.studentid = src.studentid
		)

		--para eliminar
		WHEN NOT MATCHED BY SOURCE THEN DELETE;

		--confirmar la transaccion
		commit transaction;

	end try
	begin catch
		rollback transaction;
		
		declare @MensajeError varchar(100);
		set @MensajeError = ERROR_MESSAGE();
		print @MensajeError;
		
	end catch

end;
go

exec spu_carga_delta_s1_s2_merge_delete

select * from StudentsC1;
select * from StudentsC2;

go

create or alter proc spu_limpiar_tabla
@nombreTabla nvarchar (50)
as
begin 
   declare @sql nvarchar (50)
   set @sql= 'truncate table '+ @nombreTabla;
   exec (@sql)
end;
go