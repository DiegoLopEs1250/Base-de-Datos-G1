--Parametros de salida
create or alter procedure calcular_area
--parametros de entrada
@radio float, 
--Parametro de salida
@area float output
as 
begin 
 
 set @area = pi() * (@radio*@radio)

end
go

declare @res float
exec calcular_area @radio= 22.3, @area = @res output
print'El area es: ' + cast(@res as varchar)
go


--Mostrar el nombre completo de un empleado determinado
create or alter procedure sp_obtenerDatos
@numeroEmpleado int,
@fullName nvarchar(35) output
as
begin
select @fullName=CONCAT(FirstName, ' ', LastName)
from Employees
where EmployeeID = @numeroEmpleado

end
go

declare @nombre varchar(35)
exec sp_obtenerDatos @numeroEmpleado=10,  @fullName = @nombre output
print 'El nombre completo es: ' + @nombre

--Mostrar lo mismo pero con una validacion
create or alter procedure sp_obtenerDatos2
@numeroEmpleado int,
@fullName nvarchar(35) output
as
begin
select @fullName=CONCAT(FirstName, ' ', LastName)
from Employees
where EmployeeID = @numeroEmpleado
if @fullName is null
begin
    print'No hay empleado'
end
else
begin
select @fullName=CONCAT(FirstName, ' ', LastName)
from Employees
where EmployeeID = @numeroEmpleado
end

end
go

declare @nombre varchar(35)
exec sp_obtenerDatos2 @numeroEmpleado=9,  @fullName = @nombre output
print 'El nombre completo es: ' + @nombre



--CREAMOS LA BASE DE DATOS etlempresa y a trabajar ;)

select * from Customers

create database etlempresa;
use etlempresa; 

create table Cliente(
clienteid int not null identity(1,1),
clientebk nchar (5) not null,
empresa varchar (40) not null,
ciudad nvarchar (15) not null,
region nvarchar (15) not null,
pais nvarchar (15) not null,
constraint pk_cliente primary key (clienteid));

--crear un store procedure 
create or alter proc sp_etl_carga_cliente
as
begin

insert into etlempresa.dbo.Cliente
select CustomerID, upper(CompanyName) as Empresa, isnull(nc.Region,'Sin region') as Region, upper(Country) as Pais, upper(City) as Ciudad
from NORTHWND.dbo.Customers as nc
left join etlempresa.dbo.Cliente etle
on nc.CustomerID= etle.clientebk
where etle.clientebk is null;

update cl
set cl.empresa = upper(c.CompanyName),
cl.ciudad = upper(c.City),
cl.pais = UPPER (c.Country),
cl.region = upper(ISNULL(c.Region, 'Sin region'))
from NORTHWND.dbo.Customers as c
inner join etlempresa.dbo.Cliente as cl
on c.CustomerID= cl.clientebk

select * from NORTHWND.dbo.Customers
where CustomerID = 'CLIB1'

update NORTHWND.dbo.Customers
set CompanyName = 'pepsi'
where CustomerID= 'CLIB1'
end

select * from etlempresa.dbo.Cliente
where clientebk = 'CLIB1'

truncate table etlempresa.dbo.cliente


--crear la tabla Producto
create table Producto(
productoid int not null identity(1,1),
productobk int not null,
nombreproducto nvarchar(40) not null,
precio money not null,
categoria int not null,

);



--crear la tabla empleado
create table Empleado(
empleadoid int not null identity (1,1),
empleadobk int not null,
nombrecompleto nvarchar (30) not null,
ciudad nvarchar (15) not null,
region nvarchar (15) not null,
pais nvarchar (15) not null,

constraint pk_empleado
primary key (empleadoid)
);

--Crear la tabla provedor 
create table Provedor(
provedorid int not null identity (1,1),
provedorbk int not null,
empresa nvarchar (40) not null,
city nvarchar (15) not null,
region nvarchar (15) not null,
country nvarchar (15) not null,
homepage ntext not null,

constraint pk_provedor
primary key (provedorid)
);

--crear la tabla Ventas
create table Ventas(
clienteid int,
productoid int,
empleadoid int,
provedorid int,

constraint fk_cliente_ventas
foreign key (clienteid)
references Cliente (clienteid),

constraint fk_producto_ventas
foreign key (productoid)
references Producto (productoid),

constraint fk_empleado_ventas
foreign key (empleadoid)
references Empleado (empleadoid),

constraint fk_provedor_ventas 
foreign key (provedorid)
references Provedor (provedorid)
);
