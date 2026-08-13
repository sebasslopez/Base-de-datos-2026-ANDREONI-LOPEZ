delimiter $$
create procedure listarProductos(in prod int)
begin
    declare nombre varchar(500) default nombre = (select pr.nombre from productos pr where pr.id_producto = prod);
    select p.id_publicacion, pr.nombre,p.precio from publicaciones p
    join productos pr on p.id_producto = pr.id_producto
    where pr.nombre like concat('%',nombre,'%') or pr.descripcion like concat('%',nombre,'%');
end $$

create procedure pujar(in idPubli int,in cant int)
begin
        if(idpubli in (select id_publicacion from subastas)) then

        end if;
end $$

delimiter ;