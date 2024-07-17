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

exec sp_solicitarPromedio_prod 3

--Crear un sp que reciba 2 fechas y debuelba una lista de empleados, que fueron contartados en ese rango de fechas full name 
select * from employees
go

create or alter proc SP_2
@a1 date,@a2 date 
as
begin
select CONCAT(e.FirstName,' ',e.FirstName) as 'Nombre completo', e.HireDate as 'Fecha de contratacion' 
from Employees as e
where e.HireDate between @a1 and @a2 
end
go

exec SP_2 '1992-05-01' , '1993-10-17'

 

