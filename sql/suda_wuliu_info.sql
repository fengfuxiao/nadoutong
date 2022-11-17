-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: localhost    Database: suda
-- ------------------------------------------------------
-- Server version	5.7.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wuliu_info`
--

DROP TABLE IF EXISTS `wuliu_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wuliu_info` (
  `wi_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '物品id',
  `wi_number` varchar(45) NOT NULL COMMENT '运单单号',
  `wi_sender` varchar(45) DEFAULT NULL COMMENT '寄件人',
  `wi_sender_phone` varchar(45) DEFAULT NULL COMMENT '寄件人电话',
  `wi_sender_address` varchar(45) DEFAULT NULL COMMENT '寄件人地址',
  `wi_recipient` varchar(45) DEFAULT NULL COMMENT '收件人',
  `wi_recipient_phone` varchar(45) DEFAULT NULL COMMENT '收件人电话',
  `wi_recipient_address` varchar(45) DEFAULT NULL COMMENT '收件人地址',
  `wi_count` varchar(45) DEFAULT NULL COMMENT '数量',
  `wi_weight` varchar(45) DEFAULT NULL COMMENT '重量',
  `wi_description` varchar(45) DEFAULT NULL COMMENT '物品描述',
  `wi_starttime` varchar(45) DEFAULT NULL COMMENT '发货时间',
  `d_id` int(11) DEFAULT NULL COMMENT '配送员id',
  PRIMARY KEY (`wi_id`),
  UNIQUE KEY `wi_id_UNIQUE` (`wi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wuliu_info`
--

LOCK TABLES `wuliu_info` WRITE;
/*!40000 ALTER TABLE `wuliu_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `wuliu_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-12 14:14:59
