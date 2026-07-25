-- ============================================================
-- BASE DE DATOS `rincon_libro_db` PARA POSTGRESQL (RENDER)
-- ============================================================

-- 1. TABLA `libros`
CREATE TABLE IF NOT EXISTS libros (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  autor VARCHAR(150) NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  genero VARCHAR(50) NOT NULL,
  imagen VARCHAR(255) DEFAULT NULL,
  emoji VARCHAR(10) DEFAULT '❓',
  descontinuado INT NOT NULL DEFAULT 0,
  fecha_creado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO libros (id, titulo, autor, precio, genero, imagen, emoji, descontinuado, fecha_creado) VALUES
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

SELECT setval('libros_id_seq', (SELECT MAX(id) FROM libros));

-- 2. TABLA `usuarios`
CREATE TABLE IF NOT EXISTS usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  rol VARCHAR(20) NOT NULL DEFAULT 'cliente',
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (id, nombre, email, password_hash, rol, fecha_registro) VALUES
(1, 'fernando', 'jpadillanoguez@gmail.com', '$2y$10$MQDhYHIEqI5vBosNIxOae.bYPGZp4hMLkHrTcgy36.yZtHDE9MZ.O', 'admin', '2026-07-23 00:26:56'),
(2, 'fer', 'ferpigpadilla@gmail.com', '$2y$10$pDOH6ft2CZZA9z64eprx9OuyNg.PHdiyJBWBQt8wBiKh3Z7z28pPO', 'cliente', '2026-07-23 01:56:29');

SELECT setval('usuarios_id_seq', (SELECT MAX(id) FROM usuarios));

-- 3. TABLA `pedidos`
CREATE TABLE IF NOT EXISTS pedidos (
  id SERIAL PRIMARY KEY,
  usuario_id INT NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  subtotal NUMERIC(10,2) NOT NULL,
  envio NUMERIC(10,2) NOT NULL,
  total NUMERIC(10,2) NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO pedidos (id, usuario_id, subtotal, envio, total, fecha) VALUES
(2, 1, 480.00, 0.00, 480.00, '2026-07-24 09:14:22'),
(3, 1, 1000.00, 0.00, 1000.00, '2026-07-24 09:17:40'),
(4, 1, 1390.00, 0.00, 1390.00, '2026-07-24 13:17:02');

SELECT setval('pedidos_id_seq', (SELECT MAX(id) FROM pedidos));

-- 4. TABLA `pedido_detalle`
CREATE TABLE IF NOT EXISTS pedido_detalle (
  id SERIAL PRIMARY KEY,
  pedido_id INT NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
  libro_id INT NOT NULL REFERENCES libros(id),
  titulo VARCHAR(200) NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  cantidad INT NOT NULL
);

INSERT INTO pedido_detalle (id, pedido_id, libro_id, titulo, precio, cantidad) VALUES
(5, 2, 9, 'Dune', 480.00, 1),
(6, 3, 10, 'Harry Potter', 520.00, 1),
(7, 3, 9, 'Dune', 480.00, 1),
(8, 4, 10, 'Harry Potter', 520.00, 1),
(9, 4, 9, 'Dune', 480.00, 1),
(10, 4, 11, 'El amor en los tiempos del cólera', 390.00, 1);

SELECT setval('pedido_detalle_id_seq', (SELECT MAX(id) FROM pedido_detalle));
