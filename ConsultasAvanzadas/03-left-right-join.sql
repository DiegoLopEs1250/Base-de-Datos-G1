create database pruebajoings;

use pruebajoings;

create table provedor(
  provid int not null IDENTITY(1,1),
  nombre VARCHAR (50) not NULL,
  limite_credito money not null,
  constraint pk_proveedor
  PRIMARY KEY (provid),
  constraint unico_nombrepro
  unique(nombre)
);

CREATE table productos (
   productid int not null IDENTITY(1,1),
   nombre VARCHAR (50) not NULL,
   precio money not null,
   existencia int not null,
   provedor int,
   constraint pk_proveedor_producto
   PRIMARY key (productid),
   constraint unico_valor_proveedor
   unique (nombre),
   constraint fk_proveedor_producto
   foreign key (provedor)
   REFERENCES provedor(provid)
);

--Agragar registros a las tablas provedor y producto

insert into provedor (nombre,limite_credito)
values
('Provedor1', 5000),
('Provedor2', 6778),
('Provedor3', 6788),
('Provedor4', 5677),
('Provedor5', 6666);

SELECT * FROM provedor;

insert into productos (nombre,precio,existencia, provedor)
values
('Producto1', 56,34,13),
('Producto2', 56.15,12,13),
('Producto3', 45.6,33,14),
('Producto4', 22.34,666,15);


select * from productos


select * from provedor
