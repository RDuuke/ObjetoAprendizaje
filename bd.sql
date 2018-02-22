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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_CODIGO` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.areas_conocimientos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `areas_conocimientos` DISABLE KEYS */;
REPLACE INTO `areas_conocimientos` (`id`, `codigo`, `name`, `created_at`, `updated_at`) VALUES
	(1, '1', 'AGRONOMIA VETERINARIA Y AFINES.', '2018-02-04 22:07:03', '2018-02-05 04:07:03'),
	(2, '2', 'BELLAS ARTES', '2018-02-12 17:39:26', '2018-02-12 17:39:26');
/*!40000 ALTER TABLE `areas_conocimientos` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.formatos
CREATE TABLE IF NOT EXISTS `formatos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
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
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE CODIGO` (`codigo`),
  KEY `FK__areas_conocimientos` (`codigo_area`),
  CONSTRAINT `FK__areas_conocimientos` FOREIGN KEY (`codigo_area`) REFERENCES `areas_conocimientos` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.nucleo_conocimiento: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `nucleo_conocimiento` DISABLE KEYS */;
REPLACE INTO `nucleo_conocimiento` (`id`, `name`, `codigo`, `codigo_area`, `created_at`, `updated_at`) VALUES
	(1, 'AGRONOMIA.', '11', '1', '2018-02-05 13:49:18', '2018-02-05 19:49:18'),
	(2, 'ZOOTECNIA', '12', '1', '2018-02-12 19:36:34', '2018-02-12 19:36:34'),
	(3, 'MUSICA', '28', '2', '2018-02-12 19:37:14', '2018-02-12 19:37:14');
/*!40000 ALTER TABLE `nucleo_conocimiento` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_cabecera
CREATE TABLE IF NOT EXISTS `objetos_cabecera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `adjunto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `tags` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `licencia` int(11) DEFAULT NULL,
  `descargas` int(11) NOT NULL DEFAULT '0',
  `idioma` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cobertura` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estructura` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nivel_agregacion` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pais_proveedor` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objeto_cabecera_licencias` (`licencia`),
  CONSTRAINT `FK_objeto_cabecera_licencias` FOREIGN KEY (`licencia`) REFERENCES `licencias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_cabecera: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_cabecera` DISABLE KEYS */;
REPLACE INTO `objetos_cabecera` (`id`, `titulo`, `adjunto`, `descripcion`, `tags`, `licencia`, `descargas`, `idioma`, `cobertura`, `estructura`, `nivel_agregacion`, `pais_proveedor`, `created_at`, `updated_at`) VALUES
	(6, 'Mapa conceptual: Derechos de autor ', '11\\1\\d1323ede3f56211c.jpg', 'Mapa conceptual que muestra una alternativa de licenciamiento de contenidos educativos, para autores que deseen ceder algunos de sus derechos de autor mediante la licencia Creative Commons, con el fin de contribuir a la difusión de conocimiento.', 'derechos de autor, licenciamiento, producción intelectual, Creatice Commons', 3, 0, NULL, NULL, NULL, NULL, NULL, '2018-02-06 00:26:14', '2018-02-06 00:26:14'),
	(7, 'Conceptualización y manipulación en las técnicas de ilustración para docentes que enseñan en institutos infantiles', '28\\2\\54d97dffda882ccc.jpg', '  Una multimedia que recopila información y ejercicios sobre diferentes técnicas de ilustración, con el fin de hacer que los métodos de ilustración básicos puedan ser enseñados de manera practica en otros ámbitos como los infantiles.', 'Técnicas de ilustración, enseñanza infantil, ilustración, educación profesoral, teacher education, ilustration, children’s education', 1, 0, NULL, NULL, NULL, NULL, NULL, '2018-02-12 20:46:46', '2018-02-12 20:46:46'),
	(11, 'Como ser Emprendedor', '', ' El objeto brindar a los estudiantes una visión general de los que es ser emprendedor, contiene las características de un emprendedor y como seleccionar una idea de negocios.', 'Emprendedor, características del emprendedor, selección de idea de negocios', 1, 0, 'Español', 'Cobertura', 'Estructura', 'Nivel de agregación', 'País proveedor', '2018-02-22 15:04:34', '2018-02-22 15:04:34');
/*!40000 ALTER TABLE `objetos_cabecera` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_ciclo
CREATE TABLE IF NOT EXISTS `objetos_ciclo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `version` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contribuyente` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cambio_registro` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objeto_ciclo_objeto_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objeto_ciclo_objeto_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_ciclo: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_ciclo` DISABLE KEYS */;
REPLACE INTO `objetos_ciclo` (`id`, `codigo_objeto`, `version`, `estado`, `contribuyente`, `cambio_registro`, `created_at`, `updated_at`) VALUES
	(5, 11, '1.0', 'Estado', 'Hernández García, Neyla Ramírez Ballesteros Luz Pi', 'Cambio Registro', '2018-02-22 20:53:13', '2018-02-22 20:53:13');
/*!40000 ALTER TABLE `objetos_ciclo` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_derecho
CREATE TABLE IF NOT EXISTS `objetos_derecho` (
  `id` int(11) NOT NULL,
  `codigo_objeto` int(11) NOT NULL,
  `costo` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `poseedor_derecho_patrimonial` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `descripcion` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'No especificado',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objetos_derecho_objetos_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objetos_derecho_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_derecho: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_derecho` DISABLE KEYS */;
