--Crear un sp que solicite un id de una categoria y debualba el promedio de los precios de sus productos
use NORTHWND
go

create or alter procedure sp_solicitarPromedio_prod
@category int  --parametro de entrada
as
begin
select AVG(UnitPrice) as 'Promedio de los porductos' from Products
where CategoryID=@category;
end
go

exec sp_solicitarPromedio_prod 2