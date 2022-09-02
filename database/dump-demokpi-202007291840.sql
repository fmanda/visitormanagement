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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'L3','INFORMATION CAPITAL READINESS (ICR) '),(2,'I5','OPERATION MANAGEMENT THERMAL'),(3,'I3','SUPPLY CHAIN MANAGEMENT (SCM)'),(4,'L1','HUMAN CAPITAL READINESS (HCR)'),(5,'test','test');
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
  `kpi_department_id` int(11) NOT NULL,
  `areacode` varchar(30) DEFAULT NULL,
  `areaname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kpi_area`
--

LOCK TABLES `kpi_area` WRITE;
/*!40000 ALTER TABLE `kpi_area` DISABLE KEYS */;
INSERT INTO `kpi_area` VALUES (8,1,'L3','KPI ICR');
/*!40000 ALTER TABLE `kpi_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kpi_department`
--

DROP TABLE IF EXISTS `kpi_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kpi_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `period` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kpi_department`
--

LOCK TABLES `kpi_department` WRITE;
/*!40000 ALTER TABLE `kpi_department` DISABLE KEYS */;
INSERT INTO `kpi_department` VALUES (1,202001,1);
/*!40000 ALTER TABLE `kpi_department` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kpi_subarea`
--

LOCK TABLES `kpi_subarea` WRITE;
/*!40000 ALTER TABLE `kpi_subarea` DISABLE KEYS */;
INSERT INTO `kpi_subarea` VALUES (22,8,'L3.18','Pencapaian SLA TTO',NULL,0.333,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,8,'L3.19','Pencapaian SLA TTR',NULL,0.333,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,8,'L3.20','Penyelesaian Permasalahan User sesuai Tiket Helpdesk User',NULL,0.333,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
  `kpi_department_id` int(11) NOT NULL,
  `areacode` varchar(30) DEFAULT NULL,
  `areaname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml_area`
--

LOCK TABLES `ml_area` WRITE;
/*!40000 ALTER TABLE `ml_area` DISABLE KEYS */;
INSERT INTO `ml_area` VALUES (8,1,'L3','ML ICR'),(9,5,'e','e');
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
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml_subarea`
--

LOCK TABLES `ml_subarea` WRITE;
/*!40000 ALTER TABLE `ml_subarea` DISABLE KEYS */;
INSERT INTO `ml_subarea` VALUES (120,8,'L3.1','Jenis Kabel/media  untuk user/client','Deskripsi :\nKesesuaian media yang digunakan  untuk menghubungkan koneksi antar gedung maupun yang digunakan oleh user berdasarkan standar jarak dan peruntukan penggunaan di dalam jaringan lokal untuk mendukung penggunaan SIT\n\nMaksud : \nMedia transmisi bersama dengan topologi menentukan kecepatan, efisiensi saluran, tipe data yang boleh disalurkan dan juga aplikasi yang dapat didukung oleh jaringan.\n\nEvident :\n1. Foto Kabel UTP \n2. Optical Termination Box FO(OTB) \n3. Foto Access Point\n4. Foto Wall Mount Rack \n5. Foto SMB\n6. Foto Patch Panel',0.06,'Fire Fighting (menunggu & memadamkan kebakaran)','Koneksi secara keseluruhan hanya menggunakan kabel UTP.\nDibuktikan dengan kondisi:\nKabel UTP  dan SMB (min. 1 Titik)','Stabilizing (Bertindak sebatas merespon kebakaran)','Koneksi sudah mengunakan campuran media, namun kesesuaian peruntukan masih < 60%. Dibuktikan dengan kondisi:\nAkses point (min. 1 titik)','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','Koneksi sudah mengunakan campuran media, namun kesesuaian peruntukan masih < 80%. Dibuktikan dengan kondisi:\nTermination box FO (OTB).','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','Koneksi sudah mengunakan campuran media, kesesuaian peruntukan sudah 100%, namun interkoneksi belum terintegrasi/terpusat. Dibuktikan dengan kondisi:\nWallmount rack (min. 1 titik) ','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','Koneksi sudah mengunakan campuran media, kesesuaian peruntukan sudah 100%, namun interkoneksi belum terintegrasi/terpusat. Dibuktikan dengan kondisi:\nWallmount rack (min. 1 titik) '),(121,8,'L3.2','Cakupan & Topologi LAN','Deskripsi :\nSeberapa lengkap informasi topologi LAN\n\nMaksud : \nUntuk mempercepat proses troubleshooting, pengembangan LAN dan transfer knowledge.\n\nEvident :\n1. Denah Cakupan LAN\n2. Diagram topologi LAN, diagram line dari koneksi utama dilengkapi dengan informasi lokasi perangkat,hostname & IP Address',0.06,'Fire Fighting (menunggu & memadamkan kebakaran)','tidak memiliki dokumen formal cakupan & diagram topologi LAN.','Stabilizing (Bertindak sebatas merespon kebakaran)','memiliki dokumen formal cakupan & diagram topologi LAN namun hanya menunjukan diagram line dari koneksi utama. ','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki dokumen formal cakupan & diagram topologi LAN, diagram line dari koneksi utama dan dilengkapi dengan informasi lokasi perangkat.','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','memiliki dokumen formal cakupan & diagram topologi LAN, diagram line dari koneksi utama dilengkapi dengan informasi lokasi perangkat dan informasi lain yang berhubungan dengan protokol jaringan (misalnya IP Address dan/atau  MAC Address perangkat).','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki dokumen formal cakupan & diagram topologi LAN yang terintegrasi dengan data manajemen PC sehingga mempermudah troubleshooting. '),(122,8,'L3.3','Informasi PC User dan Server','Deskripsi :\nSeberapa lengkap informasi mengenai PC user\n\nMaksud : \nUntuk mempercepat proses troubleshooting & informasi aset IT\n\nEvident :\n1. Kelengkapan Informasi PC User meliputi : nama PC,lokasi,IP dan Mac Address,Nomor Port SMB dan Nomor Switch.\n\nKelengkapan Informasi Server meliputi : Alamat Url Aplikasi, lokasi, IP dan MAC Address, Nomor Port SMB dan Nomor Switch\n\n2. Foto labeling SMB (3 titik)\n3. Foto labeling Switch (3 titik)\n\n\n',0.06,'Fire Fighting (menunggu & memadamkan kebakaran)','tidak memiliki Informasi atau informasi tidak lengkap, mengenai PC user dan Server.','Stabilizing (Bertindak sebatas merespon kebakaran)','Memiliki Informasi PC User dan Server yang tercatat manual.','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','Informasi PC User dan Server tercatat pada database namun tidak terupdate. ','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','Informasi PC User dan Server tercatat pada database dan update.','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','Informasi PC User dan Server tercatat pada database ,update dan dapat diakses secara online (URL,Login & Password) Central Manage'),(123,8,'L3.4','Rack System','Deskripsi :\nSeberapa banyak server dan network hardware dimasukkan ke dalam rack system\n\nMaksud : \nUntuk memenuhi strandard datacenter,kemudahan koneksi,kerapihan & efisiensi tempat\n\nEvident :\nFoto seluruh Rak didalam ruang Server (2 Foto)\n',0.06,'Fire Fighting (menunggu & memadamkan kebakaran)','tidak memiliki rack system','Stabilizing (Bertindak sebatas merespon kebakaran)','memiliki rack system tapi belum mencakup seluruh server dan network hardware (cakupan 30%).','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki rack system tapi belum mencakup seluruh server dan network hardware (cakupan 60%).','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','memiliki rack system tapi belum mencakup seluruh server dan network hardware (cakupan 90%).','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki rack system yang standar untuk seluruh server dan network hardware.'),(124,8,'L3.5','UPS','Deskripsi :\nSentralisasi dan Runtime\n\nMaksud : \nUntuk menjaga keamanan data & hardware dari gangguan power supply\n\nEvident :\n1. Foto UPS\n2. Dokumen kapasitas dan Runtime UPS\n3. Dokumen Pemeliharaan UPS dan Testing UPS\n\n\n',0.06,'Fire Fighting (menunggu & memadamkan kebakaran)','memiliki UPS tapi belum tersentralisasi dengan runtime kurang dari 15 menit.','Stabilizing (Bertindak sebatas merespon kebakaran)','memiliki UPS tapi belum tersentralisasi dengan runtime kurang dari 45 menit.','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki UPS tapi belum tersentralisasi dengan runtime kurang dari 60 menit.','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','memiliki UPS tersentralisasi dengan runtime minimal 60 menit dan memiliki dokumen testing UPS.','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','Level 4 terpenuhi dan memiliki dokumen pemeliharaan UPS.'),(125,8,'L3.6','Cooling System',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',' memiliki pendingin hanya berupa fan pada rak server. ','Stabilizing (Bertindak sebatas merespon kebakaran)','memiliki sistem pendingin berupa AC yang belum dipantau sesuai dengan standar ruang server.','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','\"memiliki sistem pendingin berupa AC yang sudah dipantau sesuai dengan standar ruang server. Dibuktikan dengan kondisi:\n1. AC\n2. Dokumen pemantauan temperatur dan kelembaban ruang server selama 1 semester\"','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','memiliki sistem pendingin berupa precision cooling system yang sudah dipantau (dibuktikan dengan dokumen pengukuran selama 1 semester) sesuai dengan standar ruang server.','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki Precision Cooling System yang standar dan sesuai kebutuhan data center serta memiliki dokumen pemeliharaan precision cooling system. '),(126,8,'L3.7','Access Control','\"Deskripsi :\nPemenuhan standard access control, pemantauan dan dokumentasinya\n\nMaksud : \nMeningkatkan keamanan fisik ruang server \n\nEvident :\n1. Foto perangkat access control, atau kunci (1 Foto)\n2. Dokumen pemantauan aktivitas keluar masuk ruang server\"\n\n\n',0.06,'Fire Fighting (menunggu & memadamkan kebakaran)','tidak memiliki access control, aktivitas keluar masuk ruang server tidak dicatat.','Stabilizing (Bertindak sebatas merespon kebakaran)','tidak memiliki access control, aktivitas keluar masuk ruang server dicatat manual','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','memiliki access control sederhana (kunci ruangan misalnya) namun belum dapat dipantau dan terdokumentasi aktivitas keluar masuk ruang server.','Optimizing (Adanya usaha optimasi sumberdaya & improvement)','memiliki access control sederhana (kunci ruangan misalnya) yang dapat dipantau dan terdokumentasi aktivitas keluar masuk ruang server. Dibuktikan dengan kondisi:\n1. Access control sederhana\n2. Dokumen aktifitas keluar masuk ruang server','Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)','\"memiliki access control modern (access card misalnya) yang dapat terpantau dan terdokumentasi aktivitas keluar masuk ruang server. Dibuktikan dengan:\n1. Access control modern                                      \n2. Dokumen aktifitas keluar masuk ruang server'),(127,8,'L3.8','Pemadam Kebakaran',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(128,8,'L3.9','Security Monitoring',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(129,8,'L3.10','Raised Floor dan cable management',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(130,8,'L3.11','Authentikasi User',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(131,8,'L3.12','Pengamanan Akses Wifi',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(132,8,'L3.13','Server Antivirus, Firewall dan IPS',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(133,8,'L3.14','Tools Monitoring ',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(134,8,'L3.15','Tools TroubleShooting',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(135,8,'L3.16','Ketersediaan LAN dalam satu semester',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL),(136,8,'L3.17','Training dan SK Key User',NULL,0.06,'Fire Fighting (menunggu & memadamkan kebakaran)',NULL,'Stabilizing (Bertindak sebatas merespon kebakaran)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL,'Optimizing (Adanya usaha optimasi sumberdaya & improvement)',NULL,'Excellence (Mencapai keunggulan optimasi sumberdaya & continuous improvement)',NULL);
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
-- Table structure for table `upload_log`
--

DROP TABLE IF EXISTS `upload_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `directory` varchar(100) DEFAULT NULL,
  `yearperiod` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `ml_subarea` varchar(30) DEFAULT NULL,
  `kpi_subarea` varchar(30) DEFAULT NULL,
  `level_id` int(11) DEFAULT NULL,
  `filepath` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_log`
--

LOCK TABLES `upload_log` WRITE;
/*!40000 ALTER TABLE `upload_log` DISABLE KEYS */;
INSERT INTO `upload_log` VALUES (27,'2020-07-21 12:16:24',1,'desktop.ini','D:\\Upload\\2020\\L3\\L3.1',2020,1,'L3.1',NULL,1,'D:\\Upload\\2020\\L3\\L3.1\\desktop.ini'),(28,'2020-07-22 12:12:15',1,'INV19090002.pdf','D:\\Upload\\2020\\L3\\L3.1',2020,1,'L3.1',NULL,1,'D:\\Upload\\2020\\L3\\L3.1\\INV19090002.pdf'),(29,'2020-07-28 13:06:54',1,'test.jpg','D:\\Upload\\2020\\L3\\L3.2',2020,1,'L3.2',NULL,2,'D:\\Upload\\2020\\L3\\L3.2\\test.jpg'),(30,'2020-07-28 13:56:18',1,'test.jpg','D:\\Upload\\2020\\L3\\L3.1',2020,1,'L3.1',NULL,1,'D:\\Upload\\2020\\L3\\L3.1\\test.jpg');
/*!40000 ALTER TABLE `upload_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','admin',0),(2,'fmanda','fmanda','Febrian Manda',1),(3,'arkan','arkan','Arkan',4),(6,'test','a','tes',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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

-- Dump completed on 2020-07-29 18:40:38