REPLACE INTO `objetos_derecho` (`id`, `codigo_objeto`, `costo`, `poseedor_derecho_patrimonial`, `descripcion`, `created_at`, `updated_at`) VALUES
	(0, 11, 'Libre', 'Universidad TAL', 'Esta obra es publicada bajo la licencia Creative C', '2018-02-22 20:53:13', '2018-02-22 20:53:13');
/*!40000 ALTER TABLE `objetos_derecho` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_educacional
CREATE TABLE IF NOT EXISTS `objetos_educacional` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objetos_educacional_objetos_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objetos_educacional_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_educacional: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_educacional` DISABLE KEYS */;
REPLACE INTO `objetos_educacional` (`id`, `codigo_objeto`, `tipo_interactividad`, `tipo_recurso`, `nivel_interactividad`, `usuario_final`, `densidad_semantica`, `rangos_edad`, `contexto`, `dificultad`, `tiempo_aprendizaje`, `descripcion`, `created_at`, `updated_at`) VALUES
	(0, 11, 'Combinado', 'Auto evaluación Cuestionario Texto narrativo', 'Nivel de interactividad', 'No especificado', 'Densidad semántica', '10-20', 'Educación Superior', 'Bajo', '20horas', 'No especificado', '2018-02-22 20:53:13', '2018-02-22 20:53:13');
/*!40000 ALTER TABLE `objetos_educacional` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_meta
CREATE TABLE IF NOT EXISTS `objetos_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `contribuyente` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `esquema_metadato` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `idioma` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No especificado',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objeto_meta_objetos_cabecera` (`codigo_objeto`),
  CONSTRAINT `FK_objeto_meta_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_meta: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_meta` DISABLE KEYS */;
REPLACE INTO `objetos_meta` (`id`, `codigo_objeto`, `contribuyente`, `esquema_metadato`, `idioma`, `created_at`, `updated_at`) VALUES
	(1, 11, 'No especificado', 'Esquema de metadato', 'Idioma', '2018-02-22 20:53:13', '2018-02-22 20:53:13');
/*!40000 ALTER TABLE `objetos_meta` ENABLE KEYS */;

-- Volcando estructura para tabla bancoobjetos.objetos_relacion
CREATE TABLE IF NOT EXISTS `objetos_relacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_objeto` int(11) NOT NULL,
  `codigo` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objetos_relacion_objetos_cabecera` (`codigo_objeto`),
  KEY `FK_objetos_relacion_nucleo_conocimiento` (`codigo`),
  CONSTRAINT `FK_objetos_relacion_nucleo_conocimiento` FOREIGN KEY (`codigo`) REFERENCES `nucleo_conocimiento` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_objetos_relacion_objetos_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_relacion: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_relacion` DISABLE KEYS */;
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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_objeto_tecnico_objeto_cabecera` (`codigo_objeto`),
  KEY `FK_objeto_tecnico_formato` (`formato`),
  CONSTRAINT `FK_objeto_tecnico_formato` FOREIGN KEY (`formato`) REFERENCES `formatos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_objeto_tecnico_objeto_cabecera` FOREIGN KEY (`codigo_objeto`) REFERENCES `objetos_cabecera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.objetos_tecnico: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `objetos_tecnico` DISABLE KEYS */;
REPLACE INTO `objetos_tecnico` (`id`, `codigo_objeto`, `formato`, `instrucciones`, `requerimientos`, `tamano`, `ubicacion`, `otro_requerimiento`, `duracion`, `miniatura`, `imagenes_previas`, `imagenes_posteriores`, `created_at`, `updated_at`) VALUES
	(5, 11, 6, 'Paso 1: Descargue el archivo comprimido " Como-se-emprendedor.zip" y guárdelo en su PC.  Paso 2: descomprima el paquete .zip en su disco duro  Paso 3: explore el directorio resultante del paso anterior, ubique y ejecute el archivo "index.html"  paso ', 'No especificado', '24kb', 'src://carpeta/objeto.zip', 'Otros requerimientos', 'Duracion', 'src/miniatura.jpg', 'No especificado', 'No especificado', '2018-02-22 20:53:13', '2018-02-22 20:53:13');
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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE EMAIL` (`email`),
  KEY `FK_users_roles` (`role`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla bancoobjetos.users: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`, `role`) VALUES
	(5, 'Duque Juan', 'juan.duque@gmail.com', '$2y$10$j/EfROSsk919mwiA5VcqquNPyYBvNzQxTCH/hb/BLqA60jH8YaZQm', '2018-02-12 16:04:31', '2018-02-12 22:04:31', 2),
	(6, 'Carlos Andres', 'carlos.andres@gmail.com', '$2y$10$mBtjV4mVTDgvdCkwgzNV1ObIBCr//Gp1XMnKptkACIpdZyG8hTxLC', '2018-02-04 16:49:27', '2018-02-04 16:49:27', 1),
	(12, 'Juan Duque', 'juuanduuke@gmail.com', '$2y$10$qpSThi3Hm5yf9q/JZa3NluXcheVJy4pXtgV9jKah37IzYCbyouSdO', '2018-02-12 16:03:10', '2018-02-12 16:03:10', 2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
