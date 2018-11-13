-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-10-2018 a las 02:57:36
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ns100213_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comandas`
--

CREATE TABLE `comandas` (
  `Idcomanda` bigint(20) NOT NULL,
  `IdCombo` bigint(20) NOT NULL,
  `descripcion` text NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` char(1) NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaDespacho` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `comandas`
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
-- Estructura de tabla para la tabla `combos`
--

CREATE TABLE `combos` (
  `Idcombo` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` char(1) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `combos`
--

INSERT INTO `combos` (`Idcombo`, `nombre`, `descripcion`, `estado`, `precio`, `imagen`) VALUES
(1, 'WINGS y FRIES ', ' perfecto para el\r\nalmuerzo, pero genial\r\ncualquier momento.', 'A', '10.00', 'Imagen1.png\r\n'),
(2, 'Dona con refil de cafe', 'Combinacion perfecta', 'A', '15.00', 'Imagen1.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Idusuario` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Idusuario`, `nombre`, `usuario`, `clave`, `estado`) VALUES
(1, 'Administrador', 'Administrador', 'admin', 'A'),
(2, 'Cliente', 'Cliente', 'demo', 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comandas`
--
ALTER TABLE `comandas`
  ADD PRIMARY KEY (`Idcomanda`),
  ADD KEY `IdCombo` (`IdCombo`);

--
-- Indices de la tabla `combos`
--
ALTER TABLE `combos`
  ADD PRIMARY KEY (`Idcombo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Idusuario`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comandas`
--
ALTER TABLE `comandas`
  MODIFY `Idcomanda` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `combos`
--
ALTER TABLE `combos`
  MODIFY `Idcombo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Idusuario` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comandas`
--
ALTER TABLE `comandas`
  ADD CONSTRAINT `comandas_ibfk_1` FOREIGN KEY (`IdCombo`) REFERENCES `combos` (`Idcombo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
