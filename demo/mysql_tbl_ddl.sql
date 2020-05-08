-- --------------------------------------------------------
-- Host:                         ntcoahuila-db.mysql.database.azure.com
-- Server version:               5.7.27-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for mysql_ntcoahuila_db
CREATE DATABASE IF NOT EXISTS `mysql_ntcoahuila_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mysql_ntcoahuila_db`;

-- Dumping structure for table mysql_ntcoahuila_db.ntcoahulia_hospital
CREATE TABLE IF NOT EXISTS `ntcoahulia_hospital` (
  `hid` bigint(20) NOT NULL AUTO_INCREMENT,
  `hname` varchar(250) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `hcity` varchar(250) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `hstreet1` varchar(250) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `hstreet2` varchar(250) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `hnumber` varchar(250) DEFAULT NULL,
  `hpostalcode` varchar(250) DEFAULT NULL,
  `hmaintelephone` varchar(250) DEFAULT NULL,
  `hCOVIDflg` varchar(250) DEFAULT NULL,
  `hlatitude` varchar(250) DEFAULT NULL,
  `hlongitude` varchar(250) DEFAULT NULL,
  `havaliablebeds` int(10) DEFAULT NULL,
  `hoccupiedbeds` int(10) DEFAULT NULL,
  KEY `Index 1` (`hid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Dumping data for table mysql_ntcoahuila_db.ntcoahulia_hospital: ~25 rows (approximately)
/*!40000 ALTER TABLE `ntcoahulia_hospital` DISABLE KEYS */;
INSERT INTO `ntcoahulia_hospital` (`hid`, `hname`, `hcity`, `hstreet1`, `hstreet2`, `hnumber`, `hpostalcode`, `hmaintelephone`, `hCOVIDflg`, `hlatitude`, `hlongitude`, `havaliablebeds`, `hoccupiedbeds`) VALUES
	(1, 'Hospital General de Allende', 'Allende', 'Dr. Eduardo W. Benavides', '', '402 Pte.', '26530', NULL, 'Yes', NULL, NULL, NULL, NULL),
	(2, 'Rural 01 Nucleos Basicos de Guerrero', 'Guerrero', 'Raul Lopez Sanches y Corregidora', 'Ejido San Vicente', 'S/N', '26640', NULL, 'No', NULL, NULL, NULL, NULL),
	(3, 'Rural de 01 Núcleo Básico Hidalgo', 'Hidalgo', 'Porfirio Diaz y Morelos', 'Ejido Hidalgo', 'S/N', '26670', NULL, 'No', NULL, NULL, NULL, NULL),
	(4, 'Rural 05 Nucleo Basico de ej. Nava', 'Nava', 'Emilio Carranza y Aldama', 'Ejido Nava', '190', '26170', NULL, 'No', NULL, NULL, NULL, NULL),
	(5, 'Unidad Móvil de Nava', 'Nava', 'Emilio Carranza y Aldama', 'Ejido Nava', '190', '26170', NULL, 'No', NULL, NULL, NULL, NULL),
	(6, 'Hospital Especialidades Salvador Chavarria S', 'Piedras Negras', 'Avenida Centenario', 'Nueva Creación', '901', '26010', NULL, 'Yes', NULL, NULL, NULL, NULL),
	(7, 'Urbano de 01 Núcleo Básico Col. Mundo Nuevo', 'Piedras Negras', 'Xicotencatl', 'Centro', '918 Nte.', '26000', NULL, 'No', NULL, NULL, NULL, NULL),
	(8, 'Urbano de 01 Núcleo Básico Col. Buenos Aires', 'Piedras Negras', 'Privada 20 de Noviembre', 'Buenos Aires', '110', '26030', NULL, 'No', NULL, NULL, NULL, NULL),
	(9, 'Urbano de 01 Núcleo Básico Col. Lazaro', 'Piedras Negras', 'Avenida Miguel Garza', 'Lazaro Cardenas', '2607', '26030', NULL, 'No', NULL, NULL, NULL, NULL),
	(10, 'Rural de 01 Núcleo Básico Ej. Piedras Negras', 'Piedras Negras', 'Avenida Revolución esquina Dr. Loth', 'Ejido Piedras Negras', '908', '26069', NULL, 'No', NULL, NULL, NULL, NULL),
	(11, 'Rural de 01 Núcleo Básico Villa de Fuente', 'Piedras Negras', 'Coahuila esquina Bertha B. de Peña', 'Villa de Fuente', 'S/N', '26090', NULL, 'No', NULL, NULL, NULL, NULL),
	(12, 'Centro Si Mujer', 'Piedras Negras', 'Colon', 'Centro', '203 Altos', '26000', NULL, 'No', NULL, NULL, NULL, NULL),
	(13, 'Unidad Médica de Oportunidades', 'Piedras Negras', 'Xicotencatl', 'Centro', '918', '26000', NULL, 'No', NULL, NULL, NULL, NULL),
	(14, 'UNEME Capasits Piedras Negras', 'Piedras Negras', 'Avenida Miguel Garza', 'Lazaro Cardenas', 'S/N', '26017', NULL, 'No', NULL, NULL, NULL, NULL),
	(15, 'UNEME Nueva Vida Piedras Negras', 'Piedras Negras', 'Avenida Miguel Garza', 'Lazaro Cardenas', '2701', '26017', NULL, 'No', NULL, NULL, NULL, NULL),
	(16, 'Unidad Móvil del Ejido Piedras Negras', 'Piedras Negras', 'Avenida Revolución esquina Dr. Loth', 'Lazaro Cardenas', '908', '26069', NULL, 'No', NULL, NULL, NULL, NULL),
	(17, 'Hospital General Cd. Acuña', 'Acuña', 'Libramiento José de las Fuentes Rodriguez', '', '503', '26200', NULL, 'Yes', NULL, NULL, NULL, NULL),
	(18, 'UNEME Nueva Vida Acuña', 'Acuña', 'Toledo esquina Libramiento Sur Poniente', 'Fraccionamiento Altos de Santa Teresa', '700', '26284', NULL, 'No', NULL, NULL, NULL, NULL),
	(19, 'UNEME Cronicas Acuña', 'Acuña', 'Avenida Atilano Barrera', 'Fraccionamiento Las Aves', '2301', '26284', NULL, 'No', NULL, NULL, NULL, NULL),
	(20, 'UNEME Capasits Acuña', 'Acuña', 'Avenida Atilano Barrera', 'Fraccionamiento Las Aves', '2301', '26284', NULL, 'No', NULL, NULL, NULL, NULL),
	(21, 'Caravana Acuña', 'Acuña', 'Morelos', 'Centro', '1035', '26200', NULL, 'No', NULL, NULL, NULL, NULL),
	(22, 'Unidad Móvil Acuña', 'Acuña', 'Juárez', 'Centro', '600', '26000', NULL, 'No', NULL, NULL, NULL, NULL),
	(23, 'Ojo de Agua', 'General Cepeda', 'Al lado de la Iglesia de nuestra señora de Guadalupe', 'Ejido Ojo de Agua', 'S/N', '25979', NULL, 'No', NULL, NULL, NULL, NULL),
	(24, 'La Tortuga', 'Ramos Arizpe', 'Enfrente del tinaco de agua potable de la comunidad', 'Ejido La Tortuga', 'S/N', '25926', NULL, 'No', NULL, NULL, NULL, NULL),
	(25, 'Hospital de Especialidades #71', 'Torreon', 'Boulevard Revolución', 'Jardín', 'S/N', '27200', NULL, 'Yes', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `ntcoahulia_hospital` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
