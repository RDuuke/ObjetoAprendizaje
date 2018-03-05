-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.30-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para bancoobjetos
CREATE DATABASE IF NOT EXISTS `bancoobjetos` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `bancoobjetos`;

-- Volcando estructura para tabla bancoobjetos.areas_conocimientos
CREATE TABLE IF NOT EXISTS `areas_conocimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_CODIGO` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.areas_conocimientos: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `areas_conocimientos` DISABLE KEYS */;
REPLACE INTO `areas_conocimientos` (`id`, `codigo`, `name`, `created_at`, `updated_at`) VALUES
	(1, '1', 'AGRONOMIA VETERINARIA Y AFINES.', '2018-02-04 22:07:03', '2018-02-05 04:07:03'),
	(2, '2', 'BELLAS ARTES', '2018-02-12 17:39:26', '2018-02-12 17:39:26');
/*!40000 ALTER TABLE `areas_conocimientos` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.formatos
CREATE TABLE IF NOT EXISTS `formatos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.formatos: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `formatos` DISABLE KEYS */;
REPLACE INTO `formatos` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(3, 'Comprimido (zip, rar, tar.gz)', '2018-02-05 03:31:30', '2018-02-05 03:31:30'),
	(6, 'Imagen (jpg, gif, png)', '2018-02-05 03:33:34', '2018-02-05 03:33:34');
/*!40000 ALTER TABLE `formatos` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.licencias
CREATE TABLE IF NOT EXISTS `licencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE NAME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.licencias: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `licencias` DISABLE KEYS */;
REPLACE INTO `licencias` (`id`, `name`, `updated_at`, `created_at`) VALUES
	(1, 'Licencias GPL (Licencia Pública General Reducida de GNU)', '2018-02-05 01:40:38', '2018-02-05 01:40:38'),
	(3, 'Licencia de Dominio Público', '2018-02-05 01:46:34', '2018-02-05 01:46:34');
/*!40000 ALTER TABLE `licencias` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.nucleo_conocimiento
CREATE TABLE IF NOT EXISTS `nucleo_conocimiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `codigo_area` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE CODIGO` (`codigo`),
  KEY `FK__areas_conocimientos` (`codigo_area`),
  CONSTRAINT `FK__areas_conocimientos` FOREIGN KEY (`codigo_area`) REFERENCES `areas_conocimientos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.nucleo_conocimiento: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `nucleo_conocimiento` DISABLE KEYS */;
REPLACE INTO `nucleo_conocimiento` (`id`, `name`, `codigo`, `codigo_area`, `created_at`, `updated_at`) VALUES
	(1, 'AGRONOMIA', '11', '1', '2018-03-05 12:03:58', '2018-03-05 12:03:58'),
	(2, 'ZOOTECNIA', '12', '1', '2018-02-12 19:36:34', '2018-02-12 19:36:34'),
	(3, 'MUSICA', '28', '2', '2018-02-12 19:37:14', '2018-02-12 19:37:14');
/*!40000 ALTER TABLE `nucleo_conocimiento` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_cabecera
CREATE TABLE IF NOT EXISTS `objetos_cabecera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `tags` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `descargas` int(11) NOT NULL DEFAULT '0',
  `idioma` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cobertura` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estructura` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nivel_agregacion` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pais_proveedor` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_cabecera: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_cabecera` DISABLE KEYS */;
REPLACE INTO `objetos_cabecera` (`id`, `titulo`, `descripcion`, `tags`, `descargas`, `idioma`, `cobertura`, `estructura`, `nivel_agregacion`, `pais_proveedor`, `created_at`, `updated_at`) VALUES
	(6, 'Mapa conceptual: Derechos de autor ', 'Mapa conceptual que muestra una alternativa de licenciamiento de contenidos educativos, para autores que deseen ceder algunos de sus derechos de autor mediante la licencia Creative Commons, con el fin de contribuir a la difusión de conocimiento.', 'derechos de autor, licenciamiento, producción intelectual, Creatice Commons', 0, NULL, NULL, NULL, NULL, NULL, '2018-02-06 00:26:14', '2018-02-06 00:26:14'),
	(7, 'Conceptualización y manipulación en las técnicas de ilustración para docentes que enseñan en institutos infantiles', '  Una multimedia que recopila información y ejercicios sobre diferentes técnicas de ilustración, con el fin de hacer que los métodos de ilustración básicos puedan ser enseñados de manera practica en otros ámbitos como los infantiles.', 'Técnicas de ilustración, enseñanza infantil, ilustración, educación profesoral, teacher education, ilustration, children’s education', 0, NULL, NULL, NULL, NULL, NULL, '2018-02-12 20:46:46', '2018-02-12 20:46:46'),
	(18, 'Ecotecnología', '  Es un documento con algunas generalidades acerca de la Ecotecnología, que se refiere las formas que ha hecho el hombre para mantener un el medio ambiente en concordancia con la tecnología', 'ecotecnologia; sellos verdes; casa ecológicas, alternativas de energía', 0, 'Español', 'cobertura', '', '', '', '2018-02-27 18:03:22', '2018-02-27 18:03:22');
