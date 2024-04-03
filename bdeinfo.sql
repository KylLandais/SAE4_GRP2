-- MariaDB dump 10.19  Distrib 10.5.23-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mydatabase
-- ------------------------------------------------------
-- Server version	10.5.23-MariaDB-0+deb11u1
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Table structure for table `color`
--
DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `color`
--
LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */
;
INSERT INTO `color`
VALUES (1, 'rouge'),
  (2, 'bleu-marine');
/*!40000 ALTER TABLE `color` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `event`
--
DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `event`
--
LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */
;
INSERT INTO `event`
VALUES (
    11028701,
    'Marché de Noël',
    -1,
    '2023-12-21 18:30:00',
    'marche_de_noel.webp'
  ),
  (
    49469041,
    'Goûter de rentrée',
    0,
    '2023-09-04 16:00:00',
    'gouter_de_rentree.webp'
  ),
  (
    226517193,
    'Gourde ADIIL',
    -1,
    '2023-11-06 08:00:00',
    'gourde.webp'
  ),
  (
    239501416,
    'Nuit de l\'info',
    0,
    '2023-12-07 15:38:00',
    'ndli.webp'
  ),
  (
    341554572,
    'Menu Maxi',
    4.5,
    '2023-12-07 09:00:00',
    'menu_maxi.webp'
  ),
  (
    383910450,
    'Soirée Haloween',
    -1,
    '2023-10-27 17:30:00',
    'soiree_haloween.webp'
  );
/*!40000 ALTER TABLE `event` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `grade`
--
DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `grade` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `grade`
--
LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */
;
INSERT INTO `grade`
VALUES (0, 'Iron', 5),
  (1, 'Gold', 15),
  (2, 'Diamant', 25);
/*!40000 ALTER TABLE `grade` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `inscription`
--
DROP TABLE IF EXISTS `inscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `inscription` (
  `user` varchar(255) NOT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`user`, `event_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `inscription_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`email`),
  CONSTRAINT `inscription_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `inscription`
--
LOCK TABLES `inscription` WRITE;
/*!40000 ALTER TABLE `inscription` DISABLE KEYS */
;
INSERT INTO `inscription`
VALUES ('', 801547147),
  ('a', 239501416),
  ('Adrien Derache V2', 1089493169),
  ('AIT-LAHCEN ABDELADEM', 940575287),
  ('AIT-LAHCEN ABDELADEM', 1567685583),
  ('alex.lemoine.etu@univ-lemans.fr', 1946907562),
  ('Alexandre ANTONIO', 341554572),
  (
    'alexandre.grasteau.etu@univ-lemans.fr',
    485759472
  );
/*!40000 ALTER TABLE `inscription` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `product`
--
DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `release_date` datetime DEFAULT NULL,
  `expire_date` datetime DEFAULT NULL,
  `confirm_threashold` int(11) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `is_promoted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `product`
--
LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */
;
INSERT INTO `product`
VALUES (
    2,
    'Pull 2023-2024',
    27.5,
    'Le pull officiel du département informatique pour l\'année 2023-2024. Design par Mathéo Orgé.',
    'image-1706202613813.png',
    '2024-01-24 19:00:00',
    '2024-02-15 20:00:00',
    NULL,
    'bleu-marine',
    1
  ),
  (
    3,
    'Redbull',
    1,
    'Une canette de redbull de 25cl. Goût classic.',
    'image-1706120804285.png',
    '2024-01-24 19:00:00',
    '2024-06-30 23:59:00',
    NULL,
    NULL,
    0
  );
