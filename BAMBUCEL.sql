-- MySQL dump 10.13  Distrib 8.0.16, for macos10.14 (x86_64)
--
-- Host: localhost    Database: bambucel
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `camaras`
--

DROP TABLE IF EXISTS `camaras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `camaras` (
  `id_camara` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `dimensiones` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_camara`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camaras`
--

LOCK TABLES `camaras` WRITE;
/*!40000 ALTER TABLE `camaras` DISABLE KEYS */;
/*!40000 ALTER TABLE `camaras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fecha_expiracion` date DEFAULT NULL,
  `id_estatus_compra` varchar(20) NOT NULL,
  `costo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `observacion` text,
  PRIMARY KEY (`id_compra`),
  KEY `fk_listas_estados_idx` (`id_estatus_compra`),
  CONSTRAINT `fk_listas_estados` FOREIGN KEY (`id_estatus_compra`) REFERENCES `estatus_compras` (`id_estatus_compra`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compras`
--

DROP TABLE IF EXISTS `detalle_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `detalle_compras` (
  `id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_compra` datetime NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `id_insumo` int(11) NOT NULL,
  `cantidad_comprada` decimal(10,4) NOT NULL,
  `cantidad_deseada` decimal(10,4) DEFAULT NULL,
  `unidad_compra` decimal(10,4) DEFAULT '1.0000' COMMENT 'Atributo que permite el calculo mas simple de compra en mayoreo.',
  `id_compra` int(11) NOT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `observacion` text,
  `id_creado_por` int(11) NOT NULL,
  `id_modificado_por` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_compra`),
  KEY `fk_insumos_comprados_listas_compras_idx` (`id_compra`),
  KEY `fk_insumos_comprados_catalogo_proveedores_idx` (`id_proveedor`),
  KEY `fk_insumos_comprados_catalogo_insumos_idx` (`id_insumo`),
  KEY `fk_detalle_compras_usuario_creo_idx` (`id_creado_por`),
  KEY `fk_detalle_compras_usuario_modifico_idx` (`id_modificado_por`),
  CONSTRAINT `fk_detalle_compras_compras` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`),
  CONSTRAINT `fk_detalle_compras_proveedores` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`),
  CONSTRAINT `fk_detalle_compras_usuario_creo` FOREIGN KEY (`id_creado_por`) REFERENCES `usuarios` (`id_persona`),
  CONSTRAINT `fk_detalle_compras_usuario_modifico` FOREIGN KEY (`id_modificado_por`) REFERENCES `usuarios` (`id_persona`),
  CONSTRAINT `fk_insumos_comprados_catalogo_insumos` FOREIGN KEY (`id_insumo`) REFERENCES `insumos` (`id_insumo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compras`
--

LOCK TABLES `detalle_compras` WRITE;
/*!40000 ALTER TABLE `detalle_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_movimientos_productos`
--

DROP TABLE IF EXISTS `detalle_movimientos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `detalle_movimientos_productos` (
  `id_detalle_movimiento` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` decimal(10,4) DEFAULT NULL,
  `id_movimiento` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `observacion` text,
  PRIMARY KEY (`id_detalle_movimiento`),
  KEY `fk_detalle_movimientos_movimientos1_idx` (`id_movimiento`),
  KEY `fk_detalle_movimientos_productos1_idx` (`id_producto`),
  CONSTRAINT `fk_detalle_movimientos_movimientos1` FOREIGN KEY (`id_movimiento`) REFERENCES `movimientos_productos` (`id_movimiento`),
  CONSTRAINT `fk_detalle_movimientos_productos1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_movimientos_productos`
--

LOCK TABLES `detalle_movimientos_productos` WRITE;
/*!40000 ALTER TABLE `detalle_movimientos_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_movimientos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_aplicacion_producto`
--

DROP TABLE IF EXISTS `detalles_aplicacion_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `detalles_aplicacion_producto` (
  `id_detalle_aplicacion_producto` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` decimal(10,4) NOT NULL,
  `es_variable` tinyint(1) NOT NULL DEFAULT '0',
  `id_insumo` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_detalle_aplicacion_producto`),
  KEY `fk_Recetas_insumos1_idx` (`id_insumo`),
  KEY `fk_Recetas_productos1_idx` (`id_producto`),
  CONSTRAINT `fk_Recetas_insumos1` FOREIGN KEY (`id_insumo`) REFERENCES `insumos` (`id_insumo`),
  CONSTRAINT `fk_Recetas_productos1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Es la tabla a la cual llamamos recetas que tiene como objetivo gusrdar todos los insumos que son necesarios para realizar un producto por unidad';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `estatus_compras`
--

DROP TABLE IF EXISTS `estatus_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `estatus_compras` (
  `id_estatus_compra` varchar(20) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_estatus_compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_compras`
--

LOCK TABLES `estatus_compras` WRITE;
/*!40000 ALTER TABLE `estatus_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `estatus_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estatus_produccion`
--

DROP TABLE IF EXISTS `estatus_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `estatus_produccion` (
  `id_estatus_produccion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_estatus_produccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Se encarga de mostrar el estatus de una producción puede ser acrtiva o finalizada';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estatus_produccion`
--

LOCK TABLES `estatus_produccion` WRITE;
/*!40000 ALTER TABLE `estatus_produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `estatus_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `existencias_productos`
--

DROP TABLE IF EXISTS `existencias_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `existencias_productos` (
  `id_existencia` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `id_producto` int(11) NOT NULL,
  `id_camara` int(11) NOT NULL,
  PRIMARY KEY (`id_existencia`),
  KEY `fk_existencias_productos1_idx` (`id_producto`),
  KEY `fk_existencias_camaras1_idx` (`id_camara`),
  CONSTRAINT `fk_existencias_camaras1` FOREIGN KEY (`id_camara`) REFERENCES `camaras` (`id_camara`),
  CONSTRAINT `fk_existencias_productos1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `existencias_productos`
--

LOCK TABLES `existencias_productos` WRITE;
/*!40000 ALTER TABLE `existencias_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `existencias_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumos`
--

DROP TABLE IF EXISTS `insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `insumos` (
  `id_insumo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `costo` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Costo promedio calculado',
  `id_tipo_insumo` varchar(20) NOT NULL,
  `id_unidades_medida` int(11) NOT NULL,
  `cantidad_disponible` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`id_insumo`),
  KEY `fk_insumos_unidades_medida1_idx` (`id_unidades_medida`),
  KEY `fk_insumos_tipo_insumos_idx` (`id_tipo_insumo`),
  CONSTRAINT `fk_insumos_tipo_insumos` FOREIGN KEY (`id_tipo_insumo`) REFERENCES `tipos_insumos` (`id_tipo_insumo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_insumos_unidades_medida1` FOREIGN KEY (`id_unidades_medida`) REFERENCES `unidades_medida` (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumos`
--

LOCK TABLES `insumos` WRITE;
/*!40000 ALTER TABLE `insumos` DISABLE KEYS */;
INSERT INTO `insumos` VALUES (1,'polipapel',10.00,'tipo insumo 1',2,10.0000),(2,'leche',10.00,'tipo insumo 2',1,10.0000),(3,'vainilla',10.00,'tipo insumo 1',3,10.0000),(4,'vaso 200 ml',10.00,'tipo insumo 2',2,10.0000),(5,'ligas',10.00,'tipo insumo 1',2,10.0000),(6,'gelatina',10.00,'tipo insumo 1',4,10.0000),(7,'yogurt',10.00,'tipo insumo 1',3,10.0000);
/*!40000 ALTER TABLE `insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediciones_humedad`
--

DROP TABLE IF EXISTS `mediciones_humedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `mediciones_humedad` (
  `id_medicion_humedad` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `porcentaje` decimal(6,2) NOT NULL,
  `id_sensor` int(11) NOT NULL,
  `id_camara` int(11) NOT NULL,
  `nivel` varchar(45) NOT NULL,
  PRIMARY KEY (`id_medicion_humedad`),
  KEY `fkl_mh_sensor_idx` (`id_sensor`),
  KEY `fk_mh_camara_idx` (`id_camara`),
  CONSTRAINT `fk_mh_camara` FOREIGN KEY (`id_camara`) REFERENCES `camaras` (`id_camara`),
  CONSTRAINT `fkl_mh_sensor` FOREIGN KEY (`id_sensor`) REFERENCES `sensores` (`id_sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediciones_humedad`
--

LOCK TABLES `mediciones_humedad` WRITE;
/*!40000 ALTER TABLE `mediciones_humedad` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediciones_humedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediciones_temperatura`
--

DROP TABLE IF EXISTS `mediciones_temperatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `mediciones_temperatura` (
  `id_medicion_temperatura` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `centigrados` decimal(6,2) NOT NULL,
  `id_sensor` int(11) NOT NULL,
  `id_camara` int(11) NOT NULL,
  `nivel` varchar(45) NOT NULL,
  PRIMARY KEY (`id_medicion_temperatura`),
  KEY `fk_variables_fisicas_estatus_sensor1_idx` (`id_sensor`),
  KEY `fk_variables_fisicas_camaras1_idx` (`id_camara`),
  CONSTRAINT `fk_variables_fisicas_camaras1` FOREIGN KEY (`id_camara`) REFERENCES `camaras` (`id_camara`),
  CONSTRAINT `fk_variables_fisicas_estatus_sensor1` FOREIGN KEY (`id_sensor`) REFERENCES `sensores` (`id_sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediciones_temperatura`
--

LOCK TABLES `mediciones_temperatura` WRITE;
/*!40000 ALTER TABLE `mediciones_temperatura` DISABLE KEYS */;
/*!40000 ALTER TABLE `mediciones_temperatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimiento_insumos`
--

DROP TABLE IF EXISTS `movimiento_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `movimiento_insumos` (
  `id_movimiento` int(11) NOT NULL,
  `id_insumo` int(11) NOT NULL,
  `id_tipo_movimiento_insumo` varchar(45) NOT NULL,
  `fecha` date DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `id_persona` int(11) NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `fk_existencia_insumos_insumos_idx` (`id_insumo`),
  KEY `fk_movimiento_insumos_tipo_movimiento_insumo1_idx` (`id_tipo_movimiento_insumo`),
  KEY `fk_movimiento_insumos_usuarios1_idx` (`id_persona`),
  CONSTRAINT `fk_existencia_insumos_insumos` FOREIGN KEY (`id_insumo`) REFERENCES `insumos` (`id_insumo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_movimiento_insumos_tipo_movimiento_insumo1` FOREIGN KEY (`id_tipo_movimiento_insumo`) REFERENCES `tipo_movimiento_insumo` (`id_tipo_movimiento_insumo`),
  CONSTRAINT `fk_movimiento_insumos_usuarios1` FOREIGN KEY (`id_persona`) REFERENCES `usuarios` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimiento_insumos`
--

LOCK TABLES `movimiento_insumos` WRITE;
/*!40000 ALTER TABLE `movimiento_insumos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimiento_insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_productos`
--

DROP TABLE IF EXISTS `movimientos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `movimientos_productos` (
  `id_movimiento` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `observacion` text,
  `id_usuario_receptor` int(11) NOT NULL,
  `id_usuario_emisor` int(11) NOT NULL,
  `id_tipo_movimiento` varchar(45) NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `fk_movimientos_usuarios1_idx` (`id_usuario_receptor`),
  KEY `fk_movimientos_usuarios2_idx` (`id_usuario_emisor`),
  KEY `fk_movimientos_productos_tipos_movimientos_productos1_idx` (`id_tipo_movimiento`),
  CONSTRAINT `fk_movimientos_usuarios1` FOREIGN KEY (`id_usuario_receptor`) REFERENCES `usuarios` (`id_persona`),
  CONSTRAINT `fk_movimientos_usuarios2` FOREIGN KEY (`id_usuario_emisor`) REFERENCES `usuarios` (`id_persona`),
  CONSTRAINT `fk_tipos_movimientos_productos` FOREIGN KEY (`id_tipo_movimiento`) REFERENCES `tipos_movimientos_productos` (`id_tipo_movimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_productos`
--

LOCK TABLES `movimientos_productos` WRITE;
/*!40000 ALTER TABLE `movimientos_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `perfiles` (
  `id_perfil` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `personas` (
  `id_persona` int(11) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` datetime DEFAULT NULL,
  `correo_electronico` varchar(255) DEFAULT NULL,
  `telefono_particular` varchar(100) DEFAULT NULL,
  `telefono_celular` varchar(100) DEFAULT NULL,
  `rfc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,'Paola Varela Ocampo','F','1992-11-11 00:00:00','empleado1@gmail.com','2281828384','2281828384','PDUF929394'),(2,'Juan Pablo Zamora Treviño','M','1992-11-11 00:00:00','empleado2@gmail.com','2281828384','2281828384','PDUF929394');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentaciones`
--

DROP TABLE IF EXISTS `presentaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `presentaciones` (
  `id_presentacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `cantidad_unidad` decimal(10,4) NOT NULL,
  `id_unidad_medida` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_presentacion`),
  KEY `fk_presentaciones_unidades_medida1_idx` (`id_unidad_medida`),
  CONSTRAINT `fk_presentaciones_unidades_medida1` FOREIGN KEY (`id_unidad_medida`) REFERENCES `unidades_medida` (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentaciones`
--

LOCK TABLES `presentaciones` WRITE;
/*!40000 ALTER TABLE `presentaciones` DISABLE KEYS */;
INSERT INTO `presentaciones` VALUES (1,'presentacion 1',1.0000,1,1);
/*!40000 ALTER TABLE `presentaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producciones`
--

DROP TABLE IF EXISTS `producciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `producciones` (
  `id_produccion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_creacion` datetime NOT NULL,
  `fecha_produccion` datetime NOT NULL,
  `cantidad_producto_final` decimal(10,4) NOT NULL,
  `cantidad_leche` decimal(10,4) NOT NULL,
  `cantidad_yogurt` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `cantidad_suero` decimal(10,4) DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  `id_estatus_produccion` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_produccion`),
  KEY `fk_producciones_productos1_idx` (`id_producto`),
  KEY `fk_producciones_estatus_produccion1_idx` (`id_estatus_produccion`),
  KEY `fk_producciones_personas1_idx` (`id_usuario`),
  CONSTRAINT `fk_producciones_estatus_produccion1` FOREIGN KEY (`id_estatus_produccion`) REFERENCES `estatus_produccion` (`id_estatus_produccion`),
  CONSTRAINT `fk_producciones_productos1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `fk_producciones_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Modulo que se encarga de proceso de producción de los productos que se realizan dentro de bambucel';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producciones`
--

LOCK TABLES `producciones` WRITE;
/*!40000 ALTER TABLE `producciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `producciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `id_tipo_producto` varchar(20) NOT NULL,
  `id_sabor` int(11) NOT NULL,
  `id_presentacion` int(11) NOT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `fk_productos_tipos_producto1_idx` (`id_tipo_producto`),
  KEY `fk_productos_sabores1_idx` (`id_sabor`),
  KEY `fk_productos_presentaciones1_idx` (`id_presentacion`),
  CONSTRAINT `fk_productos_presentaciones1` FOREIGN KEY (`id_presentacion`) REFERENCES `presentaciones` (`id_presentacion`),
  CONSTRAINT `fk_productos_sabores1` FOREIGN KEY (`id_sabor`) REFERENCES `sabores` (`id_sabor`),
  CONSTRAINT `fk_productos_tipos_producto1` FOREIGN KEY (`id_tipo_producto`) REFERENCES `tipos_productos` (`id_tipo_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Flan de vainilla',1,'1',1,1),(2,'Queso de hebra',1,'1',1,1),(3,'Vaso de yogurt',1,'1',1,1),(4,'Vaso de gelatina con yogurt',1,'1',1,1);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `costo_litro_leche` decimal(10,2) NOT NULL DEFAULT '0.00',
  `observacion` text,
  `telefono_cel` varchar(100) DEFAULT NULL,
  `rfc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sabores`
--

DROP TABLE IF EXISTS `sabores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sabores` (
  `id_sabor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_sabor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sabores`
--

LOCK TABLES `sabores` WRITE;
/*!40000 ALTER TABLE `sabores` DISABLE KEYS */;
INSERT INTO `sabores` VALUES (1,'sabor 1',1);
/*!40000 ALTER TABLE `sabores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensores`
--

DROP TABLE IF EXISTS `sensores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sensores` (
  `id_sensor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `id_tipo_sensor` varchar(45) NOT NULL,
  `fecha_instalacion` datetime DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_sensor`),
  KEY `fk_sensores_tipo_sensor_idx` (`id_tipo_sensor`),
  CONSTRAINT `fk_sensores_tipo_sensor` FOREIGN KEY (`id_tipo_sensor`) REFERENCES `tipos_sensores` (`id_tipo_sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensores`
--

LOCK TABLES `sensores` WRITE;
/*!40000 ALTER TABLE `sensores` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_movimiento_insumo`
--

DROP TABLE IF EXISTS `tipo_movimiento_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipo_movimiento_insumo` (
  `id_tipo_movimiento_insumo` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_movimiento_insumo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_movimiento_insumo`
--

LOCK TABLES `tipo_movimiento_insumo` WRITE;
/*!40000 ALTER TABLE `tipo_movimiento_insumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_movimiento_insumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_insumos`
--

DROP TABLE IF EXISTS `tipos_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipos_insumos` (
  `id_tipo_insumo` varchar(20) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_tipo_insumo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_insumos`
--

LOCK TABLES `tipos_insumos` WRITE;
/*!40000 ALTER TABLE `tipos_insumos` DISABLE KEYS */;
INSERT INTO `tipos_insumos` VALUES ('tipo insumo 1','1'),('tipo insumo 2','2');
/*!40000 ALTER TABLE `tipos_insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_movimientos_productos`
--

DROP TABLE IF EXISTS `tipos_movimientos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipos_movimientos_productos` (
  `id_tipo_movimiento` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo_movimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_movimientos_productos`
--

LOCK TABLES `tipos_movimientos_productos` WRITE;
/*!40000 ALTER TABLE `tipos_movimientos_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipos_movimientos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_productos`
--

DROP TABLE IF EXISTS `tipos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipos_productos` (
  `id_tipo_producto` varchar(20) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_productos`
--

LOCK TABLES `tipos_productos` WRITE;
/*!40000 ALTER TABLE `tipos_productos` DISABLE KEYS */;
INSERT INTO `tipos_productos` VALUES ('1','tipo producto 1');
/*!40000 ALTER TABLE `tipos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_sensores`
--

DROP TABLE IF EXISTS `tipos_sensores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipos_sensores` (
  `id_tipo_sensor` varchar(45) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_sensores`
--

LOCK TABLES `tipos_sensores` WRITE;
/*!40000 ALTER TABLE `tipos_sensores` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipos_sensores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades_medida`
--

DROP TABLE IF EXISTS `unidades_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `unidades_medida` (
  `id_unidad_medida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `abreviatura` varchar(4) NOT NULL,
  PRIMARY KEY (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades_medida`
--

LOCK TABLES `unidades_medida` WRITE;
/*!40000 ALTER TABLE `unidades_medida` DISABLE KEYS */;
INSERT INTO `unidades_medida` VALUES (1,'litro','lt'),(2,'pieza','pz'),(3,'mililitro','ml'),(4,'gramo','gr');
/*!40000 ALTER TABLE `unidades_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuarios` (
  `id_persona` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `es_activo` tinyint(1) NOT NULL,
  `id_perfil` varchar(45) NOT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `fk_usuarios_perfil_idx` (`id_perfil`),
  CONSTRAINT `fk_usuarios_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`),
  CONSTRAINT `fk_usuarios_persona` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-17  0:33:52
