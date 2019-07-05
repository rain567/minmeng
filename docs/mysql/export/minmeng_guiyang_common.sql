-- MySQL dump 10.13  Distrib 5.7.25, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: minmeng_guiyang_common
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
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ads` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `position` varchar(32) NOT NULL DEFAULT '' COMMENT '广告位：index_rotaion:首页轮播，index_banner:首页横幅广告',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `href` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `text` varchar(999) DEFAULT NULL COMMENT '广告内容',
  `price` double(11,2) DEFAULT NULL COMMENT '价格',
  `descri` varchar(255) DEFAULT NULL COMMENT '广告说明',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:0:未启用,1:启用',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES ('201904261147096397','index_rotation','attaches/image/20190426/201904261150261973.png',NULL,'',0.00,NULL,'2019-04-26 11:50:44','2019-04-26 11:50:44','2019-04-26 11:50:44','2019-04-26 11:50:44','1',1),('201904261151334930','mobile_index_rotation','attaches/image/20190426/201904261151301447.png',NULL,'',0.00,NULL,'2019-04-26 11:51:35','2019-04-26 11:51:35','2019-04-26 11:51:35','2019-04-26 11:51:35','1',2),('201904261152007065','mobile_page_banner','attaches/image/20190426/201904261151588078.png',NULL,'',0.00,NULL,'2019-04-26 11:52:01','2019-04-26 11:52:01','2019-04-26 11:52:01','2019-04-26 11:52:01','1',3),('201904261152548040','page_banner','attaches/image/20190426/201904261152493721.png',NULL,'',0.00,NULL,'2019-04-26 11:52:56','2019-04-26 11:52:56','2019-04-26 11:52:56','2019-04-26 11:52:56','1',4);
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attaches`
--

