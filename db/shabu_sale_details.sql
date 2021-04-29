-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: shabu
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `sale_details`
--

DROP TABLE IF EXISTS `sale_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_details` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `unit` int DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `sale_id` int NOT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `sale_details.sales.sale_id.fk1_idx` (`sale_id`),
  KEY `sale_details.menu.menu_id.fk1_idx` (`menu_id`),
  CONSTRAINT `sale_details.menu.menu_id.fk1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`),
  CONSTRAINT `sale_details.sales.sale_id.fk1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_details`
--

LOCK TABLES `sale_details` WRITE;
/*!40000 ALTER TABLE `sale_details` DISABLE KEYS */;
INSERT INTO `sale_details` VALUES (1,5,20.00,1,1),(2,2,35.00,1,6),(3,1,43.00,1,3),(4,2,35.00,2,6),(5,3,20.00,2,1),(6,1,43.00,2,3),(7,1,39.00,2,2),(8,3,20.00,3,1),(9,2,43.00,3,3),(10,4,39.00,3,2),(11,5,39.00,4,2),(12,3,20.00,4,1),(13,4,15.00,5,5),(14,3,20.00,5,1),(15,5,39.00,5,2),(16,2,43.00,6,3),(17,4,39.00,6,2),(18,5,20.00,7,1),(19,6,20.00,7,1),(20,2,43.00,7,3),(21,6,43.00,8,3),(22,3,20.00,8,1),(23,3,50.00,9,4),(24,4,15.00,9,5),(25,2,43.00,9,3),(26,3,39.00,9,2),(27,3,20.00,9,1),(28,6,43.00,10,3),(29,6,39.00,10,2),(30,5,20.00,11,1),(31,3,15.00,11,5),(32,4,50.00,12,4),(33,3,39.00,13,2),(34,5,43.00,14,3),(35,5,20.00,15,1),(36,6,15.00,15,5),(37,2,39.00,15,2);
/*!40000 ALTER TABLE `sale_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-29 22:10:35
