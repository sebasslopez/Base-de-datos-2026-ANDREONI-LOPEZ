ALTER TABLE publicaciones
MODIFY estado ENUM('ACTIVA','PAUSADA','FINALIZADA','OBSERVADA') NOT NULL DEFAULT 'ACTIVA',
ADD COLUMN medio_pago ENUM('TARJETA_CREDITO','TARJETA_DEBITO','PAGO_FACIL','RAPIPAGO') NULL;

CREATE INDEX idx_productos_nombre ON productos(nombre);
CREATE UNIQUE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_publicaciones_estado_fecha ON publicaciones(estado, fecha_publicacion);
CREATE INDEX idx_publicaciones_estado_finalizacion ON publicaciones(estado, fecha_finalizacion);

DELIMITER $$

DROP FUNCTION IF EXISTS tiempo_promedio_venta$$
CREATE FUNCTION tiempo_promedio_venta(p_id_usuario INT)
RETURNS INT
BEGIN
    DECLARE v_promedio INT;

    SELECT AVG(TIMESTAMPDIFF(SECOND, p.fecha_publicacion, t.fecha_transaccion)) / 86400
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
RETURNS INT
BEGIN
    DECLARE v_total INT;
    DECLARE v_concretadas INT;

    SELECT COUNT(*)
    INTO v_total
    FROM publicaciones
    WHERE id_usuario_vendedor = p_id_usuario;

    IF v_total = 0 THEN
        RETURN 0;
    END IF;

    SELECT COUNT(*)
    INTO v_concretadas
    FROM transacciones t
     JOIN publicaciones p ON p.id_publicacion = t.id_publicacion
    WHERE p.id_usuario_vendedor = p_id_usuario
      AND t.estado = 'CONCRETADA';

    RETURN v_concretadas * 100.0 / v_total;
END$$

DROP FUNCTION IF EXISTS mayor_puja$$
CREATE FUNCTION mayor_puja(p_id_publicacion INT)
RETURNS INT
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
RETURNS INT

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
RETURNS DATETIME
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
               IF(s.id_usuario_ofertante IS NULL, 0, 1) AS cantidad_oferentes,
               p.precio AS valor_inicial,
               IFNULL(s.oferta_maxima, 0) AS valor_ganador
        FROM subastas s
         JOIN publicaciones p ON p.id_publicacion = s.id_publicacion
         JOIN productos pr ON pr.id_producto = p.id_producto
        LEFT JOIN usuarios u ON u.id_usuario = s.id_usuario_ofertante
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

        INSERT INTO preguntas(id_publicacion, id_usuario, pregunta)
        VALUES(p_id_publicacion, p_id_usuario, p_pregunta);

        SET p_ok = 1;
    END IF;
END$$

DROP PROCEDURE IF EXISTS estadisticas_vendedor$$
CREATE PROCEDURE estadisticas_vendedor(
    IN p_id_usuario INT,
    OUT p_ok BOOLEAN
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;

    SET p_ok = 0;

    SELECT COUNT(*)
    INTO v_existe
    FROM usuarios
    WHERE id_usuario = p_id_usuario;

    IF v_existe = 1 THEN
        SELECT
            u.id_usuario,
            SUM(IF(p.estado IN ('ACTIVA','PAUSADA','OBSERVADA'), 1, 0)) AS publicaciones_activas,
            SUM(IF(p.estado = 'FINALIZADA', 1, 0)) AS publicaciones_finalizadas,
            COUNT(DISTINCT IF(t.estado = 'CONCRETADA', t.id_transaccion, NULL)) AS ventas_totales,
            IFNULL(SUM(IF(t.estado = 'CONCRETADA', t.monto, 0)), 0) AS facturacion_total,
            IFNULL(AVG(p.precio), 0) AS precio_promedio_productos,
            COUNT(DISTINCT q.id_pregunta) AS preguntas_recibidas,
            tiempo_promedio_venta(p_id_usuario) AS tiempo_promedio_venta
        FROM usuarios u
        LEFT JOIN publicaciones p ON p.id_usuario_vendedor = u.id_usuario
        LEFT JOIN transacciones t ON t.id_publicacion = p.id_publicacion
        LEFT JOIN preguntas q ON q.id_publicacion = p.id_publicacion
        WHERE u.id_usuario = p_id_usuario
        GROUP BY u.id_usuario;

        SET p_ok = 1;
    END IF;
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
     JOIN preguntas q ON q.id_publicacion = p.id_publicacion
    LEFT JOIN respuestas r ON r.id_pregunta = q.id_pregunta
    WHERE p.estado IN ('ACTIVA','OBSERVADA')
      AND r.id_respuesta IS NULL
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
BEFORE DELETE ON preguntas
FOR EACH ROW
BEGIN
    DELETE FROM respuestas
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

        IF (SELECT cantidad_ventas FROM usuarios WHERE id_usuario = NEW.id_usuario_vendedor) >= 10 THEN
            UPDATE usuarios SET nivel = 'PLATINUM' WHERE id_usuario = NEW.id_usuario_vendedor;
        ELSEIF (SELECT cantidad_ventas FROM usuarios WHERE id_usuario = NEW.id_usuario_vendedor) >= 5 THEN
            UPDATE usuarios SET nivel = 'GOLD' WHERE id_usuario = NEW.id_usuario_vendedor;
        ELSE
            UPDATE usuarios SET nivel = 'NORMAL' WHERE id_usuario = NEW.id_usuario_vendedor;
        END IF;
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
    END IF;
END$$

DROP VIEW IF EXISTS preguntas_sin_responder$$
CREATE VIEW preguntas_sin_responder AS
SELECT q.id_pregunta,
       q.pregunta AS descripcion,
       q.id_publicacion AS publicacion,
       pr.nombre AS producto,
       u.nombre AS usuario_que_respondio
FROM preguntas q
 JOIN publicaciones p ON p.id_publicacion = q.id_publicacion
 JOIN productos pr ON pr.id_producto = p.id_producto
LEFT JOIN respuestas r ON r.id_pregunta = q.id_pregunta
LEFT JOIN usuarios u ON u.id_usuario = r.id_usuario_vendedor
WHERE p.estado IN ('ACTIVA','OBSERVADA')
  AND r.id_respuesta IS NULL$$

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
SELECT p.id_publicacion,
       pr.nombre AS producto,
       COUNT(q.id_pregunta) AS cantidad_preguntas
FROM publicaciones p
 JOIN productos pr ON pr.id_producto = p.id_producto
LEFT JOIN preguntas q
    ON q.id_publicacion = p.id_publicacion
   AND DATE(q.fecha_pregunta) = CURDATE()
WHERE p.estado IN ('ACTIVA','OBSERVADA')
GROUP BY p.id_publicacion, pr.nombre
HAVING COUNT(q.id_pregunta) > 0
ORDER BY cantidad_preguntas DESC$$

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
SELECT id_transaccion, estado
FROM transacciones
WHERE id_transaccion = 1
FOR UPDATE;
UPDATE transacciones
SET estado = 'CANCELADA'
WHERE id_transaccion = 1
  AND estado = 'PENDIENTE';
COMMIT;