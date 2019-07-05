-- MySQL dump 10.13  Distrib 5.7.25, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: minmeng_guiyang_ui
-- ------------------------------------------------------
-- Server version	5.7.25

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
-- Table structure for table `navs`
--

DROP TABLE IF EXISTS `navs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navs` (
  `id` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL COMMENT '名称',
  `alias` varchar(64) DEFAULT NULL COMMENT '别名',
  `link` varchar(255) NOT NULL COMMENT '链接地址',
  `nav_type` varchar(2) NOT NULL DEFAULT '1' COMMENT '导航类型：1:文本导航，2：关联分类',
  `cat_id` varchar(32) DEFAULT NULL COMMENT '关联分类ID,可以为空',
  `sub_depth` int(11) NOT NULL DEFAULT '0' COMMENT '子导航深度，深度的显示决定于栏目分类下级分类深度',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:1:启用,0:未启用',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navs`
--

LOCK TABLES `navs` WRITE;
/*!40000 ALTER TABLE `navs` DISABLE KEYS */;
INSERT INTO `navs` VALUES ('201904261035157124','盟务要闻',NULL,'/c/mwyw','2','201904260957595792',0,1,'1','2019-04-26 10:36:10','2019-04-26 10:36:10'),('201904261425567681','自身建设',NULL,'/c/zsjs','2','201904261037381844',2,2,'1','2019-04-26 14:27:04','2019-04-26 14:27:04'),('201904261427147460','参政议政',NULL,'/c/czyz','2','201904261045247891',0,4,'1','2019-04-26 14:27:48','2019-04-26 14:27:48'),('201904261428183195','社会服务',NULL,'/c/shfw','2','201904261047314603',0,4,'1','2019-04-26 14:28:35','2019-04-26 14:28:35'),('201904261428406212','基层动态',NULL,'/c/jcdt','2','201904261051171001',2,5,'1','2019-04-26 14:29:43','2019-04-26 14:29:43'),('201904261430469974','盟员风采',NULL,'/c/myfc','2','201904261105199410',2,6,'1','2019-04-26 14:31:04','2019-04-26 14:31:04'),('201904261431355763','学习园地',NULL,'/c/xxyd','2','201904261056322027',2,7,'1','2019-04-26 14:31:52','2019-04-26 14:31:52'),('201904261432068852','资料下载',NULL,'/c/zlxz','2','201904261416582048',0,8,'1','2019-04-26 14:32:26','2019-04-26 14:32:26');
/*!40000 ALTER TABLE `navs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_views`
--

DROP TABLE IF EXISTS `page_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_views` (
  `id` varchar(32) NOT NULL,
  `page_id` varchar(32) NOT NULL COMMENT '页面ID',
  `view_id` varchar(32) NOT NULL COMMENT '控件ID',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:1:启用,0:未启用',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `view_id` (`view_id`),
  CONSTRAINT `page_views_ibfk_1` FOREIGN KEY (`view_id`) REFERENCES `views` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_views`
--

LOCK TABLES `page_views` WRITE;
/*!40000 ALTER TABLE `page_views` DISABLE KEYS */;
INSERT INTO `page_views` VALUES ('201904261004281262','20150522001','201904260927078843',1,'1','2019-04-26 10:04:28','2019-04-26 10:04:28'),('201904261016514655','20150522001','201904261009167078',2,'1','2019-04-26 10:16:51','2019-04-26 10:16:51'),('201904261017045188','20150522001','201904261014127483',3,'1','2019-04-26 10:17:04','2019-04-26 10:17:04'),('201904261115084700','20150522001','201904261015031750',4,'1','2019-04-26 11:15:08','2019-04-26 11:15:08'),('201904261122083106','20150522001','201904261108113141',5,'1','2019-04-26 11:22:08','2019-04-26 11:22:08'),('201904261122173720','20150522001','201904261108545028',6,'1','2019-04-26 11:22:17','2019-04-26 11:22:17'),('201904261122378938','20150522001','201904261109284843',7,'1','2019-04-26 11:22:37','2019-04-26 11:22:37'),('201904261122488281','20150522001','201904261111347460',8,'1','2019-04-26 11:22:48','2019-04-26 11:22:48'),('201904261123157061','20150522001','201904261113038407',10,'1','2019-04-26 11:23:15','2019-04-26 11:23:15');
/*!40000 ALTER TABLE `page_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL COMMENT '页面：index：首页',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `keywords` varchar(255) DEFAULT NULL COMMENT '页面关键字',
  `descri` varchar(255) DEFAULT NULL COMMENT '页面说明',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES ('20150522001','index','贵阳民盟','关键词','描述','2019-04-26 10:32:49','2019-04-26 10:32:49'),('20150522002','list','标题','关键词','描述','2018-12-18 00:00:00','2018-12-18 00:00:00'),('20150522003','info','标题','关键词','描述','2018-12-18 00:00:00','2018-12-18 00:00:00');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_items`
--

DROP TABLE IF EXISTS `view_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view_items` (
  `id` varchar(32) NOT NULL,
  `cat_id` varchar(32) DEFAULT NULL COMMENT '分类ID',
  `view_id` varchar(32) NOT NULL COMMENT '组件ID',
  `content` text COMMENT '文本内容',
  `link` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `image` varchar(255) DEFAULT NULL COMMENT '图片',
  `target` varchar(32) DEFAULT '_blank' COMMENT '打开目标',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `is_ad` tinyint(1) NOT NULL COMMENT '是否为广告,0：否，1:是',
  `price` double(11,2) DEFAULT NULL COMMENT '广告价格',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:1:启用,0:未启用',
  PRIMARY KEY (`id`),
  KEY `view_id` (`view_id`),
  CONSTRAINT `view_items_ibfk_1` FOREIGN KEY (`view_id`) REFERENCES `views` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_items`
--

LOCK TABLES `view_items` WRITE;
/*!40000 ALTER TABLE `view_items` DISABLE KEYS */;
INSERT INTO `view_items` VALUES ('201904261000046791','201904260957595792','201904260927078843','','',NULL,'','2019-04-26 10:00:23','2019-04-26 10:00:23','2019-04-26 10:00:23','2019-04-26 10:00:23',0,0.00,1,'1'),('201904261022437166','201904261020256122','201904261009167078','','',NULL,'','2019-04-26 10:23:02','2019-04-26 10:23:02','2019-04-26 10:23:02','2019-04-26 10:23:02',0,0.00,99,'1'),('201904261025058412',NULL,'201904261014127483','','','attaches/image/20190426/201904261025477957.png','_blank','2019-04-26 10:26:31','2019-04-26 10:26:31','2019-04-26 10:26:31','2019-04-26 10:26:31',0,0.00,99,'1'),('201904261113575072','201904261038228346','201904261015031750','','',NULL,'','2019-04-26 11:14:16','2019-04-26 11:14:16','2019-04-26 11:14:16','2019-04-26 11:14:16',0,0.00,1,'1'),('201904261114193097','201904261043116435','201904261015031750','','',NULL,'','2019-04-26 11:14:27','2019-04-26 11:14:27','2019-04-26 11:14:27','2019-04-26 11:14:27',0,0.00,2,'1'),('201904261114289512','201904261043535286','201904261015031750','','',NULL,'','2019-04-26 11:14:35','2019-04-26 11:14:35','2019-04-26 11:14:35','2019-04-26 11:14:35',0,0.00,3,'1'),('201904261114375700','201904261044247238','201904261015031750','','',NULL,'','2019-04-26 11:14:44','2019-04-26 11:14:44','2019-04-26 11:14:44','2019-04-26 11:14:44',0,0.00,4,'1'),('201904261115451875','201904261045247891','201904261108113141','','',NULL,'','2019-04-26 11:15:56','2019-04-26 11:15:56','2019-04-26 11:15:56','2019-04-26 11:15:56',0,0.00,1,'1'),('201904261120103637','201904261047314603','201904261108545028','','',NULL,'','2019-04-26 11:20:18','2019-04-26 11:20:18','2019-04-26 11:20:18','2019-04-26 11:20:18',0,0.00,1,'1'),('201904261124413034','201904261105476619','201904261113038407','','',NULL,'','2019-04-26 11:24:59','2019-04-26 11:24:59','2019-04-26 11:24:59','2019-04-26 11:24:59',0,0.00,1,'1'),('201904261125028675','201904261106215682','201904261113038407','','',NULL,'','2019-04-26 11:25:10','2019-04-26 11:25:10','2019-04-26 11:25:10','2019-04-26 11:25:10',0,0.00,2,'1'),('201904261127355271','201904261053197498','201904261109284843','','',NULL,'','2019-04-26 11:27:58','2019-04-26 11:27:58','2019-04-26 11:27:58','2019-04-26 11:27:58',0,0.00,1,'1'),('201904261128399853',NULL,'201904261110204215','<span><span>民盟</span><br />\r\n<span>遵义市委</span></span><span></span>','','attaches/image/20190426/201904261132363224.png','_blank','2019-04-26 11:31:43','2019-04-26 11:32:52','2019-04-26 11:31:43','2019-04-26 11:31:43',0,0.00,1,'1'),('201904261132567616',NULL,'201904261110204215','<span>民盟</span><br />\r\n<span>安顺市委</span>','','attaches/image/20190426/201904261133088445.png','_blank','2019-04-26 11:33:21','2019-04-26 11:33:21','2019-04-26 11:33:21','2019-04-26 11:33:21',0,0.00,2,'1'),('201904261134099843',NULL,'201904261110204215','<span>民盟</span><br />\r\n<span>六盘水市委</span>','','attaches/image/20190426/201904261134293958.png','_blank','2019-04-26 11:34:41','2019-04-26 11:34:41','2019-04-26 11:34:41','2019-04-26 11:34:41',0,0.00,3,'1'),('201904261134552607',NULL,'201904261110204215','<span>民盟</span><br />\r\n<span>黔西南州委</span>','','attaches/image/20190426/201904261135149089.png','_blank','2019-04-26 11:35:28','2019-04-26 11:35:28','2019-04-26 11:35:28','2019-04-26 11:35:28',0,0.00,4,'1'),('201904261135325957',NULL,'201904261110204215','<span>民盟</span><br />\r\n<span>毕节市委</span>','','attaches/image/20190426/201904261135581448.png','_blank','2019-04-26 11:36:01','2019-04-26 11:36:01','2019-04-26 11:36:01','2019-04-26 11:36:01',0,0.00,5,'1'),('201904261136042041',NULL,'201904261110204215','<span>民盟</span><br />\r\n<span>黔东南工委</span>','','attaches/image/20190426/201904261136289600.png','_blank','2019-04-26 11:36:31','2019-04-26 11:36:31','2019-04-26 11:36:31','2019-04-26 11:36:31',0,0.00,6,'1'),('201904261136347931',NULL,'201904261110204215','<span>民盟</span><br />\r\n<span>黔南州工委</span>','','attaches/image/20190426/201904261136541668.png','_blank','2019-04-26 11:36:58','2019-04-26 11:36:58','2019-04-26 11:36:58','2019-04-26 11:36:58',0,0.00,7,'1'),('201904261414541333','201904261057089894','201904261111347460','','',NULL,'','2019-04-26 14:15:22','2019-04-26 14:15:47','2019-04-26 14:15:22','2019-04-26 14:15:22',0,0.00,2,'1'),('201904261415259007','201904261057592085','201904261111347460','','',NULL,'','2019-04-26 14:15:38','2019-04-26 14:15:54','2019-04-26 14:15:38','2019-04-26 14:15:38',0,0.00,1,'1'),('201904261417409905','201904261416582048','201904261111347460','','',NULL,'','2019-04-26 14:17:46','2019-04-26 14:17:46','2019-04-26 14:17:46','2019-04-26 14:17:46',0,0.00,3,'1');
/*!40000 ALTER TABLE `view_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `views`
--

DROP TABLE IF EXISTS `views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT '识别名称',
  `mode` varchar(255) DEFAULT NULL COMMENT '类型：0:容器，1：关联分类，2：自定义内容',
  `style` varchar(255) DEFAULT NULL COMMENT '样式',
  `max_items` int(11) NOT NULL DEFAULT '8' COMMENT '最大条目数',
  `link` varchar(255) DEFAULT '' COMMENT '链接地址',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '父层组件ID',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:1:启用,0:未启用',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `out_mode` varchar(32) DEFAULT NULL COMMENT '当前控件为子控件时使用，输出的方式:before，在前面输出，after:在后面输出',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `views`
--

LOCK TABLES `views` WRITE;
/*!40000 ALTER TABLE `views` DISABLE KEYS */;
INSERT INTO `views` VALUES ('201904260927078843','盟务要闻','1','thumbtextlist mwyw',6,NULL,NULL,'1',1,NULL,'2019-04-26 09:27:39','2019-04-26 09:27:39'),('201904261009167078','公示公告','1','textlist gsgg',3,NULL,NULL,'1',2,NULL,'2019-04-26 10:10:05','2019-04-26 10:10:05'),('201904261014127483','横幅广告','2','banner',1,'/c/tzl',NULL,'1',3,NULL,'2019-04-26 10:14:44','2019-04-26 10:14:44'),('201904261015031750','自身建设','1','textlist zsjs',4,NULL,NULL,'1',5,NULL,'2019-04-26 10:16:02','2019-04-26 10:16:02'),('201904261108113141','参政议政','1','textlist czyz',6,NULL,NULL,'1',6,NULL,'2019-04-26 11:08:44','2019-04-26 11:08:44'),('201904261108545028','社会服务','1','textlist shfw',6,NULL,NULL,'1',7,NULL,'2019-04-26 11:09:25','2019-04-26 11:09:25'),('201904261109284843','基层动态','1','textlist jcdt',5,NULL,NULL,'1',8,NULL,'2019-04-26 11:09:57','2019-04-26 11:09:57'),('201904261110204215','民盟联盟','2','sudoku',7,NULL,'201904261109284843','1',8,'after','2019-04-26 11:10:52','2019-04-26 11:38:24'),('201904261111347460','学习园地','1','textlist xxyd',1,NULL,NULL,'1',9,NULL,'2019-04-26 11:12:08','2019-04-26 11:12:08'),('201904261112247312','年度重点','1','textlist ndzd',6,'/c/tzl',NULL,'1',10,NULL,'2019-04-26 11:12:51','2019-04-26 11:12:51'),('201904261113038407','盟员风采','1','thumblist myfc',6,NULL,NULL,'1',12,NULL,'2019-04-26 11:13:32','2019-04-26 11:13:32');
/*!40000 ALTER TABLE `views` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-09 13:10:47
