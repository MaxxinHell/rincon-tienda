-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-07-2026 a las 02:24:22
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
-- Base de datos: `rincon_libro_db`
--

CREATE DATABASE IF NOT EXISTS `rincon_libro_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `rincon_libro_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `autor` varchar(150) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `genero` varchar(50) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `emoji` varchar(10) DEFAULT '?',
  `descontinuado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_creado` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id`, `titulo`, `autor`, `precio`, `genero`, `imagen`, `emoji`, `descontinuado`, `fecha_creado`) VALUES
(1, 'Cien años de soledad', 'Gabriel García Márquez', 370.00, 'amor', 'imagenes/libro1.jpg', '💕', 0, '2026-07-23 00:18:18'),
(2, 'It', 'Stephen King', 460.00, 'miedo', 'imagenes/libro2.jpg', '👻', 0, '2026-07-23 00:18:18'),
(3, 'El código Da Vinci', 'Dan Brown', 425.00, 'misterio', 'imagenes/libro3.jpg', '🔍', 0, '2026-07-23 00:18:18'),
(4, '1984', 'George Orwell', 350.00, 'ciencia-ficcion', 'imagenes/libro4.jpg', '🚀', 0, '2026-07-23 00:18:18'),
(5, 'El Señor de los Anillos', 'J.R.R. Tolkien', 555.00, 'fantasia', 'imagenes/libro5.jpg', '🐉', 0, '2026-07-23 00:18:18'),
(6, 'Orgullo y prejuicio', 'Jane Austen', 315.00, 'amor', 'imagenes/libro6.jpg', '💕', 0, '2026-07-23 00:18:18'),
(7, 'El resplandor', 'Stephen King', 405.00, 'miedo', 'imagenes/libro7.jpg', '👻', 0, '2026-07-23 00:18:18'),
(8, 'Sherlock Holmes', 'Arthur Conan Doyle', 370.00, 'misterio', 'imagenes/libro8.jpg', '🔍', 0, '2026-07-23 00:18:18'),
(9, 'Dune', 'Frank Herbert', 480.00, 'ciencia-ficcion', 'imagenes/libro9.jpg', '🚀', 0, '2026-07-23 00:18:18'),
(10, 'Harry Potter', 'J.K. Rowling', 520.00, 'fantasia', 'imagenes/libro10.jpg', '🐉', 0, '2026-07-23 00:18:18'),
(11, 'El amor en los tiempos del cólera', 'Gabriel García Márquez', 390.00, 'amor', 'imagenes/libro11.jpg', '💕', 0, '2026-07-23 00:18:18'),
(12, 'Drácula', 'Bram Stoker', 450.00, 'miedo', 'imagenes/libro12.jpg', '👻', 0, '2026-07-23 00:18:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `envio` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `usuario_id`, `subtotal`, `envio`, `total`, `fecha`) VALUES
(2, 1, 480.00, 0.00, 480.00, '2026-07-24 09:14:22'),
(3, 1, 1000.00, 0.00, 1000.00, '2026-07-24 09:17:40'),
(4, 1, 1390.00, 0.00, 1390.00, '2026-07-24 13:17:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_detalle`
--

CREATE TABLE `pedido_detalle` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `libro_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido_detalle`
--

INSERT INTO `pedido_detalle` (`id`, `pedido_id`, `libro_id`, `titulo`, `precio`, `cantidad`) VALUES
(5, 2, 9, 'Dune', 480.00, 1),
(6, 3, 10, 'Harry Potter', 520.00, 1),
(7, 3, 9, 'Dune', 480.00, 1),
(8, 4, 10, 'Harry Potter', 520.00, 1),
(9, 4, 9, 'Dune', 480.00, 1),
(10, 4, 11, 'El amor en los tiempos del cólera', 390.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('cliente','admin') NOT NULL DEFAULT 'cliente',
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password_hash`, `rol`, `fecha_registro`) VALUES
(1, 'fernando', 'jpadillanoguez@gmail.com', '$2y$10$MQDhYHIEqI5vBosNIxOae.bYPGZp4hMLkHrTcgy36.yZtHDE9MZ.O', 'admin', '2026-07-23 00:26:56'),
(2, 'fer', 'ferpigpadilla@gmail.com', '$2y$10$pDOH6ft2CZZA9z64eprx9OuyNg.PHdiyJBWBQt8wBiKh3Z7z28pPO', 'cliente', '2026-07-23 01:56:29');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `libro_id` (`libro_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD CONSTRAINT `pedido_detalle_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pedido_detalle_ibfk_2` FOREIGN KEY (`libro_id`) REFERENCES `libros` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
