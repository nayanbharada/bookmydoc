-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: new_hospital
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add appointment',7,'add_appointment'),(26,'Can change appointment',7,'change_appointment'),(27,'Can delete appointment',7,'delete_appointment'),(28,'Can view appointment',7,'view_appointment'),(29,'Can add patient',8,'add_patient'),(30,'Can change patient',8,'change_patient'),(31,'Can delete patient',8,'delete_patient'),(32,'Can view patient',8,'view_patient'),(33,'Can add hospital',9,'add_hospital'),(34,'Can change hospital',9,'change_hospital'),(35,'Can delete hospital',9,'delete_hospital'),(36,'Can view hospital',9,'view_hospital'),(37,'Can add hospital request',10,'add_hospitalrequest'),(38,'Can change hospital request',10,'change_hospitalrequest'),(39,'Can delete hospital request',10,'delete_hospitalrequest'),(40,'Can view hospital request',10,'view_hospitalrequest'),(41,'Can add doc time slot',11,'add_doctimeslot'),(42,'Can change doc time slot',11,'change_doctimeslot'),(43,'Can delete doc time slot',11,'delete_doctimeslot'),(44,'Can view doc time slot',11,'view_doctimeslot'),(45,'Can add doctor profile',12,'add_doctorprofile'),(46,'Can change doctor profile',12,'change_doctorprofile'),(47,'Can delete doctor profile',12,'delete_doctorprofile'),(48,'Can view doctor profile',12,'view_doctorprofile'),(49,'Can add qualification',13,'add_qualification'),(50,'Can change qualification',13,'change_qualification'),(51,'Can delete qualification',13,'delete_qualification'),(52,'Can view qualification',13,'view_qualification'),(53,'Can add appointment',14,'add_appointment'),(54,'Can change appointment',14,'change_appointment'),(55,'Can delete appointment',14,'delete_appointment'),(56,'Can view appointment',14,'view_appointment'),(57,'Can add checkup timing',15,'add_checkuptiming'),(58,'Can change checkup timing',15,'change_checkuptiming'),(59,'Can delete checkup timing',15,'delete_checkuptiming'),(60,'Can view checkup timing',15,'view_checkuptiming'),(61,'Can add doctor degree',16,'add_doctordegree'),(62,'Can change doctor degree',16,'change_doctordegree'),(63,'Can delete doctor degree',16,'delete_doctordegree'),(64,'Can view doctor degree',16,'view_doctordegree'),(65,'Can add doctor university',17,'add_doctoruniversity'),(66,'Can change doctor university',17,'change_doctoruniversity'),(67,'Can delete doctor university',17,'delete_doctoruniversity'),(68,'Can view doctor university',17,'view_doctoruniversity'),(69,'Can add images',18,'add_images'),(70,'Can change images',18,'change_images'),(71,'Can delete images',18,'delete_images'),(72,'Can view images',18,'view_images'),(73,'Can add contact',19,'add_contact'),(74,'Can change contact',19,'change_contact'),(75,'Can delete contact',19,'delete_contact'),(76,'Can view contact',19,'view_contact'),(77,'Can add carousel',20,'add_carousel'),(78,'Can change carousel',20,'change_carousel'),(79,'Can delete carousel',20,'delete_carousel'),(80,'Can view carousel',20,'view_carousel');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-01-31 06:49:46.583818','1','shalby hospital',2,'[]',10,1),(2,'2020-01-31 06:51:06.086437','2','apple clinic',2,'[]',10,1),(3,'2020-01-31 08:48:58.977502','2','Appointment object (2)',3,'',14,1),(4,'2020-01-31 08:48:59.009148','1','Appointment object (1)',3,'',14,1),(5,'2020-02-03 05:15:12.036532','7','Appointment object (7)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(6,'2020-02-03 05:38:03.702699','8','Appointment object (8)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(7,'2020-02-03 05:49:07.279119','8','Appointment object (8)',3,'',14,1),(8,'2020-02-03 05:54:29.705474','7','Appointment object (7)',3,'',14,1),(9,'2020-02-03 05:54:29.746819','6','Appointment object (6)',3,'',14,1),(10,'2020-02-03 05:54:29.824371','5','Appointment object (5)',3,'',14,1),(11,'2020-02-03 05:54:29.850232','4','Appointment object (4)',3,'',14,1),(12,'2020-02-03 05:54:29.874698','3','Appointment object (3)',3,'',14,1),(13,'2020-02-03 05:55:58.132829','9','Appointment object (9)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(14,'2020-02-03 05:58:40.810147','10','Appointment object (10)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(15,'2020-02-03 07:38:26.642186','12','Appointment object (12)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(16,'2020-02-03 11:32:17.844351','12','Appointment object (12)',3,'',14,1),(17,'2020-02-03 11:32:17.891645','11','Appointment object (11)',3,'',14,1),(18,'2020-02-03 11:32:17.915385','10','Appointment object (10)',3,'',14,1),(19,'2020-02-03 11:32:17.953506','9','Appointment object (9)',3,'',14,1),(20,'2020-02-03 12:24:44.405763','13','Appointment object (13)',1,'[{\"added\": {}}]',14,1),(21,'2020-02-03 12:25:00.285691','13','Appointment object (13)',3,'',14,1),(22,'2020-02-03 12:39:44.414914','14','Appointment object (14)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(23,'2020-02-03 12:44:29.892539','14','Appointment object (14)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(24,'2020-02-03 13:52:25.982382','15','Appointment object (15)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(25,'2020-02-03 14:25:15.239891','15','Appointment object (15)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(26,'2020-02-04 06:44:28.312254','25','Appointment object (25)',3,'',14,1),(27,'2020-02-04 06:44:28.343276','24','Appointment object (24)',3,'',14,1),(28,'2020-02-04 06:44:28.380912','23','Appointment object (23)',3,'',14,1),(29,'2020-02-04 06:44:28.428820','22','Appointment object (22)',3,'',14,1),(30,'2020-02-04 06:44:28.486475','21','Appointment object (21)',3,'',14,1),(31,'2020-02-04 06:44:28.586686','20','Appointment object (20)',3,'',14,1),(32,'2020-02-04 06:44:28.612021','19','Appointment object (19)',3,'',14,1),(33,'2020-02-04 06:44:28.650419','18','Appointment object (18)',3,'',14,1),(34,'2020-02-04 06:44:28.699137','17','Appointment object (17)',3,'',14,1),(35,'2020-02-04 06:44:28.749609','16','Appointment object (16)',3,'',14,1),(36,'2020-02-04 06:44:28.774603','15','Appointment object (15)',3,'',14,1),(37,'2020-02-04 06:44:28.811869','14','Appointment object (14)',3,'',14,1),(38,'2020-02-04 07:06:09.421914','26','Appointment object (26)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(39,'2020-02-04 07:12:25.963263','1','CheckupTiming object (1)',3,'',15,1),(40,'2020-02-04 07:26:51.168480','26','Appointment object (26)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(41,'2020-02-04 07:31:27.249652','26','Appointment object (26)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(42,'2020-02-04 08:44:15.499875','8','CheckupTiming object (8)',3,'',15,1),(43,'2020-02-04 08:44:15.700569','2','CheckupTiming object (2)',3,'',15,1),(44,'2020-02-04 08:44:25.461076','26','Appointment object (26)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(45,'2020-02-04 08:44:31.917953','27','Appointment object (27)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(46,'2020-02-04 09:08:04.385876','9','CheckupTiming object (9)',3,'',15,1),(47,'2020-02-04 09:21:02.410249','10','CheckupTiming object (10)',3,'',15,1),(48,'2020-02-04 09:21:34.598291','27','Appointment object (27)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(49,'2020-02-04 09:21:40.196287','26','Appointment object (26)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1),(50,'2020-02-04 09:21:43.828539','26','Appointment object (26)',2,'[]',14,1),(51,'2020-02-04 09:21:47.432437','27','Appointment object (27)',2,'[]',14,1),(52,'2020-02-04 11:43:37.218053','4','MCM',3,'',13,1),(53,'2020-02-04 11:43:37.248031','3','MBBS',3,'',13,1),(54,'2020-02-04 11:43:37.297115','2','BMBS',3,'',13,1),(55,'2020-02-04 11:43:37.321745','1','MBBS',3,'',13,1),(56,'2020-02-04 11:50:37.458262','1','DoctorDegree object (1)',1,'[{\"added\": {}}]',16,1),(57,'2020-02-04 11:51:46.849180','2','BDS',1,'[{\"added\": {}}]',16,1),(58,'2020-02-04 11:51:58.192982','3','BAMS',1,'[{\"added\": {}}]',16,1),(59,'2020-02-04 11:53:41.512446','4','PHD',1,'[{\"added\": {}}]',16,1),(60,'2020-02-04 11:54:02.205068','5','MS',1,'[{\"added\": {}}]',16,1),(61,'2020-02-04 11:57:49.808109','5','MS',3,'',13,1),(62,'2020-02-04 12:26:03.759085','1','DoctorUniversity object (1)',1,'[{\"added\": {}}]',17,1),(63,'2020-02-04 12:26:48.681715','2','DoctorUniversity object (2)',1,'[{\"added\": {}}]',17,1),(64,'2020-02-04 12:27:32.942186','3','DoctorUniversity object (3)',1,'[{\"added\": {}}]',17,1),(65,'2020-02-04 12:27:48.872485','4','DoctorUniversity object (4)',1,'[{\"added\": {}}]',17,1),(66,'2020-02-04 12:28:21.631725','5','DoctorUniversity object (5)',1,'[{\"added\": {}}]',17,1),(67,'2020-02-04 12:28:40.581811','6','DoctorUniversity object (6)',1,'[{\"added\": {}}]',17,1),(68,'2020-02-04 12:29:48.917167','7','DoctorUniversity object (7)',1,'[{\"added\": {}}]',17,1),(69,'2020-02-04 12:34:37.669151','8','DoctorUniversity object (8)',1,'[{\"added\": {}}]',17,1),(70,'2020-02-04 12:35:16.470645','9','DoctorUniversity object (9)',1,'[{\"added\": {}}]',17,1),(71,'2020-02-04 12:35:34.883830','10','DoctorUniversity object (10)',1,'[{\"added\": {}}]',17,1),(72,'2020-02-04 12:35:50.045099','11','DoctorUniversity object (11)',1,'[{\"added\": {}}]',17,1),(73,'2020-02-04 12:36:28.475151','12','DoctorUniversity object (12)',1,'[{\"added\": {}}]',17,1),(74,'2020-02-04 12:36:51.499072','13','DoctorUniversity object (13)',1,'[{\"added\": {}}]',17,1),(75,'2020-02-04 12:37:05.717651','14','DoctorUniversity object (14)',1,'[{\"added\": {}}]',17,1),(76,'2020-02-04 12:39:29.484863','15','Goa University',1,'[{\"added\": {}}]',17,1),(77,'2020-02-04 12:39:50.152256','16','Gujarat University',1,'[{\"added\": {}}]',17,1),(78,'2020-02-04 12:40:20.307574','17','Dharmsinh Desai University',1,'[{\"added\": {}}]',17,1),(79,'2020-02-04 12:40:50.092686','18','MS University',1,'[{\"added\": {}}]',17,1),(80,'2020-02-04 12:41:15.385407','19','KSKV Kachchh University',1,'[{\"added\": {}}]',17,1),(81,'2020-02-04 12:41:37.067151','20','Parul University',1,'[{\"added\": {}}]',17,1),(82,'2020-02-04 12:41:46.114798','21','Sardar Patel University',1,'[{\"added\": {}}]',17,1),(83,'2020-02-04 12:42:17.334470','22','Himachal Pradesh University',1,'[{\"added\": {}}]',17,1),(84,'2020-02-04 12:46:29.626118','7','sagar',3,'',13,1),(85,'2020-02-05 12:02:32.790610','10','jfdklsjlk',3,'',6,1),(86,'2020-02-05 12:10:15.187723','11','def',3,'',6,1),(87,'2020-02-05 12:13:17.101645','12','def',3,'',6,1),(88,'2020-02-10 08:47:16.605614','3','Contact object (3)',3,'',19,1),(89,'2020-02-10 08:47:16.668038','2','Contact object (2)',3,'',19,1),(90,'2020-02-10 08:47:16.693741','1','Contact object (1)',3,'',19,1),(91,'2020-02-10 09:18:56.006831','5','Contact object (5)',3,'',19,1),(92,'2020-02-10 09:18:56.087147','4','Contact object (4)',3,'',19,1),(93,'2020-02-10 11:25:18.508991','1','def hospital',2,'[{\"changed\": {\"fields\": [\"email\"]}}]',10,1),(94,'2020-02-10 11:25:34.136211','4','def  hospital',3,'',9,1),(95,'2020-02-10 11:25:34.252800','4','def  hospital',3,'',9,1),(96,'2020-02-10 11:33:09.913530','11','def',3,'',6,1),(97,'2020-02-10 11:35:06.174738','2','tapanhospital clinic',3,'',10,1),(98,'2020-02-10 11:36:54.136384','3','tapanhospital hospital',2,'[]',10,1),(99,'2020-02-10 11:38:16.503328','13','tapan',3,'',6,1),(100,'2020-02-10 11:41:36.059531','4','tapanhospital hospital',2,'[]',10,1),(101,'2020-02-10 12:04:16.918035','6','sagar',2,'[{\"changed\": {\"fields\": [\"email\"]}}]',6,1),(102,'2020-02-10 13:06:50.830662','2','test12',2,'[{\"changed\": {\"fields\": [\"email\", \"gender\", \"profile_image\"]}}]',6,1),(103,'2020-02-10 13:53:15.291629','37','Appointment object (37)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(104,'2020-02-11 06:47:49.793816','6','mba',3,'',16,1),(105,'2020-02-11 07:21:31.648678','12','test',3,'',16,1),(106,'2020-02-11 07:22:24.966334','13','test',3,'',16,1),(107,'2020-02-11 08:53:44.609298','38','Appointment object (38)',2,'[{\"changed\": {\"fields\": [\"canceled_by\", \"status\"]}}]',14,1),(108,'2020-02-11 11:53:23.208009','6','sagar',2,'[{\"changed\": {\"fields\": [\"email\"]}}]',6,1),(109,'2020-02-13 07:06:49.697747','1','nayan',2,'[{\"changed\": {\"fields\": [\"email\", \"mobile_number\", \"gender\", \"profile_image\"]}}]',6,1),(110,'2020-02-13 07:13:31.251308','1','Carousel object (1)',1,'[{\"added\": {}}]',20,1),(111,'2020-02-13 07:14:26.286860','2','Carousel object (2)',1,'[{\"added\": {}}]',20,1),(112,'2020-02-13 07:14:39.210481','3','Carousel object (3)',1,'[{\"added\": {}}]',20,1),(113,'2020-02-13 10:37:15.667632','41','Appointment object (41)',2,'[{\"changed\": {\"fields\": [\"status\"]}}]',14,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(14,'doctor','appointment'),(15,'doctor','checkuptiming'),(11,'doctor','doctimeslot'),(16,'doctor','doctordegree'),(12,'doctor','doctorprofile'),(17,'doctor','doctoruniversity'),(13,'doctor','qualification'),(9,'hospital','hospital'),(10,'hospital','hospitalrequest'),(18,'hospital','images'),(7,'patient','appointment'),(8,'patient','patient'),(5,'sessions','session'),(20,'user','carousel'),(19,'user','contact'),(6,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-01-31 06:38:15.124010'),(2,'contenttypes','0002_remove_content_type_name','2020-01-31 06:38:15.869054'),(3,'auth','0001_initial','2020-01-31 06:38:16.512248'),(4,'auth','0002_alter_permission_name_max_length','2020-01-31 06:38:17.605673'),(5,'auth','0003_alter_user_email_max_length','2020-01-31 06:38:17.637932'),(6,'auth','0004_alter_user_username_opts','2020-01-31 06:38:17.671149'),(7,'auth','0005_alter_user_last_login_null','2020-01-31 06:38:17.699311'),(8,'auth','0006_require_contenttypes_0002','2020-01-31 06:38:17.727585'),(9,'auth','0007_alter_validators_add_error_messages','2020-01-31 06:38:17.760283'),(10,'auth','0008_alter_user_username_max_length','2020-01-31 06:38:17.792961'),(11,'auth','0009_alter_user_last_name_max_length','2020-01-31 06:38:17.824679'),(12,'auth','0010_alter_group_name_max_length','2020-01-31 06:38:17.907582'),(13,'auth','0011_update_proxy_permissions','2020-01-31 06:38:17.948183'),(14,'auth','0012_auto_20200107_1018','2020-01-31 06:38:17.981405'),(15,'auth','0013_auto_20200107_1021','2020-01-31 06:38:18.012410'),(16,'user','0001_initial','2020-01-31 06:38:18.716067'),(17,'admin','0001_initial','2020-01-31 06:38:19.912418'),(18,'admin','0002_logentry_remove_auto_add','2020-01-31 06:38:20.255912'),(19,'admin','0003_logentry_add_action_flag_choices','2020-01-31 06:38:20.291233'),(20,'hospital','0001_initial','2020-01-31 06:38:20.690690'),(21,'doctor','0001_initial','2020-01-31 06:38:21.263926'),(22,'doctor','0002_doctorprofile_hospital','2020-01-31 06:38:21.752700'),(23,'doctor','0003_auto_20200131_1208','2020-01-31 06:38:23.000234'),(24,'hospital','0002_hospital_user','2020-01-31 06:38:23.754399'),(25,'patient','0001_initial','2020-01-31 06:38:24.226133'),(26,'patient','0002_auto_20200131_1208','2020-01-31 06:38:27.115104'),(27,'sessions','0001_initial','2020-01-31 06:38:28.396597'),(28,'patient','0003_delete_appointment','2020-01-31 06:58:35.765268'),(29,'doctor','0004_appointment','2020-01-31 06:58:35.987190'),(30,'doctor','0005_appointment_status','2020-01-31 07:40:06.547713'),(31,'doctor','0006_auto_20200203_1044','2020-02-03 05:14:37.111509'),(32,'doctor','0007_appointment_checkup_time','2020-02-03 12:22:51.783887'),(33,'doctor','0008_remove_appointment_checkup_time','2020-02-04 06:46:40.855539'),(34,'doctor','0009_checkuptiming','2020-02-04 06:55:44.372957'),(35,'doctor','0010_auto_20200204_1717','2020-02-04 11:48:14.453240'),(36,'doctor','0011_auto_20200204_1734','2020-02-04 12:05:06.777157'),(37,'hospital','0003_images','2020-02-05 12:52:48.283160'),(38,'user','0002_contact','2020-02-10 07:15:52.386312'),(39,'user','0003_contact_created_date','2020-02-10 07:21:43.814274'),(40,'user','0004_auto_20200210_1417','2020-02-10 08:48:05.674493'),(41,'user','0005_auto_20200210_1432','2020-02-10 09:02:23.366452'),(42,'user','0006_auto_20200210_1450','2020-02-10 09:20:21.078145'),(43,'auth','0014_auto_20200213_1233','2020-02-13 07:04:06.315864'),(44,'user','0007_auto_20200213_1233','2020-02-13 07:10:43.096720'),(45,'user','0008_delete_carousel','2020-02-13 07:10:43.643719'),(46,'user','0009_carousel','2020-02-13 07:11:04.845361');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1hbvorsy41q5m27xq5zng9r6o2ipjp1t','ZmJkYTE0OGVmZjdiZmM1ZDIxNTE3ODMwZTIxNmE3ZDFlMmY5ZDY4MDp7Il9wYXNzd29yZF9yZXNldF90b2tlbiI6IjVkdy1kNzY4NzA4NjA4YWY0ZDYwMzA4OSJ9','2020-02-25 11:55:47.004698'),('o5qi1srhiaw6wvg4ua9m0u5ew06ay6ju','N2U4MzQ1Mjc2YmU2ZjRlZTk2ODEyNTQwOWJhYjY2NGFmMDA1ZDFlYjp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiY2Y0M2ExZGMxYTMzNmYyZWQ1NWU5ZjlkNTBjZGM4MGU5ZGM0OGNjIn0=','2020-02-27 10:12:51.161052');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_appointment`
--

DROP TABLE IF EXISTS `doctor_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `canceled_by_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `hospital_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `time_slot_id` int(11) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_appointment_canceled_by_id_bce879f1_fk_user_user_id` (`canceled_by_id`),
  KEY `doctor_appointment_created_by_id_22cba518_fk_user_user_id` (`created_by_id`),
  KEY `doctor_appointment_doctor_id_8c182dc1_fk_doctor_doctorprofile_id` (`doctor_id`),
  KEY `doctor_appointment_hospital_id_2ecf5c27_fk_hospital_hospital_id` (`hospital_id`),
  KEY `doctor_appointment_patient_id_bff365b8_fk_patient_patient_id` (`patient_id`),
  KEY `doctor_appointment_time_slot_id_79c295f9_fk_doctor_do` (`time_slot_id`),
  CONSTRAINT `doctor_appointment_canceled_by_id_bce879f1_fk_user_user_id` FOREIGN KEY (`canceled_by_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `doctor_appointment_created_by_id_22cba518_fk_user_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `user_user` (`id`),
  CONSTRAINT `doctor_appointment_doctor_id_8c182dc1_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`),
  CONSTRAINT `doctor_appointment_hospital_id_2ecf5c27_fk_hospital_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_hospital` (`id`),
  CONSTRAINT `doctor_appointment_patient_id_bff365b8_fk_patient_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient_patient` (`id`),
  CONSTRAINT `doctor_appointment_time_slot_id_79c295f9_fk_doctor_do` FOREIGN KEY (`time_slot_id`) REFERENCES `doctor_doctimeslot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_appointment`
--

LOCK TABLES `doctor_appointment` WRITE;
/*!40000 ALTER TABLE `doctor_appointment` DISABLE KEYS */;
INSERT INTO `doctor_appointment` VALUES (26,'2020-02-04',8,9,3,1,2,45,'Completed'),(27,'2020-02-04',9,9,3,1,2,47,'Cancel'),(28,'2020-02-04',NULL,3,3,1,10,49,'Booked'),(29,'2020-02-04',7,2,3,1,1,48,'Cancel'),(30,'2020-02-05',6,3,2,1,11,8,'Cancel'),(31,'2020-02-07',6,3,2,1,12,36,'Cancel'),(32,'2020-02-07',9,9,2,1,2,12,'Cancel'),(33,'2020-03-02',6,3,2,1,13,1,'Cancel'),(34,'2020-02-11',9,9,2,1,2,5,'Cancel'),(35,'2020-02-11',6,2,2,1,1,6,'Cancel'),(36,'2020-02-11',NULL,3,2,1,14,5,'Cancel'),(37,'2020-02-10',8,2,4,1,1,41,'Cancel'),(38,'2020-02-11',1,3,3,1,15,44,'Cancel'),(39,'2020-02-14',2,2,2,1,1,11,'Cancel'),(40,'2020-02-13',NULL,2,1,2,1,21,'Completed'),(41,'2020-02-13',2,2,1,2,1,22,'Booked'),(42,'2020-02-14',NULL,2,2,1,1,11,'Booked'),(43,'2020-02-15',19,19,2,1,17,14,'Cancel'),(44,'2020-02-17',NULL,19,1,2,17,15,'Booked'),(45,'2020-02-15',NULL,3,2,1,18,13,'Booked');
/*!40000 ALTER TABLE `doctor_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_checkuptiming`
--

DROP TABLE IF EXISTS `doctor_checkuptiming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_checkuptiming` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `check_in` time(6) DEFAULT NULL,
  `check_out` time(6) DEFAULT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appointment_id` (`appointment_id`),
  KEY `doctor_checkuptiming_doc_id_ba60b000_fk_doctor_doctorprofile_id` (`doc_id`),
  CONSTRAINT `doctor_checkuptiming_appointment_id_bee747c4_fk_doctor_ap` FOREIGN KEY (`appointment_id`) REFERENCES `doctor_appointment` (`id`),
  CONSTRAINT `doctor_checkuptiming_doc_id_ba60b000_fk_doctor_doctorprofile_id` FOREIGN KEY (`doc_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_checkuptiming`
--

LOCK TABLES `doctor_checkuptiming` WRITE;
/*!40000 ALTER TABLE `doctor_checkuptiming` DISABLE KEYS */;
INSERT INTO `doctor_checkuptiming` VALUES (11,'2020-02-04','14:52:00.000000','14:53:00.000000',26,3),(12,'2020-02-10','19:20:00.000000','19:21:00.000000',37,4),(13,'2020-02-13','15:51:00.000000','15:51:00.000000',40,1);
/*!40000 ALTER TABLE `doctor_checkuptiming` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_doctimeslot`
--

DROP TABLE IF EXISTS `doctor_doctimeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_doctimeslot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `days` varchar(10) NOT NULL,
  `from_time` time(6) NOT NULL,
  `to_time` time(6) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_doctimeslot_doc_id_3acb27b2_fk_doctor_doctorprofile_id` (`doc_id`),
  KEY `doctor_doctimeslot_hospital_id_e0bbf896_fk_hospital_hospital_id` (`hospital_id`),
  CONSTRAINT `doctor_doctimeslot_doc_id_3acb27b2_fk_doctor_doctorprofile_id` FOREIGN KEY (`doc_id`) REFERENCES `doctor_doctorprofile` (`id`),
  CONSTRAINT `doctor_doctimeslot_hospital_id_e0bbf896_fk_hospital_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_hospital` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_doctimeslot`
--

LOCK TABLES `doctor_doctimeslot` WRITE;
/*!40000 ALTER TABLE `doctor_doctimeslot` DISABLE KEYS */;
INSERT INTO `doctor_doctimeslot` VALUES (1,'monday','09:00:00.000000','10:00:00.000000',2,1),(2,'monday','10:00:00.000000','11:00:00.000000',2,1),(3,'monday','16:00:00.000000','17:00:00.000000',2,1),(4,'monday','17:00:00.000000','18:00:00.000000',2,1),(5,'tuesday','09:00:00.000000','10:00:00.000000',2,1),(6,'tuesday','10:00:00.000000','11:00:00.000000',2,1),(7,'wednesday','09:00:00.000000','10:00:00.000000',2,1),(8,'wednesday','10:00:00.000000','11:00:00.000000',2,1),(9,'thursday','09:00:00.000000','10:00:00.000000',2,1),(11,'friday','09:00:00.000000','10:00:00.000000',2,1),(12,'friday','10:00:00.000000','11:00:00.000000',2,1),(13,'saturday','09:00:00.000000','10:00:00.000000',2,1),(14,'saturday','10:00:00.000000','11:00:00.000000',2,1),(15,'monday','08:00:00.000000','09:00:00.000000',1,2),(16,'monday','09:00:00.000000','10:00:00.000000',1,2),(17,'tuesday','09:00:00.000000','10:00:00.000000',1,2),(18,'tuesday','10:00:00.000000','11:00:00.000000',1,2),(19,'wednesday','09:00:00.000000','10:00:00.000000',1,2),(20,'wednesday','10:00:00.000000','11:00:00.000000',1,2),(21,'thursday','16:00:00.000000','17:00:00.000000',1,2),(22,'thursday','17:00:00.000000','18:00:00.000000',1,2),(23,'friday','09:00:00.000000','10:00:00.000000',1,2),(24,'monday','09:00:00.000000','10:00:00.000000',4,1),(25,'monday','10:00:00.000000','11:00:00.000000',4,1),(26,'monday','16:00:00.000000','17:00:00.000000',4,1),(27,'monday','17:00:00.000000','18:00:00.000000',4,1),(28,'tuesday','09:00:00.000000','10:00:00.000000',4,1),(29,'tuesday','10:00:00.000000','11:00:00.000000',4,1),(30,'wednesday','09:00:00.000000','10:00:00.000000',4,1),(31,'wednesday','10:00:00.000000','11:00:00.000000',4,1),(32,'thursday','09:00:00.000000','10:00:00.000000',4,1),(33,'thursday','13:00:00.000000','14:00:00.000000',4,1),(34,'friday','09:00:00.000000','10:00:00.000000',4,1),(35,'friday','10:00:00.000000','11:00:00.000000',4,1),(36,'friday','19:00:00.000000','20:00:00.000000',2,1),(37,'monday','12:00:00.000000','13:00:00.000000',2,1),(38,'monday','13:00:00.000000','14:00:00.000000',2,1),(39,'monday','18:00:00.000000','19:00:00.000000',2,1),(40,'monday','19:00:00.000000','20:00:00.000000',4,1),(41,'monday','20:00:00.000000','21:00:00.000000',4,1),(42,'tuesday','11:00:00.000000','12:00:00.000000',3,1),(43,'tuesday','12:00:00.000000','13:00:00.000000',3,1),(44,'tuesday','13:00:00.000000','14:00:00.000000',3,1),(45,'tuesday','14:00:00.000000','15:00:00.000000',3,1),(46,'tuesday','15:00:00.000000','16:00:00.000000',3,1),(47,'tuesday','16:00:00.000000','17:00:00.000000',3,1),(48,'tuesday','17:00:00.000000','18:00:00.000000',3,1),(49,'tuesday','18:00:00.000000','19:00:00.000000',3,1),(50,'tuesday','19:00:00.000000','20:00:00.000000',3,1),(51,'wednesday','11:00:00.000000','12:00:00.000000',2,1),(52,'thursday','11:00:00.000000','12:00:00.000000',2,1),(53,'thursday','07:00:00.000000','08:00:00.000000',2,1),(54,'thursday','08:00:00.000000','09:00:00.000000',2,1);
/*!40000 ALTER TABLE `doctor_doctimeslot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_doctordegree`
--

DROP TABLE IF EXISTS `doctor_doctordegree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_doctordegree` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degree` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_doctordegree_degree_ccb5b1b4_uniq` (`degree`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_doctordegree`
--

LOCK TABLES `doctor_doctordegree` WRITE;
/*!40000 ALTER TABLE `doctor_doctordegree` DISABLE KEYS */;
INSERT INTO `doctor_doctordegree` VALUES (3,'BAMS'),(2,'BDS'),(1,'MBBS'),(5,'MS'),(4,'PHD');
/*!40000 ALTER TABLE `doctor_doctordegree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_doctorprofile`
--

DROP TABLE IF EXISTS `doctor_doctorprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_doctorprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specialization` varchar(20) NOT NULL,
  `registration_no` varchar(20) NOT NULL,
  `council` varchar(50) NOT NULL,
  `experience` int(11) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `doctor_doctorprofile_hospital_id_9e0f931d_fk_hospital_` (`hospital_id`),
  CONSTRAINT `doctor_doctorprofile_hospital_id_9e0f931d_fk_hospital_` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_hospital` (`id`),
  CONSTRAINT `doctor_doctorprofile_user_id_42aa5af1_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_doctorprofile`
--

LOCK TABLES `doctor_doctorprofile` WRITE;
/*!40000 ALTER TABLE `doctor_doctorprofile` DISABLE KEYS */;
INSERT INTO `doctor_doctorprofile` VALUES (1,'dental surgeon','4561232','gujarat medical council',3,2,5),(2,'dentist','45678921','tamil nadu medical council',2,1,6),(3,'','','',0,1,7),(4,'ayurveda','45678922','bhopal medical council',6,1,8),(5,'','','',0,7,16);
/*!40000 ALTER TABLE `doctor_doctorprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_doctoruniversity`
--

DROP TABLE IF EXISTS `doctor_doctoruniversity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_doctoruniversity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `university_name` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `university_name` (`university_name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_doctoruniversity`
--

LOCK TABLES `doctor_doctoruniversity` WRITE;
/*!40000 ALTER TABLE `doctor_doctoruniversity` DISABLE KEYS */;
INSERT INTO `doctor_doctoruniversity` VALUES (9,'Aryabhatta Knowledge University'),(10,'B.N. Mandal University'),(14,'Delhi University'),(17,'Dharmsinh Desai University'),(15,'Goa University'),(16,'Gujarat University'),(12,'Guru Gobind Singh Indraprastha University'),(2,'Hemchandracharya North Gujarat University'),(22,'Himachal Pradesh University'),(19,'KSKV Kachchh University'),(5,'Maharashtra University of Health Sciences'),(7,'Mahatma Gandhi Kashi Vidyapith'),(18,'MS University'),(8,'NTR University of Health Sciences'),(20,'Parul University'),(1,'Pondicherry University'),(11,'Punjab University'),(6,'Rajasthan University of Health Sciences'),(4,'Rajiv Gandhi University of Health Sciences'),(21,'Sardar Patel University'),(3,'Saurashtra University'),(13,'University of Jamia Hamdard');
/*!40000 ALTER TABLE `doctor_doctoruniversity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_qualification`
--

DROP TABLE IF EXISTS `doctor_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_qualification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degree` varchar(20) NOT NULL,
  `university` varchar(80) NOT NULL,
  `year_completion` int(11) DEFAULT NULL,
  `doctor_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_qualification_doctor_profile_id_6a532526_fk_doctor_do` (`doctor_profile_id`),
  CONSTRAINT `doctor_qualification_doctor_profile_id_6a532526_fk_doctor_do` FOREIGN KEY (`doctor_profile_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_qualification`
--

LOCK TABLES `doctor_qualification` WRITE;
/*!40000 ALTER TABLE `doctor_qualification` DISABLE KEYS */;
INSERT INTO `doctor_qualification` VALUES (6,'MBBS','Saurashtra University',2020,2),(10,'PHD','Gujarat University',2010,2);
/*!40000 ALTER TABLE `doctor_qualification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_hospital`
--

DROP TABLE IF EXISTS `hospital_hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_hospital` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `is_type` varchar(8) NOT NULL,
  `website` varchar(200) NOT NULL,
  `address` varchar(500) NOT NULL,
  `no_of_opd` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `hospital_hospital_user_id_b0c96b32_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_hospital`
--

LOCK TABLES `hospital_hospital` WRITE;
/*!40000 ALTER TABLE `hospital_hospital` DISABLE KEYS */;
INSERT INTO `hospital_hospital` VALUES (1,'shalby','hospital','http://www.shalby.com','rajkot',3,3),(2,'apple','clinic','http://www.apple.com','jamnagar',5,4),(7,'tapanhospital','hospital','http://www.tapan.com','',0,15);
/*!40000 ALTER TABLE `hospital_hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_hospitalrequest`
--

DROP TABLE IF EXISTS `hospital_hospitalrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_hospitalrequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `type` varchar(8) NOT NULL,
  `username` varchar(20) NOT NULL,
  `website` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_hospitalrequest`
--

LOCK TABLES `hospital_hospitalrequest` WRITE;
/*!40000 ALTER TABLE `hospital_hospitalrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospital_hospitalrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_images`
--

DROP TABLE IF EXISTS `hospital_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `hospital_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_images_hospital_id_2863df96_fk_hospital_hospital_id` (`hospital_id`),
  CONSTRAINT `hospital_images_hospital_id_2863df96_fk_hospital_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_hospital` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_images`
--

LOCK TABLES `hospital_images` WRITE;
/*!40000 ALTER TABLE `hospital_images` DISABLE KEYS */;
INSERT INTO `hospital_images` VALUES (1,'images/hospital.jpeg',1),(2,'images/hospital_8u3pJCp.jpeg',1),(4,'images/hospital4.jpeg',2),(5,'images/download_0Y59OOC.jpeg',2),(6,'images/hospital5.jpeg',1),(8,'images/hospital6.jpeg',1);
/*!40000 ALTER TABLE `hospital_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_patient`
--

DROP TABLE IF EXISTS `patient_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `birth_date` date DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `blood_group` varchar(4) DEFAULT NULL,
  `pulse` int(11) DEFAULT NULL,
  `blood_pressure` int(11) DEFAULT NULL,
  `physical_disorders` tinyint(1) NOT NULL,
  `mental_disorders` tinyint(1) NOT NULL,
  `major_surgeries` tinyint(1) NOT NULL,
  `diabetes` tinyint(1) NOT NULL,
  `cancer` tinyint(1) NOT NULL,
  `heart_attack` tinyint(1) NOT NULL,
  `smoke` tinyint(1) NOT NULL,
  `regular_medicine` varchar(100) NOT NULL,
  `drug_allergies` varchar(200) NOT NULL,
  `comments` varchar(300) NOT NULL,
  `first_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(300) DEFAULT NULL,
  `mobile_no` varchar(10) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `patient_patient_user_id_40c1c82a_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_patient`
--

LOCK TABLES `patient_patient` WRITE;
/*!40000 ALTER TABLE `patient_patient` DISABLE KEYS */;
INSERT INTO `patient_patient` VALUES (1,'1998-07-27',NULL,NULL,'O+',NULL,NULL,0,0,0,0,1,1,1,'','','',NULL,NULL,NULL,NULL,'M',2),(2,'1998-07-26',50,5.6,'AB+',150,250,0,0,1,0,0,1,1,'','','',NULL,NULL,NULL,NULL,NULL,9),(3,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','bhara','tejinder','7588456923','tejinder@gmail.com','M',NULL),(4,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','nikuj','joshi','7567372204','nikuj@gmail.com','M',NULL),(5,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','testone','testlast','7567372004','tesdt@gmail.com','F',NULL),(6,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','raju','rastogi','8758162943','raju@gmail.com','M',NULL),(7,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','vikram','singh','9974434331','vikram@gmail.com','M',NULL),(8,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','manish','gori','9924482256','manish@gmail.com','M',NULL),(9,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','niraj','verma','9924443258','niraj@gmail.com','M',NULL),(10,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','nikuj','joshi','7567372004','nikuj@gmail.com','M',NULL),(11,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','abhijit','seth','8752664596','abhijit@gmail.com','M',NULL),(12,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','bhvya','parmar','9924456822','bhvya@gmail.com','F',NULL),(13,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','data','datalast','7567372004','data@gmail.com','M',NULL),(14,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','bhutik','parmar','7567372004','bhutikparmar@gmail.com','M',NULL),(15,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','demo','demolast','8758162943','demo@gmail.com','M',NULL),(16,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','',NULL,NULL,NULL,NULL,NULL,18),(17,'1995-09-29',98,6.3,'A-',72,NULL,0,0,0,0,0,1,1,'perasitamol','','',NULL,NULL,NULL,NULL,NULL,19),(18,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,'','','','devang','vithlani','8758162943','devang@gmail.com','M',NULL);
/*!40000 ALTER TABLE `patient_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_carousel`
--

DROP TABLE IF EXISTS `user_carousel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_carousel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_carousel`
--

LOCK TABLES `user_carousel` WRITE;
/*!40000 ALTER TABLE `user_carousel` DISABLE KEYS */;
INSERT INTO `user_carousel` VALUES (1,'images/index_hero.jpg'),(2,'images/hospitalslider.jpeg'),(3,'images/slider1.jpeg');
/*!40000 ALTER TABLE `user_carousel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_contact`
--

DROP TABLE IF EXISTS `user_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `subject` varchar(300) NOT NULL,
  `message` varchar(700) NOT NULL,
  `created_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_contact`
--

LOCK TABLES `user_contact` WRITE;
/*!40000 ALTER TABLE `user_contact` DISABLE KEYS */;
INSERT INTO `user_contact` VALUES (6,'data','test@gmail.com','datat','hdgds','2020-02-10'),(7,'testfinal','final@gmail.com','fddfh','message test','2020-02-10'),(8,'ghgjh','hjhjk@ghgh.com','fgfgf','fgfhg','2020-02-13'),(9,'sfd','sfafsa@gmail.com','gsdgsd','fdgf','2020-02-13');
/*!40000 ALTER TABLE `user_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user`
--

DROP TABLE IF EXISTS `user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_type` varchar(10) NOT NULL,
  `mobile_number` varchar(12) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `profile_image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `user_user_email_1c6f3d1a_uniq` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user`
--

LOCK TABLES `user_user` WRITE;
/*!40000 ALTER TABLE `user_user` DISABLE KEYS */;
INSERT INTO `user_user` VALUES (1,'pbkdf2_sha256$150000$cou0KUEfrfQa$EpRZPChjFv0NZKt/+D3Q3jlJG8xx143gV/BPF8PftFE=','2020-02-13 10:37:05.886092',1,'nayan','nayan','bharada','nayan47@gmail.com',1,1,'2020-01-31 06:40:25.000000','patient','8758162943','M','images/download_x3KBApK.jpeg'),(2,'pbkdf2_sha256$150000$N15UTypVtqTi$fbGLUuiBQ541IMsDFe2FeGEdKfEflMUNM2nQd77QAp4=','2020-02-14 07:12:02.840167',0,'test12','testfirst','testlast','todaynoposts@gmail.com',0,1,'2020-01-31 06:47:23.000000','patient','8758162943','M','images/download_8UtDDxi.jpeg'),(3,'pbkdf2_sha256$150000$2Ye9VGka0F3n$hDWzWss5H7OTkaR4mtmvLBTzYQnsXjhkaHOC7i89fLE=','2020-02-14 05:27:15.808325',0,'shalby','shalby','shalby','shalby@gmail.com',0,1,'2020-01-31 06:49:46.478640','hospital','9974434333','M','images/download_yT4YrEx.jpeg'),(4,'pbkdf2_sha256$150000$hrsAz4uhHaub$xm2Fqwhdbl6+WBw/cUgie394eiGXV6jJxAXbk9weSd0=','2020-02-06 08:53:25.626479',0,'apple','apple','clinic','apple@gmail.com',0,1,'2020-01-31 06:51:05.902126','hospital','7567372004','M','images/download_H4YrLRk.jpeg'),(5,'pbkdf2_sha256$150000$s8Zdvh58cydp$Ak/UWtpqTBSvHcrD8LQweCY/kLnV48HkxsnL8G5BIb8=','2020-02-13 10:21:40.953330',0,'shalin','shalin','kamdar','sk@gmail.com',0,1,'2020-01-31 07:06:29.923057','doctor','9974434331','M','images/download_MFxmUcM.jpeg'),(6,'pbkdf2_sha256$150000$xhDCoef1m9J9$SuaRM1YJXR5+6JeXhqCDRIt4Rbufhjkv+Pj0HbYhE1o=','2020-02-14 05:29:13.459577',0,'sagar','sagar','makwana','nayan.bharada@trootech.com',0,1,'2020-01-31 07:10:32.000000','doctor','8490980930','M','images/download_YS0z4A8.jpeg'),(7,'pbkdf2_sha256$150000$UBFPL0CnX7Vj$UQ4++cqr2lzakjtY02v8gxuPICgfEBenmBR6Qm0kG6k=','2020-02-13 12:27:12.545622',0,'udit','udit','lodariya','udit@gmail.com',0,1,'2020-01-31 07:11:36.195960','doctor','7589124569','M',''),(8,'pbkdf2_sha256$150000$G3U4oMGZNV2p$X0mKfiC8IGfgYmiqyotXViyNPkn0aH99Dsb9xvbR8wg=','2020-02-13 12:26:37.701236',0,'akki','akshay','goswami','akkig@gmail.com',0,1,'2020-01-31 07:13:09.275601','doctor','7564891526','M','images/download_ppdzy0b.jpeg'),(9,'pbkdf2_sha256$150000$fIUWmP21DZs2$3h6t4a3akgjcA/vzuUGDeErPKHwLJ1KVJ71v/27CBE8=','2020-02-12 12:34:49.354509',0,'demo','demofirst','demolast','demo@gmail.com',0,1,'2020-01-31 08:32:54.431489','patient','8758162943','M','images/download_WMOpSkX.jpeg'),(15,'pbkdf2_sha256$150000$JNcsiGEyj4Np$p+VFHQpEcZ+THeC6V5v0UpKmBiNetxUe2qQeWCqlwv4=','2020-02-10 11:46:53.351183',0,'tapan','tapanhospital','','bharadanayan47@gmail.com',0,1,'2020-02-10 11:41:31.764943','hospital','8758162943','',''),(16,'pbkdf2_sha256$150000$FcyRMyvOLEn1$djImastlFD15acba1m01DTPVOBhEMVevtjMJtEnt2eY=',NULL,0,'raja','raja','selvarajan','bharadanayan007@gmail.com',0,1,'2020-02-10 11:56:23.541598','doctor','8426012345','M',''),(17,'pbkdf2_sha256$150000$EgeHY1EoUwyj$SE+OUJ69paLEWXHlcmFihuXc8FextP3YSwFJHAQSeyM=','2020-02-11 09:20:10.403393',1,'second','secondfirst','secondlast','second@gmail.com',1,1,'2020-02-11 08:49:32.420098','patient','','',''),(18,'pbkdf2_sha256$150000$LjXSmdYYAT8X$P4x+gRtnOHqST7jnnEehQbVTHdfXrTEjc5xJhGZN3aQ=',NULL,0,'mayank','mayank','nathwani','mayank@gmail.com',0,1,'2020-02-12 11:41:40.305508','patient','7567372004','',''),(19,'pbkdf2_sha256$150000$eYCvSdvpYp6o$YAiJigAsoLJmD3FPvhxLUBAfzIKMaohxruCQao3shso=','2020-02-13 13:57:27.176394',0,'nick','nikunj','joshi','nikunj@gmail.com',0,1,'2020-02-13 13:57:12.508437','patient','8347856135','','');
/*!40000 ALTER TABLE `user_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_groups`
--

DROP TABLE IF EXISTS `user_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_groups_user_id_group_id_bb60391f_uniq` (`user_id`,`group_id`),
  KEY `user_user_groups_group_id_c57f13c0_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_user_groups_group_id_c57f13c0_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_user_groups_user_id_13f9a20d_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_groups`
--

LOCK TABLES `user_user_groups` WRITE;
/*!40000 ALTER TABLE `user_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_user_permissions`
--

DROP TABLE IF EXISTS `user_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_user_permissions_user_id_permission_id_64f4d5b8_uniq` (`user_id`,`permission_id`),
  KEY `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_user_user_permissions_user_id_31782f58_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_user_permissions`
--

LOCK TABLES `user_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `user_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-14 15:50:40
