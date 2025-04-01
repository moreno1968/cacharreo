-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-04-2025 a las 03:32:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `la4ta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `coste` float NOT NULL DEFAULT 0,
  `precio` float NOT NULL DEFAULT 0,
  `descuento` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `coste`, `precio`, `descuento`) VALUES
(1, 'productos A', 5000, 5000, 0.00),
(2, 'productos B', 2, 8000, 0.00),
(3, 'productos C', 40, 8, 0.00),
(4, 'productos X', 4, 5, 0.00),
(5, 'productos z', 1, 3, 0.00),
(6, 'productos r', 9, 1, 0.00),
(7, 'productos k', 5, 7, 0.00),
(8, 'producto b', 400, 30000, 1500.00);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `aplicar_descuento` BEFORE INSERT ON `productos` FOR EACH ROW BEGIN
    DECLARE descuento DECIMAL(5,2);
 
    IF NEW.precio <= 7000 THEN
        SET descuento = 0.10; 
    ELSEIF NEW.precio <= 12000 THEN  
        SET descuento = 0.15;
    ELSEIF NEW.precio <= 25000 THEN  
        SET descuento = 0.50;  
    ELSE
        SET descuento = 0.00; 
    END IF;
   
    SET NEW.precio = NEW.precio - (NEW.precio * descuento);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `aplicar_descuento_producto` BEFORE INSERT ON `productos` FOR EACH ROW BEGIN
    -- Inicializar el descuento con 5%
    SET NEW.descuento = ROUND(NEW.precio * 0.05, 2);

    -- Aplicar las condiciones de descuento según el precio
    IF NEW.precio <= 7000 THEN
        SET NEW.descuento = ROUND(NEW.precio * 0.10, 2);
    ELSEIF NEW.precio <= 12000 THEN
        SET NEW.descuento = ROUND(NEW.precio * 0.15, 2);
    ELSEIF NEW.precio <= 25000 THEN
        SET NEW.descuento = ROUND(NEW.precio * 0.50, 2);
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
