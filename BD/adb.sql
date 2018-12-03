-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2018 at 09:50 PM
-- Server version: 5.7.20-log
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `c_escolta` ()  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `c_visita` ()  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `t_registro_empleado` (IN `nemp` VARCHAR(50), IN `aemp` VARCHAR(50), IN `cargo` INT(11), IN `jefe` INT(11), IN `pais` INT(11), IN `estado` CHAR(1))  BEGIN
DECLARE exit handler FOR sqlexception
BEGIN
	ROLLBACK;
END;

START TRANSACTION;

INSERT into  empleados(id_empleado, nombres_empleado, apellidos_empleado, id_cargo,id_jefe_empleado, id_pais,estado_empleado)
VALUES (NULL, nemp,aemp,cargo,jefe,pais,estado);

COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `t_registro_visita` (IN `nvisita` VARCHAR(100), IN `comvisita` VARCHAR(80), IN `empvisita` INT(11), IN `docvisita` VARCHAR(20), IN `movisita` VARCHAR(255), IN `empescolta` INT(11), IN `hingreso` DATETIME, IN `hegreso` DATETIME, IN `esta_visita` CHAR(1))  BEGIN
DECLARE exit handler FOR sqlexception
BEGIN
	ROLLBACK;
END;

START TRANSACTION;

INSERT into  visitas(id_visita, nombre_visita, compania_visita, id_empleado_visitado,doc_visita, movito_visita,empleado_escolta,fechahora_ingreso,fechahora_egreso,estado_visita)
VALUES (NULL, nvisita,comvisita,empvisita,docvisita,movisita,empescolta,hingreso,hegreso,esta_visita);
COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accesos`
--

CREATE TABLE `accesos` (
  `id_acceso` bigint(20) NOT NULL,
  `id_tipo_acceso` int(11) NOT NULL,
  `FechaHora_Entrega` datetime NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `ruta_aprobacion` varchar(512) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'ruta donde se aloja el archivo de aprobacion',
  `FechaHora_Devolucion` datetime NOT NULL,
  `estado_acceso` char(1) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Estado del acceso 1 o 0 / Activo o Inactivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `cargos`
--

CREATE TABLE `cargos` (
  `id_cargo` int(11) NOT NULL,
  `nombre_cargo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `id_departamento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `cargos`
--

INSERT INTO `cargos` (`id_cargo`, `nombre_cargo`, `id_departamento`) VALUES
(1, 'Desarrollador Senior REVAT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comandas`
--

