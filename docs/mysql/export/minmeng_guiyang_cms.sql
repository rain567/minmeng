-- MySQL dump 10.13  Distrib 5.7.25, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: minmeng_guiyang_cms
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
-- Table structure for table `content_attaches`
--

DROP TABLE IF EXISTS `content_attaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_attaches` (
  `id` varchar(32) NOT NULL,
  `content_id` varchar(32) NOT NULL COMMENT '内容ID',
  `attach_id` varchar(32) NOT NULL COMMENT '附件ID',
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`),
  KEY `attach_id` (`attach_id`),
  CONSTRAINT `content_attaches_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `content_infos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `content_attaches_ibfk_2` FOREIGN KEY (`attach_id`) REFERENCES `attaches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_attaches`
--

LOCK TABLES `content_attaches` WRITE;
/*!40000 ALTER TABLE `content_attaches` DISABLE KEYS */;
INSERT INTO `content_attaches` VALUES ('201904261003102777','201904261002188741','2953eee0e6ca51c5bd4ab06d9f74984c'),('201904261420435337','201904261419464829','dcc2ed998085258d8f1c7ab1d73c9823'),('201904261422045227','201904261421373656','5693442da0ade1e5496895d78fb02da8'),('201904261424449958','201904261424028669','b9b830f006f18ebb1e03cbd46bc8d3af');
/*!40000 ALTER TABLE `content_attaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_infos`
--

DROP TABLE IF EXISTS `content_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_infos` (
  `id` varchar(32) NOT NULL,
  `cat_id` varchar(32) NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `subtitle` varchar(255) DEFAULT NULL COMMENT '副标题',
  `content` longtext NOT NULL COMMENT '内容',
  `source` varchar(32) DEFAULT NULL COMMENT '作者/来源',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键词',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `creater` varchar(32) NOT NULL COMMENT '创建用户ID',
  `updater` varchar(32) NOT NULL COMMENT '更新用户ID',
  `video` varchar(255) DEFAULT '' COMMENT '视频地址',
  `brower` int(11) NOT NULL DEFAULT '0' COMMENT '访问量',
  `like_total` int(11) NOT NULL DEFAULT '0' COMMENT '点赞数',
  `status` char(2) NOT NULL DEFAULT '0' COMMENT '0:创建,1:提交未审核,2：审核通过,3:审核不通过,－1:关闭',
  `recom` char(2) NOT NULL DEFAULT '0' COMMENT '0:默认，1:推荐到列表页，2:推荐到内页，3:推到全站首页',
  `href` varchar(255) DEFAULT '' COMMENT '自定义链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_infos`
--

LOCK TABLES `content_infos` WRITE;
/*!40000 ALTER TABLE `content_infos` DISABLE KEYS */;
INSERT INTO `content_infos` VALUES ('201904261002188741','201904260957595792','全国政协副主席、民盟中央常务副主席陈晓光率队到贵州考察调研','','','','','2019-04-26 10:02:18','2019-04-26 10:03:10','','','',0,0,'0','0','https://mp.weixin.qq.com/s/cZfgRjeLOcMnqxfVAbd2ZA'),('201904261022041194','201904261020256122','测试123456789','','','','','2019-04-26 10:22:04','2019-05-09 11:21:24','','','',8,0,'0','0',''),('201904261153504421','201904261045247891','测试20190426','','','','','2019-04-26 11:53:50','2019-05-09 11:21:24','','','',3,0,'0','0',''),('201904261154591994','201904261053197498','测试TEST20192019','','测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019测试TEST20192019','','','2019-04-26 11:54:59','2019-05-09 11:21:31','','','',8,0,'0','0',''),('201904261200197249','201904261047314603','【社会服务】远程医疗试点案例教学','','','','','2019-04-26 12:00:19','2019-04-26 12:00:34','','','',0,0,'0','0','https://mp.weixin.qq.com/s/sKx07q3QpodmuF90WP4WDw'),('201904261418454627','201904261057089894','2017第2期','','<img src=\"http://47.107.237.41/upload/image/20170725/20170725154983948394.jpg\" alt=\"\" />','','','2019-04-26 14:18:45','2019-05-09 11:21:33','','','',5,0,'0','0',''),('201904261419464829','201904261057592085','《牢记历史、铭记宗旨、不忘初心、继续前行》','','<h2>\r\n	牢记历史，不忘初心，要永远铭记老一辈革命先烈的付出与奉献，珍惜眼前的美好生活。\r\n</h2>\r\n<h2>\r\n	牢记历史，不忘初心，要永远铭记老一辈革命先烈的付出与奉献，珍惜眼前的美好生活。\r\n</h2>','','','2019-04-26 14:19:46','2019-05-09 11:26:32','','','',6,0,'0','0',''),('201904261421373656','201904261105476619',' 黔东南：扶贫一线上的民盟人','','','','','2019-04-26 14:21:37','2019-05-09 11:26:32','','','',6,0,'0','0',''),('201904261424028669','201904261106215682','科普活边—参观天眼','','<p>\r\n	<img width=\"520\" height=\"350\" alt=\"\" src=\"http://resources.mmgzsw.org.cn/attaches/image/20190131/20190131163835_68.jpg\" />\r\n</p>\r\n<p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">科普活边—参观天眼&nbsp;</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">&nbsp;陈君德</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">&nbsp;&nbsp;&nbsp;&nbsp;2018年4月27日，民盟贵大工学退休支部与贵大蔡家关校区老年体协联合会组织了一次参观目前世界最大射电望远镜一天眼的科普活动。参加者有退休支部盟员20人和贵大退休职工28人。其中80岁以上健康老人6位。</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">&nbsp;&nbsp;&nbsp;&nbsp;上午11点半，满载48人的旅游大巴沿贵惠大道和惠罗（甸）高速经边阳古镇，历时3小时到达平塘县克度镇。在布依山庄吃完简餐后乘车前往天眼景区。在景区内大家分批登上摆渡车中巴，行驶22公里崎岖山路后到达天眼观景点。下后步行攀登789级台阶上观景台。沿途经过五个平台，每个平台都有一座星座塑像：如第一平台为双鱼座，相应名人为爱因斯坦等，第五平台为天蝎座，相应名人为钱学森等。过了这五个平台，大家登上了最高观景平台。俯瞰天眼。四周群山环抱，景象壮观。因为要避免电子干扰，游客的手机、数码相机和钥匙手表等物品都不能带上观景台。为弥补这一遗憾，有专业人员用光学胶卷相机帮顾客照相后用快递送达。每张收费35元。因为排队人多，大部分盟员未照相。大家沿台阶原路返回后又乘摆渡中巴车返回景区入口区内并进入《平塘国际天文体验馆》。馆内大厅耸立看诗人屈原站在地球仪上的塑像，正在《天问》。大家穿越了“时光隧道”。听取了有关宇宙、银河系和太阳系的科普介绍。参观了国际著名射电望远镜的模型：德国的直径100米;美国的300米。综合性能指标比美国高约2.5倍。这充分表明了中国的射电望远镜目前稳居世界第一。</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">&nbsp;&nbsp;&nbsp;&nbsp;为了弥补现场无法照相的遗憾，大家在体验馆内照了不少相。</span>\r\n	</p>\r\n	<p style=\"text-align:center;\">\r\n		<img alt=\"\" src=\"http://resources.mmgzsw.org.cn/attaches/image/20190131/20190131163904_364.jpg\" />\r\n	</p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">&nbsp;&nbsp;&nbsp;&nbsp;天眼选址平塘县克度镇的原因有三：一、自然的天坑，其形状最接近500米直径射电望远镜所需的形态；二、喀斯特地貌排水性能良好，雨水会自然渗入地下；三、方圆五千米范围内无任何发射电磁波的工厂企业或单位。</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"font-size:18px;\">&nbsp;&nbsp;&nbsp;&nbsp;通过这次参观，大家开了眼界，为祖国的天文事业的长足进步欢欣鼓舞。学到了不少关于宇宙和太阳系的科普知识。绝大部分人都登上了观景平台，经受了789级台阶的考验，为自己的健康体魄感到欣慰。</span>\r\n	</p>\r\n</p>','','','2019-04-26 14:24:02','2019-05-09 11:21:31','','','',5,0,'0','0','');
/*!40000 ALTER TABLE `content_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fetch_records`
--

DROP TABLE IF EXISTS `fetch_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fetch_records` (
  `id` varchar(32) NOT NULL,
  `fetch_type` varchar(32) DEFAULT NULL COMMENT 'list:列表，detail:详情',
  `url` varchar(255) NOT NULL COMMENT '链接地址',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fetch_records`
--

LOCK TABLES `fetch_records` WRITE;
/*!40000 ALTER TABLE `fetch_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `fetch_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_contents`
--

DROP TABLE IF EXISTS `forum_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_contents` (
  `id` varchar(32) NOT NULL,
  `forum_id` varchar(32) NOT NULL COMMENT '专题ID',
  `content_id` varchar(32) NOT NULL COMMENT '内容ID',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:0:未启用,1:启用',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_contents`
--

LOCK TABLES `forum_contents` WRITE;
/*!40000 ALTER TABLE `forum_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forums` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT '名称',
  `uri` varchar(255) NOT NULL COMMENT 'URI',
  `image` varchar(255) DEFAULT NULL COMMENT '专题图片',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:0:未启用,1:启用',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forums`
--

LOCK TABLES `forums` WRITE;
/*!40000 ALTER TABLE `forums` DISABLE KEYS */;
/*!40000 ALTER TABLE `forums` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-09 13:10:38
