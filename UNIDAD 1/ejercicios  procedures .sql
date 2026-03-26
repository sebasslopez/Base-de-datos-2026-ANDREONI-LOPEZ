
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
 