/*!40000 ALTER TABLE `objetos_cabecera` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_ciclo
CREATE TABLE IF NOT EXISTS `objetos_ciclo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `version` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contribuyente` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cambio_registro` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_objeto_ciclo_objeto_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objeto_ciclo_objeto_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_ciclo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_ciclo` DISABLE KEYS */;
REPLACE INTO `objetos_ciclo` (`id`, `codigo_objeto`, `version`, `estado`, `contribuyente`, `cambio_registro`, `created_at`, `updated_at`) VALUES
	(5, 18, '1.0', '', '', '', '2018-02-27 18:03:22', '2018-02-27 18:03:22');
/*!40000 ALTER TABLE `objetos_ciclo` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_derecho
CREATE TABLE IF NOT EXISTS `objetos_derecho` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  `poseedor_derecho_patrimonial` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `descripcion` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_objetos_derecho_objetos_cabecera` (`codigo_objeto`),
  KEY `FK_objetos_derecho_licencias` (`costo`),
  CONSTRAINT `FK_objetos_derecho_licencias` FOREIGN KEY (`costo`) REFERENCES `licencias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_objetos_derecho_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_derecho: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_derecho` DISABLE KEYS */;
REPLACE INTO `objetos_derecho` (`id`, `codigo_objeto`, `costo`, `poseedor_derecho_patrimonial`, `descripcion`, `created_at`, `updated_at`) VALUES
	(4, 18, 1, '', 'Descripcion', '2018-02-27 18:03:22', '2018-02-27 18:03:22'),
	(6, 6, 1, 'No especificado', 'No especificado', '2018-03-05 10:27:28', '2018-03-05 10:27:28'),
	(7, 7, 3, 'No especificado', 'No especificado', '2018-03-05 10:27:38', '2018-03-05 10:27:38');
/*!40000 ALTER TABLE `objetos_derecho` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_educacional
CREATE TABLE IF NOT EXISTS `objetos_educacional` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `tipo_interactividad` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `tipo_recurso` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `nivel_interactividad` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `usuario_final` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `densidad_semantica` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `rangos_edad` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `contexto` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `dificultad` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `tiempo_aprendizaje` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `descripcion` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_objetos_educacional_objetos_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objetos_educacional_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_educacional: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_educacional` DISABLE KEYS */;
REPLACE INTO `objetos_educacional` (`id`, `codigo_objeto`, `tipo_interactividad`, `tipo_recurso`, `nivel_interactividad`, `usuario_final`, `densidad_semantica`, `rangos_edad`, `contexto`, `dificultad`, `tiempo_aprendizaje`, `descripcion`, `created_at`, `updated_at`) VALUES
	(1, 18, 'Combinada', 'simuladores', 'Baja', 'No especificado', '', '', '', 'Baja', '', 'Descripcion', '2018-02-27 18:03:22', '2018-02-27 18:03:22');
/*!40000 ALTER TABLE `objetos_educacional` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_meta
CREATE TABLE IF NOT EXISTS `objetos_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `contribuyente` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `esquema_metadato` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `idioma` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_objeto_meta_objetos_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objeto_meta_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_meta: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_meta` DISABLE KEYS */;
REPLACE INTO `objetos_meta` (`id`, `codigo_objeto`, `contribuyente`, `esquema_metadato`, `idioma`, `created_at`, `updated_at`) VALUES
	(4, 18, 'Universidad', 'No especificado', '', '2018-02-27 18:03:22', '2018-02-27 18:03:22');
