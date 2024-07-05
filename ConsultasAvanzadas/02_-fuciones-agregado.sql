--Funciones de agragado y agrupación


--Utilizar base de datos

use NORTHWND

--Funciones agregado

--Seleccioar el numero de total de ordenes 


--count(*)

select count(*) as 'Numero de ordenes' FROM orders;
select COUNT(*) FROM Customers

--count(campo)

SELECT region FROM Customers;

--seleccionar el maximo numero de productos de pedido

SELECT max (Quantity) as 'Cantidad' 
FROM [orders Details];

--seleccionar el minimo numero de productos de pedido

SELECT MIN (Quantity) as 'Cantidad' 
FROM [orders Details];

--seleccionar el total de las cantidades de los prpductos pedidos
SELECT sum(UnitPrice) FROM [order Details];

--seleccionar el total de dinero que he vendido

SELECT SUM (Quantity * od.UnitPrice) as total 
from [order Details] as od
INNER JOIN products as p
on od.productid = p.productid
where p.productName = 'Aniseed Syrup';

--seleccionar el total de dinero que he vendido

SELECT avg (Quantity * od.UnitPrice) as 'Promedio de ventas'
from [order Details] as od
INNER JOIN products as p
on od.productid = p.productid
where p.productName = 'Aniseed Syrup';

--seleccionar el numero de productos por categoria 

select avg (categoryid), count(*) as 'Numero de productos'
from products 

select CategoryID
from products 

select count(*)
from products

select categoryid, count(*) as 'Total de Productos'
from products 
group by categoryid;

--seleccionar el numero de productos por nombre de categoria
select c.categoryname, count(*) as 'Numero de productos'
FROM categories as c
INNER JOIN products as p
on c.categoryid = p.categoryid
where c.categoryid IN ('Beverages','Confections')
GROUP BY c.categoryname;







