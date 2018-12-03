/*
 Navicat Premium Data Transfer

 Source Server         : YamatakaLocal
 Source Server Type    : MySQL
 Source Server Version : 100134
 Source Host           : localhost:3306
 Source Schema         : adb

 Target Server Type    : MySQL
 Target Server Version : 100134
 File Encoding         : 65001

 Date: 02/12/2018 17:59:09
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
  `id_empleado` int(11) NULL DEFAULT NULL,
  `ruta_aprobacion` varchar(512) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL COMMENT 'ruta donde se aloja el archivo de aprobacion',
  `FechaHora_Devolucion` datetime(0) NOT NULL,
  `estado_acceso` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Estado del acceso 1 o 0 / Activo o Inactivo',
  PRIMARY KEY (`id_acceso`) USING BTREE,
  INDEX `fk_accesos_empleados1_idx`(`id_empleado`) USING BTREE,
  INDEX `fk_accesos_tiposacceso1_idx`(`id_tipo_acceso`) USING BTREE,
  CONSTRAINT `fk_accesos_empleados1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_accesos_tiposacceso1` FOREIGN KEY (`id_tipo_acceso`) REFERENCES `tiposacceso` (`id_tipo_acceso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of accesos
-- ----------------------------
INSERT INTO `accesos` VALUES (2, 2, '2018-12-02 22:17:01', 1, '0', '2018-12-03 22:17:01', '1');
INSERT INTO `accesos` VALUES (3, 2, '2018-12-02 22:36:07', 2, '0', '2018-12-03 22:36:07', '0');

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
  `disponible` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_empleado`) USING BTREE,
  INDEX `Jefe_empleado`(`id_jefe_empleado`) USING BTREE,
  INDEX `Cargo_empleado`(`id_cargo`) USING BTREE,
  INDEX `Pais_Empleado`(`id_pais`) USING BTREE,
  CONSTRAINT `Cargo_empleado` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Jefe_empleado` FOREIGN KEY (`id_jefe_empleado`) REFERENCES `empleados` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Pais_Empleado` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of empleados
-- ----------------------------
INSERT INTO `empleados` VALUES (1, 'Jairo Josue', 'Guzman Andres', 1, 1, 1, '1', 1);
INSERT INTO `empleados` VALUES (2, 'Jose Osvaldo', 'Campos Jimenez', 1, 1, 1, '1', 1);
INSERT INTO `empleados` VALUES (3, 'Javier', 'Castillo', 1, 1, 1, '1', 1);

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
-- Table structure for parametros
-- ----------------------------
DROP TABLE IF EXISTS `parametros`;
CREATE TABLE `parametros`  (
  `parametro` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `valor_numerico` int(11) NULL DEFAULT NULL,
  `periodo_inicial` datetime(0) NULL DEFAULT NULL,
  `periodo_final` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`parametro`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of parametros
-- ----------------------------
INSERT INTO `parametros` VALUES ('periodo_visita', NULL, '2001-01-00 09:00:00', '2001-01-00 11:00:00');

-- ----------------------------
-- Table structure for tiposacceso
-- ----------------------------
DROP TABLE IF EXISTS `tiposacceso`;
CREATE TABLE `tiposacceso`  (
  `id_tipo_acceso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_acceso` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT 'Nombre corto de tipo acceso',
  `descripcion_tipo_acceso` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL COMMENT 'Descripcion con todos los detalles del tipo de acceso',
  PRIMARY KEY (`id_tipo_acceso`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tiposacceso
-- ----------------------------
INSERT INTO `tiposacceso` VALUES (1, 'Acceso local', 'Acceso para empleados de la oficina corportativa');
INSERT INTO `tiposacceso` VALUES (2, 'Acceso externo', 'Acceso para empleados de oficinas externas');

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of visitas
-- ----------------------------
INSERT INTO `visitas` VALUES (1, 'Javier Ernesto Castillo Martinez', 'Claro', 1, '12345678-1', 'Probando', 2, '2018-11-08 00:00:00', '2018-12-02 06:59:26', '3');
INSERT INTO `visitas` VALUES (2, 'Juan Perez', 'Claro', 2, '02505078-2', 'Ventas', 1, '2018-11-27 13:39:30', '2018-12-02 17:06:00', '1');
INSERT INTO `visitas` VALUES (3, 'Elmer Barrios', 'Claro', 1, '02501234-2', 'TEST', 1, '2018-12-01 13:39:30', '2018-12-01 22:43:12', '0');
INSERT INTO `visitas` VALUES (4, 'Gaby', 'SIMAN', 1, '123456', 'TEST', 1, '2018-12-02 04:30:07', NULL, '1');
INSERT INTO `visitas` VALUES (5, 'Gaby', 'SIMAN', 1, '123456', 'TEST', 2, '2018-12-02 04:31:01', NULL, '1');
INSERT INTO `visitas` VALUES (6, 'Gaby', 'SITES', 2, '123456', 'TEST', 2, '2018-12-02 06:39:05', NULL, '1');

-- ----------------------------
-- View structure for v_dashboard_accesos
-- ----------------------------
DROP VIEW IF EXISTS `v_dashboard_accesos`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dashboard_accesos` AS select
a1.id_acceso,
ta.nombre_tipo_acceso as tipo_acceso,
e1.nombres_empleado as empleado,
e2.nombres_empleado as jefe,
c1.nombre_cargo as cargo,
d1.nombre_departamento,
a1.FechaHora_Entrega,
a1.FechaHora_Devolucion,
a1.estado_acceso
from accesos as a1
INNER JOIN empleados as e1 on a1.id_empleado = e1.id_empleado
INNER JOIN empleados as e2 on e1.id_jefe_empleado = e2.id_empleado
INNER JOIN cargos as c1 on e1.id_cargo = c1.id_cargo
INNER JOIN departamentos as d1 on c1.id_departamento = d1.id_departamento
INNER JOIN tiposacceso as ta on a1.id_tipo_acceso = ta.id_tipo_acceso
WHERE
a1.estado_acceso <> '2' ;

-- ----------------------------
-- View structure for v_dashboard_visitas
-- ----------------------------
DROP VIEW IF EXISTS `v_dashboard_visitas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dashboard_visitas` AS SELECT
v.id_visita,
v.nombre_visita,
v.compania_visita,
e1.nombres_empleado AS visitando_a,
e2.nombres_empleado AS escolta,
v.fechahora_ingreso,
v.estado_visita,
v.empleado_escolta
FROM
visitas AS v
INNER JOIN empleados AS e1 ON v.id_empleado_visitado = e1.id_empleado
INNER JOIN empleados AS e2 on v.empleado_escolta = e2.id_empleado
WHERE
v.estado_visita <> '2' ;

-- ----------------------------
-- View structure for v_info_emplado
-- ----------------------------
DROP VIEW IF EXISTS `v_info_emplado`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_info_emplado` AS select concat(`e`.`nombres_empleado`,' ',`e`.`apellidos_empleado`) AS `Nombre Empleado`,concat(`j`.`nombres_empleado`,' ',`j`.`apellidos_empleado`) AS `Nombre Supervisor`,`d`.`nombre_departamento` AS `Departamento` from (((`empleados` `e` left join `cargos` `c` on((`e`.`id_cargo` = `c`.`id_cargo`))) left join `departamentos` `d` on((`c`.`id_departamento` = `d`.`id_departamento`))) left join `empleados` `j` on((`j`.`id_empleado` = `j`.`id_jefe_empleado`))) ;

-- ----------------------------
-- View structure for v_info_supervisor
-- ----------------------------
DROP VIEW IF EXISTS `v_info_supervisor`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_info_supervisor` AS select concat(`j`.`nombres_empleado`,' ',`j`.`apellidos_empleado`) AS `Supervisor`,`e`.`id_empleado` AS `Numero Empleado`,concat(`e`.`nombres_empleado`,' ',`e`.`apellidos_empleado`) AS `Empleado`,`d`.`nombre_departamento` AS `Departamento` from (((`empleados` `e` left join `cargos` `c` on((`e`.`id_cargo` = `c`.`id_cargo`))) left join `departamentos` `d` on((`c`.`id_departamento` = `d`.`id_departamento`))) left join `empleados` `j` on((`j`.`id_empleado` = `j`.`id_jefe_empleado`))) order by concat(`j`.`nombres_empleado`,' ',`j`.`apellidos_empleado`) ;

-- ----------------------------
-- View structure for v_info_visita
-- ----------------------------
DROP VIEW IF EXISTS `v_info_visita`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_info_visita` AS select `v`.`nombre_visita` AS `Nombre Visitante`,`v`.`compania_visita` AS `Compañia` from `visitas` `v` ;

-- ----------------------------
-- View structure for v_nombre_empleado_activo
-- ----------------------------
DROP VIEW IF EXISTS `v_nombre_empleado_activo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_nombre_empleado_activo` AS select concat(`t1`.`nombres_empleado`,' ',`t1`.`apellidos_empleado`) AS `Empleados Activos` from `empleados` `t1` where (`t1`.`estado_empleado` = 1) ;

-- ----------------------------
-- View structure for v_tipo_acceso
-- ----------------------------
DROP VIEW IF EXISTS `v_tipo_acceso`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_tipo_acceso` AS select `t1`.`nombre_tipo_acceso` AS `Tipo de Acceso` from `tiposacceso` `t1` ;

-- ----------------------------
-- Procedure structure for c_escolta
-- ----------------------------
DROP PROCEDURE IF EXISTS `c_escolta`;
delimiter ;;
CREATE PROCEDURE `c_escolta`()
BEGIN
 DECLARE done INT DEFAULT 0;
 DECLARE nombre longtext;
 DECLARE n2 longtext DEFAULT "";
 DECLARE e CURSOR FOR SELECT t2.nombres_empleado FROM visitas t1 inner join empleados t2 on t1.empleado_escolta = t2.id_empleado; 
 DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

OPEN e;

fetch_loop: LOOP
FETCH e INTO nombre;
IF done THEN
	LEAVE fetch_loop;
END IF;
SET n2 = CONCAT(nombre,",",n2);
END LOOP;

CLOSE e;

SELECT 'Las personas que fueron escolata hoy son',n2;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for c_visita
-- ----------------------------
DROP PROCEDURE IF EXISTS `c_visita`;
delimiter ;;
CREATE PROCEDURE `c_visita`()
BEGIN
 DECLARE done INT DEFAULT 0;
 DECLARE count INT DEFAULT 0;
 DECLARE code INT;
 DECLARE visita_cnt CURSOR FOR SELECT visitas.id_visita FROM visitas WHERE  DATE(fechahora_ingreso) = DATE(NOW()); 
 DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

OPEN visita_cnt;

fetch_loop: LOOP
FETCH visita_cnt INTO code;
IF done THEN
	LEAVE fetch_loop;
END IF;
SET count = count + 1;
END LOOP;

CLOSE visita_cnt;

SELECT 'Numero de visitas en el dia son',count;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for f_asignar_escolta
-- ----------------------------
DROP FUNCTION IF EXISTS `f_asignar_escolta`;
delimiter ;;
CREATE FUNCTION `f_asignar_escolta`(`idacceso` INT)
 RETURNS int(11)
BEGIN

	/*1=Asignado  0=No hay pendiente de asignar  -1=Error de Asignacion  -2=No hay visita asociada al acceso*/
	DECLARE vResultadoAsignacion int;
    DECLARE vPendienteAsignar    int;
    DECLARE vIdEmpleadoEscolta   int;
    DECLARE vVisitaAsociada      int;
    
    
    select count(*), max(a.id_visita) into vPendienteAsignar, vVisitaAsociada from accesos a 
		 inner join tiposacceso b on a.id_tipo_acceso=b.id_tipo_acceso
         inner join visitas     c on a.id_visita     =c.id_visita
		 where b.id_tipo_acceso=3 /*Visita*/ and a.id_empleado is null and empleado_escolta is null and a.id_acceso= idacceso;


	if vVisitaAsociada is null then 
		set vResultadoAsignacion = -2;
        return vResultadoAsignacion;
    end if;
    
    if vPendienteAsignar <=0 then
		set vResultadoAsignacion = 0;
    else
		select min(id_empleado) into vIdEmpleadoEscolta
        from   empleados 
        where  id_empleado not in (     select empleado_escolta from accesos a 
										inner join tiposacceso b on a.id_tipo_acceso=b.id_tipo_acceso
										inner join visitas     c on a.id_visita     =c.id_visita
										where 	b.id_tipo_acceso=3 /*Visita*/ and a.id_empleado is null and empleado_escolta is not null and f_ref_acc( a.id_acceso) <0 );

		if vIdEmpleadoEscolta > 0 then
			update visitas set empleado_escolta = vIdEmpleadoEscolta where id_visita=  vVisitaAsociada;
            set vResultadoAsignacion = 1;
        else
			set vResultadoAsignacion = -1;
        end if;
    end if;
	


