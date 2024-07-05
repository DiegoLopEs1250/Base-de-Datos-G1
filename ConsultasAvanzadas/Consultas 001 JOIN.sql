SELECT C.CategoryName as 'Nombre de categoria', P.ProductName as 'Nombre del producto',P.UnitPrice as 'Precio', P.UnitsInStock AS 'Existencias' 
from Categories as C
JOIN Products as P
on C.CategoryID=P.CategoryID
where CategoryName in ('Beverages', 'Produce')

--seleccionar toas las ordenes que fueron emitidas por lo empleados Nancy Davoli, Anne Dodsworth y Andrew Fuller

select * FROM Orders
WHERE EmployeeID=1 OR
EmployeeID=9 or
EmployeeID= 2 

SELECT * FROM Orders
where EmployeeID in(1,2,9);

--seleccionar todas las ordenes, dividiendo la fecha de orden en, año, mes y dia.

SELECT OrderDate as'Fecha de Orden', 
YEAR(OrderDate) as'Año',
MONTH(OrderDate) as'Mes',
DAY(OrderDate) AS' Dias'
FROM Orders

--seleccionar todos los nombre sde los empleados 

SELECT CONCAT(FirstName,' ',LastName) AS'Nombre Completo'
FROM Employees

--seleccionar todos los productos donde la existencia sea mayor o igual 40 y el precio sea menor a 19

SELECT*FROM Products
WHERE UnitsInStock >=40 and UnitPrice <19

--seleccionar todas las ordenes realizadas de Abril a Agosto de 1996

SELECT OrderID, CustomerID, EmployeeID, OrderDate 
FROM Orders
where OrderDate BETWEEN '1996-04-01' and '1996-08-31';


--seleccionar todas las ordenes entre 1996 y 1998
SELECT OrderID, CustomerID, EmployeeID, OrderDate 
FROM Orders
where OrderDate BETWEEN '1996' and '1998';


--seleccionar todas las ordenes de 1996 y 1999
SELECT OrderID, CustomerID, EmployeeID, OrderDate 
FROM Orders
where YEAR(OrderDate) in ('1996','1999')

--seleccionar todos los productos que comiencen con c

SELECT ProductName FROM Products
where ProductName LIKE 'c%';

--seleccioant todos los productos wue terminen con S
SELECT ProductName FROM Products
where ProductName LIKE '%s';

--SELECCIONAR todos los productos que el nimbre del producto contenga la palabra NO
SELECT ProductName FROM Products
where ProductName LIKE '%no%';

--seleccionar todos los productos que contengan las letras a o n
SELECT ProductName FROM Products
where ProductName LIKE '%[AN]%'

--seleccionar todos los productos que comiencen entre la letra A y N
SELECT*FROM Products
where ProductName LIKE '%[AN]'

--seleccionar toas las ordenes que fueron emitidas por lo empleados Nancy Davoli, Anne Dodsworth y Andrew Fuller (inner Joing)
SELECT o.OrderID AS 'Numero Orden',
o.orderDate as 'Fecha Orden',
CONCAT(FirstName, ' ', LastName) as 'Nomre Empleado'
FROM
Employees as e
INNER JOIN
orders as o
on E.EmployeeID = o.EmployeeID
where e.FirstName IN ('Nancy','Anne','Andrew')
and e.LastName in ('Davolio','Dosswort','Fuller')



--crear base de datos 
CREATE DATABASE pruebaxyz;
--utilizar la base de datos
use pruebaxyz;

--Crear una tabla a pertir de un constraint a la tabla products2
select top 0 * 
into pruebaxyz.dbo.products2
from NORTHWND.dbo.Products;

SELECT*FROM products2
--Agragar un constraint a la tabla products2
ALTER table products2
add constraint pk_products2
primary key (Productid) 


select*from products2

--llenar una tabla a partir de una consulta

insert into pruebaxyz.dbo.products2 (ProductName,SupplierID,CategoryID,
QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,
ReorderLevel,Discontinued)


select ProductName,SupplierID,CategoryID,
QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,
ReorderLevel,Discontinued from NORTHWND.dbo.Products;


-- Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado
-- del representante de ventas de cada pedido.

--Nombre del cliente (Customers)
--Nombre del empleado (Employees)
--Pedido


use NORTHWND;

SELECT o.CustomerId, o.Employeeid, o.OrderID, o.OrderDate 
FROM 
orders as o;

SELECT c.CompanyName as 'Nombre del cliente',
concat (e.FirstName,',',e.LastName) as 'Nombre Empleado',
o.OrderID, o.OrderDate, (od.Quantity * od.UnitPrice) as 'Importe' 
FROM Customers as c
INNER JOIN
Orders as o
on c.CustomerID = o.customerid
INNER JOIN Employees as e
on o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] as od
on od.OrderID= o.OrderID
WHERE year(OrderDate) in('1996','1998')

--seleccionar cuantas ordenes se han realizado en 1996 y 1998

SELECT COUNT(*) as 'Total de Ordenes' 
FROM Customers as c
INNER JOIN
Orders as o
on c.CustomerID = o.customerid
INNER JOIN Employees as e
on o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] as od
on od.OrderID= o.OrderID
WHERE year(OrderDate) in('1996','1998')

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.



--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.


--Ejercico 11: Seleccionar el total de ordenes por cada uno de los proveedores

select s.CompanyName as 'Proveedor', count(od.orderId) as 'Numero de Ordenes' 
from Suppliers as s
inner join products as p
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName;

--Ejercicio 12: Seleccionar el total de dinero que he vendido por provedores del ultimo trimestre de 1996
select s.CompanyName as 'Nombre proveedor', sum (od.UnitPrice * od.Quantity) as 'Total ventas' 
from Suppliers as s  
inner JOIN Products as p 
on p.SupplierID = p.SupplierID
inner JOIN [Order Details] as od 
on od.ProductID = p.ProductID
inner JOIN Orders as o 
on o.OrderID= od.OrderID
where o.OrderDate BETWEEN '1996-09-01' and '1996-12-31'
GROUP by s.CompanyName
ORDER BY 'Total ventas' DESC;




--Ejercicio 13: seleccionar el total de dinero vendido por categoria

SELECT  c.CategoryName, 
sum (od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
INNER JOIN products as p 
on od.ProductId = p.ProductID
INNER JOIN Categories as C 
on c.CategoryID= p.CategoryID
GROUP by c.CategoryID
order by 2 desc;

--Ejercicio 14: Seleccionar el total de dinero vendido por categoria y dentro por producto
select c.Categoryname as 'Nombre de la categoria',
p.productname AS 'Producto',
SUM(od.Quantity*od.UnitPrice) as 'Total' 
FROM [Order Details] as od 
INNER JOIN Products as p 
on od.ProductID=p.ProductID
INNER JOIN Categories as c 
on c.CategoryID=p.CategoryID
GROUP by c.CategoryName, p.ProductName;



use NORTHWND

select c.CategoryID,p.ProductName, p.UnitsInStock, p.Unitprice, p.discontinued
FROM (
    select categoryname, categoryid from Categories
) as c 
INNER JOIN 
(
    select productname, UnitsInStock, categoryID,UnitPrice,Discontinued from Products
) as p 
on c.CategoryID=p.CategoryID;


--Left Join
use pruebajoings

select * from 
provedor as p 
LEFT JOIN productos as pr 
on pr.provedor=p.provid



select p.nombre,p.productid
from productos as p 

select * from productos

--eje1 crear 2 tablas una que se llame empleados con los campos IDempleado, nombre, direccion, DMI_empleados 