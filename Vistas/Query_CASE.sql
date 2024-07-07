
use NORTHWND

--Vistas (objeto )

create or ALTER VIEW vista_ventas
as 
select c.CustomerID as 'claveCliente', c.CompanyName as 'cliente',
CONCAT(e.FirstName,' ', e.LastName) as 'Nombre',
o.OrderDate as 'Fechaorden',
 DATEPART(YEAR, o.OrderDate) as 'Añocompra',
DATENAME(MM, o.OrderDate) as 'Mescompra',
DATEPART(QUARTER, o.OrderDate) as 'Trimestre',
UPPER(p.ProductName) as 'NombreProducto',
od.Quantity as 'Cantidadvendida',
od.UnitPrice as 'Precioventa',
p.SupplierID as 'Provedorid'
from 
Orders as o 
inner join Customers as c 
on o.CustomerID=c.CustomerID
inner join Employees as e 
on e.EmployeeID= o.EmployeeID
INNER join [Order Details] as od 
on od.OrderID = o.OrderID
inner join Products as p 
on p.ProductID = od.ProductID;

select claveCliente,Nombre,NombreProducto,Fechaorden,(Cantidadvendida*Precioventa) as' Importe' 
from vista_ventas
where NombreProducto ='chai'
AND (Cantidadvendida*Precioventa)>600
and DATEPART(YEAR,Fechaorden)=1996

--inner join de la vista copn supliers

SELECT * FROM vista_ventas as vv
inner join Suppliers as s 
on s.SupplierID= vv.Provedorid

select productName, Unitprice, UnitsInStock,
Discontinued,
disponibilidad = case Discontinued
when 0 then 'No disponible'
when 1 then 'Disponible'
else 'No existe'
end 
FROM Products

select ProductName,UnitsInStock, UnitPrice,
case 
when UnitPrice>=1 and UnitPrice<18 then 'Producto barato'
when UnitPrice >=18 and UnitPrice <=50 then 'Producto medio barato'
when UnitPrice between 51 and 100 then 'Producto caro'
else '¡Carisimo!'
end as 'Categoria de precios'
 from Products

--Usamos otra base de datos

 use AdventureWorks2019

 select BusinessEntityId, Salariedflag
 from HumanResources.Employee
 order BY
 case Salariedflag
 when 1 then BusinessEntityId
 end DESC,
 case 
 when Salariedflag =0 then BusinessEntityId
 end;


 select BusinessEntityID, LastName, TerritoryName, 
 CountryRegionName 
 from sales.vSalesPerson
 where TerritoryName is not NULL
 order BY 
       case CountryRegionName
       when 'United States' then TerritoryName
       else CountryRegionName
       END DESC
       
--Funcion isnull

--1ra
SELECT v.AccountNumber, v.Name,v.PurchasingWebServiceURL as 'PurchasingWebServiceURL'
from [Purchasing].[Vendor] as v;


--2da
SELECT v.AccountNumber, v.Name,
isnull (v.PurchasingWebServiceURL, 'NO URL') 
from [Purchasing].[Vendor] as v;

--3ra
SELECT v.AccountNumber, v.Name,
case  
when v.PurchasingWebServiceURL is null then 'No URL'
END 
as 'PurchasingWebServiceURL' 
from [Purchasing].[Vendor] as v;


--Funcion IIF 
SELECT IIF (1=1, 'verdadero', 'False') as 'Resultado'


create view vista_genero
as 
select e.LoginID,e.JobTitle, IIF(e.Gender='F','Mujer','Hombre') as 'sexo'  
from HumanResources.Employee as e;


select LOWER(JobTitle) 
from vista_genero
where sexo='Mujer'


--Merge

select OBJECT_ID(N'tempdb..#StudentsC1')


IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(    --# tabla temporal
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)




IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC1
select * FROM #StudentsC2

select * from #StudentsC1 as c1 
inner join #StudentsC2 as c2 
on c1.StudentID= c2.StudentID;

select * from #StudentsC1 as c1 
LEFT join #StudentsC2 as c2 
on c1.StudentID= c2.StudentID;

select * from #StudentsC1 as c1 
RIGHT join #StudentsC2 as c2 
on c1.StudentID= c2.StudentID;


insert into #StudentsC2 (StudentID,StudentName,StudentStatus)
select c1.StudentID,c1.StudentName,c1.StudentStatus from #StudentsC1 as c1 
LEFT join #StudentsC2 as c2 
on c1.StudentID= c2.StudentID
where c2.StudentID is NULL


UPDATE c2
set c2.StudentName = c1.StudentName,
    c2.StudentStatus = c1.StudentStatus
from #StudentsC1 as c1 
inner join #StudentsC2 as c2 
on c1.StudentID= c2.StudentID;


