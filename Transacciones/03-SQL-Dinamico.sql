use NORTHWND;
go
--crear un store porcedure que reciba como parametro de entrada el nombre de una tabla y visualice todos sus registros

 create or alter proc spu_mostrar_datosTabla
 @nomtabla varchar(15)
 as
 begin
 --SQL Dinamico
   declare @SQL nvarchar (max);
   set @SQL='select * from ' + @nomtabla;
   exec(@SQL)
 end;

 exec spu_mostrar_datosTabla 'customers'
 go
 --*****************************************--

 create or alter proc spu_mostrar_datosTabla_2
 @nomtabla varchar(15)
 as
 begin
 --SQL Dinamico
   declare @SQL nvarchar (max);
   set @SQL='select * from ' + @nomtabla;
   exec sp_executesql @SQL;
 end;

 exec spu_mostrar_datosTabla 'customers'

