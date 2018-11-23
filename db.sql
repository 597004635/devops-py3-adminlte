-- MySQL dump 10.14  Distrib 5.5.60-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: devops6
-- ------------------------------------------------------
-- Server version	5.5.60-MariaDB

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
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (9,'dev1'),(5,'H5前端'),(8,'sa'),(6,'市场部'),(7,'投放部'),(3,'研发部'),(2,'运维部'),(4,'运营部');
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
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add content type',3,'add_contenttype'),(8,'Can change content type',3,'change_contenttype'),(9,'Can delete content type',3,'delete_contenttype'),(10,'Can add 用户信息',4,'add_userprofile'),(11,'Can change 用户信息',4,'change_userprofile'),(12,'Can delete 用户信息',4,'delete_userprofile'),(13,'Can add log entry',5,'add_logentry'),(14,'Can change log entry',5,'change_logentry'),(15,'Can delete log entry',5,'delete_logentry'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add product',7,'add_product'),(20,'Can change product',7,'change_product'),(21,'Can delete product',7,'delete_product'),(22,'Can add server',8,'add_server'),(23,'Can change server',8,'change_server'),(24,'Can delete server',8,'delete_server'),(25,'Can add idc',9,'add_idc'),(26,'Can change idc',9,'change_idc'),(27,'Can delete idc',9,'delete_idc'),(28,'访问idc列表页面',9,'view_idc'),(29,'Can add status',10,'add_status'),(30,'Can change status',10,'change_status'),(31,'Can delete status',10,'delete_status'),(32,'Can add echarts_order',11,'add_echarts_order'),(33,'Can change echarts_order',11,'change_echarts_order'),(34,'Can delete echarts_order',11,'delete_echarts_order'),(35,'Can add work_order',12,'add_workorder'),(36,'Can change work_order',12,'change_workorder'),(37,'Can delete work_order',12,'delete_workorder'),(38,'Can add add_task',14,'add_tasks'),(39,'Can change add_task',14,'change_tasks'),(40,'Can delete add_task',14,'delete_tasks'),(41,'Can add task_result',15,'add_execresult'),(42,'Can change task_result',15,'change_execresult'),(43,'Can delete task_result',15,'delete_execresult'),(44,'Can add deploy',16,'add_deploy'),(45,'Can change deploy',16,'change_deploy'),(46,'Can delete deploy',16,'delete_deploy'),(47,'Can add 作者信息',17,'add_author'),(48,'Can change 作者信息',17,'change_author'),(49,'Can delete 作者信息',17,'delete_author'),(50,'Can add 图书信息',18,'add_book'),(51,'Can change 图书信息',18,'change_book'),(52,'Can delete 图书信息',18,'delete_book'),(53,'Can add 出版商信息',19,'add_publish'),(54,'Can change 出版商信息',19,'change_publish'),(55,'Can delete 出版商信息',19,'delete_publish'),(56,'Can add graph',20,'add_graph'),(57,'Can change graph',20,'change_graph'),(58,'Can delete graph',20,'delete_graph'),(59,'Can add zabbix host',21,'add_zabbixhost'),(60,'Can change zabbix host',21,'change_zabbixhost'),(61,'Can delete zabbix host',21,'delete_zabbixhost');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_author`
--

DROP TABLE IF EXISTS `books_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_author`
--

LOCK TABLES `books_author` WRITE;
/*!40000 ALTER TABLE `books_author` DISABLE KEYS */;
INSERT INTO `books_author` VALUES (1,'金庸','jy@123.com','17000111111','香港'),(2,'陈忠实','czs@123.com','17000111111','西安'),(3,'钱钟书','qzs@123.com','17000111111','江苏无锡'),(4,'三毛','chenping@123.com','17000111111','台湾'),(5,'曹雪芹','zhangsan@123.com',NULL,'京城'),(7,'天蚕土豆','tctg@123.com','17000111111','网络'),(12,'高鹗','dhl@123.com','17000111111','京城1'),(16,'净无痕','jwh@123.com','17000111111','江西南昌');
/*!40000 ALTER TABLE `books_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_book`
--

DROP TABLE IF EXISTS `books_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `publication_date` date NOT NULL,
  `publisher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `books_book_publisher_id_189e6c56_fk_books_publish_id` (`publisher_id`),
  CONSTRAINT `books_book_publisher_id_189e6c56_fk_books_publish_id` FOREIGN KEY (`publisher_id`) REFERENCES `books_publish` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_book`
--

