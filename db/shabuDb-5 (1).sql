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
  `point` int NOT NULL DEFAULT '0',
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`cus_id`),
  UNIQUE KEY `cus_id_UNIQUE` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (101,'สมสุข','สวัสดี',0,NULL),(102,'ธนา','งบน้อย',2,NULL),(103,'กินดี','อยู่งาม',1,NULL),(104,'สมภาร','นึงนิด',0,NULL),(105,'พีรพล','อุ่นใจ',0,NULL),(106,'กุ๊งกิ๊ง','มีนะ',0,NULL),(107,'สมหมาย','งามแท้',5,NULL),(108,'พล','นิยม',3,NULL),(109,'สมจิต','จงใจดู',2,NULL),(110,'ยลใจ','อิ่มดี',5,NULL),(111,'ใหม่','พึ่งมา',1,NULL),(112,'kball','kjaja',0,NULL),(113,'super','admin',0,NULL),(115,'kball','kjaja',0,7),(116,'kball','kjaja',0,8),(117,'kball','kjaja',0,NULL),(118,'asdasd','kjajasdasd',0,12),(119,'kball','kjaja',0,13),(120,'kball','kjaja',0,14);
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
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_id_UNIQUE` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (2,'อิสรา','ดีมาก','cashier',14000,'isra@mail.com','0641872935'),(3,'พอดี','พี่งพิง','chief',16000,'pordee@mail.com','0412857963'),(4,'สิตางค์','ใบบัว','employee',15000,'sitang@mail.com','0578213965'),(5,'มานะ','ละมุน','employee',15000,'mana@mail.com','0359871245'),(6,'อิงฟ้า','มาเช้า','employee',15000,'ingfah@mail.com','0954782632'),(7,'ศรีทอง','จำดี','employee',15000,'sritong@mail.com','0845976325'),(8,'หทัยชนก','กลิ่นหวาน','employee',15000,'hatai@mail.com','0954786254'),(9,'สมปอง','ปกป้อง','employee',15000,'sompong@mail.com','0845963721'),(10,'สมหมาย','งามแท้','employee',15000,'sommhai@mail.com','0120050470');
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
  `cus_id` int DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `record_id_UNIQUE` (`record_id`),
  KEY `feedback.customer.cus_id.fk2_idx` (`cus_id`),
  CONSTRAINT `feedback.customer.cus_id.fk2` FOREIGN KEY (`cus_id`) REFERENCES `customer` (`cus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,'ใหม่','น่าทานจังเลย','2021-04-29',111),(2,'พล','เนื้อนุ่มดี','2021-04-29',108),(8,NULL,NULL,'2021-04-05',NULL),(9,NULL,NULL,'2021-04-05',NULL),(10,NULL,NULL,'2021-04-05',NULL),(11,'xxx','xxx','2021-04-05',NULL),(12,'adadad','adadad','2021-04-05',NULL),(13,'test','test','2021-04-05',NULL),(14,'asdasd','asdasdasdasd','2021-04-07',NULL),(15,'นายดำ','อร่อยมากๆ','2021-04-07',116),(16,'นายแดง','แย่สุดๆ','2021-04-07',116),(17,'นายเขียว','เวรี่กุ้ด','2021-04-07',116),(18,'jukasd','aroi','2021-04-07',NULL),(19,'asdasd','hola','2021-04-07',116);
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
  `status_menu` enum('Deleted','Stayed') DEFAULT 'Stayed',
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `menu_id_UNIQUE` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Beecon','https://foodsguy.com/wp-content/uploads/2020/08/Can-You-Freeze-Uncooked-Bacon.jpg',20.00,17.00,'เบค่อนนุ่มละมุน','Stayed'),(2,'เนื้อสันคอ','https://img.wongnai.com/p/1920x0/2019/05/06/23ac401d7bb54cd2a6015d5615c14289.jpg',39.00,30.00,'อร่อยมาก','Stayed'),(3,'หอยเชลล์','https://www.thammachartseafood.com/media/catalog/product/cache/2/image/1500x1500/6dcdb3bec3b7d3d8fa2d31ce95a0090e/f/r/frozen_us_scallops_2-min.jpg',43.00,35.00,'หอยสดๆ','Stayed'),(4,'หมูสามชั้น','https://f.ptcdn.info/379/049/000/olo4nbziuotStJAF89A-o.jpg',50.00,43.00,'หมูเด้งสู้ฟัน','Stayed'),(5,'ผักบุ้ง','https://cfcdn2.azsg.opensnap.com/azsg/snapphoto/photo/LL/H2GM/3DDI5K847601F48E6091E7lv.jpg',15.00,10.00,'กรอบฟันแทบแตก','Stayed'),(6,'เนื้อลาย','https://kaizensushi.ketshopweb.com/upload-img/Kaizen_Sushi&hibachi/11_Shabu/10_%E0%B9%80%E0%B8%99%E0%B8%B7%E0%B9%89%E0%B8%AD%E0%B8%99%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%A5%E0%B8%B2%E0%B8%A2_100_%E0%B8%81%E0%B8%A3%E0%B8%B1%E0%B8%A1_117_baht.png',35.00,27.00,NULL,'Stayed'),(9,'pizza2','https://assets.bonappetit.com/photos/597f6564e85ce178131a6475/master/w_1200,c_limit/0817-murray-mancini-dried-tomato-pie.jpg',500.00,10.00,'asdads','Deleted'),(10,'burger','https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/221598/1608102785_81663',500.00,250.00,'asdasd','Deleted');
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
  `mats_id` int DEFAULT NULL,
  PRIMARY KEY (`item_no`),
  UNIQUE KEY `item_no_UNIQUE` (`item_no`),
  KEY `order.order_id_idx` (`order_id`),
  KEY `material.mats_id_idx` (`mats_id`),
  CONSTRAINT `order_details.material.mats_id.fk1` FOREIGN KEY (`mats_id`) REFERENCES `materials` (`mats_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order_details.order.order_id.fk1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,50,17.00,1,1),(2,10,30.00,2,2),(3,20,43.00,3,3),(4,5,10.00,4,4),(5,5,35.00,5,5),(6,10,27.00,6,6),(7,39,440.00,7,NULL),(9,45,60.00,9,NULL);
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
  `employee_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `employees.emp_id_idx` (`employee_id`),
  KEY `supplier.sup_id_idx` (`supplier_id`),
  CONSTRAINT `orders.employees.emp_id.fk1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `orders.supplier.sup_id.fk1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`sup_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2021-04-15',850.00,1,1),(2,'2021-04-15',300.00,2,1),(3,'2021-04-15',860.00,3,1),(4,'2021-04-15',50.00,4,1),(5,'2021-04-15',175.00,5,1),(6,'2021-04-15',270.00,2,1),(7,'2021-05-17',17160.00,4,NULL),(9,'2021-05-27',2700.00,3,NULL);
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
  `menu_id` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `sale_details.sales.sale_id.fk1_idx` (`sale_id`),
  KEY `sale_details.menu.menu_id.fk1_idx` (`menu_id`),
  CONSTRAINT `sale_details.menu.menu_id.fk1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON DELETE SET NULL,
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
  `status` enum('Pending','Waiting','Finished','Received') DEFAULT 'Pending',
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
INSERT INTO `sales` VALUES (1,'2021-04-16',213.00,2,102,'Pending'),(2,'2021-02-17',212.00,1,103,'Pending'),(3,'2021-04-18',302.00,4,107,'Pending'),(4,'2021-04-18',255.00,3,108,'Pending'),(5,'2021-04-19',315.00,5,102,'Pending'),(6,'2021-04-19',242.00,2,107,'Pending'),(7,'2021-04-19',306.00,6,108,'Pending'),(8,'2021-04-20',318.00,7,109,'Pending'),(9,'2021-04-21',432.00,9,110,'Pending'),(10,'2021-04-21',492.00,8,111,'Pending'),(11,'2021-04-22',145.00,9,102,'Pending'),(12,'2021-04-22',200.00,10,109,'Pending'),(13,'2021-04-23',117.00,10,108,'Pending'),(14,'2021-04-23',215.00,4,110,'Pending'),(15,'2021-04-24',268.00,6,110,'Pending');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'เจ้าน้อยเบค่อน','0884576891'),(2,'บังเนื้อ','0842563198'),(3,'เจ้ศรีสามชั้น','0945784132'),(4,'ผักบุ้งจำกัด','0856472135'),(5,'นายฮ้อหอยเชลล์','0821547968');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_UN` (`token`),
  KEY `token_FK` (`user_id`),
  CONSTRAINT `token_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,6,'!rheVWGaiPiYzUxl-YqXnWJ!A=EjfpCN-TnQhefweiwrCdNHF8$b*GIJGPJfy^bPl2@$qDHVLozxV84H3!$XwhxT2oj*J0LJl8ui'),(2,1,'4hgi=3fDxh1J7k-5Kl@N*=htTe3oN@G!$wjhJ1lYWEZSKj=Cm$i348mi&Mjebt^$uKxNqqmV6wXdpRUiOwgglTRSlK!nj36-51gm'),(3,12,'y0/i5cS8Q3Vdm0UH4xxI*6FwyQhMo-&95LckJ27WIuLV9XfcCPohirEnyV$Uf3bVXJNzzoonjL@AAOp$CKmhxd5BT1x17j$dnA*z'),(4,13,'sOw$Xbr5*IN45Qh2/y9LzhzN6YRj7Obpx$rSOO/KqyyiKJibi1ub8AFoqWRoT6IPA4XCB42D5/5aE7$VIO&r$LCbQio4z@RnrGIg'),(5,8,'Tf-NtCGZipOzBStlj-m$u7YmHNyhNDWOPCL$iG1cby0T!pZRrRKJYv9=5H5CLaeUgVa4*^oID25-mqCZBqpU06cNY4j0/*W9dauc'),(6,14,'$hS8z7Z&xgt8PH/QnyKZ5Ekkb5qfLm=RR!xv4-TSC06y$Bpzj!OY!VfAladlXBuI60mky5$HH@SzUe6bWX11MG$5vA^/DzBnz7b5');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(10) DEFAULT NULL,
  `join_date` varchar(45) DEFAULT NULL,
  `role` varchar(10) DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ball9988','$2b$05$gl1ftrY8HKLMRN8k1zLhBeWbWAdy0YqrKw6F3yD9sevoiRg/7pnKu','kball','kjaja','k@gmail.com','0633419885',NULL,'customer'),(2,'ball9982','$2b$05$HNJ1cZKKXG5bEeITIRU/4OBReVUm/Is5WyiqrT706ah0ADhymgwSG','kball','kjaja','k@gmail.com','0633419885','2021-05-05 22:37:50','customer'),(3,'ball998222','$2b$05$A6.nzdrgAJ6PlVKRX1YkkuIr4nvWYIC0p2rB6Fdn0cARI38sanimO','kball','kjaja','k@gmail.com','0633419885','2021-05-05 22:41:15','customer'),(5,'ball99881','$2b$05$ZrBrP7rh2YDf/26dQ32/nOocCSu0mPUC3/lQNOv/RSevVlH9StErS','kball','kjaja','k@gmail.com','0633419885','2021-05-05 22:45:07','customer'),(6,'admin','$2b$05$sJmg5LVuXBs28InH.c7Z8ubkjkNAWexwpfzVhuHLyPetgsDCBUsJa','super','admin','k@gmail.com','0633419885','2021-05-06 01:18:04','admin'),(7,'azset','$2b$05$aG4Jh5rPniFbVKbprgIuX.D2gZfJlSXotkWCjKLvU6Swz1udsekru','kball','kjaja','k@gmail.com','0633419885','2021-05-06 03:53:28','customer'),(8,'newtest','$2b$05$7WgUi0arSklwFTxEFxO96Oczwhko8.6LPAWb45DBXF4/se5yPZL5y','kball','kjaja','k@gmail.com','0633419885','2021-05-06 03:54:31','customer'),(9,'holytest','$2b$05$8Vu9.uwhcbY80WF43xiWf.veArN3V2SDFCrX1GAua4d/CmHLsWUCq','kball','kjaja','k@gmail.com','0633419885','2021-05-06 04:18:39','customer'),(12,'heetodlastone','$2b$05$mX.Frr3LvOdAZ2bEeJdO5.24plhl/PQhq8BuYifCA4QYXStZcXEvi','asdasd','kjajasdasd','k@gmail.com','0633419885','2021-05-06 04:45:26','customer'),(13,'kwaipete','$2b$05$H3W.4VbgP1b0/iWsdnn0bOhVE1eNvtj7IllkrFpWCEjKbOSir.Thu','kball','kjaja','k@gmail.com','0633419885','2021-05-06 04:48:46','customer'),(14,'superadmin','$2b$05$40HGLQwBa9.zyl//il0YrOQR1.dJ9XijHMZVhBfXzyetqjNrD9NaK','kball','kjaja','k@gmail.com','0633419885','2021-05-07 05:08:27','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'shabu'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-07  9:32:27
