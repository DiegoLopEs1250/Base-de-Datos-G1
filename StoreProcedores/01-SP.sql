use NORTHWND

--Declaracion y uso de variables en transact-sql

--Declaracion de una variable
declare @numeroCal INT
declare @calif DECIMAL(10,2)
--Asiganacion de variables
SET @numeroCal=10
IF @numeroCal <=0
BEGIN
set @numeroCal = 1
end 

DECLARE @i=1

WHILE (@1<=@numeroCal)
BEGIN
set @calif+10
set @i=@i+1
set @calif= @calif/@numeroCal
PRINT('El resultado es: '+@calif)
