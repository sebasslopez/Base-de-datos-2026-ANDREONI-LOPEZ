
CREATE INDEX idx_productos_nombre ON productos(nombre);
CREATE UNIQUE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_publicaciones_estado_fecha ON publicaciones(estado, fecha_publicacion);
CREATE INDEX idx_publicaciones_estado_finalizacion ON publicaciones(estado, fecha_finalizacion);

DELIMITER $$

DROP FUNCTION IF EXISTS tiempo_promedio_venta$$
CREATE FUNCTION tiempo_promedio_venta(p_id_usuario INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_promedio INT;

    SELECT AVG(TIMESTAMPDIFF(HOUR , p.fecha_publicacion, t.fecha_transaccion))
    INTO v_promedio
    FROM publicaciones p
    JOIN transacciones t ON t.id_publicacion = p.id_publicacion
    WHERE p.id_usuario_vendedor = p_id_usuario AND t.estado = 'CONCRETADA';
    RETURN v_promedio;
END$$

DROP FUNCTION IF EXISTS comision$$
CREATE FUNCTION comision(p_monto INT, p_nivel VARCHAR(20))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_comision INT;

    IF p_nivel = 'NORMAL' THEN
        SET v_comision = p_monto * 0.08;
    ELSEIF p_nivel = 'PLATINUM' THEN
        SET v_comision = p_monto * 0.05;
    ELSEIF p_nivel = 'GOLD' THEN
        SET v_comision = p_monto * 0.03;
    ELSE
        SET v_comision = -1;
    END IF;

    RETURN v_comision;
END$$

DROP FUNCTION IF EXISTS porcentaje_ventas$$
CREATE FUNCTION porcentaje_ventas(p_id_usuario INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_total INT;
    DECLARE v_concretadas INT;

    SELECT COUNT(*)
    INTO v_total
    FROM publicaciones
    WHERE id_usuario_vendedor = p_id_usuario;

    if(v_total = 0) then
        return 0;
    end if ;

    SELECT COUNT(*)
    INTO v_concretadas
    FROM publicaciones p
    JOIN transacciones t ON t.id_publicacion = p.id_publicacion
    WHERE p.id_usuario_vendedor = 1 AND t.estado = 'CONCRETADA';

    RETURN v_concretadas * 100.0 / v_total;
END$$

DROP FUNCTION IF EXISTS mayor_puja$$
CREATE FUNCTION mayor_puja(p_id_publicacion INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE v_es_subasta INT;
    DECLARE v_oferta INT;

    SELECT COUNT(*)
    INTO v_es_subasta
    FROM subastas
    WHERE id_publicacion = p_id_publicacion;

    IF v_es_subasta = 0 THEN
        RETURN -1;
    END IF;

    SELECT oferta_maxima
    INTO v_oferta
    FROM subastas
    WHERE id_publicacion = p_id_publicacion;

    RETURN v_oferta;
END$$

DROP FUNCTION IF EXISTS precio_promedio_categoria$$
CREATE FUNCTION precio_promedio_categoria(p_id_categoria INT)
RETURNS INT DETERMINISTIC

BEGIN
    DECLARE v_promedio INT;

    SELECT AVG(precio)
    INTO v_promedio
    FROM publicaciones
    WHERE id_categoria = p_id_categoria;

    RETURN v_promedio;
END$$

DROP FUNCTION IF EXISTS ultima_compra$$
CREATE FUNCTION ultima_compra(p_id_usuario INT)
RETURNS DATETIME DETERMINISTIC
BEGIN
    DECLARE v_fecha DATETIME;

    SELECT MAX(fecha_transaccion)
    INTO v_fecha
    FROM transacciones
    WHERE id_usuario_comprador = p_id_usuario AND estado = 'CONCRETADA';

    RETURN v_fecha;
END$$

DROP PROCEDURE IF EXISTS buscar_publicaciones$$
CREATE PROCEDURE buscar_publicaciones(
    IN p_nombre VARCHAR(150),
    OUT p_ok BOOLEAN
)
BEGIN
    IF p_nombre IS NULL OR p_nombre = '' THEN
        SET p_ok = 0;
    ELSE
        SET p_ok = 1;
        SELECT p.id_publicacion,
               pr.nombre AS titulo,
               p.precio
        FROM publicaciones p
         JOIN productos pr ON pr.id_producto = p.id_producto
        WHERE pr.nombre LIKE CONCAT('%', p_nombre, '%')
           OR pr.descripcion LIKE CONCAT('%', p_nombre, '%');
    END IF;
END$$

DROP PROCEDURE IF EXISTS pujar$$
CREATE PROCEDURE pujar(
    IN p_id_publicacion INT,
    IN p_id_usuario INT,
    IN p_monto INT,
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_es_subasta INT DEFAULT 0;
    DECLARE v_estado VARCHAR(20);
    DECLARE v_vendedor INT;
    DECLARE v_maximo INT;

    SET p_ok = 0;

    SELECT COUNT(*)
    INTO v_es_subasta
    FROM subastas
    WHERE id_publicacion = p_id_publicacion;

    IF v_es_subasta = 1 THEN
        SELECT p.estado, p.id_usuario_vendedor
        INTO v_estado, v_vendedor
        FROM publicaciones p
        WHERE p.id_publicacion = p_id_publicacion;

        SELECT IFNULL(oferta_maxima, 0)
        INTO v_maximo
        FROM subastas
        WHERE id_publicacion = p_id_publicacion;

        IF v_estado = 'ACTIVA'
           AND p_id_usuario <> v_vendedor
           AND p_monto > v_maximo THEN
            UPDATE subastas
            SET oferta_maxima = p_monto,
                id_usuario_ofertante = p_id_usuario
            WHERE id_publicacion = p_id_publicacion;
            SET p_ok = 1;
        END IF;
    END IF;
END$$

DROP PROCEDURE IF EXISTS pausar_publicacion$$
CREATE PROCEDURE pausar_publicacion(
    IN p_id_publicacion INT,
    IN p_id_usuario INT,
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_estado VARCHAR(20);
    DECLARE v_vendedor INT;
    DECLARE v_es_venta_directa INT DEFAULT 0;

    SET p_ok = 0;

    SELECT p.estado, p.id_usuario_vendedor
    INTO v_estado, v_vendedor
    FROM publicaciones p
    WHERE p.id_publicacion = p_id_publicacion;

    SELECT COUNT(*)
    INTO v_es_venta_directa
    FROM ventas_directas
    WHERE id_publicacion = p_id_publicacion;

    IF v_es_venta_directa = 1
       AND v_estado <> 'FINALIZADA'
       AND p_id_usuario = v_vendedor THEN
        UPDATE publicaciones
        SET estado = 'PAUSADA'
        WHERE id_publicacion = p_id_publicacion;
        SET p_ok = 1;
    END IF;
END$$

DROP PROCEDURE IF EXISTS actualizar_nivel$$
CREATE PROCEDURE actualizar_nivel(
    IN p_id_usuario INT,
    OUT p_nuevo_nivel VARCHAR(20),
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_ventas INT;

    SET p_ok = 0;
    SET p_nuevo_nivel = NULL;

    SELECT cantidad_ventas
    INTO v_ventas
    FROM usuarios
    WHERE id_usuario = p_id_usuario;

    IF v_ventas IS NOT NULL THEN
        IF v_ventas >= 10 THEN
            SET p_nuevo_nivel = 'PLATINUM';
        ELSEIF v_ventas >= 5 THEN
            SET p_nuevo_nivel = 'GOLD';
        ELSE
            SET p_nuevo_nivel = 'NORMAL';
        END IF;

        UPDATE usuarios
        SET nivel = p_nuevo_nivel
        WHERE id_usuario = p_id_usuario;

        SET p_ok = 1;
    END IF;
END$$

DROP PROCEDURE IF EXISTS calificar_usuario$$
CREATE PROCEDURE calificar_usuario(
    IN p_id_transaccion INT,
    IN p_id_usuario_calificador INT,
    IN p_id_usuario_calificado INT,
    IN p_satisfaccion TINYINT,
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_comprador INT;
    DECLARE v_vendedor INT;
    DECLARE v_estado VARCHAR(20);
    DECLARE v_existe INT DEFAULT 0;

    SET p_ok = 0;

    SELECT id_usuario_comprador, id_usuario_vendedor, estado
    INTO v_comprador, v_vendedor, v_estado
    FROM transacciones
    WHERE id_transaccion = p_id_transaccion;

    IF v_estado = 'CONCRETADA'
       AND p_satisfaccion BETWEEN 0 AND 100
       AND (p_id_usuario_calificador = v_comprador OR p_id_usuario_calificador = v_vendedor)
       AND (p_id_usuario_calificado = v_comprador OR p_id_usuario_calificado = v_vendedor)
       AND p_id_usuario_calificador <> p_id_usuario_calificado THEN

        SELECT COUNT(*)
        INTO v_existe
        FROM calificaciones
        WHERE id_transaccion = p_id_transaccion
          AND id_usuario_calificado = p_id_usuario_calificado;

        IF v_existe = 0 THEN
            INSERT INTO calificaciones(
                id_transaccion,
                id_usuario_calificado,
                id_usuario_calificador,
                operacion_concretada,
                satisfaccion
            )
            VALUES(
                p_id_transaccion,
                p_id_usuario_calificado,
                p_id_usuario_calificador,
                TRUE,
                p_satisfaccion
            );

            SET p_ok = 1;
        END IF;
    END IF;
END$$

DROP PROCEDURE IF EXISTS ganador_subasta$$
CREATE PROCEDURE ganador_subasta(
    IN p_id_publicacion INT,
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_es_subasta INT DEFAULT 0;

    SET p_ok = 0;

    SELECT COUNT(*)
    INTO v_es_subasta
    FROM subastas
    WHERE id_publicacion = p_id_publicacion;

    IF v_es_subasta = 1 THEN
        SELECT u.id_usuario AS usuario,
               u.email,
               pr.nombre AS producto,
               #Es probable que la cantidad de oferentes de 0 porque subastas_update_audit no tiene nada.
               (select count(*) from subastas_update_audit where id_subasta = s.id_publicacion) AS cantidad_oferentes,
               p.precio AS valor_inicial,
               IFNULL(s.oferta_maxima, 0) AS valor_ganador
        FROM subastas s
        JOIN publicaciones p ON p.id_publicacion = s.id_publicacion
        JOIN productos pr ON pr.id_producto = p.id_producto
        JOIN usuarios u ON u.id_usuario = s.id_usuario_ofertante
        WHERE s.id_publicacion = p_id_publicacion;

        SET p_ok = 1;
    END IF;
END$$

DROP PROCEDURE IF EXISTS crear_pregunta$$
CREATE PROCEDURE crear_pregunta(
    IN p_id_publicacion INT,
    IN p_id_usuario INT,
    IN p_pregunta TEXT,
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_estado VARCHAR(20);
    DECLARE v_vendedor INT;

    SET p_ok = 0;

    SELECT estado, id_usuario_vendedor
    INTO v_estado, v_vendedor
    FROM publicaciones
    WHERE id_publicacion = p_id_publicacion;

    IF v_estado = 'ACTIVA'
       AND p_pregunta IS NOT NULL
       AND TRIM(p_pregunta) <> ''
       AND p_id_usuario <> v_vendedor THEN

        INSERT INTO interaccion(id_publicacion,id_pregunta,id_usuario,interaccion,fecha_interaccion)
        VALUES(p_id_publicacion,null, p_id_usuario, p_pregunta,current_timestamp);

        SET p_ok = 1;
    END IF;
END$$

DROP PROCEDURE IF EXISTS estadisticas_vendedor$$
CREATE PROCEDURE estadisticas_vendedor(
    IN p_id_usuario INT
)
BEGIN
    declare cantActivas int default 0;
    declare cantFinalizadas int default 0;
    declare ventas int default 0;
    declare Facturacion float default 0;
    declare avgProductos int default 0;
    declare preguntas int default 0;

    select count(*),avg(p.precio) into cantActivas,avgProductos from publicaciones p
    where p.id_usuario_vendedor = p_id_usuario and p.estado = 'ACTIVA';

    select count(*) into cantFinalizadas from publicaciones p
    where p.id_usuario_vendedor = p_id_usuario and p.estado = 'FINALIZADA';

    select sum(obtenerPreguntasDePublicacion(p.id_publicacion)) into preguntas from publicaciones p
    where p.id_usuario_vendedor = p_id_usuario;

    select count(*),sum(t.monto) into ventas,Facturacion from transacciones t
    where t.id_usuario_vendedor = p_id_usuario and t.estado = 'CONCRETADA';

    select cantActivas,cantActivas,ventas,Facturacion,avgProductos,preguntas,tiempo_promedio_venta(p_id_usuario);
END$$

DROP PROCEDURE IF EXISTS top_vendedores_mes$$
CREATE PROCEDURE top_vendedores_mes(
    IN p_fecha_inicio DATETIME,
    IN p_fecha_fin DATETIME,
    OUT p_ok BOOLEAN
)
BEGIN
    SET p_ok = 0;

    IF p_fecha_inicio IS NOT NULL
       AND p_fecha_fin IS NOT NULL
       AND p_fecha_inicio <= p_fecha_fin THEN

        SELECT u.id_usuario,
               CONCAT(u.nombre, ' ', u.apellido) AS vendedor,
               COUNT(t.id_transaccion) AS ventas
        FROM usuarios u
         JOIN transacciones t
            ON t.id_usuario_vendedor = u.id_usuario
           AND t.estado = 'CONCRETADA'
           AND t.fecha_transaccion BETWEEN p_fecha_inicio AND p_fecha_fin
        GROUP BY u.id_usuario, u.nombre, u.apellido
        ORDER BY ventas DESC
        LIMIT 10;

        SET p_ok = 1;
    END IF;
END$$

DROP PROCEDURE IF EXISTS notificar_preguntas$$
CREATE PROCEDURE notificar_preguntas()
BEGIN
    SELECT u.id_usuario,
           u.email,
           CONCAT(
               'La publicación sobre ',
               pr.nombre,
               ' tiene ',
               COUNT(q.id_pregunta),
               ' sin responder'
           ) AS mensaje
    FROM usuarios u
     JOIN publicaciones p ON p.id_usuario_vendedor = u.id_usuario
     JOIN productos pr ON pr.id_producto = p.id_producto
     JOIN interaccion q ON q.id_publicacion = p.id_publicacion
    WHERE p.estado IN ('ACTIVA','OBSERVADA')
      AND q.id_pregunta IS NOT NULL
    GROUP BY u.id_usuario, u.email, p.id_publicacion, pr.nombre;
END$$

DROP PROCEDURE IF EXISTS generar_estadisticas$$
CREATE PROCEDURE generar_estadisticas()
BEGIN
    SELECT 'VENDEDORES' AS tipo,
           COUNT(DISTINCT id_usuario_vendedor) AS cantidad_vendedores,
           COUNT(*) AS ventas,
           IFNULL(SUM(monto), 0) AS facturacion
    FROM transacciones
    WHERE estado = 'CONCRETADA';

    SELECT 'COMPRADORES' AS tipo,
           COUNT(DISTINCT id_usuario_comprador) AS cantidad_compradores,
           COUNT(*) AS compras,
           IFNULL(SUM(monto), 0) AS gasto_total
    FROM transacciones
    WHERE estado = 'CONCRETADA';

    SELECT 'PRODUCTOS' AS tipo,
           COUNT(*) AS cantidad_productos,
           COUNT(DISTINCT id_producto) AS productos_publicados
    FROM publicaciones;
END$$

DROP TRIGGER IF EXISTS preguntas_delete$$
CREATE TRIGGER preguntas_delete
BEFORE DELETE ON interaccion
FOR EACH ROW
BEGIN
    DELETE FROM interaccion
    WHERE id_pregunta = OLD.id_pregunta;
END$$

DROP TRIGGER IF EXISTS venta_nivel$$
CREATE TRIGGER venta_nivel
AFTER UPDATE ON transacciones
FOR EACH ROW
BEGIN
    IF NEW.estado = 'CONCRETADA' AND OLD.estado <> 'CONCRETADA' THEN
        UPDATE usuarios
        SET cantidad_ventas = cantidad_ventas + 1,
            facturacion = facturacion + NEW.monto
        WHERE id_usuario = NEW.id_usuario_vendedor;
        call actualizar_nivel(new.id_usuario_vendedor,@var1,@var2);
    END IF;
END$$

DROP TRIGGER IF EXISTS reputacion$$
CREATE TRIGGER reputacion
AFTER INSERT ON calificaciones
FOR EACH ROW
BEGIN
    UPDATE usuarios u
    SET u.reputacion = (
        SELECT AVG(c.satisfaccion)
        FROM calificaciones c
        WHERE c.id_usuario_calificado = NEW.id_usuario_calificado
    )
    WHERE u.id_usuario = NEW.id_usuario_calificado;
END$$



DROP TRIGGER IF EXISTS puja$$
CREATE TRIGGER puja
BEFORE UPDATE ON subastas
FOR EACH ROW
BEGIN
    DECLARE v_estado VARCHAR(20);
    DECLARE v_vendedor INT;

    SELECT estado, id_usuario_vendedor
    INTO v_estado, v_vendedor
    FROM publicaciones
    WHERE id_publicacion = NEW.id_publicacion;

    IF v_estado <> 'ACTIVA'
       OR NEW.id_usuario_ofertante = v_vendedor
       OR NEW.oferta_maxima <= IFNULL(OLD.oferta_maxima, 0) THEN
        SIGNAL SQLSTATE '45000';
    else
        insert into subastas_update_audit(id_subasta,id_ofertante_anterior,anterior_oferta) values(
                new.id_publicacion,
               old.id_usuario_ofertante,
                old.oferta_maxima
            );
    END IF;

END$$

DROP VIEW IF EXISTS preguntas_sin_responder$$
CREATE VIEW preguntas_sin_responder AS
select i.id_pregunta,i.interaccion,i.id_publicacion,pr.nombre,p.id_usuario_vendedor from interaccion i
join publicaciones p on i.id_publicacion = p.id_publicacion
join productos pr on pr.id_producto = p.id_producto
where p.estado = 'ACTIVA' and i.id_pregunta is null and i.id_interaccion not in (select t.id_pregunta from interaccion t where t.id_pregunta is not NULL);


DROP VIEW IF EXISTS top_categorias_semana$$
CREATE VIEW top_categorias_semana AS
SELECT c.id_categoria,
       c.nombre AS categoria,
       COUNT(p.id_publicacion) AS publicaciones
FROM categorias c
 JOIN publicaciones p ON p.id_categoria = c.id_categoria
WHERE p.fecha_publicacion >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY c.id_categoria, c.nombre
ORDER BY publicaciones DESC
LIMIT 10$$

DROP VIEW IF EXISTS publicaciones_tendencia$$
CREATE VIEW publicaciones_tendencia AS
select * from publicaciones p
where obtenerPreguntasDePublicacionHoy(p.id_publicacion) != 0
order by obtenerPreguntasDePublicacionHoy(p.id_publicacion) desc;

DROP VIEW IF EXISTS mejor_vendedor_categoria$$
CREATE VIEW mejor_vendedor_categoria AS
SELECT categoria,
       vendedor,
       reputacion
FROM (
    SELECT c.nombre AS categoria,
           CONCAT(u.nombre, ' ', u.apellido) AS vendedor,
           u.reputacion,
           ROW_NUMBER() OVER (
               PARTITION BY c.id_categoria
               ORDER BY u.reputacion DESC
           ) AS posicion
    FROM categorias c
     JOIN publicaciones p ON p.id_categoria = c.id_categoria
     JOIN usuarios u ON u.id_usuario = p.id_usuario_vendedor
) x
WHERE posicion = 1$$

DROP EVENT IF EXISTS eliminar_pausadas$$
CREATE EVENT eliminar_pausadas
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    DELETE FROM publicaciones
    WHERE estado = 'PAUSADA'
      AND fecha_publicacion < DATE_SUB(NOW(), INTERVAL 90 DAY);
END$$

DROP EVENT IF EXISTS observar_sin_pago$$
CREATE EVENT observar_sin_pago
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE publicaciones p
     JOIN ventas_directas v ON v.id_publicacion = p.id_publicacion
    SET p.estado = 'OBSERVADA'
    WHERE p.estado = 'ACTIVA'
      AND p.medio_pago IS NULL;
END$$

DROP EVENT IF EXISTS notificar_preguntas$$
CREATE EVENT notificar_preguntas
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 10 HOUR
DO
BEGIN
    CALL notificar_preguntas();
END$$

DROP EVENT IF EXISTS estadisticas_diarias$$
CREATE EVENT estadisticas_diarias
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    CALL generar_estadisticas();
END$$

DROP ROLE IF EXISTS 'rol_auditor';
CREATE ROLE 'rol_auditor';
GRANT SELECT ON tp.preguntas_sin_responder TO 'rol_auditor';
GRANT SELECT ON tp.top_categorias_semana TO 'rol_auditor';
GRANT SELECT ON tp.publicaciones_tendencia TO 'rol_auditor';
GRANT SELECT ON tp.mejor_vendedor_categoria TO 'rol_auditor';

DROP ROLE IF EXISTS 'rol_desarrollador';
CREATE ROLE 'rol_desarrollador';
GRANT SELECT ON tp.* TO 'rol_desarrollador';
GRANT CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON tp.* TO 'rol_desarrollador';

DROP ROLE IF EXISTS 'rol_admin';
CREATE ROLE 'rol_admin';
GRANT ALL PRIVILEGES ON tp.* TO 'rol_admin';

DELIMITER ;

START TRANSACTION;
SELECT id_publicacion, estado, id_usuario_vendedor
FROM publicaciones
WHERE id_publicacion = 1
FOR UPDATE;
UPDATE publicaciones
SET estado = 'FINALIZADA'
WHERE id_publicacion = 1 AND estado = 'ACTIVA';
INSERT INTO transacciones(
    id_publicacion, id_usuario_comprador, id_usuario_vendedor,
    monto, medio_pago, medio_envio, estado
)
SELECT id_publicacion, 2, id_usuario_vendedor,
       precio, 'TARJETA_CREDITO', 'CORREO_ARGENTINO', 'CONCRETADA'
FROM publicaciones
WHERE id_publicacion = 1 AND estado = 'FINALIZADA';
COMMIT;

START TRANSACTION;
SELECT id_publicacion, estado
FROM publicaciones
WHERE id_publicacion = 1
FOR UPDATE;
SELECT oferta_maxima
FROM subastas
WHERE id_publicacion = 1
FOR UPDATE;
UPDATE subastas
SET oferta_maxima = 1000,
    id_usuario_ofertante = 2
WHERE id_publicacion = 1
  AND 2 <> (SELECT id_usuario_vendedor FROM publicaciones WHERE id_publicacion = 1)
  AND 1000 > IFNULL(oferta_maxima, 0);
COMMIT;

START TRANSACTION;
    select * from publicaciones where id_publicacion = 1 for update;
    select * from interaccion where id_publicacion = 1 for update;
    select * from subastas where id_publicacion = 1 for update;
    select * from subastas_update_audit where id_subasta = 1 for update;
    select * from transacciones where id_publicacion = 1 for update;

    delete from transacciones where id_publicacion = 1;
    delete from subastas_update_audit where id_subasta = 1;
    delete from subastas where id_publicacion = 1;
    delete from interaccion where id_publicacion = 1;
    delete from publicaciones where id_publicacion = 1;
COMMIT;


create function obtenerPreguntasDePublicacionHoy(id int)returns int deterministic
    begin
        return (select count(*) from interaccion where id_publicacion = id and fecha_interaccion = CURRENT_TIMESTAMP());
    end;

create function obtenerPreguntasDePublicacion(id int)returns int deterministic
    begin
        return (select count(*) from interaccion where id_publicacion = id);
    end;
call ganador_subasta(51,@var)