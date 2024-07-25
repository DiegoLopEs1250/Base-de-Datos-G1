use NORTHWND

select o.OrderID, o.OrderDate, c.CompanyName, c.City, od.Quantity, od.UnitPrice
from Orders as o
inner join [Order Details] as od 
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in('San Cristóbal','México D.F.')


--heaving--
select c.CompanyName, count(o.OrderID) as 'Numero ordenes'
from Orders as o
inner join [Order Details] as od 
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in('San Cristóbal','México D.F.')
group by c.CompanyName
having count (*) >18  ---filtro del group by

--heaving 2
--obtener los nombres de los productos y sus categorias 
--donde el precio promedio de los productos en la mismma categoria sea mayor a 20

select * from Products

select c.CategoryName,p.ProductName, avg(p.UnitPrice) as 'Promedio'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
group by  c.CategoryName, p.ProductName
having avg (p.UnitPrice) > 20
order by c.CategoryName asc



--**************2
select c.CategoryName,p.ProductName, avg(p.UnitPrice) as 'Promedio'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
group by  c.CategoryName, p.ProductName
having max (p.UnitPrice) > 200
order by c.CategoryName asc

