-- Script de migración para MySQL - DPattyModa
-- Creación del esquema completo de la base de datos

-- Configuración inicial
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS `dpatty_moda` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `dpatty_moda`;

-- Tabla de roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `nombre_rol` VARCHAR(50) NOT NULL UNIQUE,
  `descripcion` TEXT,
  `permisos` JSON,
  `activo` BOOLEAN DEFAULT TRUE,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20),
  `dni` VARCHAR(20) UNIQUE,
  `ruc` VARCHAR(20) UNIQUE,
  `direccion` TEXT,
  `fecha_nacimiento` DATE,
  `genero` VARCHAR(20),
  `rol_id` CHAR(36),
  `activo` BOOLEAN DEFAULT TRUE,
  `ultimo_acceso` TIMESTAMP NULL,
  `intentos_fallidos` INT DEFAULT 0,
  `bloqueado_hasta` TIMESTAMP NULL,
  `token_verificacion` VARCHAR(255),
  `email_verificado` BOOLEAN DEFAULT FALSE,
  `token_recuperacion` VARCHAR(255),
  `fecha_token_recuperacion` TIMESTAMP NULL,
  `preferencias` JSON,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`rol_id`) REFERENCES `roles`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de sucursales
CREATE TABLE IF NOT EXISTS `sucursales` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `nombre_sucursal` VARCHAR(100) NOT NULL,
  `direccion` TEXT NOT NULL,
  `telefono` VARCHAR(20),
  `email` VARCHAR(100),
  `horario_atencion` JSON,
  `coordenadas_gps` VARCHAR(255),
  `activa` BOOLEAN DEFAULT TRUE,
  `es_principal` BOOLEAN DEFAULT FALSE,
  `configuracion` JSON,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de categorías
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `nombre_categoria` VARCHAR(100) NOT NULL,
  `descripcion` TEXT,
  `categoria_padre_id` CHAR(36),
  `nivel` INT DEFAULT 1,
  `orden_visualizacion` INT DEFAULT 0,
  `imagen_url` VARCHAR(500),
  `activa` BOOLEAN DEFAULT TRUE,
  `seo_titulo` VARCHAR(200),
  `seo_descripcion` TEXT,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`categoria_padre_id`) REFERENCES `categorias`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `codigo_producto` VARCHAR(50) NOT NULL UNIQUE,
  `nombre_producto` VARCHAR(200) NOT NULL,
  `descripcion` TEXT,
  `descripcion_corta` VARCHAR(500),
  `categoria_id` CHAR(36),
  `marca` VARCHAR(100),
  `precio_base` DECIMAL(10,2) NOT NULL,
  `precio_oferta` DECIMAL(10,2),
  `costo_producto` DECIMAL(10,2),
  `margen_ganancia` DECIMAL(5,2),
  `peso` DECIMAL(8,3),
  `dimensiones` JSON,
  `caracteristicas` JSON,
  `imagenes` JSON,
  `tags` JSON,
  `activo` BOOLEAN DEFAULT TRUE,
  `destacado` BOOLEAN DEFAULT FALSE,
  `nuevo` BOOLEAN DEFAULT FALSE,
  `fecha_lanzamiento` DATE,
  `calificacion_promedio` DECIMAL(3,2) DEFAULT 0.00,
  `total_reseñas` INT DEFAULT 0,
  `total_ventas` INT DEFAULT 0,
  `seo_titulo` VARCHAR(200),
  `seo_descripcion` TEXT,
  `seo_palabras_clave` JSON,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`categoria_id`) REFERENCES `categorias`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de variantes de productos
CREATE TABLE IF NOT EXISTS `variantes_producto` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `producto_id` CHAR(36) NOT NULL,
  `sku` VARCHAR(100) NOT NULL UNIQUE,
  `talla` VARCHAR(20),
  `color` VARCHAR(50),
  `material` VARCHAR(100),
  `precio_variante` DECIMAL(10,2),
  `peso_variante` DECIMAL(8,3),
  `imagen_variante` VARCHAR(500),
  `codigo_barras` VARCHAR(100),
  `activo` BOOLEAN DEFAULT TRUE,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de inventario
CREATE TABLE IF NOT EXISTS `inventario` (
  `id` CHAR(36) NOT NULL PRIMARY KEY,
  `variante_id` CHAR(36) NOT NULL,
  `sucursal_id` CHAR(36) NOT NULL,
  `cantidad_disponible` INT DEFAULT 0,
  `cantidad_reservada` INT DEFAULT 0,
  `cantidad_minima` INT DEFAULT 5,
  `cantidad_maxima` INT DEFAULT 1000,
  `ubicacion_fisica` VARCHAR(100),
  `ultimo_movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultimo_ingreso` TIMESTAMP NULL,
  `fecha_ultimo_egreso` TIMESTAMP NULL,
  `costo_promedio` DECIMAL(10,2),
  `fecha_actualizacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`variante_id`) REFERENCES `variantes_producto`(`id`),
  FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales`(`id`),
  UNIQUE KEY `unique_variante_sucursal` (`variante_id`, `sucursal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar datos iniciales
INSERT IGNORE INTO `roles` (`id`, `nombre_rol`, `descripcion`) VALUES
(UUID(), 'Administrador', 'Acceso completo al sistema'),
(UUID(), 'Empleado', 'Gestión de productos e inventario'),
(UUID(), 'Cajero', 'Operaciones de punto de venta'),
(UUID(), 'Cliente', 'Compras en línea');

-- Insertar sucursal principal
INSERT IGNORE INTO `sucursales` (`id`, `nombre_sucursal`, `direccion`, `activa`, `es_principal`) VALUES
(UUID(), 'Sucursal Principal', 'Pampa Hermosa, Loreto, Perú', TRUE, TRUE);

-- Insertar categorías principales
INSERT IGNORE INTO `categorias` (`id`, `nombre_categoria`, `descripcion`, `activa`) VALUES
(UUID(), 'Ropa Femenina', 'Prendas de vestir para mujeres', TRUE),
(UUID(), 'Ropa Masculina', 'Prendas de vestir para hombres', TRUE),
(UUID(), 'Accesorios', 'Complementos y accesorios', TRUE),
(UUID(), 'Calzado', 'Zapatos y calzado en general', TRUE);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;