#3
/*
delimiter //
create function cliente (idcliente int) returns varchar(50) deterministic
begin
declare ciudadem varchar(50) default ""; 
select o.city into cuidadem from offices o 
join employees e on e.officeCode = o.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
 where c.customerNumber = idcliente;
 return cuidadem;
 end//
 delimiter ;
 #7
 delimiter //
 create function beneficios (numorden int, numproduct int) returns int deterministic
 begin 
 declare bene int default 0;
 select od.priceEach - p.buyPrice from products p
 join orderdetails od on od.productCode = p.productCode;
 return bene;
 end//
 delimiter ;
 
 #8
 delimiter //
 create function juan ( numero int) returns int deterministic
 begin
 declare num varchar(50) default "" ;
 select o.status into num from orders o where o.orderNumber= numero;
 if num == "cancelado" then
 return -1;
 else 
 return 0;
 end if;
 end;
 // delimiter;*/
 
 #4
 delimiter //
 create function productosEnLine(id int) returns int deterministic
 begin
declare cant int default 0;
select count(*) into cant from products p
where p.productLine = id;
return cant;
 end//
 
 delimiter //
 create function productosCompra(id int) returns int deterministic
 begin
declare cant int default 0;
select count(*) into cant from orderdetails p
where p.orderNumber = id;
return cant;
 end//
 
 
 
 
 