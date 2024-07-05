--crear las tablas solicitadas

--crear base de datos 
create database ejercicioexam;

--usamos la base

use ejercicioexam;

--crear las tablas solicitadas

--crear la tabla provedor

create table provedor(
    idprov int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null,
    limitecredito money not null,
    CONSTRAINT pk_provedor
    primary KEY(idprov),
    CONSTRAINT unico_nombre_provedor
    UNIQUE (nombre)
);

create table categoria(
    idcatego int not null,
    nombre VARCHAR(50) not null,
    CONSTRAINT pk_categoria
    primary key (idcatego),
    CONSTRAINT unico_nombre_categoria
    unique (nombre)
);

CREATE TABLE producto(
    idprod int not null,
    nombre varchar(50) not null,
    precio money not null,
    existencia int not null,
    idprov int,
    idcatego int
    constraint pk_producto
    primary key(idprod),
    constraint fk_producto_proveedor
    foreign key (idprov)
    references provedor(idprov),
    constraint fk_producto_categoria
    foreign key (idcatego)
    references categoria(idcatego)
);

-- Insertar datos en las tablas
insert into provedor (nombre, limitecredito)
values('Coca-cola', 98777),
      ('Pecsi', 234567),
      ('Hay me Pica', 44566),
      ('Hay me Duele', 45677),
      ('Tengo Miedo', 22344);


insert into categoria
values(1, 'Lacteos'),
(2, 'Linea Blanca'),
(3, 'Dulces'),
(4, 'Vinos'),
(5, 'Abarrotes');
     

select * from provedor

insert into producto
values(1, 'Mascara', 78.9, 20, 5,5)

insert into producto(idprov, existencia, idcatego, precio, idprod, nombre)
values(3, 34, 5, 56.7, 2, 'Manita Rascadora')

insert into producto
values (3, 'Tonayan', 1450, 56,4 ,4),
       (4, 'Caramelo', 200, 22,1 ,3),
       (5, 'Terry', 200, 24,4 ,4);


select * from Producto
select * from Categoria
select * from provedor


--consultas con inner join
--1ra Forma

SELECT c.nombre,p.nombre,p.precio   --seleccionamos los puntos que queremos ver
from categoria as c --tabla dd la izquierda
inner join producto as p  --tabla de la derecha
on c.idcatego= p.idcatego;

--2da Forma

SELECT *,(p.precio * p.existencia) as 'importe'
from categoria as c --tabla dd la izquierda
inner join producto as p  --tabla de la derecha
on c.idcatego= p.idcatego;

--3ra Forma Tabla derivada (Mejor Opcion)

SELECT c.idcatego, c.nombre, p.nombre,p.existencia,p.precio,(p.precio*p.existencia) as 'importe' 
FROM 
(select idcatego,nombre from categoria) as c 
inner JOIN
(select nombre,precio,existencia, idcatego from producto) as p 
on c.idcatego=p.idcatego


--con 2 INNER JOIN conectando 3 tablas 
select * FROM
categoria as c 
inner JOIN producto as p 
on c.idcatego= p.idcatego
inner JOIN provedor as pr 
on pr.idprov=p.idprov;


--LEFTH JOIN

select c.nombre,p.nombre, p.precio,p.existencia   
from categoria as c 
left JOIN producto as p 
on c.idcatego=p.idcatego
where p.idcatego is NULL;


--Mejor Forma (Left Join)
select c.nombre,p.nombre, p.precio,p.existencia   
from 
( select nombre, idcatego from categoria) as c 
left JOIN ( select precio,existencia, idcatego, nombre from producto) as p 
on c.idcatego=p.idcatego
where p.idcatego is NULL;


--Right Join 
select c.nombre,p.nombre, p.precio,p.existencia   
from categoria as c      --Tabla de la izquierda
RIGHT JOIN producto as p --Tabla de la Derecha
on c.idcatego=p.idcatego

insert into producto values (6,'P6',45.6,12,2, null)



--Full Join

select *
from categoria as c      
FULL JOIN producto as p 
on c.idcatego=p.idcatego


--con 2 INNER JOIN conectando 3 tablas 
select * FROM
categoria as c 
LEFT JOIN producto as p 
on c.idcatego= p.idcatego
inner JOIN provedor as pr 
on pr.idprov=p.idprov;


--left con left
select * FROM
categoria as c 
LEFT JOIN producto as p 
on c.idcatego= p.idcatego
LEFT JOIN provedor as pr 
on pr.idprov=p.idprov;

--Right con right
select * FROM
categoria as c 
RIGHT JOIN producto as p 
on c.idcatego= p.idcatego
RIGHT JOIN provedor as pr 
on pr.idprov=p.idprov;

--con full y inner
select * FROM
categoria as c 
FULL JOIN producto as p 
on c.idcatego= p.idcatego
inner JOIN provedor as pr 
on pr.idprov=p.idprov;

select * FROM producto 
where idcatego in (1,2)