CREATE TABLE `comandas` (
  `Idcomanda` bigint(20) NOT NULL,
  `IdCombo` bigint(20) NOT NULL,
  `descripcion` text NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` char(1) NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaDespacho` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `comandas`
--

INSERT INTO `comandas` (`Idcomanda`, `IdCombo`, `descripcion`, `total`, `estado`, `fechaRegistro`, `fechaDespacho`) VALUES
(1, 1, 'Descripcion', '2.99', 'A', '2018-09-29 23:47:51', '2018-09-30 15:52:14'),
(7, 1, 'dfdf', '10.00', 'D', '2018-09-30 23:12:38', '2018-09-30 16:01:53'),
(8, 1, 'perfecto para el\nalmuerzo, pero genial\ncualquier momento.', '10.00', 'D', '2018-09-30 23:13:32', '2018-09-30 16:14:00'),
(9, 2, 'Combinacion perfecta', '15.00', 'D', '2018-09-30 23:30:30', '2018-09-30 16:12:59'),
(10, 1, 'perfecto para el\nalmuerzo, pero genial\ncualquier momento.', '10.00', 'D', '2018-10-01 00:26:54', '2018-09-30 16:27:04'),
(11, 2, 'Combinacion perfecta', '15.00', 'D', '2018-10-01 02:02:59', '2018-09-30 18:03:12');

-- --------------------------------------------------------

--
-- Table structure for table `combos`
--

CREATE TABLE `combos` (
  `Idcombo` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` char(1) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `combos`
--

INSERT INTO `combos` (`Idcombo`, `nombre`, `descripcion`, `estado`, `precio`, `imagen`) VALUES
(1, 'WINGS y FRIES ', ' perfecto para el\r\nalmuerzo, pero genial\r\ncualquier momento.', 'A', '10.00', 'Imagen1.png\r\n'),
(2, 'Dona con refil de cafe', 'Combinacion perfecta', 'A', '15.00', 'Imagen1.png');

-- --------------------------------------------------------

--
-- Table structure for table `departamentos`
--

CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nombre_departamento` varchar(75) COLLATE utf8_spanish_ci NOT NULL,
  `id_empresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `departamentos`
--

INSERT INTO `departamentos` (`id_departamento`, `nombre_departamento`, `id_empresa`) VALUES
(1, 'Desarrollo', 2);

-- --------------------------------------------------------

--
-- Table structure for table `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `nombres_empleado` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos_empleado` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_cargo` int(11) NOT NULL,
  `id_jefe_empleado` int(11) DEFAULT NULL,
  `id_pais` int(11) DEFAULT NULL,
  `estado_empleado` char(1) COLLATE utf8_spanish_ci NOT NULL COMMENT '1 caracter para declarar Activo o inactivo este registro',
  `disponible` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombres_empleado`, `apellidos_empleado`, `id_cargo`, `id_jefe_empleado`, `id_pais`, `estado_empleado`, `disponible`) VALUES
(1, 'Jairo Josue', 'Guzman Andres', 1, 1, 1, '1', 1),
(2, 'Jose Osvaldo', 'Campos Jimenez', 1, 1, 1, '1', 1),
(3, 'Javier', 'Castillo', 1, 1, 1, '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `empresas`
--

CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL,
  `nombre_empresa` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_empresa` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `nombre_empresa`, `descripcion_empresa`) VALUES
(1, 'TekHub El Salvador', 'Empresa anfitrión de la solución'),
(2, 'UFG', 'Universidad');

-- --------------------------------------------------------

--
-- Table structure for table `eventos`
--

CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `tabla_objetivo` varchar(35) COLLATE utf8_spanish_ci NOT NULL COMMENT 'tabla a la que pertenece el registro a modificar',
  `accion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'descripcion del cambio',
  `fecha_hora_ejecucion` datetime NOT NULL,
  `ejecutado_por` int(11) DEFAULT NULL COMMENT 'referencia a cambio empleados.id_empleado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `paises`
--

CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL,
  `nombre_pais` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `cod_pais_alfa3` char(3) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Codigo de 3 letras ISO_3166-1 codigo alfa 3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `paises`
--

INSERT INTO `paises` (`id_pais`, `nombre_pais`, `cod_pais_alfa3`) VALUES
(1, 'El Salvador', 'SLV');

-- --------------------------------------------------------

--
-- Table structure for table `tiposacceso`
--

CREATE TABLE `tiposacceso` (
  `id_tipo_acceso` int(11) NOT NULL,
  `nombre_tipo_acceso` varchar(25) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Nombre corto de tipo acceso',
  `descripcion_tipo_acceso` text COLLATE utf8_spanish_ci COMMENT 'Descripcion con todos los detalles del tipo de acceso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `tiposacceso`
--

INSERT INTO `tiposacceso` (`id_tipo_acceso`, `nombre_tipo_acceso`, `descripcion_tipo_acceso`) VALUES
(1, 'Acceso local', 'Acceso para empleados de la oficina corportativa'),
(2, 'Acceso Externo', 'Acceso para empleados de la empresa que residen en otras oficinas'),
(3, 'Visitas', 'Acceso para personal de otras empresas vinculadas a TekHub que visiten las instalaciones corporativas');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `Idusuario` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`Idusuario`, `nombre`, `usuario`, `clave`, `estado`) VALUES
(1, 'Administrador', 'Administrador', 'admin', 'A'),
(2, 'Cliente', 'Cliente', 'demo', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `visitas`
--

CREATE TABLE `visitas` (
  `id_visita` bigint(20) NOT NULL,
  `nombre_visita` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `compania_visita` varchar(80) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Empresa a la que pertenece el visitante',
  `id_empleado_visitado` int(11) NOT NULL COMMENT 'Id de empleado que se visitara',
  `doc_visita` varchar(20) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Documento identificador legal de la visita como DUI, N Licencia de Conducir, Pasaporte',
  `movito_visita` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'Detalle de la razon de visita',
  `empleado_escolta` int(11) DEFAULT NULL COMMENT 'Si necesitará escolta se coloca el empleado que lo escoltara',
  `fechahora_ingreso` datetime DEFAULT NULL,
  `fechahora_egreso` datetime DEFAULT NULL,
  `estado_visita` char(1) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Estado del acceso VISITA 1 o 0 / Activo o Inactivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `visitas`
--

INSERT INTO `visitas` (`id_visita`, `nombre_visita`, `compania_visita`, `id_empleado_visitado`, `doc_visita`, `movito_visita`, `empleado_escolta`, `fechahora_ingreso`, `fechahora_egreso`, `estado_visita`) VALUES
(1, 'Javier Ernesto Castillo Martinez', 'Claro', 1, '12345678-1', 'Probando', 2, '2018-11-08 00:00:00', '2018-11-05 00:00:00', '1'),
(2, 'Juan Perez', 'Claro', 1, '02505078-2', 'Ventas', 3, '2018-11-27 13:39:30', '2018-11-27 14:39:30', '1');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_info_emplado`
--
CREATE TABLE `v_info_emplado` (
`Nombre Empleado` varchar(101)
,`Nombre Supervisor` varchar(101)
,`Departamento` varchar(75)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_info_supervisor`
--
CREATE TABLE `v_info_supervisor` (
`Supervisor` varchar(101)
,`Numero Empleado` int(11)
,`Empleado` varchar(101)
,`Departamento` varchar(75)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_info_visita`
--
CREATE TABLE `v_info_visita` (
`Nombre Visitante` varchar(100)
,`Compañia` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_nombre_empleado_activo`
--
CREATE TABLE `v_nombre_empleado_activo` (
`Empleados Activos` varchar(101)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_tipo_acceso`
--
CREATE TABLE `v_tipo_acceso` (
`Tipo de Acceso` varchar(25)
);

-- --------------------------------------------------------

--
-- Structure for view `v_info_emplado`
--
DROP TABLE IF EXISTS `v_info_emplado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_info_emplado`  AS  select concat(`e`.`nombres_empleado`,' ',`e`.`apellidos_empleado`) AS `Nombre Empleado`,concat(`j`.`nombres_empleado`,' ',`j`.`apellidos_empleado`) AS `Nombre Supervisor`,`d`.`nombre_departamento` AS `Departamento` from (((`empleados` `e` left join `cargos` `c` on((`e`.`id_cargo` = `c`.`id_cargo`))) left join `departamentos` `d` on((`c`.`id_departamento` = `d`.`id_departamento`))) left join `empleados` `j` on((`j`.`id_empleado` = `j`.`id_jefe_empleado`))) ;

-- --------------------------------------------------------

--
-- Structure for view `v_info_supervisor`
--
DROP TABLE IF EXISTS `v_info_supervisor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_info_supervisor`  AS  select concat(`j`.`nombres_empleado`,' ',`j`.`apellidos_empleado`) AS `Supervisor`,`e`.`id_empleado` AS `Numero Empleado`,concat(`e`.`nombres_empleado`,' ',`e`.`apellidos_empleado`) AS `Empleado`,`d`.`nombre_departamento` AS `Departamento` from (((`empleados` `e` left join `cargos` `c` on((`e`.`id_cargo` = `c`.`id_cargo`))) left join `departamentos` `d` on((`c`.`id_departamento` = `d`.`id_departamento`))) left join `empleados` `j` on((`j`.`id_empleado` = `j`.`id_jefe_empleado`))) order by concat(`j`.`nombres_empleado`,' ',`j`.`apellidos_empleado`) ;

-- --------------------------------------------------------

--
-- Structure for view `v_info_visita`
--
DROP TABLE IF EXISTS `v_info_visita`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_info_visita`  AS  select `v`.`nombre_visita` AS `Nombre Visitante`,`v`.`compania_visita` AS `Compañia` from `visitas` `v` ;

-- --------------------------------------------------------

--
-- Structure for view `v_nombre_empleado_activo`
--
DROP TABLE IF EXISTS `v_nombre_empleado_activo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_nombre_empleado_activo`  AS  select concat(`t1`.`nombres_empleado`,' ',`t1`.`apellidos_empleado`) AS `Empleados Activos` from `empleados` `t1` where (`t1`.`estado_empleado` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `v_tipo_acceso`
--
DROP TABLE IF EXISTS `v_tipo_acceso`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_tipo_acceso`  AS  select `t1`.`nombre_tipo_acceso` AS `Tipo de Acceso` from `tiposacceso` `t1` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesos`
--
ALTER TABLE `accesos`
  ADD PRIMARY KEY (`id_acceso`) USING BTREE,
  ADD KEY `TipoAcceso` (`id_tipo_acceso`) USING BTREE,
  ADD KEY `Empleado` (`id_empleado`) USING BTREE;

--
-- Indexes for table `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id_cargo`) USING BTREE,
  ADD KEY `Cargo-Depto` (`id_departamento`) USING BTREE;

--
-- Indexes for table `comandas`
--
ALTER TABLE `comandas`
  ADD PRIMARY KEY (`Idcomanda`) USING BTREE,
  ADD KEY `IdCombo` (`IdCombo`) USING BTREE;

--
-- Indexes for table `combos`
--
ALTER TABLE `combos`
  ADD PRIMARY KEY (`Idcombo`) USING BTREE;

--
-- Indexes for table `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`) USING BTREE,
  ADD KEY `depto-empresa` (`id_empresa`) USING BTREE;

--
-- Indexes for table `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`) USING BTREE,
  ADD KEY `Jefe_empleado` (`id_jefe_empleado`) USING BTREE,
  ADD KEY `Cargo_empleado` (`id_cargo`) USING BTREE,
  ADD KEY `Pais_Empleado` (`id_pais`) USING BTREE;

--
-- Indexes for table `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id_empresa`) USING BTREE;

--
-- Indexes for table `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id_evento`) USING BTREE,
  ADD KEY `EjecutadoPor` (`ejecutado_por`) USING BTREE;

--
-- Indexes for table `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_pais`) USING BTREE;

--
-- Indexes for table `tiposacceso`
--
ALTER TABLE `tiposacceso`
  ADD PRIMARY KEY (`id_tipo_acceso`) USING BTREE;

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Idusuario`) USING BTREE,
  ADD UNIQUE KEY `usuario` (`usuario`) USING BTREE;

--
-- Indexes for table `visitas`
--
ALTER TABLE `visitas`
  ADD PRIMARY KEY (`id_visita`) USING BTREE,
  ADD KEY `Emp_Visitado` (`id_empleado_visitado`) USING BTREE,
  ADD KEY `Escolta` (`empleado_escolta`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accesos`
--
ALTER TABLE `accesos`
  MODIFY `id_acceso` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id_cargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `comandas`
--
ALTER TABLE `comandas`
  MODIFY `Idcomanda` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `combos`
--
ALTER TABLE `combos`
  MODIFY `Idcombo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `paises`
--
ALTER TABLE `paises`
  MODIFY `id_pais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tiposacceso`
--
ALTER TABLE `tiposacceso`
  MODIFY `id_tipo_acceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Idusuario` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `visitas`
--
ALTER TABLE `visitas`
  MODIFY `id_visita` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `accesos`
--
ALTER TABLE `accesos`
  ADD CONSTRAINT `Empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `TipoAcceso` FOREIGN KEY (`id_tipo_acceso`) REFERENCES `tiposacceso` (`id_tipo_acceso`) ON UPDATE CASCADE;

--
-- Constraints for table `cargos`
--
ALTER TABLE `cargos`
  ADD CONSTRAINT `Cargo-Depto` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`) ON UPDATE CASCADE;

--
-- Constraints for table `comandas`
--
ALTER TABLE `comandas`
  ADD CONSTRAINT `comandas_ibfk_1` FOREIGN KEY (`IdCombo`) REFERENCES `combos` (`Idcombo`);

--
-- Constraints for table `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `depto-empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON UPDATE CASCADE;

--
-- Constraints for table `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `Cargo_empleado` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Jefe_empleado` FOREIGN KEY (`id_jefe_empleado`) REFERENCES `empleados` (`id_empleado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Pais_Empleado` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON UPDATE CASCADE;

--
-- Constraints for table `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `EjecutadoPor` FOREIGN KEY (`ejecutado_por`) REFERENCES `empleados` (`id_empleado`) ON UPDATE CASCADE;

--
-- Constraints for table `visitas`
--
ALTER TABLE `visitas`
  ADD CONSTRAINT `Emp_Visitado` FOREIGN KEY (`id_empleado_visitado`) REFERENCES `empleados` (`id_empleado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Escolta` FOREIGN KEY (`empleado_escolta`) REFERENCES `empleados` (`id_empleado`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
