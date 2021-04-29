CREATE DATABASE  IF NOT EXISTS `shabu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shabu`;
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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `cus_id` int NOT NULL AUTO_INCREMENT,
  `cus_fname` varchar(255) DEFAULT NULL,
  `cus_lname` varchar(255) DEFAULT NULL,
  `point` int NOT NULL,
  PRIMARY KEY (`cus_id`),
  UNIQUE KEY `cus_id_UNIQUE` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (101,'สมสุข','สวัสดี',0),(102,'ธนา','งบน้อย',2),(103,'กินดี','อยู่งาม',1),(104,'สมภาร','นึงนิด',0),(105,'พีรพล','อุ่นใจ',0),(106,'กุ๊งกิ๊ง','มีนะ',0),(107,'สมหมาย','งามแท้',5),(108,'พล','นิยม',3),(109,'สมจิต','จงใจดู',2),(110,'ยลใจ','อิ่มดี',5),(111,'ใหม่','พึ่งมา',1);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_account`
--

DROP TABLE IF EXISTS `day_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `day_account` (
  `acc_id` int NOT NULL AUTO_INCREMENT,
  `acc_date` date NOT NULL,
  `sale_income` float(8,2) DEFAULT NULL,
  `mats_expense` float(8,2) DEFAULT NULL,
  `tip` int DEFAULT NULL,
  `balance` float(8,2) DEFAULT NULL,
  PRIMARY KEY (`acc_id`),
  UNIQUE KEY `acc_id_UNIQUE` (`acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_account`
--

LOCK TABLES `day_account` WRITE;
/*!40000 ALTER TABLE `day_account` DISABLE KEYS */;
INSERT INTO `day_account` VALUES (1,'2021-04-16',213.00,174.00,0,39.00),(2,'2021-04-17',212.00,170.00,10,52.00),(3,'2021-04-18',557.00,442.00,3,118.00),(4,'2021-04-19',863.00,548.00,30,345.00),(5,'2021-04-20',318.00,261.00,0,57.00),(6,'2021-04-21',965.00,770.00,20,215.00),(7,'2021-04-22',345.00,287.00,15,73.00),(8,'2021-04-23',332.00,265.00,5,72.00),(9,'2021-04-24',268.00,205.00,0,63.00);
/*!40000 ALTER TABLE `day_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_details`
--

DROP TABLE IF EXISTS `day_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `day_details` (
  `emp_id` int NOT NULL,
  `acc_id` int NOT NULL,
  PRIMARY KEY (`emp_id`,`acc_id`),
  UNIQUE KEY `emp_id_UNIQUE` (`emp_id`),
  UNIQUE KEY `acc_id_UNIQUE` (`acc_id`),
  CONSTRAINT `day_details.day_account.acc_id.fk1.` FOREIGN KEY (`acc_id`) REFERENCES `day_account` (`acc_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `day_details.employees.emp_id.fk3` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_details`
--

LOCK TABLES `day_details` WRITE;
/*!40000 ALTER TABLE `day_details` DISABLE KEYS */;
INSERT INTO `day_details` VALUES (1,1),(2,4),(3,2),(4,5),(5,3),(6,8),(7,9),(8,7),(9,6);
/*!40000 ALTER TABLE `day_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_id_UNIQUE` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'อำนวย','สำราญ','manager',NULL),(2,'อิสรา','ดีมาก','employee',NULL),(3,'พอดี','พี่งพิง','chief',NULL),(4,'สิตางค์','ใบบัว','employee',NULL),(5,'มานะ','ละมุน','employee',NULL),(6,'อิงฟ้า','มาเช้า','employee',NULL),(7,'ศรีทอง','จำดี','employee',NULL),(8,'หทัยชนก','กลิ่นหวาน','employee',NULL),(9,'สมปอง','ปกป้อง','employee',NULL),(10,'สมหมาย','งามแท้','employee',NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `comment` mediumtext,
  `date` date DEFAULT NULL,
  `cus_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `record_id_UNIQUE` (`record_id`),
  KEY `feedback.customer.cus_id.fk2_idx` (`cus_id`),
  CONSTRAINT `feedback.customer.cus_id.fk2` FOREIGN KEY (`cus_id`) REFERENCES `customer` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,'ใหม่','น่าทานจังเลย','2021-04-29',111),(2,'พล','เนื้อนุ่มดี','2021-04-29',108);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials` (
  `mats_id` int NOT NULL AUTO_INCREMENT,
  `mats_name` varchar(255) DEFAULT NULL,
  `mats_left` float(8,2) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  PRIMARY KEY (`mats_id`),
  UNIQUE KEY `mats_id_UNIQUE` (`mats_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'เบค่อน',20.00,17.00),(2,'เนื้อสัน',4.00,30.00),(3,'หอยเชลล์',2.00,35.00),(4,'หมูสามชั้น',5.00,43.00),(5,'ผักบุ้ง',2.00,10.00),(6,'เนื้อลาย',3.00,27.00);
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sale_price` float(8,2) DEFAULT NULL,
  `mats_cost` float(8,2) DEFAULT NULL,
  `description` mediumtext,
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_id_UNIQUE` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'เบค่อน',NULL,20.00,17.00,NULL),(2,'เนื้อสันคอ',NULL,39.00,30.00,NULL),(3,'หอยเชลล์',NULL,43.00,35.00,NULL),(4,'หมูสามชั้น',NULL,50.00,43.00,NULL),(5,'ผักบุ้ง',NULL,15.00,10.00,NULL),(6,'เนื้อลาย',NULL,35.00,27.00,NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `month_account`
--

DROP TABLE IF EXISTS `month_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `month_account` (
  `acc_id` int NOT NULL AUTO_INCREMENT,
  `acc_month` int NOT NULL,
  `amount_exp` float(8,2) DEFAULT NULL,
  `title_exp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`acc_id`),
  UNIQUE KEY `acc_id_UNIQUE` (`acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `month_account`
--

LOCK TABLES `month_account` WRITE;
/*!40000 ALTER TABLE `month_account` DISABLE KEYS */;
INSERT INTO `month_account` VALUES (1,4,4073.00,'รายได้คงเหลือประจำเดือน');
/*!40000 ALTER TABLE `month_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `month_details`
--

DROP TABLE IF EXISTS `month_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `month_details` (
  `emp_id` int NOT NULL,
  `acc_id` int NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`emp_id`,`acc_id`),
  UNIQUE KEY `emp_id_UNIQUE` (`emp_id`),
  UNIQUE KEY `acc_id_UNIQUE` (`acc_id`),
  CONSTRAINT `month_details.employees.emp_id.fk2` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `month_details.month_account.acc_id.fk1` FOREIGN KEY (`acc_id`) REFERENCES `month_account` (`acc_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `month_details`
--

LOCK TABLES `month_details` WRITE;
/*!40000 ALTER TABLE `month_details` DISABLE KEYS */;
INSERT INTO `month_details` VALUES (1,1,'2021-04-29');
/*!40000 ALTER TABLE `month_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `item_no` int NOT NULL AUTO_INCREMENT,
  `unit` int DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `order_id` int NOT NULL,
  `mats_id` int NOT NULL,
  PRIMARY KEY (`item_no`),
  UNIQUE KEY `item_no_UNIQUE` (`item_no`),
  KEY `order.order_id_idx` (`order_id`),
  KEY `material.mats_id_idx` (`mats_id`),
  CONSTRAINT `order_details.material.mats_id.fk1` FOREIGN KEY (`mats_id`) REFERENCES `materials` (`mats_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_details.order.order_id.fk1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,50,17.00,1,1),(2,10,30.00,2,2),(3,20,43.00,3,3),(4,5,10.00,4,4),(5,5,35.00,5,5),(6,10,27.00,6,6);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `buy_date` date DEFAULT NULL,
  `total_price` float(8,2) DEFAULT NULL,
  `supplier_id` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `employees.emp_id_idx` (`employee_id`),
  KEY `supplier.sup_id_idx` (`supplier_id`),
  CONSTRAINT `orders.employees.emp_id.fk1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `orders.supplier.sup_id.fk1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`sup_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2021-04-15',850.00,1,1),(2,'2021-04-15',300.00,2,1),(3,'2021-04-15',860.00,3,1),(4,'2021-04-15',50.00,4,1),(5,'2021-04-15',175.00,5,1),(6,'2021-04-15',270.00,2,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `income` float(8,2) DEFAULT NULL,
  `emp_id` int NOT NULL,
  `cus_id` int NOT NULL,
  PRIMARY KEY (`sale_id`),
  UNIQUE KEY `sale_id_UNIQUE` (`sale_id`),
  KEY `employees.emp_id_idx` (`emp_id`),
  KEY `sales.customer.cus_id.fk1_idx` (`cus_id`),
  CONSTRAINT `sales.customer.cus_id.fk1` FOREIGN KEY (`cus_id`) REFERENCES `customer` (`cus_id`),
  CONSTRAINT `sales.employees.emp_id.fk2` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2021-04-16',213.00,2,102),(2,'2021-02-17',212.00,1,103),(3,'2021-04-18',302.00,4,107),(4,'2021-04-18',255.00,3,108),(5,'2021-04-19',315.00,5,102),(6,'2021-04-19',242.00,2,107),(7,'2021-04-19',306.00,6,108),(8,'2021-04-20',318.00,7,109),(9,'2021-04-21',432.00,9,110),(10,'2021-04-21',492.00,8,111),(11,'2021-04-22',145.00,9,102),(12,'2021-04-22',200.00,10,109),(13,'2021-04-23',117.00,10,108),(14,'2021-04-23',215.00,4,110),(15,'2021-04-24',268.00,6,110);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `sup_id` int NOT NULL AUTO_INCREMENT,
  `sup_name` varchar(255) DEFAULT NULL,
  `phone` char(10) NOT NULL,
  PRIMARY KEY (`sup_id`),
  UNIQUE KEY `sup_id_UNIQUE` (`sup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'เจ้าน้อยเบค่อน','0884576891'),(2,'บังเนื้อ','0842563198'),(3,'เจ้ศรีสามชั้น','0945784132'),(4,'ผักบุ้งจำกัด','0856472135'),(5,'นายฮ้อหอยเชลล์','0821547968');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-29 22:35:29