/*!40000 ALTER TABLE `product` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `product_color`
--
DROP TABLE IF EXISTS `product_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `product_color` (
  `product_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  KEY `color_id` (`color_id`),
  CONSTRAINT `product_color_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `product_color_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `color` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `product_color`
--
LOCK TABLES `product_color` WRITE;
/*!40000 ALTER TABLE `product_color` DISABLE KEYS */
;
INSERT INTO `product_color`
VALUES (2, 2);
/*!40000 ALTER TABLE `product_color` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `product_size`
--
DROP TABLE IF EXISTS `product_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `product_size` (
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_size_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `product_size`
--
LOCK TABLES `product_size` WRITE;
/*!40000 ALTER TABLE `product_size` DISABLE KEYS */
;
INSERT INTO `product_size`
VALUES (2, 's'),
  (2, 'xl'),
  (2, ' xxl'),
  (2, ' l'),
  (2, ' m');
/*!40000 ALTER TABLE `product_size` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `transaction`
--
DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `transaction` (
  `transaction_id` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `validated` tinyint(1) DEFAULT 0,
  `total_price` float DEFAULT NULL,
  `purchase_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`transaction_id`),
  KEY `email` (`email`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `transaction`
--
LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */
;
INSERT INTO `transaction`
VALUES (
    '02028300MP216124T',
    'John.Doe.Etu@univ-lemans.fr',
    1,
    NULL,
    '2024-01-21 22:38:18'
  );
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `transactionContent`
--
DROP TABLE IF EXISTS `transactionContent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `transactionContent` (
  `transaction_id` varchar(255) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `grade_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `item_price` float DEFAULT NULL,
  KEY `event_id` (`event_id`),
  KEY `grade_id` (`grade_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `transactionContent_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`),
  CONSTRAINT `transactionContent_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `transactionContent_ibfk_3` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`),
  CONSTRAINT `transactionContent_ibfk_4` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`),
  CONSTRAINT `transactionContent_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `transactionContent`
--
LOCK TABLES `transactionContent` WRITE;
/*!40000 ALTER TABLE `transactionContent` DISABLE KEYS */
;
INSERT INTO `transactionContent`
VALUES (
    '02028300MP216124T',
    NULL,
    NULL,
    2,
    'Pull 2023-2024(m)',
    27.5
  );
/*!40000 ALTER TABLE `transactionContent` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `user`
--
DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `user` (
  `email` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `xp` int(11) NOT NULL DEFAULT 0,
  `grade` int(11) DEFAULT NULL,
  `dc_username` varchar(40) DEFAULT NULL,
  `dc_id` varchar(40) DEFAULT NULL,
  `dc_pfp` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `grade` (`grade`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`grade`) REFERENCES `grade` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `user`
--
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */
;
INSERT INTO `user`
VALUES (
    'John.Doe.Etu@univ-lemans.fr',
    'johnDoe',
    '4236441508',
    '21B',
    220,
    0,
    'NULL',
    'NULL',
    'NULL'
  ),
(
    'admin@univ-lemans.fr',
    'admin',
    '92668751',
    'admin',
    0,
    0,
    'NULL',
    'NULL',
    'NULL'
  ),
  (
    'Todd Smith',
    'Todd Smith',
    NULL,
    NULL,
    0,
    NULL,
    NULL,
    NULL,
    NULL
  );
/*!40000 ALTER TABLE `user` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `usersToRenew`
--
DROP TABLE IF EXISTS `usersToRenew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!40101 SET character_set_client = utf8 */
;
CREATE TABLE `usersToRenew` (
  `user` varchar(255) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  PRIMARY KEY (`user`),
  KEY `grade` (`grade`),
  CONSTRAINT `usersToRenew_ibfk_1` FOREIGN KEY (`grade`) REFERENCES `grade` (`id`),
  CONSTRAINT `usersToRenew_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`email`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `usersToRenew`
--
LOCK TABLES `usersToRenew` WRITE;
/*!40000 ALTER TABLE `usersToRenew` DISABLE KEYS */
;
INSERT INTO `usersToRenew`
VALUES ('John.Doe.Etu@univ-lemans.fr', 2);
/*!40000 ALTER TABLE `usersToRenew` ENABLE KEYS */
;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2024-02-28  9:24:54