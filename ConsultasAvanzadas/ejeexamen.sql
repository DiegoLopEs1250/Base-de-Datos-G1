create database pruebacargadinamica;

use pruebacargadinamica;

--Paso 1.- creamos la tabla Empleado a partir de la de Employees de NORTHWND
select top 0 EmployeeID, FirstName, LastName, [Address], HomePhone, Country
into pruebacargadinamica.dbo.empleado
from NORTHWND.dbo.Employees;

--Paso 2.- Insertamos los valores de la tabla employees en la de empleado

insert into pruebacargadinamica.dbo.empleado (FirstName, LastName, [Address], HomePhone, Country)
select FirstName, LastName, [Address], HomePhone, Country 
from NORTHWND.dbo.Employees;

--Paso 3.- Creamos la tabla dim_empleado a partir de la tabla empleado

select top 0 EmployeeID,CONCAT(FirstName,' ', LastNAme) as 'Nombre', [Address], HomePhone, Country
into pruebacargadinamica.dbo.dim_empleado
from pruebacargadinamica.dbo.empleado

--Paso 4.- insertamos los valores de empleados en dim_empleado
insert into pruebacargadinamica.dbo.[dim_empleado]  (Nombre,
[Address],
HomePhone,
Country)
select CONCAT(e.FirstName,' ',e.LastName) as 'Nombre', e.[Address], e.HomePhone, e.Country 
from pruebacargadinamica.dbo.empleado as e
LEFT JOIN dim_empleado as dim 
on e.EmployeeID = dim.EmployeeID
where dim.EmployeeID is NULL


insert into empleado(FirstName,LastName,Address,HomePhone,Country) VALUES('Larry','Santiago','5588966321','España')

select * FROM empleado
select * FROM dim_empleado

drop table empleado
drop table dim_empleado







