delimiter //
create procedure stk (in codProd int, in estante text, in cant int)

begin
declare cantact int;
declare stockg int;
start transaction;
select stock into stockg from producto
  where producto.codProducto =codProd for update;
select cantidad into cantact  from producto_ubicacion
    where Producto_codProducto=codProd and estante= estanteria for update;
if (stockg - cant)<0 or (cantact - cant)<0 then
    rollback ;
     signal sqlstate "45000" set message_text = "Error, stock insuficiente";
end if //
update producto_ubicacion set cantidad=cantidad-cant
    where Producto_codProducto= codProd and estanteria= estante;
update producto set stock = stock - cant
    where codProducto=codProd;
commit;

end //