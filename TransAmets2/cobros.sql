-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.0.67-community-nt - MySQL Community Edition (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             8.1.0.4545
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla amets.cobros
DROP TABLE IF EXISTS `cobros`;
CREATE TABLE IF NOT EXISTS `cobros` (
  `AUTOCOBRO` int(11) NOT NULL auto_increment,
  `AUTOFAC` int(11) default NULL,
  `NUFACTURA_COB` varchar(15) collate utf8_spanish_ci default NULL,
  `IMPORTE_COBRO` double default NULL,
  `FECHA_COBRO` datetime default NULL,
  PRIMARY KEY  (`AUTOCOBRO`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla amets.cobros: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `cobros` DISABLE KEYS */;
INSERT INTO `cobros` (`AUTOCOBRO`, `AUTOFAC`, `NUFACTURA_COB`, `IMPORTE_COBRO`, `FECHA_COBRO`) VALUES
	(9, 1426, '32/2010', 180, '2011-08-05 00:00:00'),
	(10, 3515, '2/2018', 6500, '2018-02-23 16:25:57'),
	(11, 3515, '2/2018', 2000, '2018-03-23 16:26:19'),
	(12, 3515, '2/2018', 500, '2018-04-01 09:24:23'),
	(13, 3515, '2/2018', 400, '2018-04-15 13:27:29'),
	(14, 2824, '187/2014', 193.6, '2016-12-31 00:00:00');
/*!40000 ALTER TABLE `cobros` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