RETURN vResultadoAsignacion;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for f_ref_acc
-- ----------------------------
DROP FUNCTION IF EXISTS `f_ref_acc`;
delimiter ;;
CREATE FUNCTION `f_ref_acc`(`idacceso` INT)
 RETURNS int(11)
BEGIN
	
	DECLARE vHorasFaltantes int;
	SET time_zone = '-6:00';
    select extract( hour from timediff(NOW(), FechaHora_Devolucion) ) INTO vHorasFaltantes FROM accesos WHERE id_acceso = idacceso;
    
	RETURN vHorasFaltantes;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for f_separar_visitas
-- ----------------------------
DROP FUNCTION IF EXISTS `f_separar_visitas`;
delimiter ;;
CREATE FUNCTION `f_separar_visitas`(`idEmpleadoVisitado` INT)
 RETURNS varchar(4000) CHARSET utf8
BEGIN
	DECLARE vCursorVisitasFin INTEGER DEFAULT 0;
    DECLARE vVisitas varchar(1000);
    DECLARE vMinutosTotalVisita   int;
    DECLARE vMinutosPorVisita   int;
    DECLARE vCantidadVisitas int;
    DECLARE vHoraInicioVisita datetime;
    DECLARE vNombreVisita varchar(500);
    DECLARE vCursorVisitas cursor for select nombre_visita from visitas where id_empleado_visitado=idEmpleadoVisitado;
    DECLARE CONTINUE HANDLER  FOR NOT FOUND SET vCursorVisitasFin = 1;
    
    set vVisitas = ' ';
    select round(TIME_TO_SEC(timediff(periodo_final, periodo_inicial))/60,2) , periodo_inicial into vMinutosTotalVisita , vHoraInicioVisita from parametros where parametro='periodo_visita';
	select count(*) into vCantidadVisitas from visitas where id_empleado_visitado=idEmpleadoVisitado;
    
    if vCantidadVisitas <=0 then
		set vVisitas = 'No hay programacion de Visitas';
	else
		set vMinutosPorVisita = vMinutosTotalVisita  / vCantidadVisitas;
		
		open vCursorVisitas;
		getvCursorVisitas : loop
			fetch vCursorVisitas into vNombreVisita;
			if vCursorVisitasFin =1 then 
				leave getvCursorVisitas;
			end if;
			set vVisitas = concat( trim(vVisitas), concat( concat( concat( rpad( vNombreVisita, 50, '.'),   '  Inicio:' ) ,  rpad(date_format( vHoraInicioVisita,'%H:%i' ),10,' ')   ) ,  char(13) )  ) ;
            set vHoraInicioVisita = ADDTIME( vHoraInicioVisita , SEC_TO_TIME(vMinutosPorVisita*60));

		end loop getvCursorVisitas;
		close vCursorVisitas;
    
    
    end if;
    
	

