-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificaciones` (
  `id_calificacion` int NOT NULL AUTO_INCREMENT,
  `id_transaccion` int NOT NULL,
  `id_usuario_calificado` int NOT NULL,
  `id_usuario_calificador` int NOT NULL,
  `operacion_concretada` tinyint(1) NOT NULL,
  `satisfaccion` tinyint NOT NULL,
  `fecha_calificacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_calificacion`),
  UNIQUE KEY `id_transaccion` (`id_transaccion`,`id_usuario_calificado`),
  KEY `id_usuario_calificado` (`id_usuario_calificado`),
  KEY `id_usuario_calificador` (`id_usuario_calificador`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_transaccion`) REFERENCES `transacciones` (`id_transaccion`),
  CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`id_usuario_calificado`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `calificaciones_ibfk_3` FOREIGN KEY (`id_usuario_calificador`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `calificaciones_chk_1` CHECK ((`satisfaccion` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (1,1,51,2,1,95,'2026-07-27 10:00:00'),(2,2,52,3,1,88,'2026-07-27 11:00:00'),(3,3,53,4,1,92,'2026-07-28 10:00:00'),(4,4,54,5,1,85,'2026-07-28 11:00:00'),(5,5,55,6,1,97,'2026-07-29 10:00:00'),(6,6,56,7,1,90,'2026-07-29 11:00:00'),(7,7,57,8,1,82,'2026-07-30 10:00:00'),(8,8,58,9,1,94,'2026-07-30 11:00:00'),(9,9,59,10,1,91,'2026-07-31 10:00:00'),(10,10,60,11,1,96,'2026-07-31 11:00:00'),(11,11,61,12,1,89,'2026-08-01 10:00:00'),(12,12,62,13,1,93,'2026-08-01 11:00:00'),(13,13,63,14,1,87,'2026-08-02 10:00:00'),(14,14,64,15,1,98,'2026-08-02 11:00:00'),(15,15,65,16,1,91,'2026-08-03 10:00:00'),(16,16,66,17,1,84,'2026-08-03 11:00:00'),(17,17,67,18,1,95,'2026-08-04 10:00:00'),(18,18,68,19,1,90,'2026-08-04 11:00:00'),(19,19,69,20,1,86,'2026-08-05 10:00:00'),(20,20,70,21,1,92,'2026-08-05 11:00:00'),(21,21,71,22,1,89,'2026-08-06 10:00:00'),(22,22,72,23,1,96,'2026-08-06 11:00:00'),(23,23,73,24,1,93,'2026-08-07 10:00:00'),(24,24,74,25,1,88,'2026-08-07 11:00:00'),(25,25,75,26,1,91,'2026-08-08 10:00:00'),(26,26,76,27,1,85,'2026-08-08 11:00:00'),(27,27,77,28,1,97,'2026-08-09 10:00:00'),(28,28,78,29,1,90,'2026-08-09 11:00:00'),(29,29,79,30,1,94,'2026-08-10 10:00:00'),(30,30,80,31,1,92,'2026-08-10 11:00:00'),(31,31,81,32,1,83,'2026-08-11 10:00:00'),(32,32,82,33,1,89,'2026-08-11 11:00:00'),(33,33,83,34,1,95,'2026-08-12 10:00:00'),(34,34,84,35,1,87,'2026-08-12 11:00:00'),(35,35,85,36,1,91,'2026-08-13 10:00:00'),(36,36,86,37,1,96,'2026-08-13 10:05:00'),(37,37,87,38,1,88,'2026-08-13 10:10:00'),(38,38,88,39,1,93,'2026-08-13 10:15:00'),(39,39,89,40,1,90,'2026-08-13 10:20:00'),(40,40,90,41,1,97,'2026-08-13 10:25:00'),(43,43,93,44,0,10,'2026-06-16 10:00:00'),(44,44,94,45,0,25,'2026-06-18 10:00:00'),(45,45,95,46,0,18,'2026-06-20 10:00:00'),(46,46,96,47,0,30,'2026-06-22 10:00:00'),(47,47,97,48,0,12,'2026-06-24 10:00:00'),(48,48,98,49,0,8,'2026-06-26 10:00:00'),(49,49,99,50,0,22,'2026-06-28 10:00:00'),(50,50,100,51,0,16,'2026-06-30 10:00:00'),(51,51,1,52,1,94,'2026-07-02 10:00:00'),(52,52,2,53,1,91,'2026-07-02 11:00:00'),(53,53,3,54,1,87,'2026-07-03 10:00:00'),(54,54,4,55,1,96,'2026-07-03 11:00:00'),(55,55,5,56,1,90,'2026-07-04 10:00:00'),(56,56,6,57,1,84,'2026-07-04 11:00:00'),(57,57,7,58,1,98,'2026-07-05 10:00:00'),(58,58,8,59,1,92,'2026-07-05 11:00:00'),(59,59,9,60,1,89,'2026-07-06 10:00:00'),(60,60,10,61,1,95,'2026-07-06 11:00:00'),(61,61,11,62,1,93,'2026-07-07 10:00:00'),(62,62,12,63,1,88,'2026-07-07 11:00:00'),(63,63,13,64,1,96,'2026-07-08 10:00:00'),(64,64,14,65,1,91,'2026-07-08 11:00:00'),(65,65,15,66,1,86,'2026-07-09 10:00:00'),(66,66,16,67,1,94,'2026-07-09 11:00:00'),(67,67,17,68,1,90,'2026-07-10 10:00:00'),(68,68,18,69,1,97,'2026-07-10 11:00:00'),(69,69,19,70,1,85,'2026-07-11 10:00:00'),(70,70,20,71,1,92,'2026-07-11 11:00:00'),(71,71,21,72,1,88,'2026-07-12 10:00:00'),(72,72,22,73,1,95,'2026-07-12 11:00:00'),(73,73,23,74,1,91,'2026-07-13 10:00:00'),(74,74,24,75,1,89,'2026-07-13 11:00:00'),(75,75,25,76,1,96,'2026-07-14 10:00:00'),(76,76,26,77,1,93,'2026-07-14 11:00:00'),(77,77,27,78,1,87,'2026-07-15 10:00:00'),(78,78,28,79,1,94,'2026-07-15 11:00:00'),(79,79,29,80,1,90,'2026-07-16 10:00:00'),(80,80,30,81,1,98,'2026-07-16 11:00:00'),(81,81,31,82,0,5,'2026-07-17 10:00:00'),(82,82,32,83,0,12,'2026-07-17 11:00:00'),(83,83,33,84,0,20,'2026-07-18 10:00:00'),(84,84,34,85,0,8,'2026-07-18 11:00:00'),(85,85,35,86,0,15,'2026-07-19 10:00:00'),(86,86,36,87,0,10,'2026-07-19 11:00:00'),(87,87,37,88,0,25,'2026-07-20 10:00:00'),(88,88,38,89,0,18,'2026-07-20 11:00:00'),(89,89,39,90,0,30,'2026-07-21 10:00:00'),(90,90,40,91,0,14,'2026-07-21 11:00:00'),(93,93,43,94,1,89,'2026-07-23 10:00:00'),(94,94,44,95,1,95,'2026-07-23 11:00:00'),(95,95,45,96,1,92,'2026-07-24 10:00:00'),(96,96,46,97,1,88,'2026-07-24 11:00:00'),(97,97,47,98,1,97,'2026-07-25 10:00:00'),(98,98,48,99,1,90,'2026-07-25 11:00:00'),(99,99,49,100,1,94,'2026-07-26 10:00:00'),(100,100,50,1,1,91,'2026-07-26 11:00:00');
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alumno27.lopez.sebastian`@`localhost`*/ /*!50003 TRIGGER `reputacion` AFTER INSERT ON `calificaciones` FOR EACH ROW BEGIN
    UPDATE usuarios u
    SET u.reputacion = (
        SELECT AVG(c.satisfaccion)
        FROM calificaciones c
        WHERE c.id_usuario_calificado = NEW.id_usuario_calificado
    )
    WHERE u.id_usuario = NEW.id_usuario_calificado;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Electronica','Productos electronicos y dispositivos'),(2,'Informatica','Computadoras, componentes y accesorios'),(3,'Celulares','Telefonos celulares y accesorios'),(4,'Hogar','Productos para el hogar'),(5,'Muebles','Muebles y articulos de decoracion'),(6,'Ropa','Indumentaria y vestimenta'),(7,'Calzado','Zapatos, zapatillas y otros calzados'),(8,'Deportes','Articulos deportivos'),(9,'Juguetes','Juguetes y entretenimiento infantil'),(10,'Libros','Libros y material de lectura'),(11,'Musica','Instrumentos y productos musicales'),(12,'Videojuegos','Videojuegos y consolas'),(13,'Coleccionables','Articulos de coleccion'),(14,'Automoviles','Productos relacionados con automoviles'),(15,'Motocicletas','Productos relacionados con motocicletas'),(16,'Herramientas','Herramientas y equipamiento'),(17,'Jardineria','Productos para jardin y exteriores'),(18,'Cocina','Utensilios y productos de cocina'),(19,'Belleza','Productos de belleza y cuidado personal'),(20,'Otros','Productos que no pertenecen a otra categoria');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `mejor_vendedor_categoria`
--

DROP TABLE IF EXISTS `mejor_vendedor_categoria`;
/*!50001 DROP VIEW IF EXISTS `mejor_vendedor_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mejor_vendedor_categoria` AS SELECT 
 1 AS `categoria`,
 1 AS `vendedor`,
 1 AS `reputacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `preguntas`
--

DROP TABLE IF EXISTS `preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preguntas` (
  `id_pregunta` int NOT NULL AUTO_INCREMENT,
  `id_publicacion` int NOT NULL,
  `id_usuario` int NOT NULL,
  `pregunta` text NOT NULL,
  `fecha_pregunta` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pregunta`),
  KEY `id_publicacion` (`id_publicacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`),
  CONSTRAINT `preguntas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preguntas`
--

LOCK TABLES `preguntas` WRITE;
/*!40000 ALTER TABLE `preguntas` DISABLE KEYS */;
INSERT INTO `preguntas` VALUES (1,1,2,'¿La notebook tiene garantía?','2026-07-01 12:00:00'),(2,2,3,'¿El celular está liberado?','2026-07-01 13:20:00'),(3,3,4,'¿Los auriculares incluyen el estuche?','2026-07-02 11:15:00'),(4,4,5,'¿El monitor tiene entrada HDMI?','2026-07-02 16:30:00'),(5,5,6,'¿El teclado tiene distribución en español?','2026-07-03 14:00:00'),(6,6,7,'¿El mouse funciona con Bluetooth?','2026-07-03 17:10:00'),(7,7,8,'¿La tablet incluye cargador?','2026-07-04 18:00:00'),(8,8,9,'¿El smartwatch es compatible con Android?','2026-07-04 19:20:00'),(9,9,10,'¿La cámara incluye lente?','2026-07-05 11:40:00'),(10,10,11,'¿Cuánto dura la batería del parlante?','2026-07-05 15:00:00'),(11,11,12,'¿La consola incluye joystick?','2026-07-06 12:30:00'),(12,12,13,'¿La Xbox está funcionando correctamente?','2026-07-06 16:20:00'),(13,13,14,'¿Incluye los Joy-Con?','2026-07-07 11:10:00'),(14,14,15,'¿El Iphone está desbloqueado?','2026-07-07 13:45:00'),(15,15,16,'¿Tiene algún detalle estético?','2026-07-08 10:30:00'),(16,16,17,'¿Cuánta memoria RAM tiene?','2026-07-08 17:00:00'),(17,17,18,'¿Tiene disco SSD?','2026-07-09 12:15:00'),(18,18,19,'¿Cuál es la resolución del monitor?','2026-07-09 18:10:00'),(19,19,20,'¿La impresora funciona con WiFi?','2026-07-10 12:00:00'),(20,20,21,'¿El SSD es nuevo?','2026-07-10 16:00:00'),(21,21,22,'¿La memoria RAM es DDR4?','2026-07-11 11:30:00'),(22,22,23,'¿Qué modelo de placa de video es?','2026-07-11 14:20:00'),(23,23,24,'¿El procesador incluye cooler?','2026-07-12 12:10:00'),(24,24,25,'¿La motherboard tiene WiFi?','2026-07-12 16:40:00'),(25,25,26,'¿La fuente tiene certificación 80 Plus?','2026-07-13 12:20:00'),(26,26,27,'¿El gabinete incluye ventiladores?','2026-07-13 17:00:00'),(27,27,28,'¿La silla soporta más de 100 kilos?','2026-07-14 11:45:00'),(28,28,29,'¿El escritorio viene armado?','2026-07-14 15:30:00'),(29,29,30,'¿La mesa tiene algún detalle?','2026-07-15 11:20:00'),(30,30,31,'¿El sofá es desmontable?','2026-07-15 17:10:00'),(31,31,32,'¿La cama incluye colchón?','2026-07-16 13:00:00'),(32,32,33,'¿Cuál es el grosor del colchón?','2026-07-16 18:00:00'),(33,33,34,'¿Cuántas puertas tiene el placard?','2026-07-17 11:30:00'),(34,34,35,'¿La biblioteca se puede desarmar?','2026-07-17 14:45:00'),(35,35,36,'¿La lámpara funciona correctamente?','2026-07-18 12:00:00'),(36,36,37,'¿La aspiradora tiene todos los accesorios?','2026-07-18 16:30:00'),(37,37,38,'¿El microondas tiene grill?','2026-07-19 11:00:00'),(38,38,39,'¿La licuadora tiene diferentes velocidades?','2026-07-19 15:15:00'),(39,39,40,'¿La cafetera incluye filtro?','2026-07-20 12:40:00'),(40,40,41,'¿La pava tiene apagado automático?','2026-07-20 18:00:00'),(41,41,42,'¿Qué talle es la campera?','2026-07-21 11:20:00'),(42,42,43,'¿Qué talles tenés disponibles?','2026-07-21 16:00:00'),(43,43,44,'¿El jean es de corte recto?','2026-07-22 10:45:00'),(44,44,45,'¿La camisa es de algodón?','2026-07-22 14:30:00'),(45,45,46,'¿Las zapatillas son originales?','2026-07-23 12:00:00'),(46,46,47,'¿Las botas tienen algún desgaste?','2026-07-23 17:00:00'),(47,47,48,'¿La pelota es tamaño profesional?','2026-07-24 11:30:00'),(48,48,49,'¿La raqueta incluye funda?','2026-07-24 15:20:00'),(49,49,50,'¿La bicicleta tiene cambios?','2026-07-25 10:30:00'),(50,50,51,'¿Las mancuernas son regulables?','2026-07-25 17:10:00'),(51,51,52,'¿Cuántas herramientas incluye el set?','2026-07-26 12:00:00'),(52,52,53,'¿El taladro incluye batería?','2026-07-26 16:30:00'),(53,53,54,'¿El destornillador es recargable?','2026-07-27 11:10:00'),(54,54,55,'¿La caja tiene compartimentos?','2026-07-27 15:45:00'),(55,55,56,'¿El libro está en español?','2026-07-28 10:20:00'),(56,56,57,'¿La novela está en buen estado?','2026-07-28 14:30:00'),(57,57,58,'¿Incluye todas las recetas?','2026-07-29 11:30:00'),(58,58,59,'¿La enciclopedia está completa?','2026-07-29 16:20:00'),(59,59,60,'¿La guitarra tiene funda?','2026-07-30 10:10:00'),(60,60,61,'¿El teclado musical tiene parlantes?','2026-07-30 14:50:00'),(61,61,62,'¿El micrófono funciona con USB?','2026-07-31 12:00:00'),(62,62,63,'¿El amplificador sirve para guitarra?','2026-07-31 17:00:00'),(63,63,64,'¿Para cuántas personas es el juego?','2026-08-01 11:00:00'),(64,64,65,'¿Cuántas piezas tiene el rompecabezas?','2026-08-01 15:30:00'),(65,65,66,'¿La muñeca viene con accesorios?','2026-08-02 10:40:00'),(66,66,67,'¿El auto incluye control remoto?','2026-08-02 17:20:00'),(67,67,68,'¿Cuántos juegos tiene la consola?','2026-08-03 12:10:00'),(68,68,69,'¿La figura es original?','2026-08-03 16:30:00'),(69,69,70,'¿El álbum está completo?','2026-08-04 11:20:00'),(70,70,71,'¿De qué año es la moneda?','2026-08-04 15:40:00'),(71,71,72,'¿La llanta es nueva?','2026-08-05 10:30:00'),(72,72,73,'¿La batería sirve para cualquier auto?','2026-08-05 14:20:00'),(73,73,74,'¿El estéreo tiene Bluetooth?','2026-08-06 11:10:00'),(74,74,75,'¿Las cubiertas son nuevas?','2026-08-06 16:00:00'),(75,75,76,'¿El casco está homologado?','2026-08-07 12:30:00'),(76,76,77,'¿Los guantes son impermeables?','2026-08-07 15:50:00'),(77,77,78,'¿Qué capacidad tiene el baúl?','2026-08-08 10:15:00'),(78,78,79,'¿Los espejos son universales?','2026-08-08 14:40:00'),(79,79,80,'¿La cortadora tiene bolsa recolectora?','2026-08-09 11:00:00'),(80,80,81,'¿Cuántos metros tiene la manguera?','2026-08-09 16:20:00'),(81,81,82,'¿La maceta sirve para exterior?','2026-08-10 10:30:00'),(82,82,83,'¿Qué herramientas incluye el kit?','2026-08-10 14:50:00'),(83,83,84,'¿Los cuchillos son de acero inoxidable?','2026-08-11 11:20:00'),(84,84,85,'¿La olla tiene tapa?','2026-08-11 15:30:00'),(85,85,86,'¿La sartén funciona en cocina de inducción?','2026-08-12 10:40:00'),(86,86,87,'¿La batidora tiene varios accesorios?','2026-08-12 14:20:00'),(87,87,88,'¿El perfume es original?','2026-08-13 09:00:00'),(88,88,89,'¿El set de maquillaje está cerrado?','2026-08-13 09:15:00'),(89,89,90,'¿El secador tiene diferentes temperaturas?','2026-08-13 09:30:00'),(90,90,91,'¿La plancha tiene control de temperatura?','2026-08-13 09:45:00'),(92,93,93,'¿Cuál es la capacidad del powerbank?','2026-08-13 10:05:00'),(93,93,94,'¿El cable HDMI soporta 4K?','2026-08-13 10:10:00'),(94,94,95,'¿La webcam tiene micrófono?','2026-08-13 10:15:00'),(95,95,96,'¿El router soporta doble banda?','2026-08-13 10:20:00'),(96,96,97,'¿La memoria USB es de 128GB reales?','2026-08-13 10:25:00'),(97,97,98,'¿El disco externo funciona con Windows?','2026-08-13 10:30:00'),(98,98,99,'¿El adaptador tiene entrada HDMI?','2026-08-13 10:35:00'),(99,99,100,'¿Cuántos puertos tiene el hub USB?','2026-08-13 10:40:00'),(100,100,1,'¿El soporte para notebook es regulable?','2026-08-13 10:45:00');
/*!40000 ALTER TABLE `preguntas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alumno27.lopez.sebastian`@`localhost`*/ /*!50003 TRIGGER `preguntas_delete` BEFORE DELETE ON `preguntas` FOR EACH ROW BEGIN
    DELETE FROM respuestas
    WHERE id_pregunta = OLD.id_pregunta;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `preguntas_sin_responder`
--

DROP TABLE IF EXISTS `preguntas_sin_responder`;
/*!50001 DROP VIEW IF EXISTS `preguntas_sin_responder`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `preguntas_sin_responder` AS SELECT 
 1 AS `id_pregunta`,
 1 AS `descripcion`,
 1 AS `publicacion`,
 1 AS `producto`,
 1 AS `usuario_que_respondio`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_producto`),
  KEY `id_usuario` (`id_usuario`),
  KEY `idx_productos_nombre` (`nombre`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,1,'Notebook Lenovo IdeaPad','Notebook Lenovo con procesador Intel y 8GB de RAM.','2026-08-13 10:32:41'),(2,2,'Smartphone Samsung Galaxy','Telefono Samsung Galaxy con pantalla AMOLED.','2026-08-13 10:32:41'),(3,3,'Auriculares Bluetooth Sony','Auriculares inalambricos Sony con cancelacion de ruido.','2026-08-13 10:32:41'),(4,4,'Monitor LG 24 pulgadas','Monitor LG Full HD de 24 pulgadas.','2026-08-13 10:32:41'),(5,5,'Teclado Mecanico Redragon','Teclado mecanico con iluminacion RGB.','2026-08-13 10:32:41'),(6,6,'Mouse Logitech','Mouse inalambrico Logitech para computadora.','2026-08-13 10:32:41'),(7,7,'Tablet Samsung','Tablet Samsung de 10 pulgadas.','2026-08-13 10:32:41'),(8,8,'Smartwatch Xiaomi','Reloj inteligente Xiaomi con monitor de actividad.','2026-08-13 10:32:41'),(9,9,'Camara Canon','Camara digital Canon para fotografia.','2026-08-13 10:32:41'),(10,10,'Parlante JBL','Parlante portatil JBL con conexion Bluetooth.','2026-08-13 10:32:41'),(11,11,'PlayStation 5','Consola PlayStation 5 en excelente estado.','2026-08-13 10:32:41'),(12,12,'Xbox Series X','Consola Xbox Series X con almacenamiento interno.','2026-08-13 10:32:41'),(13,13,'Nintendo Switch','Consola Nintendo Switch con controles incluidos.','2026-08-13 10:32:41'),(14,14,'Iphone 13','Telefono Apple Iphone 13 desbloqueado.','2026-08-13 10:32:41'),(15,15,'Iphone 14','Telefono Apple Iphone 14 en excelente estado.','2026-08-13 10:32:41'),(16,16,'Notebook HP Pavilion','Notebook HP para uso profesional y domestico.','2026-08-13 10:32:41'),(17,17,'Notebook Asus VivoBook','Notebook Asus con 8GB de RAM y SSD.','2026-08-13 10:32:41'),(18,18,'Monitor Samsung 27 pulgadas','Monitor Samsung de 27 pulgadas Full HD.','2026-08-13 10:32:41'),(19,19,'Impresora Epson','Impresora multifuncion Epson.','2026-08-13 10:32:41'),(20,20,'Disco SSD Kingston','Disco SSD Kingston de 480GB.','2026-08-13 10:32:41'),(21,21,'Memoria RAM Corsair','Memoria RAM Corsair DDR4 de 16GB.','2026-08-13 10:32:41'),(22,22,'Placa de video Nvidia','Placa de video Nvidia para computadora.','2026-08-13 10:32:41'),(23,23,'Procesador AMD Ryzen','Procesador AMD Ryzen de ultima generacion.','2026-08-13 10:32:41'),(24,24,'Motherboard Asus','Placa madre Asus compatible con procesadores modernos.','2026-08-13 10:32:41'),(25,25,'Fuente Corsair','Fuente de alimentacion Corsair de 650W.','2026-08-13 10:32:41'),(26,26,'Gabinete Gamer','Gabinete para PC con ventiladores RGB.','2026-08-13 10:32:41'),(27,27,'Silla Gamer','Silla ergonomica para gaming.','2026-08-13 10:32:41'),(28,28,'Escritorio de madera','Escritorio de madera para oficina.','2026-08-13 10:32:41'),(29,29,'Mesa ratona','Mesa ratona de madera y vidrio.','2026-08-13 10:32:41'),(30,30,'Sofa de tres cuerpos','Sofa amplio de tres cuerpos para living.','2026-08-13 10:32:41'),(31,31,'Cama de dos plazas','Cama de dos plazas de madera.','2026-08-13 10:32:41'),(32,32,'Colchon matrimonial','Colchon matrimonial de espuma.','2026-08-13 10:32:41'),(33,33,'Placard de madera','Placard de madera con varias puertas.','2026-08-13 10:32:41'),(34,34,'Biblioteca','Biblioteca de madera con cinco estantes.','2026-08-13 10:32:41'),(35,35,'Lampara de pie','Lampara decorativa para interiores.','2026-08-13 10:32:41'),(36,36,'Aspiradora Electrolux','Aspiradora domestica de gran potencia.','2026-08-13 10:32:41'),(37,37,'Microondas Atma','Microondas digital de 20 litros.','2026-08-13 10:32:41'),(38,38,'Licuadora Philips','Licuadora electrica Philips.','2026-08-13 10:32:41'),(39,39,'Cafetera Oster','Cafetera electrica para cafe filtrado.','2026-08-13 10:32:41'),(40,40,'Pava electrica','Pava electrica de acero inoxidable.','2026-08-13 10:32:41'),(41,41,'Campera deportiva','Campera deportiva impermeable.','2026-08-13 10:32:41'),(42,42,'Remera de algodon','Remera de algodon de manga corta.','2026-08-13 10:32:41'),(43,43,'Jean clasico','Jean clasico de corte recto.','2026-08-13 10:32:41'),(44,44,'Camisa formal','Camisa formal para hombre.','2026-08-13 10:32:41'),(45,45,'Zapatillas deportivas','Zapatillas deportivas para entrenamiento.','2026-08-13 10:32:41'),(46,46,'Botas de cuero','Botas de cuero para uso diario.','2026-08-13 10:32:41'),(47,47,'Pelota de futbol','Pelota profesional de futbol.','2026-08-13 10:32:41'),(48,48,'Raqueta de tenis','Raqueta de tenis profesional.','2026-08-13 10:32:41'),(49,49,'Bicicleta MTB','Bicicleta de montaña con cambios.','2026-08-13 10:32:41'),(50,50,'Mancuernas','Par de mancuernas para entrenamiento.','2026-08-13 10:32:41'),(51,51,'Set de herramientas','Set completo de herramientas para hogar.','2026-08-13 10:32:41'),(52,52,'Taladro electrico','Taladro electrico de velocidad variable.','2026-08-13 10:32:41'),(53,53,'Destornillador electrico','Destornillador electrico recargable.','2026-08-13 10:32:41'),(54,54,'Caja de herramientas','Caja plastica para guardar herramientas.','2026-08-13 10:32:41'),(55,55,'Libro de programacion','Libro introductorio de programacion.','2026-08-13 10:32:41'),(56,56,'Novela policial','Novela de misterio y suspenso.','2026-08-13 10:32:41'),(57,57,'Libro de cocina','Libro con recetas de cocina.','2026-08-13 10:32:41'),(58,58,'Enciclopedia','Enciclopedia ilustrada de varios temas.','2026-08-13 10:32:41'),(59,59,'Guitarra criolla','Guitarra criolla de madera.','2026-08-13 10:32:41'),(60,60,'Teclado musical','Teclado musical electronico.','2026-08-13 10:32:41'),(61,61,'Microfono profesional','Microfono para grabacion y streaming.','2026-08-13 10:32:41'),(62,62,'Amplificador','Amplificador para instrumentos musicales.','2026-08-13 10:32:41'),(63,63,'Juego de mesa','Juego de mesa para toda la familia.','2026-08-13 10:32:41'),(64,64,'Rompecabezas','Rompecabezas de 1000 piezas.','2026-08-13 10:32:41'),(65,65,'Muñeca','Muñeca articulada para niños.','2026-08-13 10:32:41'),(66,66,'Auto a control remoto','Auto a control remoto con bateria recargable.','2026-08-13 10:32:41'),(67,67,'Consola retro','Consola retro con juegos clasicos.','2026-08-13 10:32:41'),(68,68,'Figura coleccionable','Figura coleccionable de edicion limitada.','2026-08-13 10:32:41'),(69,69,'Album de figuritas','Album para coleccionar figuritas.','2026-08-13 10:32:41'),(70,70,'Moneda antigua','Moneda antigua para coleccionistas.','2026-08-13 10:32:41'),(71,71,'Llanta de auto','Llanta de aleacion para automovil.','2026-08-13 10:32:41'),(72,72,'Bateria de auto','Bateria para automovil de uso general.','2026-08-13 10:32:41'),(73,73,'Estereo para auto','Equipo de audio para automovil.','2026-08-13 10:32:41'),(74,74,'Cubiertas','Cubiertas nuevas para automovil.','2026-08-13 10:32:41'),(75,75,'Casco para moto','Casco homologado para motocicleta.','2026-08-13 10:32:41'),(76,76,'Guantes para moto','Guantes protectores para motociclistas.','2026-08-13 10:32:41'),(77,77,'Baul para moto','Baul trasero para motocicleta.','2026-08-13 10:32:41'),(78,78,'Espejos para moto','Par de espejos universales para moto.','2026-08-13 10:32:41'),(79,79,'Cortadora de cesped','Cortadora de cesped electrica.','2026-08-13 10:32:41'),(80,80,'Manguera de jardin','Manguera reforzada para jardin.','2026-08-13 10:32:41'),(81,81,'Maceta grande','Maceta decorativa para exteriores.','2026-08-13 10:32:41'),(82,82,'Kit de jardineria','Kit con herramientas basicas de jardineria.','2026-08-13 10:32:41'),(83,83,'Juego de cuchillos','Juego de cuchillos de cocina.','2026-08-13 10:32:41'),(84,84,'Olla de acero','Olla de acero inoxidable.','2026-08-13 10:32:41'),(85,85,'Sarten antiadherente','Sarten con revestimiento antiadherente.','2026-08-13 10:32:41'),(86,86,'Batidora electrica','Batidora electrica para cocina.','2026-08-13 10:32:41'),(87,87,'Perfume importado','Perfume importado de fragancia masculina.','2026-08-13 10:32:41'),(88,88,'Set de maquillaje','Set completo de maquillaje.','2026-08-13 10:32:41'),(89,89,'Secador de pelo','Secador de pelo profesional.','2026-08-13 10:32:41'),(90,90,'Plancha de pelo','Plancha de pelo con control de temperatura.','2026-08-13 10:32:41'),(91,91,'Cargador universal','Cargador universal para dispositivos electronicos.','2026-08-13 10:32:41'),(92,92,'Powerbank','Bateria portatil de alta capacidad.','2026-08-13 10:32:41'),(93,93,'Cable HDMI','Cable HDMI de alta velocidad.','2026-08-13 10:32:41'),(94,94,'Webcam HD','Camara web HD para videollamadas.','2026-08-13 10:32:41'),(95,95,'Router WiFi','Router inalambrico de doble banda.','2026-08-13 10:32:41'),(96,96,'Memoria USB','Memoria USB de 128GB.','2026-08-13 10:32:41'),(97,97,'Disco externo','Disco rigido externo de 1TB.','2026-08-13 10:32:41'),(98,98,'Adaptador USB','Adaptador USB multipuerto.','2026-08-13 10:32:41'),(99,99,'Hub USB','Hub USB con multiples puertos.','2026-08-13 10:32:41'),(100,100,'Soporte para notebook','Soporte ajustable para computadora portatil.','2026-08-13 10:32:41');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicaciones`
--

DROP TABLE IF EXISTS `publicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicaciones` (
  `id_publicacion` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `id_categoria` int NOT NULL,
  `id_usuario_vendedor` int NOT NULL,
  `precio` decimal(15,2) NOT NULL,
  `nivel_publicacion` enum('BRONCE','PLATA','ORO','PLATINO') NOT NULL DEFAULT 'BRONCE',
  `estado` enum('ACTIVA','PAUSADA','FINALIZADA','OBSERVADA') NOT NULL DEFAULT 'ACTIVA',
  `fecha_publicacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_finalizacion` datetime DEFAULT NULL,
  `medio_pago` enum('TARJETA_CREDITO','TARJETA_DEBITO','PAGO_FACIL','RAPIPAGO') DEFAULT NULL,
  PRIMARY KEY (`id_publicacion`),
  KEY `id_producto` (`id_producto`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  KEY `idx_publicaciones_estado_fecha` (`estado`,`fecha_publicacion`),
  KEY `idx_publicaciones_estado_finalizacion` (`estado`,`fecha_finalizacion`),
  CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `publicaciones_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`),
  CONSTRAINT `publicaciones_ibfk_3` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones`
--

LOCK TABLES `publicaciones` WRITE;
/*!40000 ALTER TABLE `publicaciones` DISABLE KEYS */;
INSERT INTO `publicaciones` VALUES (1,1,2,1,850000.00,'ORO','FINALIZADA','2026-07-01 10:15:00',NULL,NULL),(2,2,3,2,620000.00,'PLATA','ACTIVA','2026-07-01 11:20:00',NULL,NULL),(3,3,1,3,185000.00,'BRONCE','ACTIVA','2026-07-02 09:30:00',NULL,NULL),(4,4,1,4,310000.00,'ORO','ACTIVA','2026-07-02 14:10:00',NULL,NULL),(5,5,2,5,95000.00,'PLATA','ACTIVA','2026-07-03 12:00:00',NULL,NULL),(6,6,2,6,65000.00,'BRONCE','ACTIVA','2026-07-03 15:40:00',NULL,NULL),(7,7,3,7,280000.00,'ORO','ACTIVA','2026-07-04 10:00:00',NULL,NULL),(8,8,3,8,145000.00,'PLATA','ACTIVA','2026-07-04 16:30:00',NULL,NULL),(9,9,1,9,720000.00,'PLATINO','ACTIVA','2026-07-05 09:15:00',NULL,NULL),(10,10,1,10,180000.00,'ORO','ACTIVA','2026-07-05 13:20:00',NULL,NULL),(11,11,12,11,980000.00,'PLATINO','ACTIVA','2026-07-06 11:00:00',NULL,NULL),(12,12,12,12,890000.00,'ORO','ACTIVA','2026-07-06 14:45:00',NULL,NULL),(13,13,12,13,520000.00,'PLATA','ACTIVA','2026-07-07 10:30:00',NULL,NULL),(14,14,3,14,670000.00,'PLATINO','ACTIVA','2026-07-07 12:15:00',NULL,NULL),(15,15,3,15,820000.00,'ORO','ACTIVA','2026-07-08 09:50:00',NULL,NULL),(16,16,2,16,730000.00,'PLATINO','ACTIVA','2026-07-08 15:10:00',NULL,NULL),(17,17,2,17,690000.00,'ORO','ACTIVA','2026-07-09 11:25:00',NULL,NULL),(18,18,1,18,430000.00,'PLATA','ACTIVA','2026-07-09 16:00:00',NULL,NULL),(19,19,2,19,240000.00,'BRONCE','ACTIVA','2026-07-10 10:40:00',NULL,NULL),(20,20,2,20,85000.00,'PLATA','ACTIVA','2026-07-10 14:30:00',NULL,NULL),(21,21,2,21,120000.00,'BRONCE','ACTIVA','2026-07-11 09:00:00',NULL,NULL),(22,22,2,22,480000.00,'ORO','ACTIVA','2026-07-11 12:45:00',NULL,NULL),(23,23,2,23,390000.00,'PLATINO','ACTIVA','2026-07-12 10:20:00',NULL,NULL),(24,24,2,24,210000.00,'PLATA','ACTIVA','2026-07-12 15:15:00',NULL,NULL),(25,25,2,25,180000.00,'ORO','ACTIVA','2026-07-13 11:35:00',NULL,NULL),(26,26,2,26,145000.00,'BRONCE','ACTIVA','2026-07-13 16:40:00',NULL,NULL),(27,27,5,27,320000.00,'ORO','ACTIVA','2026-07-14 09:30:00',NULL,NULL),(28,28,5,28,210000.00,'PLATA','ACTIVA','2026-07-14 13:50:00',NULL,NULL),(29,29,5,29,135000.00,'BRONCE','ACTIVA','2026-07-15 10:10:00',NULL,NULL),(30,30,5,30,680000.00,'PLATINO','ACTIVA','2026-07-15 14:20:00',NULL,NULL),(31,31,5,31,420000.00,'ORO','ACTIVA','2026-07-16 11:45:00',NULL,NULL),(32,32,5,32,390000.00,'PLATA','ACTIVA','2026-07-16 15:30:00',NULL,NULL),(33,33,5,33,450000.00,'BRONCE','ACTIVA','2026-07-17 09:40:00',NULL,NULL),(34,34,5,34,175000.00,'ORO','ACTIVA','2026-07-17 12:25:00',NULL,NULL),(35,35,5,35,95000.00,'PLATA','ACTIVA','2026-07-18 10:00:00',NULL,NULL),(36,36,4,36,230000.00,'PLATINO','ACTIVA','2026-07-18 14:10:00',NULL,NULL),(37,37,18,37,185000.00,'ORO','ACTIVA','2026-07-19 09:20:00',NULL,NULL),(38,38,18,38,125000.00,'BRONCE','ACTIVA','2026-07-19 13:35:00',NULL,NULL),(39,39,18,39,165000.00,'PLATA','ACTIVA','2026-07-20 11:10:00',NULL,NULL),(40,40,18,40,85000.00,'ORO','ACTIVA','2026-07-20 16:20:00',NULL,NULL),(41,41,6,41,125000.00,'BRONCE','ACTIVA','2026-07-21 10:30:00',NULL,NULL),(42,42,6,42,45000.00,'PLATA','ACTIVA','2026-07-21 14:40:00',NULL,NULL),(43,43,6,43,95000.00,'ORO','ACTIVA','2026-07-22 09:15:00',NULL,NULL),(44,44,5,44,85000.00,'BRONCE','FINALIZADA','2026-06-14 10:00:00','2026-07-22 19:00:00',NULL),(45,45,5,45,145000.00,'PLATA','FINALIZADA','2026-06-15 13:00:00','2026-07-23 18:00:00',NULL),(46,46,5,46,175000.00,'PLATA','FINALIZADA','2026-06-16 09:00:00','2026-07-23 19:00:00',NULL),(47,47,5,47,55000.00,'BRONCE','FINALIZADA','2026-06-17 12:00:00','2026-07-24 18:00:00',NULL),(48,48,5,48,185000.00,'PLATA','FINALIZADA','2026-06-18 14:00:00','2026-07-24 19:00:00',NULL),(49,49,5,49,420000.00,'ORO','FINALIZADA','2026-06-19 10:00:00','2026-07-25 18:00:00',NULL),(50,50,5,50,80000.00,'BRONCE','FINALIZADA','2026-06-20 11:30:00','2026-07-25 19:00:00',NULL),(51,51,6,51,150000.00,'PLATA','FINALIZADA','2026-06-21 09:00:00','2026-07-26 18:00:00',NULL),(52,52,6,52,215000.00,'ORO','FINALIZADA','2026-06-22 10:30:00','2026-07-26 19:00:00',NULL),(53,53,6,53,135000.00,'PLATA','FINALIZADA','2026-06-23 12:00:00','2026-07-27 18:00:00',NULL),(54,54,6,54,110000.00,'BRONCE','FINALIZADA','2026-06-24 14:00:00','2026-07-27 19:00:00',NULL),(55,55,6,55,48000.00,'BRONCE','FINALIZADA','2026-06-25 11:00:00','2026-07-28 18:00:00',NULL),(56,56,6,56,39000.00,'BRONCE','FINALIZADA','2026-06-26 13:00:00','2026-07-28 19:00:00',NULL),(57,57,6,57,62000.00,'BRONCE','FINALIZADA','2026-06-27 10:00:00','2026-07-29 18:00:00',NULL),(58,58,6,58,85000.00,'BRONCE','FINALIZADA','2026-06-28 12:30:00','2026-07-29 19:00:00',NULL),(59,59,6,59,225000.00,'ORO','FINALIZADA','2026-06-29 09:30:00','2026-07-30 18:00:00',NULL),(60,60,6,60,375000.00,'ORO','FINALIZADA','2026-06-30 14:30:00','2026-07-30 19:00:00',NULL),(61,61,7,61,125000.00,'PLATA','FINALIZADA','2026-07-01 10:00:00','2026-07-31 18:00:00',NULL),(62,62,7,62,180000.00,'PLATA','FINALIZADA','2026-07-01 12:00:00','2026-07-31 19:00:00',NULL),(63,63,7,63,72000.00,'BRONCE','FINALIZADA','2026-07-02 09:30:00','2026-08-01 18:00:00',NULL),(64,64,7,64,51000.00,'BRONCE','FINALIZADA','2026-07-02 13:00:00','2026-08-01 19:00:00',NULL),(65,65,7,65,78000.00,'BRONCE','FINALIZADA','2026-07-03 10:30:00','2026-08-02 18:00:00',NULL),(66,66,7,66,95000.00,'BRONCE','FINALIZADA','2026-07-03 14:00:00','2026-08-02 19:00:00',NULL),(67,67,7,67,210000.00,'ORO','FINALIZADA','2026-07-04 11:00:00','2026-08-03 18:00:00',NULL),(68,68,7,68,155000.00,'PLATA','FINALIZADA','2026-07-04 13:30:00','2026-08-03 19:00:00',NULL),(69,69,7,69,58000.00,'BRONCE','FINALIZADA','2026-07-05 09:00:00','2026-08-04 18:00:00',NULL),(70,70,7,70,120000.00,'PLATA','FINALIZADA','2026-07-05 12:00:00','2026-08-04 19:00:00',NULL),(71,71,8,71,295000.00,'ORO','FINALIZADA','2026-07-06 10:00:00','2026-08-05 18:00:00',NULL),(72,72,8,72,215000.00,'PLATA','FINALIZADA','2026-07-06 13:00:00','2026-08-05 19:00:00',NULL),(73,73,8,73,135000.00,'PLATA','FINALIZADA','2026-07-07 09:30:00','2026-08-06 18:00:00',NULL),(74,74,8,74,390000.00,'ORO','FINALIZADA','2026-07-07 14:00:00','2026-08-06 19:00:00',NULL),(75,75,8,75,120000.00,'PLATA','FINALIZADA','2026-07-08 11:00:00','2026-08-07 18:00:00',NULL),(76,76,8,76,72000.00,'BRONCE','FINALIZADA','2026-07-08 15:00:00','2026-08-07 19:00:00',NULL),(77,77,8,77,105000.00,'BRONCE','FINALIZADA','2026-07-09 10:00:00','2026-08-08 18:00:00',NULL),(78,78,8,78,81000.00,'BRONCE','FINALIZADA','2026-07-09 13:30:00','2026-08-08 19:00:00',NULL),(79,79,9,79,325000.00,'ORO','FINALIZADA','2026-07-10 09:30:00','2026-08-09 18:00:00',NULL),(80,80,9,80,47000.00,'BRONCE','FINALIZADA','2026-07-10 14:00:00','2026-08-09 19:00:00',NULL),(81,81,9,81,62000.00,'BRONCE','FINALIZADA','2026-07-11 10:00:00','2026-08-10 18:00:00',NULL),(82,82,9,82,95000.00,'BRONCE','FINALIZADA','2026-07-11 12:30:00','2026-08-10 19:00:00',NULL),(83,83,9,83,110000.00,'PLATA','FINALIZADA','2026-07-12 09:30:00','2026-08-11 18:00:00',NULL),(84,84,9,84,165000.00,'PLATA','FINALIZADA','2026-07-12 14:00:00','2026-08-11 19:00:00',NULL),(85,85,9,85,87000.00,'BRONCE','FINALIZADA','2026-07-13 11:00:00','2026-08-12 18:00:00',NULL),(86,86,9,86,115000.00,'PLATA','FINALIZADA','2026-07-13 13:30:00','2026-08-12 19:00:00',NULL),(87,87,10,87,185000.00,'PLATA','ACTIVA','2026-08-01 10:00:00',NULL,NULL),(88,88,10,88,125000.00,'PLATA','ACTIVA','2026-08-02 11:00:00',NULL,NULL),(89,89,10,89,90000.00,'BRONCE','ACTIVA','2026-08-03 12:00:00',NULL,NULL),(90,90,10,90,85000.00,'BRONCE','ACTIVA','2026-08-04 14:00:00',NULL,NULL),(93,93,3,93,280000.00,'ORO','ACTIVA','2026-08-06 10:00:00',NULL,NULL),(94,94,4,94,95000.00,'BRONCE','ACTIVA','2026-08-06 13:00:00',NULL,NULL),(95,95,5,95,185000.00,'PLATA','ACTIVA','2026-08-07 09:30:00',NULL,NULL),(96,96,6,96,75000.00,'BRONCE','ACTIVA','2026-08-07 12:00:00',NULL,NULL),(97,97,7,97,220000.00,'ORO','ACTIVA','2026-08-08 10:00:00',NULL,NULL),(98,98,8,98,65000.00,'BRONCE','ACTIVA','2026-08-08 14:00:00',NULL,NULL),(99,99,9,99,180000.00,'PLATA','ACTIVA','2026-08-09 11:00:00',NULL,NULL),(100,100,10,100,420000.00,'ORO','ACTIVA','2026-08-10 13:00:00',NULL,NULL);
/*!40000 ALTER TABLE `publicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `publicaciones_tendencia`
--

DROP TABLE IF EXISTS `publicaciones_tendencia`;
/*!50001 DROP VIEW IF EXISTS `publicaciones_tendencia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `publicaciones_tendencia` AS SELECT 
 1 AS `id_publicacion`,
 1 AS `producto`,
 1 AS `cantidad_preguntas`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `respuestas`
--

DROP TABLE IF EXISTS `respuestas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `respuestas` (
  `id_respuesta` int NOT NULL AUTO_INCREMENT,
  `id_pregunta` int NOT NULL,
  `id_usuario_vendedor` int NOT NULL,
  `respuesta` text NOT NULL,
  `fecha_respuesta` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_respuesta`),
  UNIQUE KEY `id_pregunta` (`id_pregunta`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id_pregunta`),
  CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuestas`
--

LOCK TABLES `respuestas` WRITE;
/*!40000 ALTER TABLE `respuestas` DISABLE KEYS */;
INSERT INTO `respuestas` VALUES (1,1,1,'Sí, la notebook cuenta con garantía por seis meses.','2026-07-01 13:00:00'),(2,2,2,'Sí, el celular está completamente liberado.','2026-07-01 14:00:00'),(3,3,3,'Sí, incluye el estuche de carga original.','2026-07-02 12:00:00'),(4,4,4,'Sí, tiene entrada HDMI y DisplayPort.','2026-07-02 17:00:00'),(5,5,5,'Sí, tiene distribución en español latinoamericano.','2026-07-03 15:00:00'),(6,6,6,'Sí, funciona mediante Bluetooth y también mediante receptor USB.','2026-07-03 18:00:00'),(7,7,7,'Sí, incluye el cargador original.','2026-07-04 19:00:00'),(8,8,8,'Sí, es compatible con teléfonos Android.','2026-07-04 20:00:00'),(9,9,9,'Sí, incluye el lente que aparece en las fotografías.','2026-07-05 12:30:00'),(10,10,10,'La batería tiene una duración aproximada de diez horas.','2026-07-05 16:00:00'),(11,11,11,'Sí, incluye un joystick original.','2026-07-06 13:30:00'),(12,12,12,'Sí, la consola funciona correctamente.','2026-07-06 17:10:00'),(13,13,13,'Sí, incluye ambos Joy-Con.','2026-07-07 12:30:00'),(14,14,14,'Sí, el teléfono está desbloqueado.','2026-07-07 14:30:00'),(15,15,15,'No presenta daños importantes y se encuentra en buen estado.','2026-07-08 11:30:00'),(16,16,16,'Tiene 16GB de memoria RAM.','2026-07-08 18:00:00'),(17,17,17,'Sí, tiene un disco SSD de 512GB.','2026-07-09 13:20:00'),(18,18,18,'La resolución es Full HD de 1920x1080.','2026-07-09 19:00:00'),(19,19,19,'Sí, la impresora tiene conexión WiFi.','2026-07-10 13:00:00'),(20,20,20,'Sí, el SSD es nuevo y nunca fue utilizado.','2026-07-10 17:00:00'),(21,21,21,'Sí, es una memoria DDR4 de 16GB.','2026-07-11 12:30:00'),(22,22,22,'Es una Nvidia GeForce GTX 1660 Super.','2026-07-11 15:30:00'),(23,23,23,'Sí, incluye el cooler original.','2026-07-12 13:00:00'),(24,24,24,'Sí, la motherboard cuenta con conexión WiFi.','2026-07-12 17:30:00'),(25,25,25,'Sí, tiene certificación 80 Plus Bronze.','2026-07-13 13:30:00'),(26,26,26,'Sí, incluye tres ventiladores RGB.','2026-07-13 18:00:00'),(27,27,27,'Sí, soporta hasta 130 kilos aproximadamente.','2026-07-14 12:30:00'),(28,28,28,'Se entrega desarmado y con todos los accesorios necesarios.','2026-07-14 16:30:00'),(29,29,29,'No presenta detalles importantes.','2026-07-15 12:30:00'),(30,30,30,'Sí, puede desmontarse para facilitar el traslado.','2026-07-15 18:00:00'),(31,31,31,'No, la publicación corresponde únicamente a la cama.','2026-07-16 14:00:00'),(32,32,32,'El colchón tiene aproximadamente 25 centímetros de grosor.','2026-07-16 19:00:00'),(33,33,33,'El placard tiene cuatro puertas.','2026-07-17 12:30:00'),(34,34,34,'Sí, puede desarmarse para transportarlo.','2026-07-17 15:30:00'),(35,35,35,'Sí, la lámpara funciona correctamente.','2026-07-18 13:00:00'),(36,36,36,'Sí, incluye todos los accesorios originales.','2026-07-18 17:30:00'),(37,37,37,'Sí, el microondas cuenta con función grill.','2026-07-19 12:00:00'),(38,38,38,'Sí, tiene cinco velocidades diferentes.','2026-07-19 16:30:00'),(39,39,39,'Sí, incluye el filtro correspondiente.','2026-07-20 13:30:00'),(40,40,40,'Sí, se apaga automáticamente cuando alcanza la temperatura.','2026-07-20 19:00:00'),(41,41,41,'La campera publicada es talle M.','2026-07-21 12:30:00'),(42,42,42,'Actualmente tengo disponibles los talles M y L.','2026-07-21 17:00:00'),(43,43,43,'Sí, el jean tiene corte recto.','2026-07-22 11:30:00'),(44,44,44,'Sí, la camisa es principalmente de algodón.','2026-07-22 15:30:00'),(45,45,45,'Sí, las zapatillas son originales.','2026-07-23 13:00:00'),(46,46,46,'Las botas presentan un desgaste leve en la suela.','2026-07-23 18:00:00'),(47,47,47,'Sí, es una pelota de tamaño profesional.','2026-07-24 12:30:00'),(48,48,48,'Sí, incluye una funda protectora.','2026-07-24 16:30:00'),(49,49,49,'Sí, tiene 21 velocidades.','2026-07-25 11:30:00'),(50,50,50,'Sí, las mancuernas permiten regular el peso.','2026-07-25 18:00:00'),(51,51,51,'El set incluye 45 herramientas diferentes.','2026-07-26 13:00:00'),(52,52,52,'Sí, incluye una batería recargable.','2026-07-26 17:30:00'),(53,53,53,'Sí, es recargable mediante USB.','2026-07-27 12:30:00'),(54,54,54,'Sí, tiene varios compartimentos internos.','2026-07-27 16:30:00'),(55,55,55,'Sí, el libro está completamente en español.','2026-07-28 11:30:00'),(56,56,56,'Sí, la novela se encuentra en muy buen estado.','2026-07-28 15:30:00'),(57,57,57,'Sí, contiene todas las recetas indicadas en la descripción.','2026-07-29 12:30:00'),(58,58,58,'Sí, la enciclopedia está completa.','2026-07-29 17:00:00'),(59,59,59,'Sí, incluye una funda para transporte.','2026-07-30 11:30:00'),(60,60,60,'Sí, tiene parlantes incorporados.','2026-07-30 15:30:00'),(61,61,61,'Sí, puede conectarse mediante USB.','2026-07-31 13:00:00'),(62,62,62,'Sí, está diseñado principalmente para guitarra.','2026-07-31 18:00:00'),(63,63,63,'El juego admite entre dos y seis jugadores.','2026-08-01 12:00:00'),(64,64,64,'El rompecabezas tiene 1000 piezas.','2026-08-01 16:30:00'),(65,65,65,'Sí, incluye los accesorios que aparecen en las imágenes.','2026-08-02 11:30:00'),(66,66,66,'Sí, incluye el control remoto.','2026-08-02 18:00:00'),(67,67,67,'La consola incluye más de 200 juegos clásicos.','2026-08-03 13:00:00'),(68,68,68,'Sí, es una figura original de colección.','2026-08-03 17:30:00'),(69,69,69,'No está completo, faltan algunas figuritas.','2026-08-04 12:30:00'),(70,70,70,'La moneda es del año 1950.','2026-08-04 16:30:00');
/*!40000 ALTER TABLE `respuestas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subastas`
--

DROP TABLE IF EXISTS `subastas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subastas` (
  `id_publicacion` int NOT NULL,
  `oferta_maxima` decimal(15,2) DEFAULT NULL,
  `id_usuario_ofertante` int DEFAULT NULL,
  PRIMARY KEY (`id_publicacion`),
  KEY `id_usuario_ofertante` (`id_usuario_ofertante`),
  CONSTRAINT `subastas_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`),
  CONSTRAINT `subastas_ibfk_2` FOREIGN KEY (`id_usuario_ofertante`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subastas`
--

LOCK TABLES `subastas` WRITE;
/*!40000 ALTER TABLE `subastas` DISABLE KEYS */;
INSERT INTO `subastas` VALUES (51,150000.00,61),(52,215000.00,72),(53,135000.00,84),(54,110000.00,19),(55,48000.00,37),(56,39000.00,65),(57,62000.00,91),(58,85000.00,12),(59,225000.00,43),(60,375000.00,77),(61,125000.00,28),(62,180000.00,53),(63,72000.00,16),(64,51000.00,94),(65,78000.00,35),(66,95000.00,69),(67,210000.00,88),(68,155000.00,24),(69,58000.00,57),(70,120000.00,31),(71,295000.00,46),(72,215000.00,73),(73,135000.00,8),(74,390000.00,63),(75,120000.00,86),(76,72000.00,44),(77,105000.00,97),(78,81000.00,21),(79,325000.00,54),(80,47000.00,82),(81,62000.00,13),(82,95000.00,71),(83,110000.00,39),(84,165000.00,92),(85,87000.00,26),(86,115000.00,67),(87,185000.00,5),(88,125000.00,58),(89,90000.00,34),(90,85000.00,76),(93,NULL,NULL),(94,NULL,NULL),(95,NULL,NULL),(96,NULL,NULL),(97,NULL,NULL),(98,NULL,NULL),(99,NULL,NULL),(100,NULL,NULL);
/*!40000 ALTER TABLE `subastas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alumno27.lopez.sebastian`@`localhost`*/ /*!50003 TRIGGER `puja` BEFORE UPDATE ON `subastas` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `top_categorias_semana`
--

DROP TABLE IF EXISTS `top_categorias_semana`;
/*!50001 DROP VIEW IF EXISTS `top_categorias_semana`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `top_categorias_semana` AS SELECT 
 1 AS `id_categoria`,
 1 AS `categoria`,
 1 AS `publicaciones`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transacciones`
--

DROP TABLE IF EXISTS `transacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacciones` (
  `id_transaccion` int NOT NULL AUTO_INCREMENT,
  `id_publicacion` int NOT NULL,
  `id_usuario_comprador` int NOT NULL,
  `id_usuario_vendedor` int NOT NULL,
  `monto` decimal(15,2) NOT NULL,
  `medio_pago` enum('TARJETA_CREDITO','TARJETA_DEBITO','PAGO_FACIL','RAPIPAGO') NOT NULL,
  `medio_envio` enum('OCA','CORREO_ARGENTINO') NOT NULL,
  `estado` enum('PENDIENTE','CONCRETADA','CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
  `fecha_transaccion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaccion`),
  KEY `id_publicacion` (`id_publicacion`),
  KEY `id_usuario_comprador` (`id_usuario_comprador`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`),
  CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`id_usuario_comprador`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `transacciones_ibfk_3` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones`
--

LOCK TABLES `transacciones` WRITE;
/*!40000 ALTER TABLE `transacciones` DISABLE KEYS */;
INSERT INTO `transacciones` VALUES (1,51,2,51,150000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-26 18:00:00'),(2,52,3,52,215000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-26 19:00:00'),(3,53,4,53,135000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-27 18:00:00'),(4,54,5,54,110000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-27 19:00:00'),(5,55,6,55,48000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-28 18:00:00'),(6,56,7,56,39000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-28 19:00:00'),(7,57,8,57,62000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-29 18:00:00'),(8,58,9,58,85000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-29 19:00:00'),(9,59,10,59,225000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-30 18:00:00'),(10,60,11,60,375000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-30 19:00:00'),(11,61,12,61,125000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-31 18:00:00'),(12,62,13,62,180000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-31 19:00:00'),(13,63,14,63,72000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-01 18:00:00'),(14,64,15,64,51000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-01 19:00:00'),(15,65,16,65,78000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-02 18:00:00'),(16,66,17,66,95000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-02 19:00:00'),(17,67,18,67,210000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-03 18:00:00'),(18,68,19,68,155000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-03 19:00:00'),(19,69,20,69,58000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-04 18:00:00'),(20,70,21,70,120000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-04 19:00:00'),(21,71,22,71,295000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-05 18:00:00'),(22,72,23,72,215000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-05 19:00:00'),(23,73,24,73,135000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-06 18:00:00'),(24,74,25,74,390000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-06 19:00:00'),(25,75,26,75,120000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-07 18:00:00'),(26,76,27,76,72000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-07 19:00:00'),(27,77,28,77,105000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-08 18:00:00'),(28,78,29,78,81000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-08 19:00:00'),(29,79,30,79,325000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-09 18:00:00'),(30,80,31,80,47000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-09 19:00:00'),(31,81,32,81,62000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-10 18:00:00'),(32,82,33,82,95000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-10 19:00:00'),(33,83,34,83,110000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-11 18:00:00'),(34,84,35,84,165000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-11 19:00:00'),(35,85,36,85,87000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-12 18:00:00'),(36,86,37,86,115000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-12 19:00:00'),(37,87,38,87,185000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-08-13 09:00:00'),(38,88,39,88,125000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-08-13 09:10:00'),(39,89,40,89,90000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-08-13 09:20:00'),(40,90,41,90,85000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-08-13 09:30:00'),(43,93,44,93,280000.00,'PAGO_FACIL','OCA','PENDIENTE','2026-06-15 18:30:00'),(44,94,45,94,95000.00,'RAPIPAGO','CORREO_ARGENTINO','PENDIENTE','2026-06-17 18:30:00'),(45,95,46,95,185000.00,'TARJETA_CREDITO','OCA','PENDIENTE','2026-06-19 18:30:00'),(46,96,47,96,75000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','PENDIENTE','2026-06-21 18:30:00'),(47,97,48,97,220000.00,'PAGO_FACIL','OCA','PENDIENTE','2026-06-23 18:30:00'),(48,98,49,98,65000.00,'RAPIPAGO','CORREO_ARGENTINO','PENDIENTE','2026-06-25 18:30:00'),(49,99,50,99,180000.00,'TARJETA_CREDITO','OCA','PENDIENTE','2026-06-27 18:30:00'),(50,100,51,100,95000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','PENDIENTE','2026-06-29 18:30:00'),(51,1,52,1,850000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-01 18:30:00'),(52,2,53,2,620000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-01 19:00:00'),(53,3,54,3,185000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-02 18:30:00'),(54,4,55,4,310000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-02 19:00:00'),(55,5,56,5,95000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-03 18:30:00'),(56,6,57,6,65000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-03 19:00:00'),(57,7,58,7,280000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-04 18:30:00'),(58,8,59,8,145000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-04 19:00:00'),(59,9,60,9,720000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-05 18:30:00'),(60,10,61,10,180000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-05 19:00:00'),(61,11,62,11,980000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-06 18:30:00'),(62,12,63,12,890000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-06 19:00:00'),(63,13,64,13,520000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-07 18:30:00'),(64,14,65,14,670000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-07 19:00:00'),(65,15,66,15,820000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-08 18:30:00'),(66,16,67,16,730000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-08 19:00:00'),(67,17,68,17,690000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-09 18:30:00'),(68,18,69,18,430000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-09 19:00:00'),(69,19,70,19,240000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-10 18:30:00'),(70,20,71,20,85000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-10 19:00:00'),(71,21,72,21,120000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-11 18:30:00'),(72,22,73,22,480000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-11 19:00:00'),(73,23,74,23,390000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-12 18:30:00'),(74,24,75,24,210000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-12 19:00:00'),(75,25,76,25,180000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-13 18:30:00'),(76,26,77,26,145000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-13 19:00:00'),(77,27,78,27,320000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-14 18:30:00'),(78,28,79,28,210000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-14 19:00:00'),(79,29,80,29,135000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-15 18:30:00'),(80,30,81,30,680000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-15 19:00:00'),(81,31,82,31,420000.00,'TARJETA_CREDITO','OCA','CANCELADA','2026-07-16 18:30:00'),(82,32,83,32,390000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CANCELADA','2026-07-16 19:00:00'),(83,33,84,33,450000.00,'PAGO_FACIL','OCA','CANCELADA','2026-07-17 18:30:00'),(84,34,85,34,175000.00,'RAPIPAGO','CORREO_ARGENTINO','CANCELADA','2026-07-17 19:00:00'),(85,35,86,35,95000.00,'TARJETA_CREDITO','OCA','CANCELADA','2026-07-18 18:30:00'),(86,36,87,36,230000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CANCELADA','2026-07-18 19:00:00'),(87,37,88,37,185000.00,'PAGO_FACIL','OCA','CANCELADA','2026-07-19 18:30:00'),(88,38,89,38,125000.00,'RAPIPAGO','CORREO_ARGENTINO','CANCELADA','2026-07-19 19:00:00'),(89,39,90,39,165000.00,'TARJETA_CREDITO','OCA','CANCELADA','2026-07-20 18:30:00'),(90,40,91,40,85000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CANCELADA','2026-07-20 19:00:00'),(93,43,94,43,95000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-22 18:30:00'),(94,44,95,44,85000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-22 19:00:00'),(95,45,96,45,145000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-23 18:30:00'),(96,46,97,46,175000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-23 19:00:00'),(97,47,98,47,55000.00,'TARJETA_CREDITO','OCA','CONCRETADA','2026-07-24 18:30:00'),(98,48,99,48,185000.00,'TARJETA_DEBITO','CORREO_ARGENTINO','CONCRETADA','2026-07-24 19:00:00'),(99,49,100,49,420000.00,'PAGO_FACIL','OCA','CONCRETADA','2026-07-25 18:30:00'),(100,50,1,50,80000.00,'RAPIPAGO','CORREO_ARGENTINO','CONCRETADA','2026-07-25 19:00:00'),(101,1,2,1,850000.00,'TARJETA_CREDITO','CORREO_ARGENTINO','CONCRETADA','2026-08-20 08:12:30'),(102,1,2,1,850000.00,'TARJETA_CREDITO','CORREO_ARGENTINO','CONCRETADA','2026-08-20 08:12:56'),(103,1,2,1,850000.00,'TARJETA_CREDITO','CORREO_ARGENTINO','CONCRETADA','2026-08-20 08:20:20'),(104,1,2,1,850000.00,'TARJETA_CREDITO','CORREO_ARGENTINO','CONCRETADA','2026-08-20 10:02:59');
/*!40000 ALTER TABLE `transacciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alumno27.lopez.sebastian`@`localhost`*/ /*!50003 TRIGGER `venta_nivel` AFTER UPDATE ON `transacciones` FOR EACH ROW BEGIN
    IF NEW.estado = 'CONCRETADA' AND OLD.estado <> 'CONCRETADA' THEN
        UPDATE usuarios
        SET cantidad_ventas = cantidad_ventas + 1,
            facturacion = facturacion + NEW.monto
        WHERE id_usuario = NEW.id_usuario_vendedor;
        call actualizar_nivel(new.id_usuario_vendedor,@var1,@var2);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nivel` enum('NORMAL','PLATINUM','GOLD') DEFAULT 'NORMAL',
  `reputacion` decimal(5,2) DEFAULT '0.00',
  `cantidad_ventas` int DEFAULT '0',
  `facturacion` decimal(15,2) DEFAULT '0.00',
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `idx_usuarios_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Juan','Gomez','juan.gomez@mail.com','pass123','NORMAL',72.50,5,42500.00,'2026-08-13 10:32:40'),(2,'Maria','Lopez','maria.lopez@mail.com','pass456','GOLD',91.20,12,156800.00,'2026-08-13 10:32:40'),(3,'Carlos','Martinez','carlos.martinez@mail.com','pass789','NORMAL',68.40,3,18500.00,'2026-08-13 10:32:40'),(4,'Ana','Rodriguez','ana.rodriguez@mail.com','ana123','PLATINUM',97.80,25,480000.00,'2026-08-13 10:32:40'),(5,'Lucas','Fernandez','lucas.fernandez@mail.com','lucas123','GOLD',88.60,10,125500.00,'2026-08-13 10:32:40'),(6,'Sofia','Garcia','sofia.garcia@mail.com','sofia123','NORMAL',74.30,4,32000.00,'2026-08-13 10:32:40'),(7,'Martin','Sanchez','martin.sanchez@mail.com','martin123','GOLD',85.70,9,98700.00,'2026-08-13 10:32:40'),(8,'Laura','Romero','laura.romero@mail.com','laura123','NORMAL',63.20,2,15400.00,'2026-08-13 10:32:40'),(9,'Diego','Torres','diego.torres@mail.com','diego123','GOLD',89.40,11,143200.00,'2026-08-13 10:32:40'),(10,'Valentina','Diaz','valentina.diaz@mail.com','vale123','PLATINUM',98.10,28,532000.00,'2026-08-13 10:32:40'),(11,'Nicolas','Alvarez','nicolas.alvarez@mail.com','nico123','NORMAL',70.50,4,28700.00,'2026-08-13 10:32:40'),(12,'Camila','Moreno','camila.moreno@mail.com','camila123','GOLD',86.90,8,93400.00,'2026-08-13 10:32:40'),(13,'Matias','Muñoz','matias.munoz@mail.com','matias123','NORMAL',61.80,2,11200.00,'2026-08-13 10:32:40'),(14,'Julieta','Castro','julieta.castro@mail.com','juli123','GOLD',84.50,7,76500.00,'2026-08-13 10:32:40'),(15,'Federico','Ortiz','federico.ortiz@mail.com','fede123','NORMAL',77.30,5,45300.00,'2026-08-13 10:32:40'),(16,'Martina','Silva','martina.silva@mail.com','martina123','PLATINUM',96.40,22,395000.00,'2026-08-13 10:32:40'),(17,'Santiago','Rojas','santiago.rojas@mail.com','santi123','GOLD',87.20,9,108500.00,'2026-08-13 10:32:40'),(18,'Agustina','Vega','agustina.vega@mail.com','agus123','NORMAL',69.70,3,21300.00,'2026-08-13 10:32:40'),(19,'Tomas','Navarro','tomas.navarro@mail.com','tomas123','GOLD',90.10,13,176400.00,'2026-08-13 10:32:40'),(20,'Florencia','Molina','florencia.molina@mail.com','flor123','NORMAL',73.60,4,36700.00,'2026-08-13 10:32:40'),(21,'Benjamin','Suarez','benjamin.suarez@mail.com','benja123','NORMAL',66.40,2,14800.00,'2026-08-13 10:32:40'),(22,'Paula','Blanco','paula.blanco@mail.com','paula123','GOLD',83.80,7,68900.00,'2026-08-13 10:32:40'),(23,'Gonzalo','Iglesias','gonzalo.iglesias@mail.com','gonza123','NORMAL',71.90,3,19700.00,'2026-08-13 10:32:40'),(24,'Lucia','Medina','lucia.medina@mail.com','lucia123','PLATINUM',95.70,20,351000.00,'2026-08-13 10:32:40'),(25,'Franco','Cabrera','franco.cabrera@mail.com','franco123','GOLD',88.30,10,119800.00,'2026-08-13 10:32:40'),(26,'Carolina','Pereyra','carolina.pereyra@mail.com','caro123','NORMAL',64.50,2,12600.00,'2026-08-13 10:32:40'),(27,'Agustin','Acosta','agustin.acosta@mail.com','agus456','GOLD',85.90,8,91500.00,'2026-08-13 10:32:40'),(28,'Daniela','Correa','daniela.correa@mail.com','dani123','NORMAL',76.20,4,33700.00,'2026-08-13 10:32:40'),(29,'Ignacio','Sosa','ignacio.sosa@mail.com','ignacio123','GOLD',89.70,12,151600.00,'2026-08-13 10:32:40'),(30,'Victoria','Mendez','victoria.mendez@mail.com','victoria123','PLATINUM',97.30,24,428500.00,'2026-08-13 10:32:40'),(31,'Joaquin','Herrera','joaquin.herrera@mail.com','joaquin123','NORMAL',70.80,3,22400.00,'2026-08-13 10:32:40'),(32,'Rocio','Paz','rocio.paz@mail.com','rocio123','GOLD',86.50,9,104300.00,'2026-08-13 10:32:40'),(33,'Emiliano','Farias','emiliano.farias@mail.com','emiliano123','NORMAL',62.70,2,9800.00,'2026-08-13 10:32:40'),(34,'Micaela','Luna','micaela.luna@mail.com','mica123','GOLD',84.90,7,71500.00,'2026-08-13 10:32:40'),(35,'Sebastian','Duarte','sebastian.duarte@mail.com','seba123','NORMAL',78.40,5,48700.00,'2026-08-13 10:32:40'),(36,'Abril','Peralta','abril.peralta@mail.com','abril123','PLATINUM',96.80,21,382000.00,'2026-08-13 10:32:40'),(37,'Ramiro','Miranda','ramiro.miranda@mail.com','ramiro123','GOLD',87.60,9,112300.00,'2026-08-13 10:32:40'),(38,'Milagros','Caceres','milagros.caceres@mail.com','mili123','NORMAL',68.90,3,17600.00,'2026-08-13 10:32:40'),(39,'Maximiliano','Dominguez','maximiliano.dominguez@mail.com','maxi123','GOLD',91.40,14,189500.00,'2026-08-13 10:32:40'),(40,'Candela','Ferreyra','candela.ferreyra@mail.com','cande123','NORMAL',75.10,4,35200.00,'2026-08-13 10:32:40'),(41,'Facundo','Benitez','facundo.benitez@mail.com','facu123','NORMAL',65.80,2,13400.00,'2026-08-13 10:32:40'),(42,'Josefina','Vazquez','josefina.vazquez@mail.com','jose123','GOLD',88.10,10,128700.00,'2026-08-13 10:32:40'),(43,'Leandro','Villalba','leandro.villalba@mail.com','lean123','NORMAL',72.40,3,20500.00,'2026-08-13 10:32:40'),(44,'Pilar','Cardozo','pilar.cardozo@mail.com','pilar123','PLATINUM',98.50,30,575000.00,'2026-08-13 10:32:40'),(45,'Bruno','Maidana','bruno.maidana@mail.com','bruno123','GOLD',85.30,8,89300.00,'2026-08-13 10:32:40'),(46,'Malena','Roldan','malena.roldan@mail.com','male123','NORMAL',69.20,3,18400.00,'2026-08-13 10:32:40'),(47,'Ezequiel','Godoy','ezequiel.godoy@mail.com','eze123','GOLD',89.90,11,136500.00,'2026-08-13 10:32:40'),(48,'Bianca','Bustos','bianca.bustos@mail.com','bianca123','NORMAL',74.80,4,31800.00,'2026-08-13 10:32:40'),(49,'Alejandro','Ponce','alejandro.ponce@mail.com','ale123','GOLD',87.40,9,97500.00,'2026-08-13 10:32:40'),(50,'Renata','Saez','renata.saez@mail.com','renata123','PLATINUM',96.10,23,412000.00,'2026-08-13 10:32:40'),(51,'Gabriel','Vidal','gabriel.vidal@mail.com','gabi123','NORMAL',67.50,2,13900.00,'2026-08-13 10:32:40'),(52,'Constanza','Mansilla','constanza.mansilla@mail.com','connie123','GOLD',84.70,7,72100.00,'2026-08-13 10:32:40'),(53,'Valentin','Ledesma','valentin.ledesma@mail.com','valen123','NORMAL',73.80,4,29400.00,'2026-08-13 10:32:40'),(54,'Belen','Ojeda','belen.ojeda@mail.com','belen123','GOLD',90.50,12,147800.00,'2026-08-13 10:32:40'),(55,'Pablo','Quiroga','pablo.quiroga@mail.com','pablo123','NORMAL',63.90,2,10700.00,'2026-08-13 10:32:40'),(56,'Delfina','Barrios','delfina.barrios@mail.com','delfi123','PLATINUM',97.60,26,465000.00,'2026-08-13 10:32:40'),(57,'Hernan','Leiva','hernan.leiva@mail.com','hernan123','GOLD',86.20,8,88400.00,'2026-08-13 10:32:40'),(58,'Sol','Godoy','sol.godoy@mail.com','sol123','NORMAL',71.30,3,22100.00,'2026-08-13 10:32:40'),(59,'Esteban','Linares','esteban.linares@mail.com','esteban123','GOLD',89.20,11,141300.00,'2026-08-13 10:32:40'),(60,'Lola','Moyano','lola.moyano@mail.com','lola123','NORMAL',76.90,4,36400.00,'2026-08-13 10:32:40'),(61,'Cristian','Arce','cristian.arce@mail.com','cris123','NORMAL',68.70,2,15200.00,'2026-08-13 10:32:40'),(62,'Natalia','Escobar','natalia.escobar@mail.com','naty123','GOLD',85.80,9,109500.00,'2026-08-13 10:32:40'),(63,'Marcos','Barrera','marcos.barrera@mail.com','marcos123','NORMAL',74.10,4,28600.00,'2026-08-13 10:32:40'),(64,'Elena','Campos','elena.campos@mail.com','elena123','PLATINUM',98.00,27,498000.00,'2026-08-13 10:32:40'),(65,'Andres','Franco','andres.franco@mail.com','andres123','GOLD',87.90,10,124600.00,'2026-08-13 10:32:40'),(66,'Celeste','Valdez','celeste.valdez@mail.com','cele123','NORMAL',66.80,2,11700.00,'2026-08-13 10:32:40'),(67,'Mauricio','Cortez','mauricio.cortez@mail.com','mau123','GOLD',90.20,13,168700.00,'2026-08-13 10:32:40'),(68,'Eva','Rios','eva.rios@mail.com','eva123','NORMAL',72.90,3,23500.00,'2026-08-13 10:32:40'),(69,'Gaston','Macias','gaston.macias@mail.com','gaston123','GOLD',84.20,7,69500.00,'2026-08-13 10:32:40'),(70,'Noelia','Salas','noelia.salas@mail.com','noe123','PLATINUM',96.90,22,387000.00,'2026-08-13 10:32:40'),(71,'Ariel','Carrizo','ariel.carrizo@mail.com','ariel123','NORMAL',69.50,3,19800.00,'2026-08-13 10:32:40'),(72,'Lorena','Vera','lorena.vera@mail.com','lorena123','GOLD',88.70,10,116400.00,'2026-08-13 10:32:40'),(73,'Rodrigo','Molina','rodrigo.molina@mail.com','rodrigo123','NORMAL',75.60,4,34200.00,'2026-08-13 10:32:40'),(74,'Carla','Aguirre','carla.aguirre@mail.com','carla123','GOLD',91.00,14,182500.00,'2026-08-13 10:32:40'),(75,'Gustavo','Rey','gustavo.rey@mail.com','gus123','NORMAL',64.70,2,12900.00,'2026-08-13 10:32:40'),(76,'Marina','Maldonado','marina.maldonado@mail.com','marina123','PLATINUM',97.40,25,447000.00,'2026-08-13 10:32:40'),(77,'Enzo','Rosales','enzo.rosales@mail.com','enzo123','GOLD',86.80,8,92400.00,'2026-08-13 10:32:40'),(78,'Iara','Rivas','iara.rivas@mail.com','iara123','NORMAL',70.20,3,21400.00,'2026-08-13 10:32:40'),(79,'Oscar','Paredes','oscar.paredes@mail.com','oscar123','GOLD',89.60,12,155700.00,'2026-08-13 10:32:40'),(80,'Julia','Cisneros','julia.cisneros@mail.com','julia123','NORMAL',77.50,5,41800.00,'2026-08-13 10:32:40'),(81,'Raul','Coronel','raul.coronel@mail.com','raul123','NORMAL',67.10,2,14300.00,'2026-08-13 10:32:40'),(82,'Flor','Ramos','flor.ramos@mail.com','flor123','GOLD',85.40,8,86700.00,'2026-08-13 10:32:40'),(83,'Kevin','Sanchez','kevin.sanchez@mail.com','kevin123','NORMAL',73.20,3,24600.00,'2026-08-13 10:32:40'),(84,'Marisol','Duran','marisol.duran@mail.com','marisol123','PLATINUM',98.30,29,551000.00,'2026-08-13 10:32:40'),(85,'Walter','Meza','walter.meza@mail.com','walter123','GOLD',87.10,9,101500.00,'2026-08-13 10:32:40'),(86,'Tamara','Nunez','tamara.nunez@mail.com','tamara123','NORMAL',65.40,2,12100.00,'2026-08-13 10:32:40'),(87,'Federico','Ledesma','federico.ledesma@mail.com','fede456','GOLD',90.80,13,174200.00,'2026-08-13 10:32:40'),(88,'Luz','Benitez','luz.benitez@mail.com','luz123','NORMAL',74.60,4,33100.00,'2026-08-13 10:32:40'),(89,'Mariano','Vega','mariano.vega@mail.com','mariano123','GOLD',88.50,10,132800.00,'2026-08-13 10:32:40'),(90,'Cecilia','Mendez','cecilia.mendez@mail.com','ceci123','PLATINUM',96.70,24,421000.00,'2026-08-13 10:32:40'),(91,'Luis','Ferreyra','luis.ferreyra@mail.com','luis123','NORMAL',68.20,3,19100.00,'2026-08-13 10:32:40'),(92,'Romina','Suarez','romina.suarez@mail.com','romi123','GOLD',84.80,7,73800.00,'2026-08-13 10:32:40'),(93,'Ivan','Cabrera','ivan.cabrera@mail.com','ivan123','NORMAL',72.70,4,27500.00,'2026-08-13 10:32:40'),(94,'Agustina','Pereira','agustina.pereira@mail.com','agus789','GOLD',91.70,15,196300.00,'2026-08-13 10:32:40'),(95,'Nahuel','Vargas','nahuel.vargas@mail.com','nahuel123','NORMAL',66.30,2,13500.00,'2026-08-13 10:32:40'),(96,'Mara','Figueroa','mara.figueroa@mail.com','mara123','PLATINUM',98.70,31,589000.00,'2026-08-13 10:32:40'),(97,'Thiago','Herrera','thiago.herrera@mail.com','thiago123','GOLD',87.80,9,107600.00,'2026-08-13 10:32:40'),(98,'Elisa','Dominguez','elisa.dominguez@mail.com','elisa123','NORMAL',75.40,4,31900.00,'2026-08-13 10:32:40'),(99,'Jorge','Castillo','jorge.castillo@mail.com','jorge123','GOLD',89.30,11,148900.00,'2026-08-13 10:32:40'),(100,'Patricia','Roldan','patricia.roldan@mail.com','patricia123','PLATINUM',97.90,26,476000.00,'2026-08-13 10:32:40');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_directas`
--

DROP TABLE IF EXISTS `ventas_directas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_directas` (
  `id_publicacion` int NOT NULL,
  PRIMARY KEY (`id_publicacion`),
  CONSTRAINT `ventas_directas_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_directas`
--

LOCK TABLES `ventas_directas` WRITE;
/*!40000 ALTER TABLE `ventas_directas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas_directas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `mejor_vendedor_categoria`
--

/*!50001 DROP VIEW IF EXISTS `mejor_vendedor_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno27.lopez.sebastian`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mejor_vendedor_categoria` AS select `x`.`categoria` AS `categoria`,`x`.`vendedor` AS `vendedor`,`x`.`reputacion` AS `reputacion` from (select `c`.`nombre` AS `categoria`,concat(`u`.`nombre`,' ',`u`.`apellido`) AS `vendedor`,`u`.`reputacion` AS `reputacion`,row_number() OVER (PARTITION BY `c`.`id_categoria` ORDER BY `u`.`reputacion` desc )  AS `posicion` from ((`categorias` `c` join `publicaciones` `p` on((`p`.`id_categoria` = `c`.`id_categoria`))) join `usuarios` `u` on((`u`.`id_usuario` = `p`.`id_usuario_vendedor`)))) `x` where (`x`.`posicion` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `preguntas_sin_responder`
--

/*!50001 DROP VIEW IF EXISTS `preguntas_sin_responder`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno27.lopez.sebastian`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `preguntas_sin_responder` AS select `q`.`id_pregunta` AS `id_pregunta`,`q`.`pregunta` AS `descripcion`,`q`.`id_publicacion` AS `publicacion`,`pr`.`nombre` AS `producto`,`u`.`nombre` AS `usuario_que_respondio` from ((((`preguntas` `q` join `publicaciones` `p` on((`p`.`id_publicacion` = `q`.`id_publicacion`))) join `productos` `pr` on((`pr`.`id_producto` = `p`.`id_producto`))) left join `respuestas` `r` on((`r`.`id_pregunta` = `q`.`id_pregunta`))) left join `usuarios` `u` on((`u`.`id_usuario` = `r`.`id_usuario_vendedor`))) where ((`p`.`estado` in ('ACTIVA','OBSERVADA')) and (`r`.`id_respuesta` is null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `publicaciones_tendencia`
--

/*!50001 DROP VIEW IF EXISTS `publicaciones_tendencia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno27.lopez.sebastian`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `publicaciones_tendencia` AS select `p`.`id_publicacion` AS `id_publicacion`,`pr`.`nombre` AS `producto`,count(`q`.`id_pregunta`) AS `cantidad_preguntas` from ((`publicaciones` `p` join `productos` `pr` on((`pr`.`id_producto` = `p`.`id_producto`))) left join `preguntas` `q` on(((`q`.`id_publicacion` = `p`.`id_publicacion`) and (cast(`q`.`fecha_pregunta` as date) = curdate())))) where (`p`.`estado` in ('ACTIVA','OBSERVADA')) group by `p`.`id_publicacion`,`pr`.`nombre` having (count(`q`.`id_pregunta`) > 0) order by `cantidad_preguntas` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `top_categorias_semana`
--

/*!50001 DROP VIEW IF EXISTS `top_categorias_semana`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alumno27.lopez.sebastian`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `top_categorias_semana` AS select `c`.`id_categoria` AS `id_categoria`,`c`.`nombre` AS `categoria`,count(`p`.`id_publicacion`) AS `publicaciones` from (`categorias` `c` join `publicaciones` `p` on((`p`.`id_categoria` = `c`.`id_categoria`))) where (`p`.`fecha_publicacion` >= (curdate() - interval 7 day)) group by `c`.`id_categoria`,`c`.`nombre` order by `publicaciones` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-20 10:21:18
