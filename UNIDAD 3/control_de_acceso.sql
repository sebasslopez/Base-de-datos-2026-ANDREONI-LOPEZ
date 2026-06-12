#1
CREATE USER 'analista_stock'@'localhost' IDENTIFIED BY 'St0ck_An@lyst_2026!';
CREATE USER 'gestor_productos'@'localhost' IDENTIFIED BY 'Pr0d_M@n@ger_2026!';
CREATE USER 'analista_ordenes'@'localhost' IDENTIFIED BY '0rd_An@lyst_2026!';
CREATE USER 'usuario_reportes'@'localhost' IDENTIFIED BY 'Rep0rt_Usr_2026!';
CREATE USER 'desarrollador'@'localhost' IDENTIFIED BY 'Dev_St@ff_2026!';
CREATE USER 'dba_admin'@'localhost' IDENTIFIED BY 'DBA_M@ster_2026!';
SELECT user, host, plugin
FROM mysql.user
#2
CREATE ROLE 'rol_analista_stock';
CREATE ROLE 'rol_gestor_productos';
CREATE ROLE 'rol_usuario_reportes';
CREATE ROLE 'rol_desarrollo';
CREATE ROLE 'rol_administrador';
GRANT SELECT ON stock.* TO 'rol_analista_stock';
GRANT EXECUTE ON PROCEDURE stock.actualizarStock TO 'rol_analista_stock';
GRANT EXECUTE ON PROCEDURE stock.reducirPrecio TO 'rol_analista_stock';
GRANT EXECUTE ON PROCEDURE stock.actualizarPrecioPorProveedor TO 'rol_analista_stock';
GRANT EXECUTE ON PROCEDURE stock.stk TO 'rol_analista_stock';
GRANT SELECT ON classicmodels.orders TO 'rol_gestor_productos';
GRANT SELECT ON classicmodels.orderdetails TO 'rol_gestor_productos';
GRANT EXECUTE ON PROCEDURE classicmodels.borrarOrden TO 'rol_gestor_productos';
GRANT EXECUTE ON PROCEDURE classicmodels.borrarLineaProductos TO 'rol_gestor_productos';
GRANT EXECUTE ON PROCEDURE classicmodels.actualizarComentarios TO 'rol_gestor_productos';
GRANT SELECT ON stock.* TO 'rol_usuario_reportes';
GRANT SELECT ON classicmodels.* TO 'rol_usuario_reportes';
GRANT EXECUTE ON FUNCTION *.* TO 'rol_usuario_reportes'; 
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ROUTINE, ALTER ROUTINE, EXECUTE, TRIGGER, EVENT ON stock.* TO 'rol_desarrollo';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ROUTINE, ALTER ROUTINE, EXECUTE, TRIGGER, EVENT ON classicmodels.* TO 'rol_desarrollo';
GRANT ALL PRIVILEGES ON *.* TO 'rol_administrador';
SELECT user AS nombre_rol FROM mysql.user WHERE attribute LIKE '%"is_role":true%';

#3
GRANT 'rol_analista_stock' TO 'analista_stock'@'localhost';
GRANT 'rol_gestor_productos' TO 'gestor_productos'@'localhost';
GRANT 'rol_gestor_productos' TO 'analista_ordenes'@'localhost';
GRANT 'rol_usuario_reportes' TO 'usuario_reportes'@'localhost';
GRANT 'rol_desarrollo' TO 'desarrollador'@'localhost';
GRANT 'rol_administrador' TO 'dba_admin'@'localhost';
ALTER USER 'analista_stock'@'localhost' DEFAULT ROLE 'rol_analista_stock';
ALTER USER 'gestor_productos'@'localhost' DEFAULT ROLE 'rol_gestor_productos';
ALTER USER 'analista_ordenes'@'localhost' DEFAULT ROLE 'rol_gestor_productos';
ALTER USER 'usuario_reportes'@'localhost' DEFAULT ROLE 'rol_usuario_reportes';
ALTER USER 'desarrollador'@'localhost' DEFAULT ROLE 'rol_desarrollo';
ALTER USER 'dba_admin'@'localhost' DEFAULT ROLE 'rol_administrador';
SHOW GRANTS FOR 'analista_stock'@'localhost';
SHOW GRANTS FOR 'gestor_productos'@'localhost';
SHOW GRANTS FOR 'usuario_reportes'@'localhost';
SHOW GRANTS FOR 'desarrollador'@'localhost';
SHOW GRANTS FOR 'dba_admin'@'localhost';

#4
CREATE USER 'usuario_rrhh'@'localhost' IDENTIFIED BY 'RRHH_Sec_2026!';
GRANT SELECT (nombre, apellido, puesto, codigo_oficina) ON classicmodels.employees TO 'usuario_rrhh'@'localhost';
GRANT EXECUTE ON FUNCTION *.* TO 'usuario_rrhh'@'localhost';

#5
CREATE USER 'operador_stock'@'localhost' IDENTIFIED BY 'Op_Stk_Restricted_2026!';
GRANT EXECUTE ON PROCEDURE stock.actualizarStock TO 'operador_stock'@'localhost';