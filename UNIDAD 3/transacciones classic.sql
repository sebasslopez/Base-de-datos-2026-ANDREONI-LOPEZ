#1 (classicModels)

delimiter //

create procedure compraSegura (in codCliente int, in codProducto int, in cantidad int, in fechaEntrega date)
begin
    declare stock int default 0;
    declare precio int default 0;
    declare numOrder int default 0;
    start transaction;
    select buyprice,quantityInStock into precio,stock from products where productCode = codProducto FOR UPDATE;
    select ifnull(max(orderNumber),0)+1 into numOrder from orders;
    insert into orders(orderNumber,requiredDate,orderDate,status,customerNumber)
        values(
               numOrder,
               fechaEntrega,
               curdate(),
                'In process',
               codCliente
              );
    insert into orderdetails values(
        numOrder,
        codProducto,
        cantidad,
        precio,
        1
   );
    update products set quantityInStock = quantityInStock - cantidad
    where productCode = codProducto;
    if(stock - cantidad < 0) then
        rollback;
        signal sqlstate "45000" set message_text = "Error, stock insuficiente";
    else
        commit;
    end if;
end //

delimiter ;

#3 (ClassicModels)

delimiter //

create procedure cancelarPedido(in numOrder int)
begin
    declare estadoActual text;
    start transaction;
    select status into estadoActual from orders where orderNumber = numOrder for update;
    update orders set status = 'Cancelled' where orderNumber = numOrder;
    update products p join orderdetails od on od.productCode = p.productCode join orders o on o.orderNumber = od.orderNumber set quantityInStock = quantityInStock+od.quantityOrdered where o.orderNumber = numOrder;
    if estadoActual = 'Shipped' then
        rollback;
        signal sqlstate "45000" set message_text = "Error: No se puede cancelar un pedido que ya fue enviado";
    else
        commit;
    end if;
end//

delimiter ;

#4 (classicModels)

delimiter //

create procedure cambiarVendedor(in viejo int, in nuevo int)
begin
    declare oficinaNuevo text default null;
    declare oficinaViejo text default '';
    start transaction;
    select officeCode into oficinaNuevo from employees
    where employeeNumber = nuevo  FOR UPDATE ;
    select officeCode into oficinaViejo from employees
    where employeeNumber = viejo;
    update customers set salesRepEmployeeNumber = nuevo
    where salesRepEmployeeNumber = viejo;
    if( nuevo is null OR nuevo != viejo ) then
        rollback;
        signal sqlstate "45000" set message_text = "Error: No existe el nuevo empleado o no es de esa zona.";
    else
        commit;
    end if;
end //

delimiter ;

