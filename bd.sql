-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.19-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for bancoobjetos
CREATE DATABASE IF NOT EXISTS `bancoobjetos` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `bancoobjetos`;

-- Dumping structure for table bancoobjetos.areas_conocimientos
CREATE TABLE IF NOT EXISTS `areas_conocimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_CODIGO` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.areas_conocimientos: ~0 rows (approximately)
/*!40000 ALTER TABLE `areas_conocimientos` DISABLE KEYS */;
INSERT INTO `areas_conocimientos` (`id`, `codigo`, `name`, `created_at`, `updated_at`) VALUES
	(1, '1', 'AGRONOMIA VETERINARIA Y AFINES.', '2018-02-04 22:07:03', '2018-02-05 04:07:03');
/*!40000 ALTER TABLE `areas_conocimientos` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.formato
CREATE TABLE IF NOT EXISTS `formato` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.formato: ~2 rows (approximately)
/*!40000 ALTER TABLE `formato` DISABLE KEYS */;
INSERT INTO `formato` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(3, 'Comprimido (zip, rar, tar.gz)', '2018-02-05 03:31:30', '2018-02-05 03:31:30'),
	(6, 'Imagen (jpg, gif, png)', '2018-02-05 03:33:34', '2018-02-05 03:33:34');
/*!40000 ALTER TABLE `formato` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.licencias
CREATE TABLE IF NOT EXISTS `licencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE NAME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.licencias: ~2 rows (approximately)
/*!40000 ALTER TABLE `licencias` DISABLE KEYS */;
INSERT INTO `licencias` (`id`, `name`, `updated_at`, `created_at`) VALUES
	(1, 'Licencias GPL (Licencia Pública General Reducida de GNU)', '2018-02-05 01:40:38', '2018-02-05 01:40:38'),
	(3, 'Licencia de Dominio Público', '2018-02-05 01:46:34', '2018-02-05 01:46:34');
/*!40000 ALTER TABLE `licencias` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.nucleo_conocimiento
CREATE TABLE IF NOT EXISTS `nucleo_conocimiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `codigo_area` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE CODIGO` (`codigo`),
  KEY `FK__areas_conocimientos` (`codigo_area`),
  CONSTRAINT `FK__areas_conocimientos` FOREIGN KEY (`codigo_area`) REFERENCES `areas_conocimientos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.nucleo_conocimiento: ~0 rows (approximately)
/*!40000 ALTER TABLE `nucleo_conocimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `nucleo_conocimiento` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.objetos_cabecera
CREATE TABLE IF NOT EXISTS `objetos_cabecera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `adjunto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `tags` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `licencia` int(11) DEFAULT NULL,
  `descargas` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objeto_cabecera_licencias` (`licencia`),
  CONSTRAINT `FK_objeto_cabecera_licencias` FOREIGN KEY (`licencia`) REFERENCES `licencias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.objetos_cabecera: ~0 rows (approximately)
/*!40000 ALTER TABLE `objetos_cabecera` DISABLE KEYS */;
/*!40000 ALTER TABLE `objetos_cabecera` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.objetos_ciclo
CREATE TABLE IF NOT EXISTS `objetos_ciclo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `autor` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `entidad` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_objeto_ciclo_objeto_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objeto_ciclo_objeto_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.objetos_ciclo: ~0 rows (approximately)
/*!40000 ALTER TABLE `objetos_ciclo` DISABLE KEYS */;
/*!40000 ALTER TABLE `objetos_ciclo` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.objetos_tecnico
CREATE TABLE IF NOT EXISTS `objetos_tecnico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) DEFAULT NULL,
  `formato` int(11) DEFAULT NULL,
  `instrucciones` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `requerimientos` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  PRIMARY KEY (`id`),
  KEY `FK_objeto_tecnico_objeto_cabecera` (`codigo_objeto`),
  KEY `FK_objeto_tecnico_formato` (`formato`),
  CONSTRAINT `FK_objeto_tecnico_formato` FOREIGN KEY (`formato`) REFERENCES `formato` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_objeto_tecnico_objeto_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.objetos_tecnico: ~0 rows (approximately)
/*!40000 ALTER TABLE `objetos_tecnico` DISABLE KEYS */;
/*!40000 ALTER TABLE `objetos_tecnico` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.roles: ~2 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`) VALUES
	(1, 'Usuario'),
	(2, 'Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table bancoobjetos.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE EMAIL` (`email`),
  KEY `FK_users_roles` (`role`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table bancoobjetos.users: ~5 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`, `role`) VALUES
	(4, 'Juan Duque', 'juuanduuke@gmail.com', '$2y$10$Dun4HcUnYMLz2zZtY3MYPOZWlBhloedjMqaYzcS2h8bdO6Up8joZe', '2018-02-04 22:13:06', '2018-02-04 22:13:06', 2),
	(5, 'Duque Juan', 'juan.duque@gmail.com', '$2y$10$j/EfROSsk919mwiA5VcqquNPyYBvNzQxTCH/hb/BLqA60jH8YaZQm', '2018-02-04 16:49:27', '2018-02-04 16:49:27', 1),
	(6, 'Carlos Andres', 'carlos.andres@gmail.com', '$2y$10$mBtjV4mVTDgvdCkwgzNV1ObIBCr//Gp1XMnKptkACIpdZyG8hTxLC', '2018-02-04 16:49:27', '2018-02-04 16:49:27', 1),
	(7, 'Estefania Duque', 'estefania.duque@gmail.com', '$2y$10$cprz7MBOYuaQybGnt1TvferO.U/xrP0ZWAuI14MwiuYdJ34H0n8Vu', '2018-02-04 16:49:29', '2018-02-04 16:49:29', 1),
	(8, 'Pedro Duque', 'pedro.duque@gmail.com', '$2y$10$YId7UXi6hCbwN9ThTBVLDexiyoP0Uezn/4VqCz11F5fpKVw3YnmCK', '2018-02-04 16:49:31', '2018-02-04 16:49:31', 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