LOCK TABLES `books_book` WRITE;
/*!40000 ALTER TABLE `books_book` DISABLE KEYS */;
INSERT INTO `books_book` VALUES (1,'天龙八部','1963-01-09',4),(2,'白鹿原','1993-06-01',1),(3,'红楼梦','1953-12-03',2),(4,'围城','1947-03-12',5),(5,'梦里花落知多少','2009-04-07',6),(6,'斗破苍穹','2009-04-08',3),(7,'太古神王','2017-10-31',11);
/*!40000 ALTER TABLE `books_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_book_authors`
--

DROP TABLE IF EXISTS `books_book_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_book_authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_book_authors_book_id_author_id_8714badb_uniq` (`book_id`,`author_id`),
  KEY `books_book_authors_author_id_984f1ab8_fk_books_author_id` (`author_id`),
  CONSTRAINT `books_book_authors_author_id_984f1ab8_fk_books_author_id` FOREIGN KEY (`author_id`) REFERENCES `books_author` (`id`),
  CONSTRAINT `books_book_authors_book_id_ed3433e7_fk_books_book_id` FOREIGN KEY (`book_id`) REFERENCES `books_book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_book_authors`
--

LOCK TABLES `books_book_authors` WRITE;
/*!40000 ALTER TABLE `books_book_authors` DISABLE KEYS */;
INSERT INTO `books_book_authors` VALUES (1,1,1),(2,2,2),(4,3,5),(3,3,12),(5,4,3),(6,5,4),(7,6,7),(15,7,16);
/*!40000 ALTER TABLE `books_book_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_publish`
--

DROP TABLE IF EXISTS `books_publish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_publish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `address` varchar(100) NOT NULL,
  `city` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_publish`
--

LOCK TABLES `books_publish` WRITE;
/*!40000 ALTER TABLE `books_publish` DISABLE KEYS */;
INSERT INTO `books_publish` VALUES (1,'人民文学出版社','北京市东城区朝阳门内大街166号','北京'),(2,'作家出版社','北京市农展馆南里10号中国作家出版集团大楼','北京'),(3,'湖北少年儿童出版社','湖北省武汉市洪山区雄楚大街268号','武汉'),(4,'明报','香港','香港'),(5,'上海晨光出版公司','上海闵行路99号','上海'),(6,'北京十月文艺出版社','北三环中路6号','北京'),(11,'创世中文网','中国（上海）自由贸易试验区碧波路690号6幢301、401、501室','上海');
/*!40000 ALTER TABLE `books_publish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_release_deploy`
--

DROP TABLE IF EXISTS `code_release_deploy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_release_deploy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `project_version` varchar(40) NOT NULL,
  `version_desc` varchar(100) DEFAULT NULL,
  `update_detail` longtext NOT NULL,
  `status` int(11) NOT NULL,
  `apply_time` datetime NOT NULL,
  `deploy_time` datetime NOT NULL,
  `result` longtext NOT NULL,
  `env` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `assigned_to_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code_release_deploy_applicant_id_09332420_fk_dashboard` (`applicant_id`),
  KEY `code_release_deploy_assigned_to_id_6b885417_fk_dashboard` (`assigned_to_id`),
  CONSTRAINT `code_release_deploy_applicant_id_09332420_fk_dashboard` FOREIGN KEY (`applicant_id`) REFERENCES `dashboard_userprofile` (`id`),
  CONSTRAINT `code_release_deploy_assigned_to_id_6b885417_fk_dashboard` FOREIGN KEY (`assigned_to_id`) REFERENCES `dashboard_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_release_deploy`
--

LOCK TABLES `code_release_deploy` WRITE;
/*!40000 ALTER TABLE `code_release_deploy` DISABLE KEYS */;
INSERT INTO `code_release_deploy` VALUES (1,'ga','v0.0.1','test1 version','张三测试ga',3,'2018-10-18 16:23:31','2018-10-18 16:23:31','',0,21,2),(2,'ga','v0.0.2','待发布','更新版本后重启tomcat服务',0,'2018-10-18 16:32:36','2018-10-18 16:32:36','',1,21,1),(3,'ga','v0.0.1','test1 version','更新tomcat',2,'2018-10-18 19:19:44','2018-10-19 14:14:38','\n Pre messages:Started by user 管理员\nBuilding in workspace /var/lib/jenkins/workspace/ga_pro\n > git rev-parse --is-inside-work-tree # timeout=10\nFetching changes from the remote Git repository\n > git config remote.origin.url http://211.159.170.73:8080/zhangsan/ga.git # timeout=10\nFetching upstream changes from http://211.159.170.73:8080/zhangsan/ga.git\n > git --version # timeout=10\nusing GIT_ASKPASS to set credentials \n > git fetch --tags --progress http://211.159.170.73:8080/zhangsan/ga.git +refs/heads/*:refs/remotes/origin/*\n > git rev-parse refs/remotes/origin/master^{commit} # timeout=10\n > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10\nChecking out Revision a86749a059640fbeeaecaa2a4f9a8f713760d1ec (refs/remotes/origin/master)\n > git config core.sparsecheckout # timeout=10\n > git checkout -f a86749a059640fbeeaecaa2a4f9a8f713760d1ec\nCommit message: \"test-3\"\n > git rev-list --no-walk a86749a059640fbeeaecaa2a4f9a8f713760d1ec # timeout=10\n[ga_pro] $ /bin/bash /tmp/jenkins6648322736067352898.sh\nFinished: SUCCESS\n',1,21,2),(4,'ga','v0.0.1','test1 version','内部测试',2,'2018-10-18 19:20:05','2018-10-19 10:52:18','Test messages:Started by user 管理员\nBuilding in workspace /var/lib/jenkins/workspace/ga_test\n > git rev-parse --is-inside-work-tree # timeout=10\nFetching changes from the remote Git repository\n > git config remote.origin.url http://211.159.170.73:8080/zhangsan/ga.git # timeout=10\nFetching upstream changes from http://211.159.170.73:8080/zhangsan/ga.git\n > git --version # timeout=10\nusing GIT_ASKPASS to set credentials \n > git fetch --tags --progress http://211.159.170.73:8080/zhangsan/ga.git +refs/heads/*:refs/remotes/origin/*\n > git rev-parse refs/remotes/origin/master^{commit} # timeout=10\n > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10\nChecking out Revision 2bcd9e17554d6ad44d2ef8293233f91535e28888 (refs/remotes/origin/master)\n > git config core.sparsecheckout # timeout=10\n > git checkout -f 2bcd9e17554d6ad44d2ef8293233f91535e28888\nCommit message: \"test 1\"\n > git rev-list --no-walk 2bcd9e17554d6ad44d2ef8293233f91535e28888 # timeout=10\n[ga_test] $ /bin/bash /tmp/jenkins7303197509462647335.sh\nFinished: SUCCESS\n',0,21,21),(5,'ga','v0.0.2','待发布','test1',0,'2018-10-19 11:12:11','2018-10-19 11:12:11','',1,21,1),(6,'ga','v0.0.2','待发布','test12',2,'2018-10-19 11:12:35','2018-10-19 12:22:53','Test messages:Started by user 管理员\nBuilding in workspace /var/lib/jenkins/workspace/ga_test\n > git rev-parse --is-inside-work-tree # timeout=10\nFetching changes from the remote Git repository\n > git config remote.origin.url http://211.159.170.73:8080/zhangsan/ga.git # timeout=10\nFetching upstream changes from http://211.159.170.73:8080/zhangsan/ga.git\n > git --version # timeout=10\nusing GIT_ASKPASS to set credentials \n > git fetch --tags --progress http://211.159.170.73:8080/zhangsan/ga.git +refs/heads/*:refs/remotes/origin/*\n > git rev-parse refs/remotes/origin/master^{commit} # timeout=10\n > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10\nChecking out Revision 2bcd9e17554d6ad44d2ef8293233f91535e28888 (refs/remotes/origin/master)\n > git config core.sparsecheckout # timeout=10\n > git checkout -f 2bcd9e17554d6ad44d2ef8293233f91535e28888\nCommit message: \"test 1\"\n > git rev-list --no-walk 2bcd9e17554d6ad44d2ef8293233f91535e28888 # timeout=10\n[ga_test] $ /bin/bash /tmp/jenkins4785778976313712494.sh\nFinished: SUCCESS\n',0,21,2),(7,'ga','v0.0.3','2018-10-19','内测',0,'2018-10-19 14:19:41','2018-10-19 14:19:41','',0,21,21);
/*!40000 ALTER TABLE `code_release_deploy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_userprofile`
--

DROP TABLE IF EXISTS `dashboard_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `name_cn` varchar(30) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_userprofile`
--

LOCK TABLES `dashboard_userprofile` WRITE;
/*!40000 ALTER TABLE `dashboard_userprofile` DISABLE KEYS */;
INSERT INTO `dashboard_userprofile` VALUES (1,'pbkdf2_sha256$36000$yDGBGJW0X7Xo$ob8es+TUJ6zhtHvetkWs7+nW2sKDKr9PQ5PgD+UACWs=','2018-11-23 18:04:26.000000',1,'admin','','','admin@132.com',1,1,'2018-10-08 10:11:26.512687','管理员','110110'),(2,'pbkdf2_sha256$36000$JrcQqFSqsBcU$z9BWzIbnexwAf4KlPG2nJHPhP82vpSHPr/FG6ISeN3I=','2018-10-19 12:21:39.000000',0,'denghonglin','','','denghonglin@16801.com',0,1,'2018-10-08 11:56:33.000000','邓红临','15712944649'),(3,'pbkdf2_sha256$36000$55QPlS6dWAD4$0l3VstYyh/ecmVMD3OVLBRGCKTg0TftX0+Ckxyi0oGM=',NULL,0,'chendongdong','','','chendongdong@16801.com',0,0,'2018-10-08 12:00:25.000000','陈冬冬','13241406189'),(4,'pbkdf2_sha256$36000$MrdvoEqnC142$huEVxsAAZQlq0E1UN9X4+VwXVepTmeqnpsTgTeWwvaQ=',NULL,0,'wanghaicheng','','','wanghaicheng@16801.com',0,0,'2018-10-08 12:01:34.873707','王海成','13381499516'),(5,'pbkdf2_sha256$36000$WSf692rUWrTM$0JtxMYYuZcaPvlB3PEg1wRTd60IEZKRORPTMEA3EbII=',NULL,0,'wangyang','','','wangyang@16801.com',0,0,'2018-10-08 12:02:23.273412','王阳','13011116545'),(6,'pbkdf2_sha256$36000$lPD0TL6AkFkv$W+0rsbvdAz0una8msPxY0+1Mfxa23dhUg1tPhtFCnJc=',NULL,0,'zhangxiaoteng','','','zhangxiaoteng@16801.com',0,0,'2018-10-08 12:02:59.493535','张晓腾','18801059506'),(7,'pbkdf2_sha256$36000$YmfeOwJBy66o$73SjrALwemqw98VR64aH5VvsdH+kt9Utq2y01P9hUSs=',NULL,0,'zhangfarong','','','zhangfarong@16801.com',0,0,'2018-10-09 03:21:35.375284','张法荣','18500061951'),(8,'pbkdf2_sha256$36000$RPpPfeaBLmZz$RzyRTP+FOGv+GBXFhN83dVpx51iy59Z9y+YessBW4u8=',NULL,0,'fanwenwen','','','fanwenwen@16801.com',0,0,'2018-10-09 03:30:43.807591','范文文','17000111111'),(10,'pbkdf2_sha256$36000$W8HcuxlGmJy4$0YLeS5n/ow3/896qYHTojJGXcldy7SMRdan+2Fx+aKs=','2018-10-11 11:31:24.000000',0,'chengyingqiu','','','chengyingqiu@16801.com',0,1,'2018-10-10 04:20:53.000000','程迎秋','17000111111'),(11,'pbkdf2_sha256$36000$bTLZd1C2uIOw$Y3l6L64gEOikULW9fHFcf7gR0rw4cmI/toGD4h71mK8=',NULL,0,'liuna','','','liuna@16801.com',0,0,'2018-10-10 04:21:58.408306','刘娜','17000111111'),(13,'pbkdf2_sha256$36000$Iz7q8l8SneZV$7TRjIpBR3/PtlG933tcJ1vXX4KPKH0E0VyMCe42IW04=',NULL,0,'zhaojinbao','','','zhaojinbao@16801.com',0,0,'2018-10-10 06:34:12.675637','赵金宝','17000111111'),(14,'pbkdf2_sha256$36000$7NTaurudgSU2$gSgKaaaxo1TnVTvVNqQetYCtQflb9A9Xkre2mOa0AHw=',NULL,0,'kouyonglou','','','kouyonglou@16801.com',0,1,'2018-10-15 15:04:07.000000','寇永露','17000111111'),(17,'pbkdf2_sha256$36000$4uV6tapnkm0m$m8gAPvp3cPCkXj7z3gkkggkLeGeG8Y86yfvgtywP4to=','2018-10-18 14:11:08.000000',0,'root','','','zhangsan@123.com',0,1,'2018-10-15 17:52:03.000000','root','17000111111'),(21,'pbkdf2_sha256$36000$Ke3JAtCZdhIF$DPbR1AyxHJFLwZj8drbOr7TyfuzCheU2+NrQHJ0VHeU=','2018-10-19 14:19:24.000000',0,'zhangsan','','','zhangsan@123.com',0,1,'2018-10-18 10:55:31.000000','张三','17000111111');
/*!40000 ALTER TABLE `dashboard_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_userprofile_groups`
--

DROP TABLE IF EXISTS `dashboard_userprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_userprofile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dashboard_userprofile_gr_userprofile_id_group_id_8b953ec2_uniq` (`userprofile_id`,`group_id`),
  KEY `dashboard_userprofile_groups_group_id_a506fcef_fk_auth_group_id` (`group_id`),
  CONSTRAINT `dashboard_userprofile_groups_group_id_a506fcef_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `dashboard_userprofil_userprofile_id_80ca1465_fk_dashboard` FOREIGN KEY (`userprofile_id`) REFERENCES `dashboard_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_userprofile_groups`
--

LOCK TABLES `dashboard_userprofile_groups` WRITE;
/*!40000 ALTER TABLE `dashboard_userprofile_groups` DISABLE KEYS */;
INSERT INTO `dashboard_userprofile_groups` VALUES (21,2,8),(12,3,2),(13,4,2),(14,5,2),(15,6,2),(16,7,3),(7,8,5),(17,10,4),(18,11,4),(19,13,4),(22,14,3),(30,21,8);
/*!40000 ALTER TABLE `dashboard_userprofile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_userprofile_user_permissions`
--

DROP TABLE IF EXISTS `dashboard_userprofile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dashboard_userprofile_us_userprofile_id_permissio_53069c57_uniq` (`userprofile_id`,`permission_id`),
  KEY `dashboard_userprofil_permission_id_5234f413_fk_auth_perm` (`permission_id`),
  CONSTRAINT `dashboard_userprofil_permission_id_5234f413_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `dashboard_userprofil_userprofile_id_9ce8d6d1_fk_dashboard` FOREIGN KEY (`userprofile_id`) REFERENCES `dashboard_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_userprofile_user_permissions`
--

LOCK TABLES `dashboard_userprofile_user_permissions` WRITE;
/*!40000 ALTER TABLE `dashboard_userprofile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_userprofile_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_dashboard_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_dashboard_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `dashboard_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (5,'admin','logentry'),(2,'auth','group'),(1,'auth','permission'),(17,'books','author'),(18,'books','book'),(19,'books','publish'),(16,'code_release','deploy'),(3,'contenttypes','contenttype'),(4,'dashboard','userprofile'),(13,'djcelery','workerstate'),(20,'monitor','graph'),(21,'monitor','zabbixhost'),(9,'resources','idc'),(7,'resources','product'),(8,'resources','server'),(10,'resources','status'),(6,'sessions','session'),(15,'tasks','execresult'),(14,'tasks','tasks'),(11,'work_order','echarts_order'),(12,'work_order','workorder');
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
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-10-10 17:39:21'),(2,'contenttypes','0002_remove_content_type_name','2018-10-10 17:39:21'),(3,'auth','0001_initial','2018-10-10 17:39:22'),(4,'auth','0002_alter_permission_name_max_length','2018-10-10 17:39:22'),(5,'auth','0003_alter_user_email_max_length','2018-10-10 17:39:22'),(6,'auth','0004_alter_user_username_opts','2018-10-10 17:39:22'),(7,'auth','0005_alter_user_last_login_null','2018-10-10 17:39:22'),(8,'auth','0006_require_contenttypes_0002','2018-10-10 17:39:22'),(9,'auth','0007_alter_validators_add_error_messages','2018-10-10 17:39:22'),(10,'auth','0008_alter_user_username_max_length','2018-10-10 17:39:22'),(11,'dashboard','0001_initial','2018-10-10 17:39:23'),(12,'admin','0001_initial','2018-10-10 17:39:29'),(13,'admin','0002_logentry_remove_auto_add','2018-10-10 17:39:29'),(14,'sessions','0001_initial','2018-10-10 17:39:29'),(15,'resources','0001_initial','2018-10-11 12:02:55'),(16,'resources','0002_status','2018-10-12 09:57:20'),(17,'resources','0003_server_status','2018-10-12 09:57:21'),(18,'resources','0004_auto_20181012_1022','2018-10-12 10:22:15'),(19,'resources','0005_auto_20181012_1131','2018-10-12 11:31:48'),(20,'work_order','0001_initial','2018-10-12 17:26:56'),(21,'tasks','0001_initial','2018-10-15 19:48:51'),(22,'code_release','0001_initial','2018-10-17 17:08:59'),(23,'books','0001_initial','2018-10-19 14:26:46'),(24,'books','0002_auto_20181019_1514','2018-10-19 15:14:21'),(25,'books','0003_auto_20181019_1613','2018-10-19 16:14:04'),(26,'books','0004_auto_20181019_1616','2018-10-19 16:16:48'),(27,'books','0005_auto_20181019_1642','2018-10-19 16:42:52'),(28,'books','0006_auto_20181019_1701','2018-10-19 17:01:11'),(29,'books','0007_auto_20181019_1703','2018-10-19 17:03:40'),(30,'resources','0006_auto_20181020_1052','2018-10-20 10:52:44'),(31,'monitor','0001_initial','2018-10-22 11:47:05');
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
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('cwige9rwkzdlwup6jgukjvu8ovr4f3ju','ZjVjZTk1YmY0NTUyYjZkMjY4N2RiOWQ4ZjNkMDM5Y2UxNDYxOGNmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MWYzMzQzOGNhYTViNDJjNjk2YTAwNTJjNzAwMmMwZTQwODllNTVkIn0=','2018-12-07 18:04:26'),('dhhqbnd8r8s3jl4g5qjs46jzhzukb10b','ZjVjZTk1YmY0NTUyYjZkMjY4N2RiOWQ4ZjNkMDM5Y2UxNDYxOGNmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MWYzMzQzOGNhYTViNDJjNjk2YTAwNTJjNzAwMmMwZTQwODllNTVkIn0=','2018-10-25 14:09:11'),('edmk2ht3fa1wee6yj43uo98pff0b1ohl','ZjVjZTk1YmY0NTUyYjZkMjY4N2RiOWQ4ZjNkMDM5Y2UxNDYxOGNmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MWYzMzQzOGNhYTViNDJjNjk2YTAwNTJjNzAwMmMwZTQwODllNTVkIn0=','2018-11-05 14:47:39');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitor_influx_graph`
--

DROP TABLE IF EXISTS `monitor_influx_graph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_influx_graph` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `subtitle` varchar(50) DEFAULT NULL,
  `unit` varchar(10) NOT NULL,
  `measurement` varchar(32) NOT NULL,
  `auto_hostname` tinyint(1) NOT NULL,
  `field_expression` varchar(100) DEFAULT NULL,
  `tooltip_formatter` varchar(100) DEFAULT NULL,
  `yaxis_formatter` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitor_influx_graph`
--

LOCK TABLES `monitor_influx_graph` WRITE;
/*!40000 ALTER TABLE `monitor_influx_graph` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitor_influx_graph` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitor_influx_graph_product`
--

DROP TABLE IF EXISTS `monitor_influx_graph_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_influx_graph_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `graph_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `monitor_influx_graph_product_graph_id_product_id_0ea4789b_uniq` (`graph_id`,`product_id`),
  KEY `monitor_influx_graph_product_id_d1a7e931_fk_resources` (`product_id`),
  CONSTRAINT `monitor_influx_graph_graph_id_cc9b1b58_fk_monitor_i` FOREIGN KEY (`graph_id`) REFERENCES `monitor_influx_graph` (`id`),
  CONSTRAINT `monitor_influx_graph_product_id_d1a7e931_fk_resources` FOREIGN KEY (`product_id`) REFERENCES `resources_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitor_influx_graph_product`
--

LOCK TABLES `monitor_influx_graph_product` WRITE;
/*!40000 ALTER TABLE `monitor_influx_graph_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitor_influx_graph_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_idc`
--

DROP TABLE IF EXISTS `resources_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `idc_name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_idc`
--

LOCK TABLES `resources_idc` WRITE;
/*!40000 ALTER TABLE `resources_idc` DISABLE KEYS */;
INSERT INTO `resources_idc` VALUES (1,'jxq','酒仙桥机房','北京将台路酒仙桥','12345671','zhangsan@123.com','张三'),(3,'zw','兆维机房','北京兆维联通机房','12324','qiuyu@123.com','李四'),(4,'Qcloud','腾讯云','腾讯云','13716400561','keatenxu@tencent.com','徐建腾'),(5,'Aliyun','阿里云','阿里云','123123213','douchuanliang@aliyun.com','窦传良'),(6,'Ucloud','优刻得','优刻得','152 1677 1250','xumin@ucloud.com','徐旻'),(7,'Kings','金山云','金山云','1234567','zhouhongxian@kingsan.com','邹宏贤');
/*!40000 ALTER TABLE `resources_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_product`
--

DROP TABLE IF EXISTS `resources_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(32) NOT NULL,
  `module_letter` varchar(10) NOT NULL,
  `op_interface` varchar(150) NOT NULL,
  `dev_interface` varchar(150) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_product_module_letter_823e94ad` (`module_letter`),
  KEY `resources_product_pid_724b87ff` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_product`
--

LOCK TABLES `resources_product` WRITE;
/*!40000 ALTER TABLE `resources_product` DISABLE KEYS */;
INSERT INTO `resources_product` VALUES (1,'太古神王','tgsw','denghonglin@16801.com','denghonglin@16801.com',0),(2,'混服','android','denghonglin@16801.com','denghonglin@16801.com',1),(5,'123','3123','denghonglin@16801.com','denghonglin@16801.com',0),(6,'狂暴西游','kbxy','denghonglin@16801.com','denghonglin@16801.com',0),(7,'应用宝','yyb','chendongdong@16801.com','zhaojinbao@16801.com',4),(8,'ios','ios','wanghaicheng@16801.com','liuna@16801.com',1);
/*!40000 ALTER TABLE `resources_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_server`
--

DROP TABLE IF EXISTS `resources_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_type` varchar(20) DEFAULT NULL,
  `sn` varchar(60) DEFAULT NULL,
  `hostname` varchar(50) DEFAULT NULL,
  `inner_ip` varchar(32) DEFAULT NULL,
  `out_ip` varchar(32) DEFAULT NULL,
  `server_conf` varchar(100) DEFAULT NULL,
  `remark` longtext,
  `service_id` int(11) DEFAULT NULL,
  `server_purpose_id` int(11) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `check_update_time` datetime DEFAULT NULL,
  `idc_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inner_ip` (`inner_ip`),
  KEY `resources_server_idc_id_fe131330_fk_resources_idc_id` (`idc_id`),
  KEY `resources_server_hostname_2a827d99` (`hostname`),
  KEY `resources_server_service_id_a9f14ac5` (`service_id`),
  KEY `resources_server_server_purpose_4acfcc08` (`server_purpose_id`),
  KEY `resources_server_status_id_85a23c2e` (`status_id`),
  CONSTRAINT `resources_server_idc_id_fe131330_fk_resources_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `resources_idc` (`id`),
  CONSTRAINT `resources_server_server_purpose_id_c7534444_fk_resources` FOREIGN KEY (`server_purpose_id`) REFERENCES `resources_product` (`id`),
  CONSTRAINT `resources_server_status_id_85a23c2e_fk_resources_status_id` FOREIGN KEY (`status_id`) REFERENCES `resources_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_server`
--

LOCK TABLES `resources_server` WRITE;
/*!40000 ALTER TABLE `resources_server` DISABLE KEYS */;
INSERT INTO `resources_server` VALUES (1,NULL,NULL,'tgsw-test-1','10.105.219.74','106.75.118.47','4核8G 200G硬盘 200M带宽','测试机',1,2,'2018-05-23',NULL,4,2),(2,NULL,NULL,'ryzg-test-1','10.10.21.74','103.75.18.4','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,5,3),(4,NULL,NULL,'ryzg-test-2','10.10.1.1','103.75.18.1','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,5,3),(5,NULL,NULL,'ryzg-test-3','10.10.1.2','103.75.18.2','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,5,3),(6,NULL,NULL,'ryzg-test-4','10.10.1.5','103.75.18.5','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,5,3),(7,NULL,NULL,'ryzg-test-4','10.10.1.6','103.75.18.6','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,4,2),(8,NULL,NULL,'ryzg-test-6','10.10.1.7','103.75.18.7','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,4,2),(9,NULL,NULL,'ryzg-test-7','10.10.1.8','103.75.18.8','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,4,2),(10,NULL,NULL,'ryzg-test-8','10.10.1.9','103.75.18.9','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,4,2),(12,NULL,NULL,'ryzg-test-10','10.10.1.11','103.75.18.11','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,4,2),(13,NULL,NULL,'ryzg-test-11','10.10.1.12','103.75.18.12','2核4G 100G硬盘 10M带宽','测试机',4,5,'2018-01-23',NULL,4,2);
/*!40000 ALTER TABLE `resources_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_status`
--

DROP TABLE IF EXISTS `resources_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_status`
--

LOCK TABLES `resources_status` WRITE;
/*!40000 ALTER TABLE `resources_status` DISABLE KEYS */;
INSERT INTO `resources_status` VALUES (3,'已停机'),(1,'已释放'),(2,'运行中');
/*!40000 ALTER TABLE `resources_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_execresult`
--

DROP TABLE IF EXISTS `tasks_execresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks_execresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(64) NOT NULL,
  `unreachable` int(11) NOT NULL,
  `skipped` int(11) NOT NULL,
  `ok` int(11) NOT NULL,
  `changed` int(11) NOT NULL,
  `failures` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_execresult_task_id_a07d8352_fk_tasks_tasks_id` (`task_id`),
  CONSTRAINT `tasks_execresult_task_id_a07d8352_fk_tasks_tasks_id` FOREIGN KEY (`task_id`) REFERENCES `tasks_tasks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_execresult`
--

LOCK TABLES `tasks_execresult` WRITE;
/*!40000 ALTER TABLE `tasks_execresult` DISABLE KEYS */;
INSERT INTO `tasks_execresult` VALUES (3,'',0,0,2,0,0,28),(12,'',0,0,1,0,0,33),(13,'',0,0,1,0,0,34),(14,'',0,0,1,0,0,35),(15,'',0,0,1,0,0,36),(16,'',0,0,0,0,1,37),(17,'',0,0,1,0,0,38);
/*!40000 ALTER TABLE `tasks_execresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks_tasks`
--

DROP TABLE IF EXISTS `tasks_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `playbook` varchar(100) NOT NULL,
  `detail_result` longtext NOT NULL,
  `status` varchar(1) NOT NULL,
  `add_time` datetime NOT NULL,
  `exec_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_tasks`
--

LOCK TABLES `tasks_tasks` WRITE;
/*!40000 ALTER TABLE `tasks_tasks` DISABLE KEYS */;
INSERT INTO `tasks_tasks` VALUES (28,'测试机调试','playbook/2018/10/test_Ry9OTcm.yml','{\n    \"skipped\": {},\n    \"failed\": {},\n    \"ok\": {\n        \"192.168.1.215\": {\n            \"group\": \"root\",\n            \"uid\": 0,\n            \"dest\": \"/tmp/api.txt\",\n            \"changed\": true,\n            \"owner\": \"root\",\n            \"state\": \"file\",\n            \"gid\": 0,\n            \"mode\": \"0777\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"directory_mode\": null,\n                    \"force\": false,\n                    \"remote_src\": null,\n                    \"_original_basename\": null,\n                    \"path\": \"/tmp/api.txt\",\n                    \"owner\": null,\n                    \"follow\": true,\n                    \"group\": null,\n                    \"unsafe_writes\": null,\n                    \"state\": \"touch\",\n                    \"content\": null,\n                    \"serole\": null,\n                    \"setype\": null,\n                    \"selevel\": null,\n                    \"regexp\": null,\n                    \"src\": null,\n                    \"seuser\": null,\n                    \"recurse\": false,\n                    \"_diff_peek\": null,\n                    \"delimiter\": null,\n                    \"mode\": \"0777\",\n                    \"attributes\": null,\n                    \"backup\": null\n                }\n            },\n            \"diff\": {\n                \"after\": {\n                    \"path\": \"/tmp/api.txt\",\n                    \"state\": \"touch\",\n                    \"mode\": \"0777\"\n                },\n                \"before\": {\n                    \"path\": \"/tmp/api.txt\",\n                    \"state\": \"absent\",\n                    \"mode\": \"0644\"\n                }\n            },\n            \"size\": 0,\n            \"_ansible_parsed\": true,\n            \"_ansible_no_log\": false\n        },\n        \"192.168.1.217\": {\n            \"group\": \"root\",\n            \"uid\": 0,\n            \"dest\": \"/tmp/api.txt\",\n            \"changed\": true,\n            \"owner\": \"root\",\n            \"state\": \"file\",\n            \"gid\": 0,\n            \"secontext\": \"unconfined_u:object_r:user_tmp_t:s0\",\n            \"mode\": \"0777\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"directory_mode\": null,\n                    \"force\": false,\n                    \"remote_src\": null,\n                    \"_original_basename\": null,\n                    \"path\": \"/tmp/api.txt\",\n                    \"owner\": null,\n                    \"follow\": true,\n                    \"group\": null,\n                    \"unsafe_writes\": null,\n                    \"state\": \"touch\",\n                    \"content\": null,\n                    \"serole\": null,\n                    \"setype\": null,\n                    \"selevel\": null,\n                    \"regexp\": null,\n                    \"src\": null,\n                    \"seuser\": null,\n                    \"recurse\": false,\n                    \"_diff_peek\": null,\n                    \"delimiter\": null,\n                    \"mode\": \"0777\",\n                    \"attributes\": null,\n                    \"backup\": null\n                }\n            },\n            \"diff\": {\n                \"after\": {\n                    \"path\": \"/tmp/api.txt\",\n                    \"state\": \"touch\",\n                    \"mode\": \"0777\"\n                },\n                \"before\": {\n                    \"path\": \"/tmp/api.txt\",\n                    \"state\": \"absent\",\n                    \"mode\": \"0644\"\n                }\n            },\n            \"size\": 0,\n            \"_ansible_parsed\": true,\n            \"_ansible_no_log\": false\n        }\n    },\n    \"status\": {\n        \"192.168.1.215\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        },\n        \"192.168.1.217\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 15:57:40','2018-10-17 15:57:47'),(32,'创建测试文件','playbook/2018/10/test_aLkGyiz.yml','','N','2018-10-17 16:39:19','2018-10-17 16:39:19'),(33,'测试shell脚本','playbook/2018/10/test.yml','{\n    \"skipped\": {},\n    \"failed\": {},\n    \"ok\": {\n        \"192.168.1.217\": {\n            \"changed\": true,\n            \"end\": \"2018-10-17 16:50:02.704567\",\n            \"stdout\": \"\",\n            \"cmd\": \"sh /tmp/do_test.sh\",\n            \"rc\": 0,\n            \"start\": \"2018-10-17 16:50:02.699151\",\n            \"stderr\": \"\",\n            \"delta\": \"0:00:00.005416\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"creates\": null,\n                    \"executable\": null,\n                    \"_uses_shell\": true,\n                    \"_raw_params\": \"sh /tmp/do_test.sh\",\n                    \"removes\": null,\n                    \"argv\": null,\n                    \"warn\": true,\n                    \"chdir\": null,\n                    \"stdin\": null\n                }\n            },\n            \"_ansible_parsed\": true,\n            \"stdout_lines\": [],\n            \"stderr_lines\": [],\n            \"_ansible_no_log\": false\n        }\n    },\n    \"status\": {\n        \"192.168.1.217\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 16:49:52','2018-10-17 16:50:02'),(34,'测试command命令','playbook/2018/10/test_R0iNzZ8.yml','{\n    \"skipped\": {},\n    \"failed\": {},\n    \"ok\": {\n        \"192.168.1.217\": {\n            \"changed\": true,\n            \"end\": \"2018-10-17 16:54:52.904231\",\n            \"stdout\": \"eth0      Link encap:Ethernet  HWaddr 20:CF:30:81:A3:18  \\n          inet addr:192.168.1.217  Bcast:192.168.1.255  Mask:255.255.255.0\\n          inet6 addr: fe80::22cf:30ff:fe81:a318/64 Scope:Link\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\n          RX packets:17468056 errors:0 dropped:0 overruns:0 frame:0\\n          TX packets:1215957 errors:0 dropped:0 overruns:0 carrier:0\\n          collisions:0 txqueuelen:1000 \\n          RX bytes:1433168504 (1.3 GiB)  TX bytes:154222208 (147.0 MiB)\\n\\nlo        Link encap:Local Loopback  \\n          inet addr:127.0.0.1  Mask:255.0.0.0\\n          inet6 addr: ::1/128 Scope:Host\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\n          RX packets:19550 errors:0 dropped:0 overruns:0 frame:0\\n          TX packets:19550 errors:0 dropped:0 overruns:0 carrier:0\\n          collisions:0 txqueuelen:0 \\n          RX bytes:1494591 (1.4 MiB)  TX bytes:1494591 (1.4 MiB)\",\n            \"cmd\": [\n                \"ifconfig\"\n            ],\n            \"rc\": 0,\n            \"start\": \"2018-10-17 16:54:52.879647\",\n            \"stderr\": \"\",\n            \"delta\": \"0:00:00.024584\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"creates\": null,\n                    \"executable\": null,\n                    \"_uses_shell\": false,\n                    \"_raw_params\": \"ifconfig\",\n                    \"removes\": null,\n                    \"argv\": null,\n                    \"warn\": true,\n                    \"chdir\": null,\n                    \"stdin\": null\n                }\n            },\n            \"_ansible_parsed\": true,\n            \"stdout_lines\": [\n                \"eth0      Link encap:Ethernet  HWaddr 20:CF:30:81:A3:18  \",\n                \"          inet addr:192.168.1.217  Bcast:192.168.1.255  Mask:255.255.255.0\",\n                \"          inet6 addr: fe80::22cf:30ff:fe81:a318/64 Scope:Link\",\n                \"          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\",\n                \"          RX packets:17468056 errors:0 dropped:0 overruns:0 frame:0\",\n                \"          TX packets:1215957 errors:0 dropped:0 overruns:0 carrier:0\",\n                \"          collisions:0 txqueuelen:1000 \",\n                \"          RX bytes:1433168504 (1.3 GiB)  TX bytes:154222208 (147.0 MiB)\",\n                \"\",\n                \"lo        Link encap:Local Loopback  \",\n                \"          inet addr:127.0.0.1  Mask:255.0.0.0\",\n                \"          inet6 addr: ::1/128 Scope:Host\",\n                \"          UP LOOPBACK RUNNING  MTU:65536  Metric:1\",\n                \"          RX packets:19550 errors:0 dropped:0 overruns:0 frame:0\",\n                \"          TX packets:19550 errors:0 dropped:0 overruns:0 carrier:0\",\n                \"          collisions:0 txqueuelen:0 \",\n                \"          RX bytes:1494591 (1.4 MiB)  TX bytes:1494591 (1.4 MiB)\"\n            ],\n            \"stderr_lines\": [],\n            \"_ansible_no_log\": false\n        }\n    },\n    \"status\": {\n        \"192.168.1.217\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 16:54:48','2018-10-17 16:54:52'),(35,'测试启动influxd服务','playbook/2018/10/test_Dkj40ZJ.yml','{\n    \"skipped\": {},\n    \"failed\": {},\n    \"ok\": {\n        \"192.168.1.217\": {\n            \"changed\": true,\n            \"end\": \"2018-10-17 16:58:47.604470\",\n            \"stdout\": \"Starting the process influxdb [ OK ]\\ninfluxdb process was started [ OK ]\",\n            \"cmd\": [\n                \"/etc/init.d/influxdb\",\n                \"start\"\n            ],\n            \"rc\": 0,\n            \"start\": \"2018-10-17 16:58:47.544186\",\n            \"stderr\": \"\",\n            \"delta\": \"0:00:00.060284\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"creates\": null,\n                    \"executable\": null,\n                    \"_uses_shell\": false,\n                    \"_raw_params\": \"/etc/init.d/influxdb start\",\n                    \"removes\": null,\n                    \"argv\": null,\n                    \"warn\": true,\n                    \"chdir\": null,\n                    \"stdin\": null\n                }\n            },\n            \"_ansible_parsed\": true,\n            \"stdout_lines\": [\n                \"Starting the process influxdb [ OK ]\",\n                \"influxdb process was started [ OK ]\"\n            ],\n            \"stderr_lines\": [],\n            \"_ansible_no_log\": false\n        }\n    },\n    \"status\": {\n        \"192.168.1.217\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 16:58:33','2018-10-17 16:58:46'),(36,'停止服务','playbook/2018/10/test_Yi9d2QR.yml','{\n    \"skipped\": {},\n    \"failed\": {},\n    \"ok\": {\n        \"192.168.1.217\": {\n            \"changed\": true,\n            \"end\": \"2018-10-17 17:00:06.176395\",\n            \"stdout\": \"influxdb process was stopped [ OK ]\",\n            \"cmd\": [\n                \"/etc/init.d/influxdb\",\n                \"stop\"\n            ],\n            \"rc\": 0,\n            \"start\": \"2018-10-17 17:00:05.110744\",\n            \"stderr\": \"\",\n            \"delta\": \"0:00:01.065651\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"creates\": null,\n                    \"executable\": null,\n                    \"_uses_shell\": false,\n                    \"_raw_params\": \"/etc/init.d/influxdb stop\",\n                    \"removes\": null,\n                    \"argv\": null,\n                    \"warn\": true,\n                    \"chdir\": null,\n                    \"stdin\": null\n                }\n            },\n            \"_ansible_parsed\": true,\n            \"stdout_lines\": [\n                \"influxdb process was stopped [ OK ]\"\n            ],\n            \"stderr_lines\": [],\n            \"_ansible_no_log\": false\n        }\n    },\n    \"status\": {\n        \"192.168.1.217\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 16:59:51','2018-10-17 17:00:05'),(37,'error 测试','playbook/2018/10/test_QeiWpXU.yml','{\n    \"skipped\": {},\n    \"failed\": {\n        \"192.168.1.217\": {\n            \"msg\": \"[Errno 2] \\u6ca1\\u6709\\u90a3\\u4e2a\\u6587\\u4ef6\\u6216\\u76ee\\u5f55\",\n            \"cmd\": \"/etc/init.d/infldb stop\",\n            \"rc\": 2,\n            \"invocation\": {\n                \"module_args\": {\n                    \"creates\": null,\n                    \"executable\": null,\n                    \"_uses_shell\": false,\n                    \"_raw_params\": \"/etc/init.d/infldb stop\",\n                    \"removes\": null,\n                    \"argv\": null,\n                    \"warn\": true,\n                    \"chdir\": null,\n                    \"stdin\": null\n                }\n            },\n            \"_ansible_parsed\": true,\n            \"_ansible_no_log\": false,\n            \"changed\": false\n        }\n    },\n    \"ok\": {},\n    \"status\": {\n        \"192.168.1.217\": {\n            \"ok\": 0,\n            \"changed\": 0,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 1\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 17:00:43','2018-10-17 17:00:46'),(38,'test','playbook/2018/10/test_J89mJj7.yml','{\n    \"skipped\": {},\n    \"failed\": {},\n    \"ok\": {\n        \"192.168.1.217\": {\n            \"changed\": true,\n            \"end\": \"2018-10-17 17:50:02.260691\",\n            \"stdout\": \"eth0      Link encap:Ethernet  HWaddr 20:CF:30:81:A3:18  \\n          inet addr:192.168.1.217  Bcast:192.168.1.255  Mask:255.255.255.0\\n          inet6 addr: fe80::22cf:30ff:fe81:a318/64 Scope:Link\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\n          RX packets:17507251 errors:0 dropped:0 overruns:0 frame:0\\n          TX packets:1218473 errors:0 dropped:0 overruns:0 carrier:0\\n          collisions:0 txqueuelen:1000 \\n          RX bytes:1438753783 (1.3 GiB)  TX bytes:154583782 (147.4 MiB)\\n\\nlo        Link encap:Local Loopback  \\n          inet addr:127.0.0.1  Mask:255.0.0.0\\n          inet6 addr: ::1/128 Scope:Host\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\n          RX packets:19550 errors:0 dropped:0 overruns:0 frame:0\\n          TX packets:19550 errors:0 dropped:0 overruns:0 carrier:0\\n          collisions:0 txqueuelen:0 \\n          RX bytes:1494591 (1.4 MiB)  TX bytes:1494591 (1.4 MiB)\",\n            \"cmd\": [\n                \"ifconfig\"\n            ],\n            \"rc\": 0,\n            \"start\": \"2018-10-17 17:50:02.218951\",\n            \"stderr\": \"\",\n            \"delta\": \"0:00:00.041740\",\n            \"invocation\": {\n                \"module_args\": {\n                    \"creates\": null,\n                    \"executable\": null,\n                    \"_uses_shell\": false,\n                    \"_raw_params\": \"ifconfig\",\n                    \"removes\": null,\n                    \"argv\": null,\n                    \"warn\": true,\n                    \"chdir\": null,\n                    \"stdin\": null\n                }\n            },\n            \"_ansible_parsed\": true,\n            \"stdout_lines\": [\n                \"eth0      Link encap:Ethernet  HWaddr 20:CF:30:81:A3:18  \",\n                \"          inet addr:192.168.1.217  Bcast:192.168.1.255  Mask:255.255.255.0\",\n                \"          inet6 addr: fe80::22cf:30ff:fe81:a318/64 Scope:Link\",\n                \"          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\",\n                \"          RX packets:17507251 errors:0 dropped:0 overruns:0 frame:0\",\n                \"          TX packets:1218473 errors:0 dropped:0 overruns:0 carrier:0\",\n                \"          collisions:0 txqueuelen:1000 \",\n                \"          RX bytes:1438753783 (1.3 GiB)  TX bytes:154583782 (147.4 MiB)\",\n                \"\",\n                \"lo        Link encap:Local Loopback  \",\n                \"          inet addr:127.0.0.1  Mask:255.0.0.0\",\n                \"          inet6 addr: ::1/128 Scope:Host\",\n                \"          UP LOOPBACK RUNNING  MTU:65536  Metric:1\",\n                \"          RX packets:19550 errors:0 dropped:0 overruns:0 frame:0\",\n                \"          TX packets:19550 errors:0 dropped:0 overruns:0 carrier:0\",\n                \"          collisions:0 txqueuelen:0 \",\n                \"          RX bytes:1494591 (1.4 MiB)  TX bytes:1494591 (1.4 MiB)\"\n            ],\n            \"stderr_lines\": [],\n            \"_ansible_no_log\": false\n        }\n    },\n    \"status\": {\n        \"192.168.1.217\": {\n            \"ok\": 1,\n            \"changed\": 1,\n            \"unreachable\": 0,\n            \"skipped\": 0,\n            \"failed\": 0\n        }\n    },\n    \"unreachable\": {},\n    \"changed\": {}\n}','Y','2018-10-17 17:49:50','2018-10-17 17:50:01');
/*!40000 ALTER TABLE `tasks_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_order_echarts_order`
--

DROP TABLE IF EXISTS `work_order_echarts_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_order_echarts_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(10) NOT NULL,
  `web` varchar(10) NOT NULL,
  `db` varchar(10) NOT NULL,
  `crontab` varchar(10) NOT NULL,
  `conf` varchar(10) NOT NULL,
  `other` varchar(10) NOT NULL,
  `data_collection_time` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_order_echarts_order`
--

LOCK TABLES `work_order_echarts_order` WRITE;
/*!40000 ALTER TABLE `work_order_echarts_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_order_echarts_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_order_workorder`
--

DROP TABLE IF EXISTS `work_order_workorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_order_workorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `type` int(11) NOT NULL,
  `order_contents` longtext NOT NULL,
  `status` int(11) NOT NULL,
  `result_desc` longtext,
  `apply_time` datetime NOT NULL,
  `complete_time` datetime NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `assign_to_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `work_order_workorder_applicant_id_fc3d5bfa_fk_dashboard` (`applicant_id`),
  KEY `work_order_workorder_assign_to_id_7fc66e0e_fk_dashboard` (`assign_to_id`),
  CONSTRAINT `work_order_workorder_applicant_id_fc3d5bfa_fk_dashboard` FOREIGN KEY (`applicant_id`) REFERENCES `dashboard_userprofile` (`id`),
  CONSTRAINT `work_order_workorder_assign_to_id_7fc66e0e_fk_dashboard` FOREIGN KEY (`assign_to_id`) REFERENCES `dashboard_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_order_workorder`
--

LOCK TABLES `work_order_workorder` WRITE;
/*!40000 ALTER TABLE `work_order_workorder` DISABLE KEYS */;
INSERT INTO `work_order_workorder` VALUES (1,'数据库测试',0,'重启数据库',3,NULL,'2018-10-12 18:57:20','2018-10-14 15:45:57',1,4),(2,'数据库测试',0,'重启数据库',2,'已处理完毕','2018-10-12 18:57:25','2018-10-14 14:52:55',1,4),(3,'数据库测试',0,'重启数据库',3,NULL,'2018-10-12 18:59:02','2018-10-14 15:45:39',1,4),(4,'test',1,'重启数据库',1,NULL,'2018-10-14 09:12:07','2018-10-14 15:44:29',1,2),(5,'test111',0,'重启数据库',2,'done','2018-10-14 09:15:32','2018-10-14 14:52:39',1,3),(6,'test',1,'重启数据库',2,'done','2018-10-14 09:49:52','2018-10-14 12:26:29',1,6),(7,'测试计划任务',2,'测试计划任务，设置定时数据库备份策略，太古神王安卓混服',2,'1111','2018-10-14 12:13:45','2018-10-14 15:43:54',1,4),(8,'test111',0,'重启数据库',0,NULL,'2018-10-14 15:46:56','2018-10-14 15:46:56',1,2),(9,'test',0,'重启数据库',0,NULL,'2018-10-14 15:59:28','2018-10-14 15:59:28',1,4),(10,'test111',1,'重启数据库',3,NULL,'2018-10-14 16:00:20','2018-10-14 16:00:39',2,4),(11,'test',0,'重启数据库',1,NULL,'2018-10-14 16:01:05','2018-10-14 16:01:15',2,3),(12,'数据库测试',0,'重启数据库',2,'done','2018-10-14 16:01:26','2018-10-14 16:02:01',2,6),(13,'test',3,'重启数据库',0,NULL,'2018-10-14 16:01:38','2018-10-14 16:01:38',2,4),(14,'test111',0,'重启数据库',0,NULL,'2018-10-14 16:32:49','2018-10-14 16:32:49',1,1),(15,'test',1,'重启数据库',3,NULL,'2018-10-14 16:35:25','2018-10-17 17:01:59',1,1),(16,'test',1,'重启数据库',0,NULL,'2018-10-14 16:41:08','2018-10-14 16:41:08',1,1),(17,'数据库测试',3,'重启数据库',0,NULL,'2018-10-14 16:42:32','2018-10-14 16:42:32',1,2),(18,'test111',1,'重启数据库',0,NULL,'2018-10-15 10:40:08','2018-10-15 10:40:08',1,2),(19,'test111',1,'重启数据库',2,'done','2018-10-15 10:42:11','2018-10-15 11:23:45',1,2),(20,'数据库测试',0,'重启数据库',0,NULL,'2018-10-15 11:02:28','2018-10-15 11:02:28',1,2),(21,'升级nginx',1,'更新重启官网',0,NULL,'2018-10-15 11:04:57','2018-10-15 11:04:57',1,2);
/*!40000 ALTER TABLE `work_order_workorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zabbix_cache_host`
--

DROP TABLE IF EXISTS `zabbix_cache_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zabbix_cache_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostid` int(11) NOT NULL,
  `host` varchar(50) DEFAULT NULL,
  `ip` varchar(32) NOT NULL,
  `updatetime` datetime NOT NULL,
  `server_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `server_id` (`server_id`),
  KEY `zabbix_cache_host_hostid_d5e20121` (`hostid`),
  KEY `zabbix_cache_host_ip_778fd9a2` (`ip`),
  CONSTRAINT `zabbix_cache_host_server_id_1739d2c7_fk_resources_server_id` FOREIGN KEY (`server_id`) REFERENCES `resources_server` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zabbix_cache_host`
--

LOCK TABLES `zabbix_cache_host` WRITE;
/*!40000 ALTER TABLE `zabbix_cache_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `zabbix_cache_host` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-23 18:11:56
