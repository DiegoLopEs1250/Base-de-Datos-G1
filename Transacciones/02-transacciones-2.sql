--Ejercicio2: Insertar una venta
use NORTHWND


create or alter proc spu_AgrgarVenta
@CustomerID nchar(5),
@EmployeeID int,
@OrderDate datetime,
@RequiredDate datetime,
@ShippedDate datetime,
@ShipVia int,
@Freight money = null,
@ShipName nvarchar(40) =null,
@ShipAddress nvarchar(60)=null,
@ShipCity nvarchar(15)=null,
@ShipRegion nvarchar(15)=null,
@ShipPostalCode nvarchar(10)=null,
@ShipCountry nvarchar(15)=null,
@ProductID int,
@Quantity smallint,
@Discount real = 0

as
begin
  begin transaction;
   begin try
     INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
(@CustomerID,
@EmployeeID,
@OrderDate, 
@RequiredDate, 
@ShippedDate, 
@ShipVia,
@Freight,
@ShipName,
@ShipAddress,
@ShipCity,
@ShipRegion,
@ShipPostalCode,
@ShipCountry)
--Obtener el id insertado en orders
Declare @orderid int;
set @orderid = SCOPE_IDENTITY();

--obtener el precio de venta del prodcuto

declare @precioVenta money
select UnitPrice 
from Products
where ProductID = @ProductID
--insertar en order details
INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES(@orderid,
           @ProductID,
           @precioVenta,
           @Quantity,
           @Discount
		   )

		   --Actualizar la tabla de producs
		   update Products
		   set UnitsInStock = UnitsInStock - @Quantity
		   where ProductID = @ProductID;

		   commit transaction
   end try
    begin catch
	rollback transaction
	declare @mensajeError nvarchar(400)
	set @mensajeError = ERROR_MESSAGE();
	print @mensajeError;
	end catch;
end;
go


