
use NORTHWND
--Procedimiento para actalizar el precio de un producto y registrar el cambio 
--paso 1: crear un sp "Actualizar_precio_producto"
--paso 2: crear una tabla que se llame "cambio_Precios" los campos que va a tener cambioid int identity primary key, productoin int, precioanterior money, precio nuevo money, fechacambio date
--paso 3: debe aceptar 2 parametros producto a cambiar y el nuevo precio
--paso 4: el sp debe actualizar el precio en la tabla products
--paso 5: el sp debe insertar un registro cambio de precios con los detalles del cambio.

select * from Products

create table cambioPrecio (
cambioid int not null identity (1,1) primary key,
productoid int not null,
precioan money not null,
precionuev money not null,
fechacambio date not null
);

go
create or alter proc sp_Actualizar_precio_producto
@nuevo_precio money, @producto_cambiar nvarchar (40)

 as 
  begin 
    
    declare @precio_antiguo money 
	select unitprice from Products

  end
go