CREATE DATABASE  IF NOT EXISTS `onlinestore6` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `onlinestore6`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: onlinestore6
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'us','us123','us@gmail.com','ujjwal');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `Cart_ID` int NOT NULL AUTO_INCREMENT,
  `Quantity` int DEFAULT '0',
  `Customer_ID` int DEFAULT NULL,
  `Product_ID` int DEFAULT NULL,
  PRIMARY KEY (`Cart_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Product_ID` (`Product_ID`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,2,1,1),(2,1,2,3),(3,3,3,5),(4,2,4,6),(5,1,5,9),(6,2,1,2),(7,1,2,4),(8,3,3,7),(9,2,4,8),(10,1,5,10);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(80) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Grocery'),(2,'Personal Care'),(3,'Home Appliances'),(4,'Electronics'),(5,'Clothing'),(6,'Footwear'),(7,'Furniture'),(8,'Books'),(9,'Toys'),(10,'Stationery');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `middle_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Rohit','Kumar','Sharma','rohit@example.com','password1','Flat No. 201, Ram Nagar','919876543210','2023-04-24 23:56:56'),(2,'Priya','Singh','Yadav','priya@example.com','password2','B-302, Shanti Niketan','918765432109','2023-04-24 23:56:56'),(3,'Vikas','Gupta','Mishra','vikas@example.com','password3','D-101, Raj Nagar Extension','917654321098','2023-04-24 23:56:56'),(4,'Sneha','Raj','Srivastava','sneha@example.com','password4','C-203, Gomti Nagar','916543210987','2023-04-24 23:56:56'),(5,'Amit','Kumar','Dubey','amit@example.com','password5','Flat No. 501, Vibhuti Khand','915432109876','2023-04-24 23:56:56'),(6,'Shweta','Singh','Chauhan','shweta@example.com','password6','B-704, Indirapuram','914321098765','2023-04-24 23:56:56'),(7,'Rajat','Verma','Trivedi','rajat@example.com','password7','Flat No. 302, Sector-12','913210987654','2023-04-24 23:56:56'),(8,'Shubham','Singh','Bisht','shubham@example.com','password8','A-502, Crossing Republik','912109876543','2023-04-24 23:56:56'),(9,'Divya','Raj','Mishra','divya@example.com','password9','C-101, Rajajipuram','911098765432','2023-04-24 23:56:56'),(10,'Ankit','Kumar','Verma','ankit@example.com','password10','Flat No. 402, Aliganj','910987654321','2023-04-24 23:56:56'),(11,'khwaish','','Rupani','khwaish@gmail.com','khwaish123','GH IIITD','9873214560','2023-04-24 23:56:56'),(12,'aamir','','khan','aamir@gmail.com','aamir123','Turkey','9871234560','2023-04-24 23:56:56');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_placed`
--

DROP TABLE IF EXISTS `order_placed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_placed` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `order_status` enum('Pending','Shipped','Delivered') NOT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_placed_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `order_placed_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_placed`
--

LOCK TABLES `order_placed` WRITE;
/*!40000 ALTER TABLE `order_placed` DISABLE KEYS */;
INSERT INTO `order_placed` VALUES (1,2000.00,'Delivered','2023-04-24 23:56:56',1,1),(2,1500.00,'Shipped','2023-04-24 23:56:56',2,3),(3,3000.00,'Pending','2023-04-24 23:56:56',3,5),(4,2500.00,'Shipped','2023-04-24 23:56:56',4,6),(5,4000.00,'Delivered','2023-04-24 23:56:56',5,9),(6,1000.00,'Delivered','2023-04-24 23:56:56',1,2),(7,800.00,'Shipped','2023-04-24 23:56:56',2,4),(8,6000.00,'Pending','2023-04-24 23:56:56',3,7),(9,3500.00,'Shipped','2023-04-24 23:56:56',4,8),(10,5000.00,'Delivered','2023-04-24 23:56:56',5,10);
/*!40000 ALTER TABLE `order_placed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdate`
--

DROP TABLE IF EXISTS `orderdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdate` (
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  KEY `customer_id` (`customer_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `orderdate_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `orderdate_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order_placed` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdate`
--

