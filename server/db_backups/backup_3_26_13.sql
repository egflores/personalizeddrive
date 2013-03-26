-- MySQL dump 10.13  Distrib 5.5.27, for osx10.7 (i386)
--
-- Host: bmw.stanford.edu    Database: pd_test
-- ------------------------------------------------------
-- Server version	5.5.29-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `admin` smallint(6) NOT NULL,
  `active` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','eeb06$4e5a6e773802a21b46a5ec0091259d93cb70c59a','boss@nuggets.com',1,1);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `vehicle_id` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `picture` longtext,
  PRIMARY KEY (`id`),
  KEY `car_user_id` (`user_id`),
  CONSTRAINT `fk_car_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (1,2,'a123','Z4',2013,'Jay\'s Dream Machine','car_1.jpg');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cardata`
--

DROP TABLE IF EXISTS `cardata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cardata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `mileage` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cardata`
--

LOCK TABLES `cardata` WRITE;
/*!40000 ALTER TABLE `cardata` DISABLE KEYS */;
INSERT INTO `cardata` VALUES (1,'2013-02-28 14:33:20',8693),(2,'2013-02-28 15:33:20',8700),(3,'2013-02-28 16:33:20',8730),(4,'2013-02-28 17:33:20',8780),(5,'2013-02-28 18:33:20',8810),(6,'2013-02-28 19:33:20',8850),(7,'2013-02-28 20:33:20',8900),(8,'2013-02-28 21:33:20',8900),(9,'2013-02-28 22:33:20',8900),(10,'2013-02-28 23:33:20',8900),(11,'2013-03-01 00:33:20',8900),(12,'2013-03-01 01:33:20',8900),(13,'2013-03-01 02:33:20',8900),(14,'2013-03-01 03:33:20',8900),(15,'2013-03-01 04:33:20',8900),(16,'2013-03-01 05:33:20',8900),(17,'2013-03-01 06:33:20',8900),(18,'2013-03-01 07:33:20',8900),(19,'2013-03-01 08:33:20',8920),(20,'2013-03-01 09:33:20',8930),(21,'2013-03-01 10:33:20',8930),(22,'2013-03-01 11:33:20',8930),(23,'2013-03-01 12:33:20',8930),(24,'2013-03-01 13:33:20',8940),(25,'2013-03-01 14:33:20',8940),(26,'2013-03-01 15:33:20',8940),(27,'2013-03-01 16:33:20',8940),(28,'2013-03-01 17:33:20',8940),(29,'2013-03-01 18:33:20',8940),(30,'2013-03-01 19:33:20',8970),(31,'2013-03-01 20:33:20',8970),(32,'2013-03-01 21:33:20',8980),(33,'2013-03-01 22:33:20',8980),(34,'2013-03-01 23:33:20',8985),(35,'2013-03-02 00:33:20',8990),(36,'2013-03-02 01:33:20',8990),(37,'2013-03-02 02:33:20',8990),(38,'2013-03-02 03:33:20',8990),(39,'2013-03-02 04:33:20',8990),(40,'2013-03-02 05:33:20',8990),(41,'2013-03-02 06:33:20',8990),(42,'2013-03-02 07:33:20',8990),(43,'2013-03-02 08:33:20',9005),(44,'2013-03-02 09:33:20',9020),(45,'2013-03-02 10:33:20',9020),(46,'2013-03-02 11:33:20',9030),(47,'2013-03-02 12:33:20',9045),(48,'2013-03-02 13:33:20',9045),(49,'2013-03-02 14:33:20',9050),(50,'2013-03-02 15:33:20',9100);
/*!40000 ALTER TABLE `cardata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cbsmessage`
--

DROP TABLE IF EXISTS `cbsmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cbsmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `remaining_mileage` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cbsmessage_update_time` (`update_time`),
  KEY `cbsmessage_car_id` (`car_id`),
  CONSTRAINT `fk_cbsmessage_car_car_id` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cbsmessage`
--

LOCK TABLES `cbsmessage` WRITE;
/*!40000 ALTER TABLE `cbsmessage` DISABLE KEYS */;
INSERT INTO `cbsmessage` VALUES (4,1,'VEHICLE_CHECK','PENDING','Ihr Fahrzeug-Check steht demnchst an',2000,NULL,'2012-06-15 14:33:20'),(5,1,'OIL','OK','lstand in Ordnung',12000,'2013-08-01 00:00:00','2012-06-15 14:33:20');
/*!40000 ALTER TABLE `cbsmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ccmmessage`
--

DROP TABLE IF EXISTS `ccmmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccmmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_id` int(11) NOT NULL,
  `ccm_id` int(11) NOT NULL,
  `mileage` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ccmmessage_update_time` (`update_time`),
  KEY `ccmmessage_car_id` (`car_id`),
  CONSTRAINT `fk_ccmmessage_car_car_id` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ccmmessage`
--

LOCK TABLES `ccmmessage` WRITE;
/*!40000 ALTER TABLE `ccmmessage` DISABLE KEYS */;
INSERT INTO `ccmmessage` VALUES (1,1,1,12345,'Bitte Bremsen prfen. Vorsichtig weiterfahren.','2012-06-15 14:33:20'),(2,1,23,32343,'Lenkung defekt','2012-06-15 14:33:20'),(3,1,1,12345,'Bitte Bremsen prfen. Vorsichtig weiterfahren.','2012-06-15 14:33:20'),(4,1,23,32343,'Lenkung defekt','2012-06-15 14:33:20'),(5,1,1,12345,'Bitte Bremsen prfen. Vorsichtig weiterfahren.','2012-06-15 14:33:20'),(6,1,23,32343,'Lenkung defekt','2012-06-15 14:33:20'),(7,1,1,12345,'Bitte Bremsen prfen. Vorsichtig weiterfahren.','2012-06-15 14:33:20'),(8,1,23,32343,'Lenkung defekt','2012-06-15 14:33:20');
/*!40000 ALTER TABLE `ccmmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commute`
--

DROP TABLE IF EXISTS `commute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `ave_speed` double NOT NULL,
  `ave_mpg` double NOT NULL,
  `tank_used` double NOT NULL,
  `start_latitude` double DEFAULT NULL,
  `start_longitude` double DEFAULT NULL,
  `end_latitude` double DEFAULT NULL,
  `end_longitude` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commute_car_id` (`car_id`),
  CONSTRAINT `fk_commute_car_car_id` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commute`
--

LOCK TABLES `commute` WRITE;
/*!40000 ALTER TABLE `commute` DISABLE KEYS */;
INSERT INTO `commute` VALUES (1,1,'2013-03-25 00:00:00',50,64,33,1.5,NULL,NULL,NULL,NULL),(2,1,'2013-03-24 00:00:00',43,70,28,1.8,NULL,NULL,NULL,NULL),(3,1,'2013-03-23 00:00:00',0,68,29,1.3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `commute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rawdata`
--

DROP TABLE IF EXISTS `rawdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rawdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_id` int(11) NOT NULL,
  `update_time` datetime NOT NULL,
  `tank_level` int(11) DEFAULT NULL,
  `fuel_range` int(11) DEFAULT NULL,
  `fuel_reserve` varchar(255) DEFAULT NULL,
  `odometer` int(11) NOT NULL,
  `ave_mpg` double DEFAULT NULL,
  `headlights` varchar(255) DEFAULT NULL,
  `speed` double DEFAULT NULL,
  `engine_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rawdata_update_time` (`update_time`),
  KEY `rawdata_car_id` (`car_id`),
  CONSTRAINT `fk_rawdata_car_car_id` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rawdata`
--

LOCK TABLES `rawdata` WRITE;
/*!40000 ALTER TABLE `rawdata` DISABLE KEYS */;
INSERT INTO `rawdata` VALUES (80,1,'2013-03-11 16:18:02',71,83,'no',1444,NULL,'no',48,NULL),(81,1,'2013-03-11 16:18:03',71,83,'no',1444,NULL,'no',48,NULL),(82,1,'2013-03-11 16:18:04',71,83,'no',1444,NULL,'no',88,NULL),(83,1,'2013-03-11 16:18:05',71,83,'no',1444,NULL,'no',39,NULL),(84,1,'2013-03-11 16:18:06',30,287,'no',1444,NULL,'no',41,NULL),(85,1,'2013-03-11 16:18:07',30,287,'no',1444,NULL,'no',44,NULL),(86,1,'2013-03-11 16:18:08',30,287,'no',1444,NULL,'no',44,NULL),(87,1,'2013-03-11 16:18:20',56,69,'no',1737,NULL,'no',83,NULL),(88,1,'2013-03-11 16:18:21',56,69,'no',1737,NULL,'no',71,NULL),(89,1,'2013-03-11 16:18:22',56,69,'no',1737,NULL,'no',51,NULL),(90,1,'2013-03-11 16:18:23',56,69,'no',1737,NULL,'no',61,NULL),(91,1,'2013-03-11 16:18:24',74,212,'no',1737,NULL,'no',95,NULL),(92,1,'2013-03-11 16:18:25',74,212,'no',1737,NULL,'no',53,NULL),(93,1,'2013-03-11 16:18:26',74,212,'no',1737,NULL,'no',84,NULL),(94,1,'2013-03-11 16:18:27',74,212,'no',1737,NULL,'no',59,NULL),(95,1,'2013-03-11 16:18:28',74,212,'no',1737,NULL,'no',45,NULL),(96,1,'2013-03-11 16:18:29',61,73,'no',1839,NULL,'no',57,NULL),(97,1,'2013-03-11 16:18:30',61,73,'no',1839,NULL,'no',87,NULL),(98,1,'2013-03-11 16:18:31',61,73,'no',1839,NULL,'no',31,NULL),(99,1,'2013-03-11 16:18:32',61,73,'no',1839,NULL,'no',47,NULL),(100,1,'2013-03-11 16:18:33',61,73,'no',1839,NULL,'no',50,NULL),(101,1,'2013-03-11 16:18:34',90,46,'no',1839,NULL,'no',81,NULL),(102,1,'2013-03-11 16:18:35',90,46,'no',1839,NULL,'no',84,NULL),(103,1,'2013-03-11 16:18:36',90,46,'no',1839,NULL,'no',63,NULL),(104,1,'2013-03-11 16:56:18',61,37,'no',2487,NULL,'no',97,NULL),(105,1,'2013-03-11 16:56:19',61,37,'no',2487,NULL,'no',37,NULL),(106,1,'2013-03-11 16:56:20',61,37,'no',2487,NULL,'no',85,NULL),(107,1,'2013-03-11 16:56:21',61,37,'no',2487,NULL,'no',66,NULL),(108,1,'2013-03-11 16:56:22',38,252,'no',2487,NULL,'no',48,NULL),(109,1,'2013-03-11 16:56:23',38,252,'no',2487,NULL,'no',50,NULL),(110,1,'2013-03-11 16:56:24',38,252,'no',2487,NULL,'no',54,NULL),(111,1,'2013-03-11 16:56:25',38,252,'no',2487,NULL,'no',85,NULL),(112,1,'2013-03-11 16:56:26',38,252,'no',2487,NULL,'no',33,NULL),(113,1,'2013-03-11 16:56:27',47,168,'no',2037,NULL,'no',39,NULL),(114,1,'2013-03-11 16:56:28',47,168,'no',2037,NULL,'no',87,NULL),(115,1,'2013-03-11 16:56:29',47,168,'no',2037,NULL,'no',57,NULL),(116,1,'2013-03-11 16:56:30',47,168,'no',2037,NULL,'no',76,NULL),(117,1,'2013-03-11 16:56:31',47,168,'no',2037,NULL,'no',49,NULL),(118,1,'2013-03-11 16:56:32',37,235,'no',2037,NULL,'no',90,NULL),(119,1,'2013-03-11 16:56:33',37,235,'no',2037,NULL,'no',43,NULL),(120,1,'2013-03-11 16:56:34',37,235,'no',2037,NULL,'no',49,NULL),(121,1,'2013-03-11 16:56:35',37,235,'no',2037,NULL,'no',80,NULL),(122,1,'2013-03-11 16:56:36',37,235,'no',2037,NULL,'no',91,NULL),(123,1,'2013-03-11 16:56:37',79,368,'no',1905,NULL,'no',70,NULL),(124,1,'2013-03-11 16:56:38',79,368,'no',1905,NULL,'no',53,NULL),(125,1,'2013-03-11 16:56:39',79,368,'no',1905,NULL,'no',95,NULL),(126,1,'2013-03-11 16:56:40',79,368,'no',1905,NULL,'no',95,NULL),(127,1,'2013-03-11 16:56:41',79,368,'no',1905,NULL,'no',65,NULL),(128,1,'2013-03-11 16:56:42',90,333,'no',1905,NULL,'no',86,NULL),(129,1,'2013-03-11 16:56:43',90,333,'no',1905,NULL,'no',47,NULL),(130,1,'2013-03-13 16:20:27',30,169,'no',1980,NULL,'no',73,NULL),(131,1,'2013-03-13 16:20:28',30,169,'no',1980,NULL,'no',36,NULL),(132,1,'2013-03-13 16:20:29',30,169,'no',1980,NULL,'no',97,NULL),(133,1,'2013-03-13 16:20:30',30,169,'no',1980,NULL,'no',69,NULL),(134,1,'2013-03-13 16:20:31',73,237,'no',1980,NULL,'no',100,NULL),(135,1,'2013-03-13 16:20:32',73,237,'no',1980,NULL,'no',81,NULL),(136,1,'2013-03-13 16:20:33',73,237,'no',1980,NULL,'no',70,NULL),(137,1,'2013-03-13 16:20:34',73,237,'no',1980,NULL,'no',84,NULL),(138,1,'2013-03-13 16:20:35',73,237,'no',1980,NULL,'no',38,NULL),(139,1,'2013-03-13 16:20:36',24,66,'no',1334,NULL,'no',39,NULL),(140,1,'2013-03-13 16:20:37',24,66,'no',1334,NULL,'no',68,NULL),(141,1,'2013-03-13 16:20:38',24,66,'no',1334,NULL,'no',96,NULL),(142,1,'2013-03-13 16:20:39',24,66,'no',1334,NULL,'no',51,NULL),(143,1,'2013-03-13 16:20:40',24,66,'no',1334,NULL,'no',59,NULL),(144,1,'2013-03-13 16:20:41',52,257,'no',1334,NULL,'no',81,NULL),(145,1,'2013-03-13 16:20:42',52,257,'no',1334,NULL,'no',98,NULL),(146,1,'2013-03-13 16:20:43',52,257,'no',1334,NULL,'no',65,NULL),(147,1,'2013-03-13 16:20:44',52,257,'no',1334,NULL,'no',74,NULL),(148,1,'2013-03-13 16:20:45',52,257,'no',1334,NULL,'no',96,NULL),(149,1,'2013-03-13 16:20:46',45,17,'no',1033,NULL,'no',91,NULL),(150,1,'2013-03-13 16:20:47',45,17,'no',1033,NULL,'no',39,NULL),(151,1,'2013-03-13 16:21:38',99,12,'no',1916,NULL,'no',56,NULL),(152,1,'2013-03-13 16:21:39',99,12,'no',1916,NULL,'no',36,NULL),(153,1,'2013-03-13 16:21:40',99,12,'no',1916,NULL,'no',71,NULL),(154,1,'2013-03-13 16:21:41',78,105,'no',1916,NULL,'no',80,NULL),(155,1,'2013-03-13 16:21:42',78,105,'no',1916,NULL,'no',90,NULL),(156,1,'2013-03-13 17:37:47',69,137,'no',1461,NULL,'no',99,NULL),(157,1,'2013-03-13 17:37:48',69,137,'no',1461,NULL,'no',50,NULL),(158,1,'2013-03-13 17:37:49',69,137,'no',1461,NULL,'no',99,NULL),(159,1,'2013-03-13 17:37:50',69,137,'no',1461,NULL,'no',51,NULL),(160,1,'2013-03-13 17:37:51',96,357,'no',1461,NULL,'no',31,NULL),(161,1,'2013-03-13 17:37:52',96,357,'no',1461,NULL,'no',78,NULL),(162,1,'2013-03-13 17:37:53',96,357,'no',1461,NULL,'no',75,NULL),(163,1,'2013-03-13 17:37:54',96,357,'no',1461,NULL,'no',86,NULL),(164,1,'2013-03-13 17:37:55',96,357,'no',1461,NULL,'no',49,NULL),(165,1,'2013-03-13 17:37:56',79,320,'no',1193,NULL,'no',38,NULL),(166,1,'2013-03-13 17:37:57',79,320,'no',1193,NULL,'no',44,NULL),(167,1,'2013-03-13 17:37:58',79,320,'no',1193,NULL,'no',69,NULL),(168,1,'2013-03-14 10:59:36',40,306,'no',1893,NULL,'no',49,NULL),(169,1,'2013-03-14 10:59:37',40,306,'no',1893,NULL,'no',96,NULL),(170,1,'2013-03-14 10:59:38',40,306,'no',1893,NULL,'no',38,NULL),(171,1,'2013-03-14 10:59:39',40,306,'no',1893,NULL,'no',32,NULL),(172,1,'2013-03-14 10:59:40',23,262,'no',1893,NULL,'no',45,NULL),(173,1,'2013-03-14 10:59:41',23,262,'no',1893,NULL,'no',35,NULL),(174,1,'2013-03-14 10:59:42',23,262,'no',1893,NULL,'no',100,NULL),(175,1,'2013-03-14 10:59:43',23,262,'no',1893,NULL,'no',62,NULL),(176,1,'2013-03-14 10:59:44',23,262,'no',1893,NULL,'no',42,NULL),(177,1,'2013-03-14 10:59:45',66,157,'no',2009,NULL,'no',94,NULL),(178,1,'2013-03-14 10:59:46',66,157,'no',2009,NULL,'no',78,NULL),(179,1,'2013-03-14 10:59:47',66,157,'no',2009,NULL,'no',69,NULL),(180,1,'2013-03-14 10:59:48',66,157,'no',2009,NULL,'no',95,NULL),(181,1,'2013-03-14 10:59:49',66,157,'no',2009,NULL,'no',84,NULL),(182,1,'2013-03-14 10:59:50',21,286,'no',2009,NULL,'no',32,NULL),(183,1,'2013-03-14 10:59:51',21,286,'no',2009,NULL,'no',71,NULL),(184,1,'2013-03-14 10:59:52',21,286,'no',2009,NULL,'no',60,NULL),(185,1,'2013-03-14 10:59:53',21,286,'no',2009,NULL,'no',54,NULL);
/*!40000 ALTER TABLE `rawdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Jay',NULL,NULL,0,0),(5,'admin','e32fe$5de8a7e4fad0a2d530d4ba1ef8d3bd496fe81bdf',NULL,1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-26 14:15:10
