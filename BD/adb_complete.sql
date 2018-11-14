/*
 Navicat Premium Data Transfer

 Source Server         : Yamataka
 Source Server Type    : MySQL
 Source Server Version : 50621
 Source Host           : localhost:3306
 Source Schema         : adb

 Target Server Type    : MySQL
 Target Server Version : 50621
 File Encoding         : 65001

 Date: 14/11/2018 03:27:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accesos
-- ----------------------------
DROP TABLE IF EXISTS `accesos`;
CREATE TABLE `accesos`  (
  `id_acceso` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_tipo_acceso` int(11) NOT NULL,
  `FechaHora_Entrega` datetime(0) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `ruta_aprobacion` varchar(512) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL COMMENT 'ruta donde se aloja el archivo de aprobacion',
  `FechaHora_Devolucion` datetime(0) NOT NULL,
  `estado_acceso` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Estado del acceso 1 o 0 / Activo o Inactivo',
  PRIMARY KEY (`id_acceso`) USING BTREE,
  INDEX `TipoAcceso`(`id_tipo_acceso`) USING BTREE,
  INDEX `Empleado`(`id_empleado`) USING BTREE,
  CONSTRAINT `Empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TipoAcceso` FOREIGN KEY (`id_tipo_acceso`) REFERENCES `tiposacceso` (`id_tipo_acceso`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for cargos
-- ----------------------------
DROP TABLE IF EXISTS `cargos`;
CREATE TABLE `cargos`  (
  `id_cargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cargo` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `id_departamento` int(11) NOT NULL,
  PRIMARY KEY (`id_cargo`) USING BTREE,
  INDEX `Cargo-Depto`(`id_departamento`) USING BTREE,
  CONSTRAINT `Cargo-Depto` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cargos
-- ----------------------------
INSERT INTO `cargos` VALUES (1, 'Desarrollador Senior REVAT', 1);

-- ----------------------------
-- Table structure for comandas
-- ----------------------------
DROP TABLE IF EXISTS `comandas`;
CREATE TABLE `comandas`  (
  `Idcomanda` bigint(20) NOT NULL AUTO_INCREMENT,
  `IdCombo` bigint(20) NOT NULL,
  `descripcion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `total` decimal(10, 2) NOT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fechaRegistro` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaDespacho` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Idcomanda`) USING BTREE,
  INDEX `IdCombo`(`IdCombo`) USING BTREE,
  CONSTRAINT `comandas_ibfk_1` FOREIGN KEY (`IdCombo`) REFERENCES `combos` (`Idcombo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comandas
-- ----------------------------
INSERT INTO `comandas` VALUES (1, 1, 'Descripcion', 2.99, 'A', '2018-09-29 17:47:51', '2018-09-30 09:52:14');
INSERT INTO `comandas` VALUES (7, 1, 'dfdf', 10.00, 'D', '2018-09-30 17:12:38', '2018-09-30 10:01:53');
INSERT INTO `comandas` VALUES (8, 1, 'perfecto para el\nalmuerzo, pero genial\ncualquier momento.', 10.00, 'D', '2018-09-30 17:13:32', '2018-09-30 10:14:00');
INSERT INTO `comandas` VALUES (9, 2, 'Combinacion perfecta', 15.00, 'D', '2018-09-30 17:30:30', '2018-09-30 10:12:59');
INSERT INTO `comandas` VALUES (10, 1, 'perfecto para el\nalmuerzo, pero genial\ncualquier momento.', 10.00, 'D', '2018-09-30 18:26:54', '2018-09-30 10:27:04');
INSERT INTO `comandas` VALUES (11, 2, 'Combinacion perfecta', 15.00, 'D', '2018-09-30 20:02:59', '2018-09-30 12:03:12');

-- ----------------------------
-- Table structure for combos
-- ----------------------------
DROP TABLE IF EXISTS `combos`;
CREATE TABLE `combos`  (
  `Idcombo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `precio` decimal(10, 2) NOT NULL,
  `imagen` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`Idcombo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of combos
-- ----------------------------
INSERT INTO `combos` VALUES (1, 'WINGS y FRIES ', ' perfecto para el\r\nalmuerzo, pero genial\r\ncualquier momento.', 'A', 10.00, 'Imagen1.png\r\n');
INSERT INTO `combos` VALUES (2, 'Dona con refil de cafe', 'Combinacion perfecta', 'A', 15.00, 'Imagen1.png');

-- ----------------------------
-- Table structure for departamentos
-- ----------------------------
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos`  (
  `id_departamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_departamento` varchar(75) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  PRIMARY KEY (`id_departamento`) USING BTREE,
  INDEX `depto-empresa`(`id_empresa`) USING BTREE,
  CONSTRAINT `depto-empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of departamentos
-- ----------------------------
INSERT INTO `departamentos` VALUES (1, 'Desarrollo', 2);

-- ----------------------------
-- Table structure for empleados
-- ----------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados`  (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombres_empleado` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `apellidos_empleado` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `id_cargo` int(11) NOT NULL,
  `id_jefe_empleado` int(11) NULL DEFAULT NULL,
  `id_pais` int(11) NULL DEFAULT NULL,
  `estado_empleado` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT '1 caracter para declarar Activo o inactivo este registro',
  PRIMARY KEY (`id_empleado`) USING BTREE,
  INDEX `Jefe_empleado`(`id_jefe_empleado`) USING BTREE,
  INDEX `Cargo_empleado`(`id_cargo`) USING BTREE,
  INDEX `Pais_Empleado`(`id_pais`) USING BTREE,
  CONSTRAINT `Cargo_empleado` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Jefe_empleado` FOREIGN KEY (`id_jefe_empleado`) REFERENCES `empleados` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Pais_Empleado` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of empleados
-- ----------------------------
INSERT INTO `empleados` VALUES (1, 'Jairo Josue', 'Guzman Andres', 1, 1, 1, '1');
INSERT INTO `empleados` VALUES (2, 'Jose Osvaldo', 'Campos Jimenez', 1, 1, 1, '1');

-- ----------------------------
-- Table structure for empresas
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas`  (
  `id_empresa` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(150) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_empresa` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_empresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of empresas
-- ----------------------------
INSERT INTO `empresas` VALUES (1, 'TekHub El Salvador', 'Empresa anfitrión de la solución');
INSERT INTO `empresas` VALUES (2, 'UFG', 'Universidad');

-- ----------------------------
-- Table structure for eventos
-- ----------------------------
DROP TABLE IF EXISTS `eventos`;
CREATE TABLE `eventos`  (
  `id_evento` int(11) NOT NULL AUTO_INCREMENT,
  `tabla_objetivo` varchar(35) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'tabla a la que pertenece el registro a modificar',
  `accion` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL COMMENT 'descripcion del cambio',
  `fecha_hora_ejecucion` datetime(0) NOT NULL,
  `ejecutado_por` int(11) NULL DEFAULT NULL COMMENT 'referencia a cambio empleados.id_empleado',
  PRIMARY KEY (`id_evento`) USING BTREE,
  INDEX `EjecutadoPor`(`ejecutado_por`) USING BTREE,
  CONSTRAINT `EjecutadoPor` FOREIGN KEY (`ejecutado_por`) REFERENCES `empleados` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for paises
-- ----------------------------
DROP TABLE IF EXISTS `paises`;
CREATE TABLE `paises`  (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_pais` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `cod_pais_alfa3` char(3) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL COMMENT 'Codigo de 3 letras ISO_3166-1 codigo alfa 3',
  PRIMARY KEY (`id_pais`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of paises
-- ----------------------------
INSERT INTO `paises` VALUES (1, 'El Salvador', 'SLV');

-- ----------------------------
-- Table structure for tiposacceso
-- ----------------------------
DROP TABLE IF EXISTS `tiposacceso`;
CREATE TABLE `tiposacceso`  (
  `id_tipo_acceso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_acceso` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Nombre corto de tipo acceso',
  `descripcion_tipo_acceso` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL COMMENT 'Descripcion con todos los detalles del tipo de acceso',
  PRIMARY KEY (`id_tipo_acceso`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tiposacceso
-- ----------------------------
INSERT INTO `tiposacceso` VALUES (1, 'Acceso local', 'Acceso para empleados de la oficina corportativa');
INSERT INTO `tiposacceso` VALUES (2, 'Acceso Externo', 'Acceso para empleados de la empresa que residen en otras oficinas');
INSERT INTO `tiposacceso` VALUES (3, 'Visitas', 'Acceso para personal de otras empresas vinculadas a TekHub que visiten las instalaciones corporativas');

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `Idusuario` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `usuario` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `clave` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`Idusuario`) USING BTREE,
  UNIQUE INDEX `usuario`(`usuario`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES (1, 'Administrador', 'Administrador', 'admin', 'A');
INSERT INTO `usuarios` VALUES (2, 'Cliente', 'Cliente', 'demo', 'A');

-- ----------------------------
-- Table structure for visitas
-- ----------------------------
DROP TABLE IF EXISTS `visitas`;
CREATE TABLE `visitas`  (
  `id_visita` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre_visita` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `compania_visita` varchar(80) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL COMMENT 'Empresa a la que pertenece el visitante',
  `id_empleado_visitado` int(11) NOT NULL COMMENT 'Id de empleado que se visitara',
  `doc_visita` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Documento identificador legal de la visita como DUI, N Licencia de Conducir, Pasaporte',
  `movito_visita` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL COMMENT 'Detalle de la razon de visita',
  `empleado_escolta` int(11) NULL DEFAULT NULL COMMENT 'Si necesitará escolta se coloca el empleado que lo escoltara',
  `fechahora_ingreso` datetime(0) NULL DEFAULT NULL,
  `fechahora_egreso` datetime(0) NULL DEFAULT NULL,
  `estado_visita` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Estado del acceso VISITA 1 o 0 / Activo o Inactivo',
  PRIMARY KEY (`id_visita`) USING BTREE,
  INDEX `Emp_Visitado`(`id_empleado_visitado`) USING BTREE,
  INDEX `Escolta`(`empleado_escolta`) USING BTREE,
  CONSTRAINT `Emp_Visitado` FOREIGN KEY (`id_empleado_visitado`) REFERENCES `empleados` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Escolta` FOREIGN KEY (`empleado_escolta`) REFERENCES `empleados` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