RETURN vVisitas;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_desactivar_accesos
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_desactivar_accesos`;
delimiter ;;
CREATE PROCEDURE `p_desactivar_accesos`()
update accesos set estado_acceso = 0 where extract(hour from timediff(now(),FechaHora_Entrega)) >= 24
;;
delimiter ;

-- ----------------------------
-- Procedure structure for t_registro_empleado
-- ----------------------------
DROP PROCEDURE IF EXISTS `t_registro_empleado`;
delimiter ;;
CREATE PROCEDURE `t_registro_empleado`(IN `nemp` VARCHAR(50), IN `aemp` VARCHAR(50), IN `cargo` INT(11), IN `jefe` INT(11), IN `pais` INT(11), IN `estado` CHAR(1))
BEGIN
DECLARE exit handler FOR sqlexception
BEGIN
	ROLLBACK;
END;

START TRANSACTION;

INSERT into  empleados(id_empleado, nombres_empleado, apellidos_empleado, id_cargo,id_jefe_empleado, id_pais,estado_empleado)
VALUES (NULL, nemp,aemp,cargo,jefe,pais,estado);

COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for t_registro_visita
-- ----------------------------
DROP PROCEDURE IF EXISTS `t_registro_visita`;
delimiter ;;
CREATE PROCEDURE `t_registro_visita`(IN `nvisita` VARCHAR(100), IN `comvisita` VARCHAR(80), IN `empvisita` INT(11), IN `docvisita` VARCHAR(20), IN `movisita` VARCHAR(255), IN `empescolta` INT(11), IN `hingreso` DATETIME, IN `hegreso` DATETIME, IN `esta_visita` CHAR(1))
BEGIN
DECLARE exit handler FOR sqlexception
BEGIN
	ROLLBACK;
END;

START TRANSACTION;

INSERT into  visitas(id_visita, nombre_visita, compania_visita, id_empleado_visitado,doc_visita, movito_visita,empleado_escolta,fechahora_ingreso,fechahora_egreso,estado_visita)
VALUES (NULL, nvisita,comvisita,empvisita,docvisita,movisita,empescolta,hingreso,hegreso,esta_visita);
COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for e_desactiva_accesos
-- ----------------------------
DROP EVENT IF EXISTS `e_desactiva_accesos`;
delimiter ;;
CREATE EVENT `e_desactiva_accesos`
ON SCHEDULE
EVERY '1' HOUR STARTS '2018-12-02 15:38:51'
COMMENT 'desactiva accesos vencidos cada hora'
DO CALL p_desactivar_accesos
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
