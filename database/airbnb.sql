CREATE DATABASE  IF NOT EXISTS `airbnb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `airbnb`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: airbnb
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `property_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_property_favourites_property_user_idx` (`property_id`),
  KEY `fk_user_property_favourites_user_property_idx` (`user_id`),
  CONSTRAINT `fk_user_property_favourites_property_user` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`),
  CONSTRAINT `fk_user_property_favourites_user_property` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,12,1),(2,12,2),(3,12,3),(4,12,4),(5,12,5),(6,12,6),(12,13,1),(13,13,2);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message_text` varchar(255) DEFAULT NULL,
  `timestamp` date DEFAULT NULL,
  `property_id` bigint DEFAULT NULL,
  `receiver_id` bigint DEFAULT NULL,
  `sender_id` bigint DEFAULT NULL,
  `next_message_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKe0jls8qfy50gvtwee3egcypv` (`property_id`),
  KEY `FK86f0kc2mt26ifwupnivu6v8oa` (`receiver_id`),
  KEY `FKcnj2qaf5yc36v2f90jw2ipl9b` (`sender_id`),
  KEY `FKmvnc79e0jaqmiuyls52eoxb34` (`next_message_id`),
  CONSTRAINT `FK86f0kc2mt26ifwupnivu6v8oa` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKcnj2qaf5yc36v2f90jw2ipl9b` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKe0jls8qfy50gvtwee3egcypv` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`),
  CONSTRAINT `FKmvnc79e0jaqmiuyls52eoxb34` FOREIGN KEY (`next_message_id`) REFERENCES `message` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'Hola Carlos, ¿está disponible la semana próxima?','2025-04-09',1,1,2,52),(2,'¿Aceptan mascotas en la cabaña?','2025-04-09',2,1,2,53),(3,'¿Tiene cochera el loft?','2025-04-09',3,1,2,54),(4,'¿Puedo hacer check-in después de las 22h?','2025-04-09',4,1,2,56),(5,'¿La zona es segura por la noche?','2025-04-09',5,1,2,49),(49,'no','2025-04-13',5,2,1,61),(52,'no','2025-04-13',1,2,1,57),(53,'si','2025-04-13',2,2,1,58),(54,'si','2025-04-13',3,2,1,59),(56,'no','2025-04-13',4,2,1,60),(57,'genial, gracias','2025-04-13',1,1,2,65),(58,'genial, gracias','2025-04-13',2,1,2,68),(59,'genial, gracias','2025-04-13',3,1,2,NULL),(60,'genial, gracias','2025-04-13',4,1,2,NULL),(61,'genial, gracias','2025-04-13',5,1,2,66),(65,'Volve pronto!','2025-04-13',1,2,1,NULL),(66,'Cualquier cosa consulta!','2025-04-13',5,2,1,NULL),(67,'Nos vemos pronto!','2025-04-13',2,3,1,NULL),(68,'Me alegra poder ayudarte','2025-04-13',2,2,1,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `max_guests` int DEFAULT NULL,
  `price_per_night` double DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `host_id` bigint DEFAULT NULL,
  `rating` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKef6rf7039ccio3ht2ylr7ytr0` (`host_id`),
  CONSTRAINT `FKef6rf7039ccio3ht2ylr7ytr0` FOREIGN KEY (`host_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (1,'2025-04-09','Cómodo para 2 personas','Buenos Aires, Argentina',2,100,'Casa de Campo en Palermo',1,3.8),(2,'2025-04-09','Vista al lago y chimenea','Bariloche, Argentina',4,180,'Cabaña en Bariloche',3,3.75),(3,'2025-04-09','Ideal para escapadas de fin de semana','Mendoza, Argentina',2,90,'Departamento en Mendoza',1,2.9),(4,'2025-04-09','Amplia casa con jardín','Córdoba, Argentina',5,150,'Cabaña  en Córdoba',3,4.8),(5,'2025-04-09','Pequeño pero acogedor','Salta, Argentina',2,75,'Departmento en Salta',1,4.7),(6,'2025-04-09','Ideal para escapadas de fin de semana','Lujan, Argentina',1,200,'Mansion en Lujan',3,4.9),(7,'2025-04-09','En pleno campo verde','Pilar, Argentina',4,400,'Casa particular en Pilar',1,4.1),(8,'2025-04-09','Vista al lago y chimenea','Pilar, Argentina',2,500,'Casa particular en Pilar',3,4.7),(9,'2025-04-09','Cómodo para 3 personas','Colonia Sacramento, Uruguay',3,460,'Mansion en Sacramento',1,2.7),(10,'2025-04-09','Ideal para escapadas de fin de semana','San Justo, Argentina',6,960,'Mansion en San Justo',3,1.9),(11,'2025-04-09','En pleno campo verde','Exaltacion Cruz, Argentina',3,490,'Casa de campo en Exaltacion Cruz',1,2.9),(12,'2025-04-09','Cómodo para 2 personas','Exaltacion Cruz, Argentina',6,800,'Departamento Exaltacion Cruz',3,4.8);
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_image`
--

DROP TABLE IF EXISTS `property_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `uploaded_at` date DEFAULT NULL,
  `property_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8myddv2ina4svuo189ju03v9o` (`property_id`),
  CONSTRAINT `FK8myddv2ina4svuo189ju03v9o` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_image`
--

LOCK TABLES `property_image` WRITE;
/*!40000 ALTER TABLE `property_image` DISABLE KEYS */;
INSERT INTO `property_image` VALUES (1,'argentina-1.jpeg','2025-04-09',1),(2,'argentina-2.jpeg','2025-04-09',2),(3,'argentina-3.jpeg','2025-04-09',3),(4,'argentina-4.jpeg','2025-04-09',4),(5,'argentina-5.jpeg','2025-04-09',5),(6,'argentina-6.jpeg','2025-04-09',6),(7,'argentina-7.jpeg','2025-04-09',7),(8,'argentina-8.jpeg','2025-04-09',8),(9,'argentina-9.jpeg','2025-04-09',9),(10,'argentina-10.jpeg','2025-04-09',10),(11,'argentina-11.jpeg','2025-04-09',11),(12,'argentina-12.jpeg','2025-04-09',12),(13,'argentina-1-1.jpeg','2025-04-09',1),(14,'argentina-1-2.jpeg','2025-04-09',1),(15,'argentina-1-3.jpeg','2025-04-09',1),(16,'argentina-1-4.jpeg','2025-04-09',1),(17,'argentina-2-1.jpeg','2025-04-09',2),(18,'argentina-2-2.jpeg','2025-04-09',2),(19,'argentina-2-3.jpeg','2025-04-09',2),(20,'argentina-2-4.jpeg','2025-04-09',2),(21,'argentina-3-1.jpeg','2025-04-09',3),(22,'argentina-3-2.jpeg','2025-04-09',3),(23,'argentina-3-3.jpeg','2025-04-09',3),(24,'argentina-3-4.jpeg','2025-04-09',3),(25,'argentina-4-1.jpeg','2025-04-09',4),(26,'argentina-4-2.jpeg','2025-04-09',4),(27,'argentina-4-3.jpeg','2025-04-09',4),(28,'argentina-4-4.jpeg','2025-04-09',4),(29,'argentina-5-1.jpeg','2025-04-09',5),(30,'argentina-5-2.jpeg','2025-04-09',5),(31,'argentina-5-3.jpeg','2025-04-09',5),(32,'argentina-5-4.jpeg','2025-04-09',5),(33,'argentina-6-1.jpeg','2025-04-09',6),(34,'argentina-6-2.jpeg','2025-04-09',6),(35,'argentina-6-3.jpeg','2025-04-09',6),(36,'argentina-6-4.jpeg','2025-04-09',6),(37,'argentina-7-1.jpeg','2025-04-09',7),(38,'argentina-7-2.jpeg','2025-04-09',7),(39,'argentina-7-3.jpeg','2025-04-09',7),(40,'argentina-7-4.jpeg','2025-04-09',7),(41,'argentina-8-1.jpeg','2025-04-09',8),(42,'argentina-8-2.jpeg','2025-04-09',8),(43,'argentina-8-3.jpeg','2025-04-09',8),(44,'argentina-8-4.jpeg','2025-04-09',8),(45,'argentina-9-1.jpeg','2025-04-09',9),(46,'argentina-9-2.jpeg','2025-04-09',9),(47,'argentina-9-3.jpeg','2025-04-09',9),(48,'argentina-9-4.jpeg','2025-04-09',9),(49,'argentina-10-1.jpeg','2025-04-09',10),(50,'argentina-10-2.jpeg','2025-04-09',10),(51,'argentina-10-3.jpeg','2025-04-09',10),(52,'argentina-10-4.jpeg','2025-04-09',10),(53,'argentina-11-1.jpeg','2025-04-09',11),(54,'argentina-11-2.jpeg','2025-04-09',11),(55,'argentina-11-3.jpeg','2025-04-09',11),(56,'argentina-11-4.jpeg','2025-04-09',11),(57,'argentina-12-1.jpeg','2025-04-09',12),(58,'argentina-12-2.jpeg','2025-04-09',12),(59,'argentina-12-3.jpeg','2025-04-09',12),(60,'argentina-12-4.jpeg','2025-04-09',12);
/*!40000 ALTER TABLE `property_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `status` enum('CANCELLED','CONFIRMED','PENDING') DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `guest_id` bigint DEFAULT NULL,
  `property_id` bigint DEFAULT NULL,
  `cantity_guests` int NOT NULL,
  `type_guest_id` bigint DEFAULT NULL,
  `method_pay` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKaa0dx3r0k84a9iqffl3me67xa` (`guest_id`),
  KEY `FKc1js26be8wn824r1uhmpfe7qk` (`property_id`),
  KEY `FK7ii2te2jpj92w4wr7tb047dns` (`type_guest_id`),
  CONSTRAINT `FK7ii2te2jpj92w4wr7tb047dns` FOREIGN KEY (`type_guest_id`) REFERENCES `type_guests` (`id`),
  CONSTRAINT `FKaa0dx3r0k84a9iqffl3me67xa` FOREIGN KEY (`guest_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKc1js26be8wn824r1uhmpfe7qk` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (2,'2025-04-09','2025-04-21','2025-04-14','CONFIRMED',1260,4,2,1,2,'Tarjeta Credito'),(3,'2025-04-09','2025-04-12','2025-04-10','CONFIRMED',180,5,3,1,3,'Tarjeta Credito'),(4,'2025-04-09','2025-05-04','2025-04-29','CANCELLED',750,2,4,1,4,'Tarjeta Credito'),(5,'2025-04-09','2025-04-18','2025-04-16','CONFIRMED',150,4,5,1,5,'Tarjeta Credito'),(6,'2025-04-11','2025-04-21','2025-04-16','CONFIRMED',275,1,2,1,6,'Tarjeta Credito'),(7,'2025-04-11','2025-04-21','2025-04-16','CANCELLED',100,2,3,1,7,'Tarjeta Credito'),(8,'2025-04-11','2025-04-21','2025-04-16','CONFIRMED',160,1,4,1,8,'Tarjeta Credito'),(9,'2025-04-11','2025-04-21','2025-04-16','CONFIRMED',400,4,5,1,9,'Tarjeta Credito'),(10,'2025-04-11','2025-04-21','2025-04-16','CANCELLED',480,2,3,1,10,'Tarjeta Credito'),(11,'2025-04-11','2025-04-18','2025-04-11','CONFIRMED',700,1,1,1,11,'Tarjeta Credito'),(12,'2025-04-11','2025-04-30','2025-04-25','CONFIRMED',500,1,1,1,12,'Tarjeta Credito'),(13,'2025-04-11','2025-05-03','2025-05-01','CONFIRMED',200,1,1,2,13,'Tarjeta Credito'),(14,'2025-04-11','2025-05-05','2025-05-04','CONFIRMED',100,1,1,1,14,'Tarjeta Credito'),(15,'2025-04-11','2025-05-07','2025-05-06','CONFIRMED',100,1,1,1,15,'Tarjeta Credito'),(16,'2025-04-12','2025-04-13','2025-04-12','CONFIRMED',180,1,2,4,16,'Tarjeta Credito'),(17,'2025-04-12','2025-05-09','2025-05-08','CONFIRMED',100,1,1,0,17,'Tarjeta Credito'),(18,'2025-04-12','2025-05-11','2025-05-10','CONFIRMED',100,1,1,0,18,'Tarjeta Credito'),(19,'2025-04-12','2025-05-13','2025-05-12','CONFIRMED',100,1,1,0,19,'Tarjeta Credito'),(20,'2025-04-12','2025-05-15','2025-05-14','CONFIRMED',100,1,1,0,20,'Tarjeta Credito'),(21,'2025-04-12','2025-05-17','2025-05-16','CONFIRMED',100,1,1,0,21,'Tarjeta Credito'),(22,'2025-04-13','2025-04-14','2025-04-13','CONFIRMED',800,1,12,0,22,'Tarjeta Credito');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `rating` double NOT NULL,
  `guest_id` bigint DEFAULT NULL,
  `property_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkdprhv0bus71rvfwhw2e7207t` (`guest_id`),
  KEY `FK4r8tpgi3hq2ldtvry1gh0vgo` (`property_id`),
  CONSTRAINT `FK4r8tpgi3hq2ldtvry1gh0vgo` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`),
  CONSTRAINT `FKkdprhv0bus71rvfwhw2e7207t` FOREIGN KEY (`guest_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'Excelente lugar y anfitrión muy amable.','2025-04-09',5,2,1),(2,'Muy lindo pero algo frío por las noches.','2025-04-09',4,4,2),(3,'Perfecto para desconectar un finde.','2025-04-09',5,5,3),(4,'Todo bien salvo por el WiFi.','2025-04-09',3,2,4),(5,'Agradable y tranquilo.','2025-04-09',4,4,5),(6,'Hermosa vista y entorno natural inmejorable.','2025-04-10',5,1,6),(7,'Un poco alejado del centro, pero tranquilo.','2025-04-10',4,3,7),(8,'No había agua caliente la primera noche.','2025-04-10',2,2,8),(9,'Perfecto para ir en pareja.','2025-04-10',5,4,9),(10,'Lo disfrutamos mucho, volveríamos sin dudas.','2025-04-10',5,5,10),(11,'El lugar estaba limpio y ordenado.','2025-04-10',4,1,11),(12,'Anfitrión muy atento y servicial.','2025-04-10',5,2,12),(13,'No cumplió con lo prometido en las fotos.','2025-04-10',2,3,1),(14,'Zona muy segura, ideal para familias.','2025-04-10',5,4,2),(15,'La calefacción no funcionaba bien.','2025-04-10',3,5,3),(16,'Cerca de todo y muy cómodo.','2025-04-10',5,1,4),(17,'Un poco ruidoso por la noche.','2025-04-10',3,2,5),(18,'Cabaña súper equipada y acogedora.','2025-04-10',5,3,6),(19,'Tuvimos problemas con el check-in.','2025-04-10',3,4,7),(20,'Ideal para unas vacaciones tranquilas.','2025-04-10',5,5,8),(21,'La limpieza podría mejorar.','2025-04-10',3,1,9),(22,'Todo excelente, tal como lo esperábamos.','2025-04-10',5,2,10),(23,'No había buena señal de internet.','2025-04-10',2,3,11),(24,'Espacioso y con buena ubicación.','2025-04-10',4,4,12),(25,'Volveremos el próximo verano.','2025-04-10',5,5,1),(26,'Un poco alejado del centro, pero tranquilo.','2025-04-09',5,2,1),(27,'Excelente lugar y anfitrión muy amable.','2025-04-09',5,3,2),(28,'No había agua caliente la primera noche.','2025-04-09',5,4,3),(29,'Perfecto para desconectar un finde.','2025-04-09',5,5,4),(30,'Excelente lugar y anfitrión muy amable.','2025-04-09',5,1,5),(31,'Hermosa vista y entorno natural inmejorable.','2025-04-11',4.6,1,1),(32,'Perfecto para desconectar un finde.','2025-04-11',4.6,1,1),(33,'Volveremos el próximo verano.','2025-04-11',1,1,1),(34,'No había buena señal de internet.','2025-04-13',1,1,2);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_guests`
--

DROP TABLE IF EXISTS `type_guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_guests` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `adults` int NOT NULL,
  `babys` int NOT NULL,
  `childs` int NOT NULL,
  `pets` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_guests`
--

LOCK TABLES `type_guests` WRITE;
/*!40000 ALTER TABLE `type_guests` DISABLE KEYS */;
INSERT INTO `type_guests` VALUES (1,2,0,0,0),(2,2,0,0,0),(3,1,0,1,0),(4,1,1,0,0),(5,1,1,0,0),(6,1,1,0,0),(7,1,1,0,0),(8,1,1,0,0),(9,1,1,0,0),(10,1,1,0,0),(11,1,1,0,0),(12,1,1,0,0),(13,1,1,0,0),(14,1,1,0,0),(15,1,1,0,0),(16,1,1,0,0),(17,1,1,0,0),(18,1,1,0,0),(19,1,1,0,0),(20,1,1,0,0),(21,1,1,0,0),(22,2,0,0,0);
/*!40000 ALTER TABLE `type_guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('GUEST','HOST') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'2025-04-09','carlos@host.com','Carlos','$2a$10$0HIMv/RNXOK27f3Wr0/IG.BifbYrGZN5WJCLCLI31uiP2HRs1n/me','HOST'),(2,'2025-04-09','lucia@guest.com','Lucía','$2a$10$a.lZr8rYmQX/wavuR/qOH.ELO4DS2YLzI.J3/T7ZbISAd9Kr4aqjK','GUEST'),(3,'2025-04-09','julian@host.com','Julián','$2a$10$S0ecePJ9OJWDH1eJDa9ime3VwFzinLkEXGGRMzamOvoX2UlHtx0sa','HOST'),(4,'2025-04-09','maria@guest.com','María','$2a$10$z5c.O78esld7rvFZ7jYkN.buOuBpbZ/umwCnrlm5de2Lw.ga3DPBa','GUEST'),(5,'2025-04-09','sofia@guest.com','Sofía','$2a$10$VEn1ON5rS4nlJqugIvJN.uciY9LqyxrtmQAJavMFj2noNhswJ0hym','GUEST'),(10,'2025-04-13','pedro@gmail.com','Pedro','$2a$10$q2jPE1Cm/FpEAT9e6sXHh.CwRVMhv/cOkUXSaRyyyQ.7zHL14kEn.','GUEST');
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

-- Dump completed on 2025-08-25 20:03:32
