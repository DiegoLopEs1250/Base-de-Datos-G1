--CREAMOS LA BASE DE DATOS etlempresa y a trabajar ;)
use NORTHWND
select * from Customers

create database etlempresa;
use etlempresa; 
select * from Cliente
create table Cliente (
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
existencia int not null,
descontinuado bit not null,
constraint pk_producto primary key (productoid)
);
select * from Producto
--store procedure Porducto
create or alter proc sp_etl_carga_Producto
  
  as
    begin 
	   insert into etlempresa.dbo.Producto
	   select ProductID, ProductName as 'Nombre del Producto', UnitPrice as 'Precio', CategoryID as 'Categoria', UnitsInStock as 'Existencia', 
	   Discontinued as 'Descontiniado'
	   from NORTHWND.dbo.Products as np
	   left join etlempresa.dbo.Producto etl
	   on np.ProductID= etl.productobk 
	   where etl.productobk is null;
	end



--crear la tabla empleado
create table Empleado(
empleadoid int not null identity (1,1),
empleadobk int not null,
nombrecompleto nvarchar (30) not null,
ciudad nvarchar (15) not null,
region nvarchar (15) not null,
pais nvarchar (15) not null,
constraint pk_empleado primary key (empleadoid)
);
--Store procedure Empleado
create or alter proc sp_etlemprea_carga_Empleado
as
begin
insert into etlempresa.dbo.Empleado
select EmployeeID, CONCAT(ne.FirstName,' ',ne.LastName) as 'Nombre Completo', isnull(ne.Region,'Sin region') as 'Region', upper(Country) as Pais, upper(City) as Ciudad
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.Empleado etle
on ne.EmployeeID = etle.empleadobk
where etle.empleadobk is null;
end



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
--store procedure
create or alter proc sp_etl_carga_Provedor
 as
  begin 
   insert into etlempresa.dbo.Provedor
   select SupplierID, s.CompanyName as 'Empresa', s.City as 'Ciudad', s.Region as 'Region', s.Country as 'Pais', s.HomePage as 'HomePage' 
   from NORTHWND.dbo.Suppliers as s
   left join etlempresa.dbo.Provedor p
   on s.SupplierID= p.provedorbk
   where p.provedorbk is null;
  end
  



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

create or alter 