DROP TABLE IF EXISTS `attaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attaches` (
  `id` varchar(32) NOT NULL,
  `alt` varchar(255) NOT NULL COMMENT '说明',
  `file_path` varchar(255) NOT NULL COMMENT '文件路径',
  `url` varchar(255) NOT NULL COMMENT '访问地址',
  `att_type` varchar(32) DEFAULT NULL COMMENT '类型：image,file,video,flash,txt,doc',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `user_id` varchar(32) DEFAULT NULL COMMENT '创建会员',
  `editor_id` varchar(32) DEFAULT NULL COMMENT '创建编辑员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attaches`
--

LOCK TABLES `attaches` WRITE;
/*!40000 ALTER TABLE `attaches` DISABLE KEYS */;
INSERT INTO `attaches` VALUES ('2953eee0e6ca51c5bd4ab06d9f74984c','全国政协副主席、民盟中央常务副主席陈晓光率队到贵州考察调研','/data/projects/minmeng-guiyang/web/ROOT/attaches/file/20190426/201904261002286920.jpg','attaches/image/20190426/201904261002286920.jpg','image','2019-04-26 10:03:10','2019-04-26 10:03:10',NULL,NULL),('5693442da0ade1e5496895d78fb02da8',' 黔东南：扶贫一线上的民盟人','/data/projects/minmeng-guiyang/web/ROOT/attaches/file/20190426/201904261421546172.jpg','attaches/image/20190426/201904261421546172.jpg','image','2019-04-26 14:22:04','2019-04-26 14:22:04',NULL,NULL),('b9b830f006f18ebb1e03cbd46bc8d3af','科普活边—参观天眼','/data/projects/minmeng-guiyang/web/ROOT/attaches/file/20190426/201904261424389573.jpg','attaches/image/20190426/201904261424389573.jpg','image','2019-04-26 14:24:44','2019-04-26 14:24:44',NULL,NULL),('dcc2ed998085258d8f1c7ab1d73c9823','《牢记历史、铭记宗旨、不忘初心、继续前行》','/data/projects/minmeng-guiyang/web/ROOT/attaches/file/20190426/201904261420055739.png','attaches/image/20190426/201904261420055739.png','image','2019-04-26 14:20:43','2019-04-26 14:20:43',NULL,NULL);
/*!40000 ALTER TABLE `attaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boards` (
  `id` varchar(32) NOT NULL COMMENT '键',
  `title` varchar(64) NOT NULL COMMENT '留言标题',
  `content` text COMMENT '留言内容',
  `mobile` varchar(15) DEFAULT NULL COMMENT '手机号',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `fax` varchar(64) DEFAULT NULL COMMENT '传真/电话',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:0:未公开,1:公开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boards`
--

LOCK TABLES `boards` WRITE;
/*!40000 ALTER TABLE `boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cats`
--

DROP TABLE IF EXISTS `cats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cats` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT '分类名称',
  `alias` varchar(32) DEFAULT NULL COMMENT '别名',
  `uri` varchar(255) NOT NULL COMMENT '分类URI',
  `enable_uri` tinyint(1) NOT NULL DEFAULT '1' COMMENT '允许URI链接地址：0：禁止，1：允许',
  `icon` varchar(255) DEFAULT NULL COMMENT '分类图标',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '上级分类',
  `cat_type` tinyint(1) DEFAULT NULL COMMENT '分类类型：1:列表栏目，2：单页栏目',
  `list_style` varchar(32) DEFAULT NULL COMMENT '列表显示样式：1:文字列表,2:图文列表,3:缩略图,4:缩略图文',
  `status` char(2) NOT NULL DEFAULT '1' COMMENT '状态:0:未启用,1:启用',
  `sorter` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cats`
--

LOCK TABLES `cats` WRITE;
/*!40000 ALTER TABLE `cats` DISABLE KEYS */;
INSERT INTO `cats` VALUES ('201904260957595792','盟务要闻',NULL,'mwyw',1,NULL,'',1,'2','1',1,'2019-04-26 09:59:14','2019-04-26 09:59:14'),('201904261020256122','公示公告',NULL,'gsgg',1,NULL,'',1,'2','1',2,'2019-04-26 10:20:52','2019-04-26 10:20:52'),('201904261037381844','自身建设',NULL,'zsjs',1,NULL,'',1,'2','1',3,'2019-04-26 10:38:18','2019-04-26 10:38:18'),('201904261038228346','思想建设',NULL,'sxjs',1,'attaches/image/20190426/201904261043008536.png','201904261037381844',1,'1','1',1,'2019-04-26 10:43:02','2019-04-26 10:43:02'),('201904261043116435','组织建设',NULL,'zzjs',1,'attaches/image/20190426/201904261043412058.png','201904261037381844',1,'1','1',2,'2019-04-26 10:43:46','2019-04-26 10:43:46'),('201904261043535286','机关建设',NULL,'jgjs',1,'attaches/image/20190426/201904261044173761.png','201904261037381844',1,'1','1',3,'2019-04-26 10:44:19','2019-04-26 10:44:19'),('201904261044247238','制度建设',NULL,'zdjs',1,'attaches/image/20190426/201904261044463190.png','201904261037381844',1,'1','1',4,'2019-04-26 10:44:53','2019-04-26 10:44:53'),('201904261045247891','参政议政',NULL,'czyz',1,'attaches/image/20190426/201904261046177676.png','',1,'2','1',4,'2019-04-26 10:46:34','2019-04-26 10:46:34'),('201904261047314603','社会服务',NULL,'shfw',1,'attaches/image/20190426/201904261049098795.png','',1,'2','1',5,'2019-04-26 10:49:12','2019-04-26 10:49:12'),('201904261051171001','基层动态',NULL,'jcdt',1,'attaches/image/20190426/201904261052126518.png','',1,'2','1',5,'2019-04-26 10:52:19','2019-04-26 10:52:19'),('201904261053197498','贵阳盟务',NULL,'gymw',1,'attaches/image/20190426/201904261054163172.png','201904261051171001',1,'2','1',1,'2019-04-26 10:54:29','2019-04-26 10:54:29'),('201904261056322027','学习园地',NULL,'xxyd',1,NULL,'',1,'2','1',999,'2019-04-26 10:57:04','2019-04-26 10:57:04'),('201904261057089894','黔地盟音',NULL,'qdmy',1,'attaches/image/20190426/201904261057405851.png','201904261056322027',1,'2','1',999,'2019-04-26 10:57:47','2019-04-26 10:57:47'),('201904261057592085','理论文章',NULL,'llwz',1,'attaches/image/20190426/201904261058259445.png','201904261056322027',1,'2','1',999,'2019-04-26 10:58:27','2019-04-26 10:58:27'),('201904261105199410','盟员风采',NULL,'myfc',1,NULL,'',1,'2','1',999,'2019-04-26 11:05:41','2019-04-26 11:05:41'),('201904261105476619','人物写真',NULL,'rwxz',1,NULL,'201904261105199410',1,'2','1',999,'2019-04-26 11:06:14','2019-04-26 11:06:14'),('201904261106215682','盟员作品',NULL,'myzp',1,NULL,'201904261105199410',1,'2','1',999,'2019-04-26 11:07:26','2019-04-26 11:07:26'),('201904261416582048','资料下载',NULL,'zlxz',1,'attaches/image/20190426/201904261417295715.png','',1,'2','1',999,'2019-04-26 14:17:32','2019-04-26 14:17:32');
/*!40000 ALTER TABLE `cats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_urls`
--

DROP TABLE IF EXISTS `friend_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_urls` (
  `id` varchar(32) NOT NULL,
  `logo` varchar(255) DEFAULT NULL COMMENT '网站LOGO',
  `sitename` varchar(64) NOT NULL COMMENT '网站名称',
  `url` varchar(64) NOT NULL COMMENT '网址',
  `sorter` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_urls`
--

LOCK TABLES `friend_urls` WRITE;
/*!40000 ALTER TABLE `friend_urls` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend_urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_settings`
--

DROP TABLE IF EXISTS `global_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_settings` (
  `id` varchar(32) NOT NULL COMMENT '键',
  `value` text NOT NULL COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_settings`
--

LOCK TABLES `global_settings` WRITE;
/*!40000 ALTER TABLE `global_settings` DISABLE KEYS */;
INSERT INTO `global_settings` VALUES ('footerHtml',''),('icp','黔ICP备14006765号'),('siteName','中国民主同盟贵阳市委员会');
/*!40000 ALTER TABLE `global_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keywords` (
  `id` varchar(32) NOT NULL,
  `keyword` varchar(255) NOT NULL COMMENT '词语',
  `tag` varchar(32) NOT NULL COMMENT 'hot：热搜recommend:推荐history:用户搜索历史',
  `sorter` int(11) DEFAULT NULL COMMENT '序号',
  `qcount` int(11) DEFAULT NULL COMMENT '查询次数',
  `create_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slide_links`
--

DROP TABLE IF EXISTS `slide_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slide_links` (
  `id` varchar(32) NOT NULL,
  `text` varchar(255) NOT NULL COMMENT '文本',
  `url` varchar(255) NOT NULL COMMENT '链接地址',
  `sorter` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slide_links`
--

LOCK TABLES `slide_links` WRITE;
/*!40000 ALTER TABLE `slide_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `slide_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_admins`
--

DROP TABLE IF EXISTS `sys_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_admins` (
  `id` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(15) DEFAULT NULL COMMENT '手机号',
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `sessionid` varchar(255) DEFAULT '' COMMENT '会话ID,用户退出时清除',
  `role` varchar(32) DEFAULT NULL COMMENT '角色：101:全权限,102:',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_admins`
--

LOCK TABLES `sys_admins` WRITE;
/*!40000 ALTER TABLE `sys_admins` DISABLE KEYS */;
INSERT INTO `sys_admins` VALUES ('20141225001','admin','96e79218965eb72c92a549dd5a330112',NULL,'18985411113','1','1c0b6b108d9b1f28e91df5781cf1ed192c3387',NULL),('20190131001','管理员A','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','',NULL),('20190131002','管理员B','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','',NULL),('20190131003','管理员C','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','',NULL),('20190131004','管理员D','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','',NULL),('20190131005','管理员E','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','',NULL);
/*!40000 ALTER TABLE `sys_admins` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-09 13:10:30
