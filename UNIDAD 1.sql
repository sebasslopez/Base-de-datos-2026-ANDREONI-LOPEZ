/*
#1
delimiter //
create function pagada (compra int) returns boolean deterministic 
begin
declare spago int default 0;
declare precio int default 0;
select sum(monto) into spago from pago p where p.compra_id = id;
select c.precio into precio from compra c where c.id= id;
if precio = spago then
return true;
else 
return false;
end if ;
end//
delimiter ;

#2
delimiter //
create function comision ( dni int) returns float deterministic
begin
declare cant int default 0;
declare comision float default 0;
declare anios int default 0;
select TIMESTAMPDIFF(YEAR, fechaIngreso, CURDATE()) into anios from empleado;
if anios < 5 then
set cant = 5;
else if 10>anios>5 then 
set cant =7;
else 
set cant= 10;
end if;
end if;
select (sum(precio)*cant)/100 into  comision from compras where empleado_dni=dni;
return comision;
end//
delimiter ;

#3
delimiter //
create function autos (modelo int, fecha date) returns int deterministic
begin
declare cant int default 0;
select count(modelo) into cant from auto 
join compra c on c.auto_patente=patente
where month(c.fecha) = month(fecha);
return cant;
end//
delimiter ;

#4
create view resuventas as select dni, mail, fecha, patente, color,marca, pagada(compra.id) from cliente
join compra on cliente_dni=dni
join auto on patente=auto_patente
join modelo on modelo_id=id;


#5
create view resvenmes as select m.id,count(c.id), sum(p.monto), autos(m.id) from modelo
join pago p on compra_id=c.id
join auto a on auto_patente=a.patente
join modelo m on m.id=modelo_id;
*/
