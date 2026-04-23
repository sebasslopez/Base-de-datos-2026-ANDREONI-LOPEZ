
 /*
 #1
delimiter //

create procedure listarProductos(out cprod int)
begin 
    select count(productCode) into cprod from products
    where buyPrice > (select avg(buyPrice) from products);
end //

delimiter ;
 
 #2
 delimiter //
create procedure borrarOrden( in porderNumber int, out presultado int)
begin
    declare cant int;
    select count(*) into cant from orderdetails where orderNumber = porderNumber;

    if cant = 0 then
        set presultado = 0;
        
    else
        delete from orderDetails
        where orderNumber = porderNumber;
        
        delete from orders
        where orderNumber = porderNumber;
        
        set presultado = cant;
        
    end if ;
end //
delimiter ;

#8
delimiter //
create procedure juan (out val int, in orderNUM int, in coment varchar(50))
begin 

update orders 
set comments =  coment
where orderNumber = orderNUM;

if exist orderNUM then
    set val = 1;
 else 
 set val=0;
 end if;
 
 end//
 delimiter ;
 
 #funcion 4
 delimiter //
 create function pedro (product text) returns int deterministic
 begin 
 declare cantprod int default 0;
 select count(productCode) into cantprod from products 
where productLine = product;
 return cantprod;
 end//
 delimiter ;
 
 delimiter // 
 create procedure borrarPL (out mensaje varchar(50))
 begin */
 
 #9
 /*
delimiter //
create procedure recorro (out lista varchar(4000))
begin
declare hayFilas boolean default 1;
declare variable1 int;
declare nombreCursor cursor for select city from offices;
declare continue handler for not found set hayFilas = 0;
open nombreCursor;
bucle:loop
fetch nombreCursor into variable1;
if hayFilas = 0 then
leave bucle;
end if;
set lista = variable1 + "," + lista;
end loop bucle;
close nombreCursor;
end//
delimiter ;

delimiter //
create procedure insertCancelledOrders ()
begin
declare hayFilas boolean default 1;
declare variable1 int;
declare nombreCursor cursor for select * from orders;
declare continue handler for not found set hayFilas = 0;
open nombreCursor;
bucle:loop
fetch nombreCursor into variable1;
if hayFilas = 0 then
leave bucle;
end if;
if (nombreCursor.status = 'Cancelled') then
insert into cancelledOrders values(
nombreCursor.orderNumber,
nombreCursor.orderDate,
nombreCursor.rrequiredDate,
nombreCursor.shippedDate,
nombreCursor.status,
nombreCursor.comments,
nombreCursor.customerNumber
);
end if;
end loop bucle;
close nombreCursor;
end//
delimiter ;

#11
delimiter //
CREATE PROCEDURE alterCommentOrder(IN p_customerNumber INT)
BEGIN
    UPDATE orders o
    SET o.comments = (
        SELECT CONCAT('El total de la orden es ... ', SUM(od.quantityOrdered * od.priceEach))
        FROM orderdetails od
        WHERE od.orderNumber = o.orderNumber
    )
    WHERE o.customerNumber = p_customerNumber 
      AND (o.comments IS NULL OR o.comments = '');
END //

#13
CREATE PROCEDURE actualizarComision()
BEGIN
    UPDATE employees e
    LEFT JOIN (
        SELECT c.salesRepEmployeeNumber, SUM(od.quantityOrdered * od.priceEach) as totalVentas
        FROM orders o
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        JOIN customers c ON o.customerNumber = c.customerNumber
        WHERE o.status != 'Cancelled'
        GROUP BY c.salesRepEmployeeNumber
    ) ventas ON e.employeeNumber = ventas.salesRepEmployeeNumber
    SET e.comision = CASE 
        WHEN ventas.totalVentas > 100000 THEN ventas.totalVentas * 0.05
        WHEN ventas.totalVentas BETWEEN 50000 AND 100000 THEN ventas.totalVentas * 0.03
        ELSE 0
    END;
END //

#14
CREATE PROCEDURE asignarEmpleados()
BEGIN
    DECLARE v_emp_id INT;

    SELECT employeeNumber INTO v_emp_id
    FROM employees e
    LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    WHERE e.jobTitle = 'Sales Rep'
    GROUP BY e.employeeNumber
    ORDER BY COUNT(c.customerNumber) ASC
    LIMIT 1;


    UPDATE customers
    SET salesRepEmployeeNumber = v_emp_id
    WHERE salesRepEmployeeNumber IS NULL;
END //
delimiter ;

#3
delimiter //
create procedure borrarProductLines(IN line int)
begin
if(productosEnLine(line) = 0) then
delete from productlines p
where line = p.producLine;
select "La línea de productos fue borrada.";
else
select "La línea de productos no pudo borrarse porque contiene productos asociados.";
end if;
end//
delimiter ;

#4
delimiter //
create procedure listarPorEstado()
begin
select count(*) from orders
group by status;
end//
delimiter ;

#6
delimiter //
create procedure listarOrdenes()
begin
select orderNumber,sum(quantityOrdered * priceEach) from orderdetails
group by orderNumber;
end//
*/

#reporte ventas
delimiter //
create procedure insertReportesVentas()
begin
declare hayFilas boolean default 1;
declare variable1 int;
declare nombreCursor cursor for select o.orderNumber,o.status,timediff(DAY,o.shippedDate,o.requiredDate),c.customerName,c.country, from orders o
join customers c on c.customerNumber = o.customerNumber;
declare continue handler for not found set hayFilas = 0;
open nombreCursor;
bucle:loop
fetch nombreCursor into variable1;
if hayFilas = 0 then
leave bucle;
end if;
insert into cancelledOrders values(
nombreCursor.orderNumber,
nombreCursor.orderDate,
nombreCursor.rrequiredDate,
nombreCursor.shippedDate,
nombreCursor.status,
nombreCursor.comments,
nombreCursor.customerNumber
);
end loop bucle;
close nombreCursor;
end//
delimiter ;