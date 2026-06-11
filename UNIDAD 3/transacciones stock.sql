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


DELIMITER $$

CREATE PROCEDURE actualizar_precio_categoria(IN p_idCategoria INT,IN p_porcentajeAumento INT)
BEGIN
    DECLARE v_existe_categoria INT;
    DECLARE v_tiene_productos INT;
    START TRANSACTION;
    SELECT COUNT(*) INTO v_existe_categoria FROM categoria
    WHERE idCategoria = p_idCategoria;
    IF v_existe_categoria = 0 THEN
        rollback;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: categoría inexistente';
    END IF;

    SELECT COUNT(*) INTO v_tiene_productos FROM producto
    WHERE Categoria_idCategoria = p_idCategoria;
    IF v_tiene_productos > 0 THEN
        UPDATE producto
        SET precio = precio * (1 + (p_porcentajeAumento / 100))
        WHERE Categoria_idCategoria = p_idCategoria;
    END IF;
    COMMIT;
END$$

CREATE PROCEDURE registrar_ingreso_stock(IN p_idProveedor INT,IN p_codProducto INT,IN p_idProvincia INT,IN p_cantidad INT)
BEGIN
    DECLARE v_provincia_proveedor INT;
    DECLARE v_idIngreso INT;
    DECLARE v_nuevo_item INT;
    START TRANSACTION;
    SELECT Provincia_idProvincia INTO v_provincia_proveedor FROM proveedor WHERE idProveedor = p_idProveedor;
    IF v_provincia_proveedor IS NULL OR v_provincia_proveedor != p_idProvincia THEN
        rollback;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ingreso rechazado: el proveedor no está habilitado para operar en esta provincia';
    END IF;

    SELECT IFNULL(MAX(idIngreso), 0) + 1 INTO v_idIngreso FROM ingresostock;
    INSERT INTO ingresostock (idIngreso, fecha, remitoNro, Proveedor_idProveedor)
    VALUES (v_idIngreso, NOW(), NULL, p_idProveedor);
    SELECT IFNULL(MAX(item), 0) + 1 INTO v_nuevo_item FROM ingresostock_producto WHERE IngresoStock_idIngreso = v_idIngreso;
    INSERT INTO ingresostock_producto (item, cantidad, IngresoStock_idIngreso, Producto_codProducto)
    VALUES (v_nuevo_item, p_cantidad, v_idIngreso, p_codProducto);
    UPDATE producto
    SET stock = IFNULL(stock, 0) + p_cantidad
    WHERE codProducto = p_codProducto;
    COMMIT;
END$$

DELIMITER ;