LOCK TABLES `orderdate` WRITE;
/*!40000 ALTER TABLE `orderdate` DISABLE KEYS */;
INSERT INTO `orderdate` VALUES ('2023-04-24 23:56:56',1,1),('2023-04-24 23:56:56',2,2),('2023-04-24 23:56:56',3,3),('2023-04-24 23:56:56',4,4),('2023-04-24 23:56:56',5,5),('2023-04-24 23:56:56',1,6),('2023-04-24 23:56:56',2,7),('2023-04-24 23:56:56',3,8),('2023-04-24 23:56:56',4,9),('2023-04-24 23:56:56',5,10);
/*!40000 ALTER TABLE `orderdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_id` int NOT NULL,
  `payment_method` enum('UPI','COD') DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `customer_id` (`customer_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order_placed` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,1,'UPI'),(2,2,2,'COD'),(3,3,3,'UPI'),(4,4,4,'COD'),(5,5,5,'UPI'),(6,1,6,'COD'),(7,2,7,'UPI'),(8,3,8,'COD'),(9,4,9,'UPI'),(10,5,10,'COD');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `category_id` int NOT NULL,
  `MRP` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `brand` varchar(50) DEFAULT 'generic',
  `discount` decimal(10,2) DEFAULT '0.00',
  `mfg_date` int DEFAULT NULL,
  `mfg_month` int DEFAULT NULL,
  `mfg_year` int DEFAULT NULL,
  `expiry_date` int DEFAULT NULL,
  `expiry_weeks` int DEFAULT NULL,
  `expiry_months` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Amul Butter',1,50.00,100,'Amul',0.00,1,4,2023,1,12,24),(2,'Patanjali Toothpaste',2,30.00,200,'Patanjali',5.00,1,5,2023,1,12,24),(3,'Philips Iron',3,1500.00,50,'Philips',10.00,1,6,2023,1,12,24),(4,'LG Refrigerator',3,20000.00,10,'LG',5.00,1,7,2023,1,12,24),(5,'Samsung LED TV',4,50000.00,5,'Samsung',8.00,1,3,2023,1,12,24),(6,'Puma T-Shirt',5,500.00,50,'Puma',15.00,1,4,2023,1,12,24),(7,'Adidas Running Shoes',6,2000.00,20,'Adidas',10.00,1,8,2023,1,12,24),(8,'Nilkamal Plastic Chair',7,500.00,100,'Nilkamal',0.00,1,9,2023,1,12,24),(9,'The Alchemist Book',8,250.00,30,'HarperCollins',5.00,1,2,2023,1,12,24),(10,'Lego Building Blocks',9,1000.00,10,'Lego',0.00,1,11,2023,1,12,24),(11,'Product A',1,10.50,100,'Brand X',0.00,1,1,2022,1,12,6),(12,'Product B',2,25.00,50,'Brand Y',5.00,15,4,2021,31,6,3),(13,'Product C',3,8.99,200,'Brand Z',2.50,1,2,2023,30,8,4);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `Review_ID` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `Text` text,
  `Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Review_ID`),
  KEY `product_id` (`product_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,1,'This product is great!','2023-04-24 18:26:56'),(2,3,2,'Average product, nothing special.','2023-04-24 18:26:56'),(3,5,3,'I am very disappointed with the quality.','2023-04-24 18:26:56'),(4,6,4,'The product is good, but the delivery was late.','2023-04-24 18:26:56'),(5,9,5,'I am very satisfied with the product.','2023-04-24 18:26:56'),(6,2,1,'Excellent product, highly recommended!','2023-04-24 18:26:56'),(7,4,2,'The product is good but overpriced.','2023-04-24 18:26:56'),(8,7,3,'This product is not as described.','2023-04-24 18:26:56'),(9,8,4,'The quality is good, but the packaging was poor.','2023-04-24 18:26:56'),(10,10,5,'The product was damaged during delivery.','2023-04-24 18:26:56');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-24 23:59:23
