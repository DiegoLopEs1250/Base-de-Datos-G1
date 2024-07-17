use NORTHWND
go
---Realizar un sp que actualize los precios y registrar los registros en la tabla historicos

create or alter proc spu_Diego
@id int, @PrecioNuevo
as
  begin
    begin transaction
	  begin try;
	    -- Iniciar una transacción
        BEGIN TRANSACTION;

        -- Declarar una variable para almacenar el precio anterior
        DECLARE @PrecioAnterior DECIMAL(10, 2);
       
        -- Obtener el precio anterior
        SELECT @PrecioAnterior = p.UnitPrice
        FROM Products as p
        WHERE p.ProductID = @id;

        -- Actualizar el precio del producto
        UPDATE Products 
        SET UnitPrice = @PrecioNuevo
        WHERE ProductID = @id;

        -- Insertar el precio anterior en la tabla de PreciosHistoricos
        INSERT INTO PreciosHistoricos (id, PrecioAnterior, FechaModi)
        VALUES (@id, @PrecioAnterior, GETDATE());

        -- Confirmar la transacción
	   commit transaction;
	 end try
	begin catch;
	  declare @mensaError varchar (50);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
    end catch;
end;
go	

--realizar un sp que elimine una orden de compra completa (orders y orders details) y debe actualizar los unitsInStock
create or alter proc spu_Cancelar_Compra
@orden int
as
  begin
    begin transaction
	  begin try;

	  update Products
	  set UnitsInStock = UnitsInStock + od.Quantity
	  from
	  [Order Details] as od
	  inner join Products as p
	  on p.ProductID = od.ProductID
	  where od.OrderID = @orden

	  delete from [Order Details] 	  
	  where OrderID = @orden
	 
	  delete from Products 	  
	  where ProductID = @orden

	   commit transaction;
	end try
	begin catch;
	  declare @mensaError varchar (50);
	  set @mensaError = ERROR_MESSAGE();
	  print @mensaError;
    end catch;
end;

exec spu_Cancelar_Compra 10248


 select * from Products as p
 inner join [Order Details] as od
 on p.ProductID = od.ProductID
 where od.OrderID = 10285 


 select * from Products
 select * from [Order Details]