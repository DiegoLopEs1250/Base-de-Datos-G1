--Lenguaje de definicion de Datio (SQL LDD)
--Crear Tienda Digital
create database tiendadigital;
go
--cambiar de base de datos
use tiendadigital;
go
--crar tabla Proveedor
create table proveedor(
 proveedorId int not null identity(1,1),
 numcontrol varchar (30) not null,
 nomempresa varchar (50) not null,
 cp int not null,
 calle varchar (50) not null,
 colonia varchar (50) not null,
 numero int,
 estado varchar (20) not null,
 telefono varchar(20),
 paginaweb varchar(30),
 constraint pk_proveedor
 primary key(proveedorId),
 constraint unico_numcontrol
 unique (numcontrol),
 constraint unico_nombreempresa
 unique (nomempresa)
);
go
-- Crear tabla categoria
create table categoria(
categoriaid int not null,
descripcion varchar (100)not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_descripcion
unique (descripcion)
);
go 
-- crear tabla producto
create table Producto(
productoid int not null identity(1,1),
numcontrol varchar (30) not null,
descripcion varchar (100) not null,
precio money not null,
existencia int not null,
[status] int not null,
categoriaid int not null,
constraint pk_Producto
primary key (productoid),
constraint unico_numerocontrol
unique (numcontrol),
constraint unico_descripcion_producto
unique(descripcion),
constraint chk_precio
check (precio>0.0),
constraint chk_existencia
--check(existencia between 1 and 2000)
check (existencia>=1 and existencia<=2000),
constraint chk_status
--check([status]=0 or [status]=1)
check ([status]in (0,1)),
constraint fk_Producto_Categoria
foreign key (categoriaid)
references categoria (categoriaid)
);
go

create table Cliente(
clienteid int not null identity (1,1),
numerocontrol varchar(20) not null,
nombreempresa varchar (50) not null default 'Mostrador',
rfc varchar(20) not null,
direccionfiscal varchar(100) not null,
limitecredito money,
constraint pk_Cliente
primary key (clienteid),
constraint unico_numerocontrol_cliente
unique (numerocontrol),
constraint unico_rfc_Cliente
unique(rfc),
constraint chk_limitecredito
check (limitecredito>=0 and limitecredito<=100000)
);
go

create table Empleado(
empleadoid int not null identity (1,1),
numeronomina int not null,
nombrecompleto varchar(50) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
rfc varchar (20) not null,
curp varchar (20) not null,
salario  money not null,
constraint pk_Empleado
primary key(empleadoid),
constraint unico_numeronomina_Empleado
unique (numeronomina),
constraint unico_rfc_Empleado
unique (rfc),
constraint unico_curp_Empleado
unique (curp),
constraint chk_salario
check (salario>0.0),
);
go

create table OrdenCompra(
ordencompraid int not null identity (1,1),
fechaorden date not null,
fechaentraga date not null,
clienteid int not null,
empleadoid int not null,
constraint pk_OrdenCompra
primary key (ordencompraid),
constraint fk_OdernCompra_Cliente
foreign key (clienteid)
references Cliente(clienteid),
constraint fk_OdernCompra_Empleado
foreign key (empleadoid)
references Empleado(empleadoid)
);
go

create table detalleorden(
	ordenid int not null,
	productoid int not null,
	cantidad int not null,
	preciocompra money not null,
	constraint pk_detalleorden
	primary key (ordenid, productoid),
	constraint fk_detalleorden_orden
	foreign key(ordenid)
	references ordencompra(ordencompraid),
	constraint fk_detalleorden_producto
	foreign key(productoid)
	references producto(productoid)
);
go

create table ContactoPorveedor(
contactoid int not null,
proveedorId int not null,
nombrecompleto varchar (50)not null,
apellido1 varchar (20) not null,
apellido2 varchar (20),
email varchar (20),
constraint pk_ContactoProveedor
primary key (contactoid,proveedorId),
constraint fk_ContactoProveedor_proveedor
foreign key (proveedorId)
references proveedor(proveedorId)
);
go

create table TelefonoContacto(
telefonoid int not null,
contactoid int not null,
proveedorId int not null,
numerotelefono varchar(20) not null,
);
go
alter table TelefonoContacto
add constraint pk_TelefonoContacto
primary key (telefonoid)

alter table TelefonoContacto
add constraint fk_TelefonoConatcto_ContactoProveedor
foreign key (contactoid,proveedorId )
references  ContactoPorveedor(contactoid,proveedorId)

alter table Producto 
add proveedorId int not null

alter table Producto
add constraint fk_Producto_proveedor
foreign key (proveedorId)
references proveedor(proveedorId)