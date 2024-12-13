-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.4.0-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla tfg.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` int(11) NOT NULL DEFAULT 0,
  `estado` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla tfg.users: ~5 rows (aproximadamente)
/*
  Para el inicio de sesión utilizaremos la contraseña "ua" para adm2 y bge3
*/
DELETE FROM `users`;
INSERT INTO `users` (`id`, `username`, `password`, `rol`, `estado`, `createdAt`, `updatedAt`) VALUES
	(24, 'adm2', '$2b$10$rPhyEllbI.XXWyzNdPhbhevO9cuRoUBtPNd6BI6wcIkFCoxcnwLLy', 1, 1, '2024-10-17 18:12:48', '2024-12-10 17:03:41'), -- Usuario: adm2, Contraseña: ua
	(28, 'bge3', '$2b$10$1n6iM7EcP.8Xc1E7lR58rOO9NHh7Z1pRRH.SznimcCFmfiiI38sBS', 1, 1, '2024-12-10 09:42:27', '2024-12-10 09:42:33'), -- Usuario: bge3, Contraseña: ua
	(30, 'egm24', '$2b$10$PcxQAORQ061vSJcE3OKhVuXzIXBLc0iK6J6IkyBqKeBLzy.2djeW6', 0, 0, '2024-12-10 10:04:24', '2024-12-10 17:13:35'),
	(31, 'fra5', '$2b$10$IYK5jPWgJ8VjHdIbdM.weuXXHqLDEhylL0e6jgb4R8LH3d4e4dzQa', 0, 0, '2024-12-10 17:30:11', '2024-12-12 11:13:21');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- Volcando estructura para tabla tfg.connections
CREATE TABLE IF NOT EXISTS `connections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`options`)),
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `connections_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla tfg.connections: ~4 rows (aproximadamente)
DELETE FROM `connections`;
INSERT INTO `connections` (`id`, `name`, `type`, `options`, `userId`, `createdAt`, `updatedAt`) VALUES
	(4, 'APIConnection', 1, '{"URL":"https://ingest.kunna.es","username":"","password":"","topic":"ua.kunnagentest.raw","clientId":"","header":"ua"}', 24, '2024-12-02 10:37:17', '2024-12-10 17:36:36'),
	(8, 'Hive MQ - EPS II', 0, '{"URL":"wss://b1f3d09eed3e4e998e98502c5567a212.s1.eu.hivemq.cloud:8884/mqtt","username":"admin_genesis","password":"Genesis1","topic":"eps2","clientId":"clientId-A9UZcYmtr4","header":""}', 24, '2024-12-03 11:13:31', '2024-12-11 23:11:09'),
	(10, 'SensorMQTT1', 0, '{"URL":"wss://broker.example.com:8883/mqtt/8084","header":"","username":"sensorUser123","password":"ua","clientId":"mqtt_yzjfbr3k0r","topic":"devices/sensors/temperature"}', 28, '2024-12-10 17:15:47', '2024-12-10 17:15:47'),
	(11, 'Hive MQ - Aulario II', 0, '{"URL":"wss://b1f3d09eed3e4e998e98502c5567a212.s1.eu.hivemq.cloud:8884/mqtt","username":"admin_genesis","password":"Genesis1","topic":"aulario2","clientId":"clientId-A9UZcYmtr4","header":""}', 24, '2024-12-03 11:13:31', '2024-12-13 11:55:36');

-- Volcando estructura para tabla tfg.sensors
CREATE TABLE IF NOT EXISTS `sensors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `coordinates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`coordinates`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla tfg.sensors: ~4 rows (aproximadamente)
DELETE FROM `sensors`;
INSERT INTO `sensors` (`id`, `name`, `coordinates`, `createdAt`, `updatedAt`, `userId`) VALUES
	(24, 'Sensores Facultad de Ciencias I', '[{"lat":37.774929,"long":-122.419418,"height":15,"alias":"C02_SENSOR3","dev_eui":"A81758FFFE02ABCD","join_eui":"0102030405060708","dev_addr":"26011B4B"},{"lat":-33.86882,"long":151.20929,"height":12,"alias":"C02_SENSOR4","dev_eui":"70B3D57ED005A7B2","join_eui":"0000000000000000","dev_addr":"260B7694"},{"lat":48.856613,"long":2.352222,"height":8,"alias":"C02_SENSOR5","dev_eui":"A81758FFFE02CDEF","join_eui":"0102030405060708","dev_addr":"26011B4C"},{"lat":34.052235,"long":-118.243683,"height":9.5,"alias":"C02_SENSOR6","dev_eui":"70B3D57ED005A7C3","join_eui":"0000000000000000","dev_addr":"260B7695"},{"lat":-23.55052,"long":-46.633308,"height":11,"alias":"C02_SENSOR7","dev_eui":"A81758FFFE02DCBA","join_eui":"0102030405060708","dev_addr":"26011B4D"},{"lat":55.755825,"long":37.617298,"height":10,"alias":"C02_SENSOR8","dev_eui":"70B3D57ED005A7D4","join_eui":"0000000000000000","dev_addr":"260B7696"}]\r\n', '2024-11-11 10:55:18', '2024-12-10 17:20:02', 24),
	(30, 'Sensores EPS II', '[{"lat":40.73061,"long":-73.935242,"height":15,"alias":"Sensor_Temperatura_001","dev_eui":"A1B2C3D4E5F6A7B8C9","join_eui":"0011223344556677","dev_addr":"192.168.0.101"},{"lat":40.73061,"long":-73.935242,"height":20,"alias":"Sensor_Humedad_002","dev_eui":"B1C2D3E4F5G6H7I8J9","join_eui":"8899AABBCCDDEEFF","dev_addr":"192.168.0.102"},{"lat":40.73061,"long":-73.935242,"height":12,"alias":"Sensor_Contaminacion_003","dev_eui":"C1D2E3F4G5H6I7J8K9","join_eui":"1122334455667788","dev_addr":"192.168.0.103"},{"lat":40.73061,"long":-73.935242,"height":24,"alias":"Sensor_Luz_004","dev_eui":"D1E2F3G4H5I6J7K8L9","join_eui":"2233445566778899","dev_addr":"192.168.0.104"}]', '2024-12-10 11:21:53', '2024-12-10 17:19:01', 28),
	(32, 'Sensores C02 Campus', '[{"lat":37.774929,"long":-122.419418,"height":15,"alias":"C02_SENSOR3","dev_eui":"A81758FFFE02ABCD","join_eui":"0102030405060708","dev_addr":"26011B4B"},{"lat":-33.86882,"long":151.20929,"height":12,"alias":"C02_SENSOR4","dev_eui":"70B3D57ED005A7B2","join_eui":"0000000000000000","dev_addr":"260B7694"},{"lat":48.856613,"long":2.352222,"height":8,"alias":"C02_SENSOR5","dev_eui":"A81758FFFE02CDEF","join_eui":"0102030405060708","dev_addr":"26011B4C"},{"lat":34.052235,"long":-118.243683,"height":9.5,"alias":"C02_SENSOR6","dev_eui":"70B3D57ED005A7C3","join_eui":"0000000000000000","dev_addr":"260B7695"},{"lat":-23.55052,"long":-46.633308,"height":11,"alias":"C02_SENSOR7","dev_eui":"A81758FFFE02DCBA","join_eui":"0102030405060708","dev_addr":"26011B4D"},{"lat":55.755825,"long":37.617298,"height":10,"alias":"C02_SENSOR8","dev_eui":"70B3D57ED005A7D4","join_eui":"0000000000000000","dev_addr":"260B7696"},{"lat":34.052235,"long":2.352222,"height":8,"alias":"C02_SENSOR9","dev_eui":"A81758FFFE02DCBA","join_eui":"0000000000000000","dev_addr":"260B7697"}]', '2024-11-11 10:55:18', '2024-12-10 17:38:20', 24),
	(33, 'Temperatura Aulario I', '[{"lat":37.774929,"long":-122.419418,"height":15,"alias":"C02_SENSOR3","dev_eui":"A81758FFFE02ABCD","join_eui":"0102030405060708","dev_addr":"26011B4B"},{"lat":-33.86882,"long":151.20929,"height":12,"alias":"C02_SENSOR4","dev_eui":"70B3D57ED005A7B2","join_eui":"0000000000000000","dev_addr":"260B7694"},{"lat":48.856613,"long":2.352222,"height":8,"alias":"C02_SENSOR5","dev_eui":"A81758FFFE02CDEF","join_eui":"0102030405060708","dev_addr":"26011B4C"},{"lat":34.052235,"long":-118.243683,"height":9.5,"alias":"C02_SENSOR6","dev_eui":"70B3D57ED005A7C3","join_eui":"0000000000000000","dev_addr":"260B7695"},{"lat":-23.55052,"long":-46.633308,"height":11,"alias":"C02_SENSOR7","dev_eui":"A81758FFFE02DCBA","join_eui":"0102030405060708","dev_addr":"26011B4D"},{"lat":55.755825,"long":37.617298,"height":10,"alias":"C02_SENSOR8","dev_eui":"70B3D57ED005A7D4","join_eui":"0000000000000000","dev_addr":"260B7696"},{"lat":37.774929,"long":151.20929,"height":12,"alias":"C02_SENSOR9","dev_eui":"A81758FFFE02CDEF","join_eui":"0102030405060709","dev_addr":"26011B4B"},{"lat":48.856613,"long":46.633308,"height":8,"alias":"C02_SENSOR10","dev_eui":"70B3D57ED005A7C3","join_eui":"0102030405060709","dev_addr":"260B7696"}]', '2024-11-11 10:55:18', '2024-12-10 17:42:14', 24);

-- Volcando estructura para tabla tfg.simulations
CREATE TABLE IF NOT EXISTS `simulations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sensorId` int(11) NOT NULL,
  `connectionId` int(11) DEFAULT NULL,
  `parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`parameters`)),
  `userId` int(11) NOT NULL,
  `minRegistrosPorInstante` int(11) NOT NULL,
  `maxRegistrosPorInstante` int(11) NOT NULL,
  `minIntervaloEntreRegistros` int(11) NOT NULL,
  `maxIntervaloEntreRegistros` int(11) NOT NULL,
  `numElementosASimular` int(11) NOT NULL,
  `noRepetirCheckbox` int(11) DEFAULT 0,
  `date` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `locationId` (`sensorId`) USING BTREE,
  CONSTRAINT `simulations_ibfk_1` FOREIGN KEY (`sensorId`) REFERENCES `sensors` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `simulations_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla tfg.simulations: ~12 rows (aproximadamente)
DELETE FROM `simulations`;
INSERT INTO `simulations` (`id`, `name`, `sensorId`, `connectionId`, `parameters`, `userId`, `minRegistrosPorInstante`, `maxRegistrosPorInstante`, `minIntervaloEntreRegistros`, `maxIntervaloEntreRegistros`, `numElementosASimular`, `noRepetirCheckbox`, `date`, `createdAt`, `updatedAt`) VALUES
	(1, 'Simulación de Sensores - Datos Correctos', 30, 8, '{"temperatura":"^float[20,25]","humedad":"^float[15,20]","estadoSensor":"^bool","time":"^time","sensor":{"longitud":"^positionlong","latitud":"^positionlat","altitud":"^positioncote"}}', 24, 2, 3, 5, 10, 40, 1, '2024-12-11 10:26:17', '2024-10-27 18:53:16', '2024-12-11 23:50:04'),
	(2, 'Simulación de Sensores - Errores', 30, 8, '{"temperatura":"^float[40,60]","humedad":"^float[40,60]","estadoSensor":"^bool","time":"^time","sensor":{"longitud":"^positionlong","latitud":"^positionlat","altitud":"^positioncote"}}', 24, 1, 1, 10, 10, 20, 1, '2024-12-11 10:26:21', '2024-10-27 18:54:12', '2024-12-11 23:50:07'),
	(20, 'Simulación de Prueba API', 24, 11, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 24, 4, 6, 15, 20, 300, 1, '2024-11-14 11:00:00', '2024-11-17 11:57:39', '2024-12-13 10:48:04'),
	(32, 'Simulación de Actividad: Aulario II', 33, 11, '{"temperatura":"^float[20,25]","humedad":"^float[20,25]","estadoSensor":"^bool","hora":"^time","sensor":{"longitud":"^positionlong","latitud":"^positionlat","altitud":"^positioncote"}}', 28, 2, 3, 10, 15, 20, 1, '2024-12-11 10:23:08', '2024-12-11 09:54:25', '2024-12-11 22:29:35'),
	(33, 'Simulación Científica: Facultad de Ciencias I', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 5, 10, 1, 2, 45, 0, '2024-11-14 11:00:00', '2024-12-10 10:55:16', '2024-12-11 16:38:20'),
	(34, 'Simulación red Wifi: EPS II', 30, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 1, 1, 15, 20, 300, 1, '2024-11-14 11:00:00', '2024-12-11 09:52:12', '2024-12-11 10:19:04'),
	(37, 'Simulacion de prueba', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 2, 3, 10, 15, 60, 0, '2024-12-12 11:50:40', '2024-12-12 11:50:40', '2024-12-12 11:50:40'),
	(41, 'Simulacion de prueba', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 2, 3, 5, 8, 60, 0, '2024-12-12 12:13:43', '2024-12-12 12:13:43', '2024-12-12 12:13:43'),
	(42, 'Simulacion de prueba', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 2, 3, 5, 8, 60, 0, '2024-12-12 12:19:48', '2024-12-12 12:19:48', '2024-12-12 12:19:48'),
	(43, 'Simulacion de prueba', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 2, 3, 5, 8, 60, 0, '2024-12-12 12:23:37', '2024-12-12 12:23:37', '2024-12-12 12:23:37'),
	(44, 'Simulacion de prueba', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 2, 3, 5, 8, 60, 0, '2024-12-12 12:27:51', '2024-12-12 12:27:51', '2024-12-12 12:27:51'),
	(45, 'Simulacion de prueba', 24, 10, '{"campo2":"^int[0,10]","campo3":"^float[20,25]","campo4":"^bool","time":"^time","campo5":"este texto","campo6":"^array[4]int[0,50]","campo7":"^array[4]float[0,50]","campo8":"^array[4]bool","campo9":{"campo10":"^array[4]float[0,50]","campo11":"^float[20,25]"},"campo12":"^positionlong","campo13":"^positionlat","campo14":"^positioncote","campo15":"^positionalias","campo16":"^positiondeveui","campo17":"^positionjoineui","campo18":"^positiondevaddr"}', 28, 2, 3, 5, 8, 60, 0, '2024-12-12 12:40:27', '2024-12-12 12:40:27', '2024-12-12 12:40:27');