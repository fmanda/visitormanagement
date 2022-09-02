-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: demokpi
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.13-MariaDB

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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptcode` varchar(30) DEFAULT NULL,
  `deptname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (2,'deptcode2',NULL);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kpi_area`
--

DROP TABLE IF EXISTS `kpi_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kpi_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `areacode` varchar(30) DEFAULT NULL,
  `areaname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kpi_area`
--

LOCK TABLES `kpi_area` WRITE;
/*!40000 ALTER TABLE `kpi_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `kpi_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kpi_subarea`
--

DROP TABLE IF EXISTS `kpi_subarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kpi_subarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kpi_area_id` int(11) NOT NULL,
  `subcode` varchar(30) DEFAULT NULL,
  `subname` varchar(100) DEFAULT NULL,
  `subdesc` text DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `level_1` text DEFAULT NULL,
  `leveldetail_1` text DEFAULT NULL,
  `level_2` text DEFAULT NULL,
  `leveldetail_2` text DEFAULT NULL,
  `level_3` text DEFAULT NULL,
  `leveldetail_3` text DEFAULT NULL,
  `level_4` text DEFAULT NULL,
  `leveldetail_4` text DEFAULT NULL,
  `level_5` text DEFAULT NULL,
  `leveldetail_5` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kpi_subarea`
--

LOCK TABLES `kpi_subarea` WRITE;
/*!40000 ALTER TABLE `kpi_subarea` DISABLE KEYS */;
/*!40000 ALTER TABLE `kpi_subarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml_area`
--

DROP TABLE IF EXISTS `ml_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `areacode` varchar(30) DEFAULT NULL,
  `areaname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml_area`
--

LOCK TABLES `ml_area` WRITE;
/*!40000 ALTER TABLE `ml_area` DISABLE KEYS */;
INSERT INTO `ml_area` VALUES (15,2,'aaareacode_1','aaareaname_1'),(16,2,'areacode_2',NULL);
/*!40000 ALTER TABLE `ml_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml_subarea`
--

DROP TABLE IF EXISTS `ml_subarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml_subarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ml_area_id` int(11) NOT NULL,
  `subcode` varchar(30) DEFAULT NULL,
  `subname` varchar(100) DEFAULT NULL,
  `subdesc` text DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `level_1` text DEFAULT NULL,
  `leveldetail_1` text DEFAULT NULL,
  `level_2` text DEFAULT NULL,
  `leveldetail_2` text DEFAULT NULL,
  `level_3` text DEFAULT NULL,
  `leveldetail_3` text DEFAULT NULL,
  `level_4` text DEFAULT NULL,
  `leveldetail_4` text DEFAULT NULL,
  `level_5` text DEFAULT NULL,
  `leveldetail_5` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml_subarea`
--

LOCK TABLES `ml_subarea` WRITE;
/*!40000 ALTER TABLE `ml_subarea` DISABLE KEYS */;
INSERT INTO `ml_subarea` VALUES (21,15,'subcode_1_1','aaasubname_1_1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,15,'subcode_1_2','subname_1_2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,16,'subcode_2_1','subname_2_1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,16,'subcode_2_2','AAAsubname_2_2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ml_subarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testdetail`
--

DROP TABLE IF EXISTS `testdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `header_id` int(11) NOT NULL,
  `detailcode` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testdetail`
--

LOCK TABLES `testdetail` WRITE;
/*!40000 ALTER TABLE `testdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `testdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testheader`
--

DROP TABLE IF EXISTS `testheader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testheader` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testheader`
--

LOCK TABLES `testheader` WRITE;
/*!40000 ALTER TABLE `testheader` DISABLE KEYS */;
/*!40000 ALTER TABLE `testheader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'demokpi'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-13 20:55:46
