--Parametros de salida
create or alter procedure calcular_area
--parametros de entrada
@radio float, 
--Parametro de salida
@area float output
as 
begin 
 set @area = pi() * (@radio*@radio)

end
go

declare @res float
exec calcular_area @radio= 22.3, @area = @res output
print'El area es: ' + cast(@res as varchar)
go


--Mostrar el nombre completo de un empleado determinado
create or alter procedure sp_obtenerDatos
@numeroEmpleado int,
@fullName nvarchar(35) output
as
begin
select @fullName=CONCAT(FirstName, ' ', LastName)
from Employees
where EmployeeID = @numeroEmpleado

end
go

declare @nombre varchar(35)
exec sp_obtenerDatos @numeroEmpleado=10,  @fullName = @nombre output
print 'El nombre completo es: ' + @nombre

--Mostrar lo mismo pero con una validacion
create or alter procedure sp_obtenerDatos2
@numeroEmpleado int,
@fullName nvarchar(35) output
as
begin
select @fullName=CONCAT(FirstName, ' ', LastName)
from Employees
where EmployeeID = @numeroEmpleado
if @fullName is null
begin
    print'No hay empleado'
end
else
begin
select @fullName=CONCAT(FirstName, ' ', LastName)
from Employees
where EmployeeID = @numeroEmpleado
end

end
go

declare @nombre varchar(35)
exec sp_obtenerDatos2 @numeroEmpleado=9,  @fullName = @nombre output
print 'El nombre completo es: ' + @nombre