/*!40000 ALTER TABLE `objetos_meta` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_relacion
CREATE TABLE IF NOT EXISTS `objetos_relacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `codigo_area` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_objetos_relacion_objetos_cabecera` (`codigo_objeto`),
  KEY `FK_objetos_relacion_nucleo_conocimiento` (`codigo_area`),
  CONSTRAINT `FK_objetos_relacion_nucleo_conocimiento` FOREIGN KEY (`codigo_area`) REFERENCES `nucleo_conocimiento` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_objetos_relacion_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_relacion: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_relacion` DISABLE KEYS */;
REPLACE INTO `objetos_relacion` (`id`, `codigo_objeto`, `codigo_area`, `created_at`, `updated_at`) VALUES
	(1, 18, '28', '2018-02-27 18:03:22', '2018-02-27 18:03:22'),
	(2, 6, '11', '2018-03-02 15:32:38', '2018-03-02 15:32:38'),
	(3, 7, '12', '2018-03-02 15:32:48', '2018-03-02 15:32:48');
/*!40000 ALTER TABLE `objetos_relacion` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_tecnico
CREATE TABLE IF NOT EXISTS `objetos_tecnico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) DEFAULT NULL,
  `formato` int(11) DEFAULT NULL,
  `instrucciones` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `requerimientos` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `tamano` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ubicacion` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `otro_requerimiento` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `duracion` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `miniatura` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `imagenes_previas` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `imagenes_posteriores` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_objeto_tecnico_objeto_cabecera` (`codigo_objeto`),
  KEY `FK_objeto_tecnico_formato` (`formato`),
  CONSTRAINT `FK_objeto_tecnico_formato` FOREIGN KEY (`formato`) REFERENCES `formatos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_objeto_tecnico_objeto_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_tecnico: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_tecnico` DISABLE KEYS */;
REPLACE INTO `objetos_tecnico` (`id`, `codigo_objeto`, `formato`, `instrucciones`, `requerimientos`, `tamano`, `ubicacion`, `otro_requerimiento`, `duracion`, `miniatura`, `imagenes_previas`, `imagenes_posteriores`, `created_at`, `updated_at`) VALUES
	(9, 18, 3, '', 'No especificado', '0 kbytes', '28\\2\\81158b8cc178f22e.zip', '', '', 'http://via.placeholder.com/150x250', 'No especificado', 'No especificado', '2018-02-27 18:03:22', '2018-03-05 11:46:57'),
	(10, 7, 3, 'No especificado', 'No especificado', '', '', 'No especificado', 'No especificado', 'http://via.placeholder.com/150x250', 'No especificado', 'No especificado', '2018-03-05 11:39:47', '2018-03-05 11:47:00'),
	(11, 6, 6, 'No especificado', 'No especificado', '', '', 'No especificado', 'No especificado', 'http://via.placeholder.com/150x250', 'No especificado', 'No especificado', '2018-03-05 11:40:11', '2018-03-05 11:47:03');
/*!40000 ALTER TABLE `objetos_tecnico` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.roles: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
REPLACE INTO `roles` (`id`, `name`) VALUES
	(1, 'Usuario'),
	(2, 'Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `role` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE EMAIL` (`email`),
  KEY `FK_users_roles` (`role`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.users: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
	(5, 'Duque Juan', 'juan.duque@gmail.com', '$2y$10$j/EfROSsk919mwiA5VcqquNPyYBvNzQxTCH/hb/BLqA60jH8YaZQm', 2, '2018-02-12 16:04:31', '2018-02-12 22:04:31'),
	(6, 'Carlos Andres', 'carlos.andres@gmail.com', '$2y$10$mBtjV4mVTDgvdCkwgzNV1ObIBCr//Gp1XMnKptkACIpdZyG8hTxLC', 1, '2018-02-04 16:49:27', '2018-02-04 16:49:27'),
	(12, 'Juan Duque', 'juuanduuke@gmail.com', '$2y$10$qpSThi3Hm5yf9q/JZa3NluXcheVJy4pXtgV9jKah37IzYCbyouSdO', 2, '2018-02-12 16:03:10', '2018-02-12 16:03:10');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
