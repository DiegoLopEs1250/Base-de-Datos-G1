use NORTHWND
--lenguaje SQL-LMD

--seleccionar todos los productos
SELECT * FROM Products;

--seleccionar todas las categorias
SELECT *FROM Categories;

--seleccionar los provedores
SELECT *FROM Suppliers;

--seleccionar los clientes
SELECT *FROM Customers;

--selecionar los empleados
SELECT * FROM Employees;

--seleccionar todos las paqueterias
SELECT *FROM Shippers;

--seleccionar todas la ordenes 
SELECT * FROM Orders;

--seleccionar todos los detalles de ordenes
SELECT * FROM [Order Details];

--proyecciones
--Alias de columna
SELECT ProductID AS 'Numero Producto', ProductName AS 'Nombre Producto', UnitsInStock AS Existencia, UnitPrice AS 'Precio' FROM Products; 

--Alias de tablas
SELECT ProductID AS 'Numero Producto', ProductName AS 'Nombre Producto',
 UnitsInStock AS Existencia, UnitPrice AS 'Precio' FROM Products; 

SELECT * FROM Products, Categories
WHERE Categories.CategoryID = Products.CategoryID

SELECT * FROM Products
SELECT * FROM Customers

-- Campo calculado 
-- Seleccionar todos los productos mostrando el ID del producto,
-- El nombre del producto, la exixtencia, el precio y el importe

SELECT *, (UnitPrice * UnitsInStock) AS 'Importe' FROM Products;

SELECT ProductID AS 'Numero Producto',
 ProductName AS 'Nombre del Producto',
 UnitsInStock as 'Existencias',
 UnitPrice as 'Precio',
 (UnitPrice * UnitsInStock) AS 'Importe'
  FROM Products;

  --seleccionar las primeras 10 ordenes (top)

  SELECT top 10 * FROM Orders;

  --seleccionar todos los clientes ordenados de forma ascenente por el pais
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by Country;

--Orden ascendente (asc)
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by Country asc;


SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by 5 asc;


--Por el alias (as)
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by 'Pais' asc;

--seleccionar todos los clientes ordenados por pais de foema descendente
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by Country;

--Orden descendente (desc)
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by Country desc;


SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by 5 desc;


--Por el alias (as)
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente',
[address] as 'Direccion',
City as 'Ciudad',
Country as 'Pais'
FROM Customers
order by 'Pais' desc;

--selecciona todos los clietes ordenados de forma ascendeente por pais y dentro de cada pais ordenado por ciudad de forma descendente


 


--operadores relacionales 
--(<,>, <=,>=, ==, <> o !=)

--seleccionar los paises a los cuales se les ha enviado las ordenes
SELECT distinct shipCountry from Orders
order by 1

--seleccionar todas las ordenes enviadas a francia
SELECT * FROM Orders
where ShipCountry = 'France';

--seleccionar todas las ordenes realizadas a francia, mostrando en numero de orden, cliente, empleado que la realizo, pais al que se envio, la ciudad a la que se envio.
SELECT OrderID, CustomerID, EmployeeID, ShipCountry, ShipCity  FROM Orders
where ShipCountry = 'France';

--seleccionar las ordenes en donde no se ha asignado una region de envio.
SELECT OrderID, CustomerID, EmployeeID, ShipCountry, ShipCity, ShipRegion  
FROM Orders
where ShipRegion is NULL

--seccionar las ordenes en donde se ha asignado una region de envio
SELECT OrderID, CustomerID, EmployeeID, ShipCountry, ShipCity, ShipRegion  
FROM Orders
where ShipRegion is not NULL

--seleccionar los productos con un precio mayor a 50 dolares
SELECT * FROM Products
WHERE UnitPrice > 50

--seleccionar los empleados contratados depues del 1 de enero 1990
SELECT * FROM Employees
where HireDate > 01/01/1990

--seleccionar los clientes donde el pais sea aAemania
SELECT * FROM Customers
where Country = 'Germany'
 
--mostrar los productos con una cantidad <=100
SELECT * FROM Products
where UnitsInStock <=100
--seleccionar todas las ordenes realizadas antes del primero de enero 1998
select * from Orders
where OrderDate < '1998-01-01'

--seleccionar todas las ordenes realizadas por el empleado fuller
SELECT * FROM Orders
where EmployeeID =2
--seleccionar todas las ordenes mostrando el numero de orden, el cliente y la fecha de orden dividida en año, mes, dia.
SELECT OrderID,CustomerID, OrderDate, YEAR(OrderDate) as 'AÑO',
MONTH(OrderDate) as 'Mes',
DAY(OrderDate) as 'Dia'
 FROM Orders


--operadores logicos
--seleccionar los productos con un precio mayor a 50 y con una cantidad menor o igual a 100
SELECT * FROM Products
WHERE UnitPrice <50 and UnitsInStock <=100


--seleccionar todas las ordenes para francia o alemania.

SELECT * FROM Orders
WHERE ShipCountry in ('France','Germany')

--seleccionar todas la sordenes en francia, alemania y mexico

SELECT * FROM Orders
WHERE ShipCountry in ('France','Germany','Mexico')
order by ShipCountry DESC




