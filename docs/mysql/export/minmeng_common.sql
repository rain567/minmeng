-- MySQL dump 10.13  Distrib 5.7.25, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: minmeng_common
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
INSERT INTO `ads` VALUES ('201901271525385410','index_rotation','attaches/image/20190218/201902181120047902.png',NULL,'',0.00,NULL,'2019-02-18 11:20:07','2019-02-18 11:20:07','2019-02-18 11:20:07','2019-02-18 11:20:07','1',1),('201901271526113404','page_banner','attaches/image/20190218/201902181121164238.png',NULL,'',0.00,NULL,'2019-02-18 11:21:18','2019-02-18 11:21:18','2019-02-18 11:21:18','2019-02-18 11:21:18','1',0),('201901280933181214','mobile_index_rotation','attaches/image/20190218/201902181146437620.png',NULL,'',0.00,NULL,'2019-02-18 11:46:46','2019-02-18 11:46:46','2019-02-18 11:46:46','2019-02-18 11:46:46','1',0),('201901281729287727','mobile_page_banner','attaches/image/20190218/201902181146292187.png',NULL,'',0.00,NULL,'2019-03-21 16:35:06','2019-03-21 16:35:06','2019-03-21 16:35:06','2019-03-21 16:35:06','1',0),('201903211652293627','page_banner','attaches/image/20190321/201903211652217989.png',NULL,'',0.00,NULL,'2019-03-21 16:52:30','2019-03-21 16:52:30','2019-03-21 16:52:30','2019-03-21 16:52:30','1',1);
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
INSERT INTO `attaches` VALUES ('0087c2650cd86c282ef195bc5bda312e','【全国两会】庹必光：要让百姓愿意在基层看病 关键得有能留住人的医疗水平','/data/projects/minmeng/resources/ROOT/attaches/file/20190306/201903060957519117.jpg','attaches/image/20190306/201903060957519117.jpg','image','2019-03-06 10:03:44','2019-03-06 10:03:44',NULL,NULL),('064aa523c449683267d93d0cfb6e55a3','民盟福建省委到黔调研','/data/projects/minmeng/resources/ROOT/attaches/file/20190128/201901281201469526.jpg','attaches/image/20190128/201901281201469526.jpg','image','2019-01-28 12:01:47','2019-01-28 12:01:47',NULL,NULL),('0739961272e7e105be61111898402c9f','一部《天眼》洞悉黔北世界——贵州作家冉正万','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902120957248797.jpg','attaches/image/20190212/201902120957248797.jpg','image','2019-02-12 09:57:30','2019-02-12 09:57:30',NULL,NULL),('111ff6eea48fd4281339dbf1b9c64131','民盟贵州省直属综合支部开展2019年支部组织活动','/data/projects/minmeng/resources/ROOT/attaches/file/20190423/201904231443343104.jpg','attaches/image/20190423/201904231443343104.jpg','image','2019-04-23 14:43:46','2019-04-23 14:43:46',NULL,NULL),('129aa1a878f848ffd74fa86a3a13e96c',' 【调查研究】民盟省委调研罗甸县远程医疗工作','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311018047705.jpg','attaches/image/20190131/201901311018047705.jpg','image','2019-01-31 10:18:20','2019-01-31 10:18:20',NULL,NULL),('13f10a3823520b1f2605c2308dfd99ba','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121518137648.png','attaches/image/20190412/201904121518137648.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('14936d4f33a5e163660b0d829072f62b','心系教育  诲人不倦——记民盟盟员、毕节一中特级教师刘建国','/data/projects/minmeng/resources/ROOT/attaches/file/20190214/201902141214516321.jpg','attaches/image/20190214/201902141214516321.jpg','image','2019-02-14 12:15:48','2019-02-14 12:15:48',NULL,NULL),('153df27d318b4c165a220accc4a83a68',' 学习贯彻习近平总书记对毕节试验区重要指示','/data/projects/minmeng/resources/ROOT/attaches/file/20190128/201901281455513409.jpg','attaches/image/20190128/201901281455513409.jpg','image','2019-01-28 14:55:53','2019-01-28 14:55:53',NULL,NULL),('178a3b7f419da1c692d0dcfe46616da2','2018年预算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/2018年度民盟贵州省委部门预算及说明.pdf','attaches/file/20190412/2018年度民盟贵州省委部门预算及说明.pdf','file','2019-04-12 15:29:12','2019-04-12 15:29:12',NULL,NULL),('18834c7f821802084de528ff55f0b2d2','深化党盟合作 助推医疗扶贫','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311022522900.jpg','attaches/image/20190131/201901311022522900.jpg','image','2019-01-31 10:23:07','2019-01-31 10:23:07',NULL,NULL),('188669de272385158fd3acfec4a68e9a','社会服务，黔东南盟员这样做','/data/projects/minmeng/resources/ROOT/attaches/file/20190313/201903130930475513.jpg','attaches/image/20190313/201903130930475513.jpg','image','2019-03-13 09:31:05','2019-03-13 09:31:05',NULL,NULL),('1d7f75b4110a6fc6eaad8b7e8f784058','民盟贵阳市委读书会（第三期）活动在白云区隆重举行','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151739327592.png','attaches/image/20190215/201902151739327592.png','image','2019-02-15 17:39:34','2019-02-15 17:39:34',NULL,NULL),('2113084a000dbd58134115f0520b7295','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519522231.png','attaches/image/20190412/201904121519522231.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('231030cab48a9dc731033cbf8f675b79','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519008230.png','attaches/image/20190412/201904121519008230.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('246812594f2ae690434601a2a2506e4a','民盟贵州省委省直关爱教育支部成立','/data/projects/minmeng/resources/ROOT/attaches/file/20190313/201903130859119813.jpg','attaches/image/20190313/201903130859119813.jpg','image','2019-03-13 08:59:37','2019-03-13 08:59:37',NULL,NULL),('26039002bce58984476f70b4aec1aa5c','民盟省三医支部参加医院党支部组织的赴紫云开展以“不忘初心勇担当.脱贫攻坚有作为”支部主题党日活动','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151433583897.png','attaches/image/20190215/201902151433583897.png','image','2019-02-15 14:34:02','2019-02-15 14:34:02',NULL,NULL),('292245eb7105cec9c6e97c762c5cfc44','民盟省委召开出席省“两会”民盟人大代表、政协委员联席会议','/data/projects/minmeng/resources/ROOT/attaches/file/20190228/201902281650065110.jpg','attaches/image/20190228/201902281650065110.jpg','image','2019-02-28 16:50:36','2019-02-28 16:50:36',NULL,NULL),('29e0e51d4bbed344a0a129569d9f10a8','以执着之心走科研之路——记民盟盟员、贵州大学东盟学院常务副院长、“黔灵学者”崔海洋教授','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121124082148.jpg','attaches/image/20190212/201902121124082148.jpg','image','2019-02-12 11:24:11','2019-02-12 11:24:11',NULL,NULL),('2f9f449f769cce6c7ae71031527e8e86','民盟省委社会发展专门委员会赴正安县开展调研','/data/projects/minmeng/resources/ROOT/attaches/file/20190313/201903130927336494.jpg','attaches/image/20190313/201903130927336494.jpg','image','2019-03-13 09:28:02','2019-03-13 09:28:02',NULL,NULL),('3751efe83085a88e582a9264685085b7','民盟省委直属综合支部赴开阳、贵定调研乡村振兴与山地经济发展','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151422156233.jpg','attaches/image/20190215/201902151422156233.jpg','image','2019-02-15 14:22:19','2019-02-15 14:22:19',NULL,NULL),('39647c6139622158184b05d3357d1fb3','关于转发《民盟中央关于学习贯彻习近平总书记在全国政协联组会上重要讲话精神的通知》的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/民盟中央关于学习贯彻习近平总书记在全国政协联组会上重要讲话精神的通知(盟中〔2018〕35号）.doc','attaches/file/20190131/民盟中央关于学习贯彻习近平总书记在全国政协联组会上重要讲话精神的通知(盟中〔2018〕35号）.doc','file','2019-01-31 16:20:20','2019-01-31 16:20:20',NULL,NULL),('3f7c3537543edec00b61e48d34e2cf4d','民盟贵州省委纪念中共中央发布“五一口号”70周年暨庆祝第34个教师节活动 ','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311020346026.jpg','attaches/image/20190131/201901311020346026.jpg','image','2019-01-31 10:20:47','2019-01-31 10:20:47',NULL,NULL),('496ffe7addadb125357f3d26622799ba','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519118117.png','attaches/image/20190412/201904121519118117.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('4aed0ee1a59a8a94690eade2d4271558','省人大常委会副主任、民盟贵州省委主委何力率队赴民盟中央汇报关于支持毕节建设新发展理念示范区工作','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311023371920.jpg','attaches/image/20190131/201901311023371920.jpg','image','2019-02-12 10:06:04','2019-02-12 10:06:04',NULL,NULL),('4d4d31b64cd28b18cdcb13493e7b40cc','环保部首批“三五”人才评选出炉 民盟盟员舒晓金上榜','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121111405960.jpg','attaches/image/20190212/201902121111405960.jpg','image','2019-02-12 11:13:20','2019-02-12 11:13:20',NULL,NULL),('4ea5e718259d6bedaddd4357596c71bd','民盟福建省委赴遵开展“不忘合作初心 继续携手前进”活动','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151740026094.png','attaches/image/20190215/201902151740026094.png','image','2019-02-15 17:40:04','2019-02-15 17:40:04',NULL,NULL),('509dad52ad81c5414c392934a4dd7e04','关于印发《民盟贵州省委2019年工作要点》的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190322/关于印发《民盟贵州省委2019年工作要点》的通知.pdf','attaches/file/20190322/关于印发《民盟贵州省委2019年工作要点》的通知.pdf','file','2019-03-22 15:41:23','2019-03-22 15:41:23',NULL,NULL),('52b73761536f5b99205c84a13ef89986','民盟贵州大学农生支部专题传达学习全国两会精神','/data/projects/minmeng/resources/ROOT/attaches/file/20190322/201903220922421987.jpg','attaches/image/20190322/201903220922421987.jpg','image','2019-03-22 09:23:10','2019-03-22 09:23:10',NULL,NULL),('56ed39983027bfe02acaf3afd16e9e12','妙手载生命重托 仁心铸大爱情怀——记“中国医师奖”获得者、贵州医科大学委员会盟员陈晓霞','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121004197261.jpg','attaches/image/20190212/201902121004197261.jpg','image','2019-02-12 11:09:15','2019-02-12 11:09:15',NULL,NULL),('57d2cea6d7dc149fcd102105f6e7b408','中共中央印发《中国共产党支部工作条例》','/data/projects/minmeng/resources/ROOT/attaches/file/20190128/201901281455219425.png','attaches/image/20190128/201901281455219425.png','image','2019-01-28 14:55:27','2019-01-28 14:55:27',NULL,NULL),('64ff0a62b319c8347efdbfe9dc878ec6','民盟贵州省委社会服务处赴罗甸县调研远程医疗试点','/data/projects/minmeng/resources/ROOT/attaches/file/20190313/201903131704014818.jpg','attaches/image/20190313/201903131704014818.jpg','image','2019-03-13 17:04:05','2019-03-13 17:04:05',NULL,NULL),('686db468ef298ebde3130a3c9cd4f3f9','关于申报民盟贵州省委2018年度委托调研课题的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/附件1民盟贵州省委2018年调研课题申报书.doc','attaches/file/20190131/附件1民盟贵州省委2018年调研课题申报书.doc','file','2019-01-31 16:22:38','2019-01-31 16:22:38',NULL,NULL),('691006757dcd9fb5c8321e2b89650da6','民盟福建省委到黔调研 ','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311017238140.jpg','attaches/image/20190131/201901311017238140.jpg','image','2019-01-31 10:17:36','2019-01-31 10:17:36',NULL,NULL),('733f0764d632d392cdb7e598e20c09f3','民盟贵州省委关于印发《关于民盟贵州省十二届委员会第三次全委（扩大）会分组讨论意见建议的回应》的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190322/民盟贵州省委关于印发《关于民盟贵州省十二届委员会第三次全委（扩大）会分组讨论意见建议的回应》的通知.pdf','attaches/file/20190322/民盟贵州省委关于印发《关于民盟贵州省十二届委员会第三次全委（扩大）会分组讨论意见建议的回应》的通知.pdf','file','2019-03-22 15:37:13','2019-03-22 15:37:13',NULL,NULL),('752f8f4eea75daf00f9aa70298e9e239','民盟省委召开远程医疗专题会议','/data/projects/minmeng/resources/ROOT/attaches/file/20190423/201904231439146453.jpg','attaches/image/20190423/201904231439146453.jpg','image','2019-04-23 14:39:39','2019-04-23 14:39:39',NULL,NULL),('781a7e9f87e546326b6cec5a6e194b9d','民盟省委医疗卫生专业委员会积极参加《职业病防治法》宣传周活动','/data/projects/minmeng/resources/ROOT/attaches/file/20190505/201905051040043413.jpg','attaches/image/20190505/201905051040043413.jpg','image','2019-05-05 10:41:19','2019-05-05 10:41:19',NULL,NULL),('7987ac88346c3aefe9aacbec29223f85','关于转发《民盟中央关于学习贯彻十三届全国人大一次会议和全国政协十三届一次会议精神的决定》的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/民盟中央关于学习贯彻十三届全国人大一次会议和全国政协十三届一次会议精神的决定的通知》(盟中〔2018〕36号）.doc','attaches/file/20190131/民盟中央关于学习贯彻十三届全国人大一次会议和全国政协十三届一次会议精神的决定的通知》(盟中〔2018〕36号）.doc','file','2019-01-31 16:18:18','2019-01-31 16:18:18',NULL,NULL),('7ab86efea8cc26ff8d98736fe54a681d','把最美的诗变成真实的景 ——我在贵安等你','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121710531517.jpg','attaches/image/20190212/201902121710531517.jpg','image','2019-02-12 17:10:56','2019-02-12 17:10:56',NULL,NULL),('82318bd1a3a9450666675aef406c60a3','民盟省委医疗卫生专委会召开2019年工作会议','/data/projects/minmeng/resources/ROOT/attaches/file/20190312/201903121040172926.jpg','attaches/image/20190312/201903121040172926.jpg','image','2019-03-12 10:40:21','2019-03-12 10:40:21',NULL,NULL),('83672acfab893daba53d8871cec9624e','民盟贵州省十二届委员会第九次常委(扩大)会议暨中心组学习会议在贵阳召开','/data/projects/minmeng/resources/ROOT/attaches/file/20190320/201903201452378501.jpg','attaches/image/20190320/201903201452378501.jpg','image','2019-03-20 14:56:58','2019-03-20 14:56:58',NULL,NULL),('84a45fd4dfad4331bd2eca2b9b0f4111','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121520141904.png','attaches/image/20190412/201904121520141904.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('854f01f45b705d2cba7657f3ae09f4eb','民盟贵阳市委应邀参加贵阳市十二中建校六十周年素质教育成果展活动','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151739102374.png','attaches/image/20190215/201902151739102374.png','image','2019-02-15 17:39:12','2019-02-15 17:39:12',NULL,NULL),('8a98776d368c689e7bf3099b22882da3','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519229273.png','attaches/image/20190412/201904121519229273.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('8c11f4400c8e6aa29fb9d6eaf14ed0df','【全国两会】何力委员：关注大数据综合试验区的立法实践','/data/projects/minmeng/resources/ROOT/attaches/file/20190308/201903081129251766.jpg','attaches/image/20190308/201903081129251766.jpg','image','2019-03-12 16:23:11','2019-03-12 16:23:11',NULL,NULL),('963ff82c6d1cf7f1aa3fc03da3a5d458','乔任侠作品','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121433328802.jpg','attaches/image/20190212/201902121433328802.jpg','image','2019-02-12 14:34:37','2019-02-12 14:34:37',NULL,NULL),('9b0a2cb0635d46e83cf0ab7af0fa604b','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519354639.png','attaches/image/20190412/201904121519354639.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('9ef300ac2cb65d7d70a9dd5b6541e0e8','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519393737.png','attaches/image/20190412/201904121519393737.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('9fd856899156440e80a388b8f837bcd1','民盟贵阳市委读书会（第三期）活动在白云区隆重举行','/data/projects/minmeng/resources/ROOT/attaches/file/20190218/201902181015206711.png','attaches/image/20190218/201902181015206711.png','image','2019-02-18 10:15:24','2019-02-18 10:15:24',NULL,NULL),('a1536abd6c47986b659d1ec5966aed93','《牢记历史、铭记宗旨、不忘初心、继续前行》','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311623278490.png','attaches/image/20190131/201901311623278490.png','image','2019-01-31 16:23:53','2019-01-31 16:23:53',NULL,NULL),('a61db0c1150d53df6c5bf34ceaae4828','民盟省直综合支部召开乡村振兴战略与山地经济发展建言献策座谈会','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151753419327.jpg','attaches/image/20190215/201902151753419327.jpg','image','2019-02-15 17:53:43','2019-02-15 17:53:43',NULL,NULL),('a87520533623180ac7489b18f69fa07e','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519317993.png','attaches/image/20190412/201904121519317993.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('aafa21dfff59d3a45f741a1ef4c0b6fa','民盟贵大工学支部开展组织生活','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151346454384.jpg','attaches/image/20190215/201902151346454384.jpg','image','2019-02-15 14:32:37','2019-02-15 14:32:37',NULL,NULL),('ad0c5d3f0cdd62ca683f92a1b970a9a0','民盟贵州省十二届委员会第六次常委（扩大）会议召开','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311018523028.jpg','attaches/image/20190131/201901311018523028.jpg','image','2019-01-31 10:19:16','2019-01-31 10:19:16',NULL,NULL),('ae049c3ec8e8b2b83add1db976a50eef','李刚雕塑作品《时代楷模文朝荣》','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121430254712.jpg','attaches/image/20190212/201902121430254712.jpg','image','2019-02-12 14:31:01','2019-02-12 14:31:01',NULL,NULL),('af96b2c81831861cc2e0ece8ae6e4310','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519042170.png','attaches/image/20190412/201904121519042170.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('b0288a9b344fce730b8be405ad6f6661','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121518577436.png','attaches/image/20190412/201904121518577436.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('b2a29ecc3297a037fb8c2373b9114c40','业绩就是尊严','/data/projects/minmeng/resources/ROOT/attaches/file/20190127/201901271458269039.jpeg','attaches/image/20190127/201901271458269039.jpeg','image','2019-01-31 10:13:07','2019-01-31 10:13:07',NULL,NULL),('b36d93258caa5af110cac5368c8ffc2b','情系教育 甘于奉献——记民盟盟员、贵州省五一劳动奖章获得者伍丹','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121132575489.jpg','attaches/image/20190212/201902121132575489.jpg','image','2019-02-12 11:35:20','2019-02-12 11:35:20',NULL,NULL),('b53213fcf8d2c51ccefb03ce74da64b8','民盟贵州省委、贵州医科大学附属医院医疗帮扶七星关区人民医院协商座谈会召开 ','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311021471084.jpg','attaches/image/20190131/201901311021471084.jpg','image','2019-01-31 10:21:53','2019-01-31 10:21:53',NULL,NULL),('b89cb417a1e5491560dfcfcefe453dda','民盟贵州省委、贵州医科大学赴毕节七星关区开展远程医疗帮扶调研','/data/projects/minmeng/resources/ROOT/attaches/file/20190429/201904290951066208.jpg','attaches/image/20190429/201904290951066208.jpg','image','2019-04-29 09:54:52','2019-04-29 09:54:52',NULL,NULL),('bc2000124f2d147c6e158ab6d9377cca','全国政协副主席、民盟中央常务副主席陈晓光率队到贵州考察调研','/data/projects/minmeng/resources/ROOT/attaches/file/20190423/201904231441134147.jpg','attaches/image/20190423/201904231441134147.jpg','image','2019-04-23 14:41:31','2019-04-23 14:41:31',NULL,NULL),('be32633edaa9dc8c671f260be971dd3b',' 黔东南：扶贫一线上的民盟人','/data/projects/minmeng/resources/ROOT/attaches/file/20190214/201902141209279695.jpg','attaches/image/20190214/201902141209279695.jpg','image','2019-02-14 12:10:24','2019-02-14 12:10:24',NULL,NULL),('bf755c70f307fbeea6e1b95e242bd4cd','【全国两会】何力代表：建言启动国家层面大数据立法','/data/projects/minmeng/resources/ROOT/attaches/file/20190308/201903081124423420.jpg','attaches/image/20190308/201903081124423420.jpg','image','2019-03-08 11:25:13','2019-03-08 11:25:13',NULL,NULL),('c129bacfdea64372e17355e00c0ac3e1','【全国两会】丁贵杰委员：好生态引大型企业 好环境揽优秀人才','/data/projects/minmeng/resources/ROOT/attaches/file/20190312/201903121042592543.jpg','attaches/image/20190312/201903121042592543.jpg','image','2019-03-12 10:43:18','2019-03-12 10:43:18',NULL,NULL),('c45163353ef3816ad32c4b287550c1d1','普及艾滋防治知识    构建和谐健康生活    ——民盟医药卫生综合支部走进洒金“新市民”社区','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151738525726.png','attaches/image/20190215/201902151738525726.png','image','2019-02-15 17:38:57','2019-02-15 17:38:57',NULL,NULL),('c74d827cf63737846d31afd38d5619df','遵义海归博士庹必光教授破译胃肠病隐藏密码','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121356346017.jpg','attaches/image/20190212/201902121356346017.jpg','image','2019-02-12 13:59:12','2019-02-12 13:59:12',NULL,NULL),('c80fa98f83c97e85e70a6b00602692ac','贵州籍盟员周利宏 孔海蓉 冉正万 潘闻丞参加中国文联第十次代表大会，民盟中央发来贺信','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902120958312828.png','attaches/image/20190212/201902120958312828.png','image','2019-02-12 09:58:35','2019-02-12 09:58:35',NULL,NULL),('c929450dbb4bab67357789f1bac8ca9d','关于积极参加《2018年贵州社会主义学院学报征稿启事》活动的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/《2018年贵州省社会主义学院学报征稿启事》(黔社院发〔2018〕2号）.doc','attaches/file/20190131/《2018年贵州省社会主义学院学报征稿启事》(黔社院发〔2018〕2号）.doc','file','2019-01-31 16:13:32','2019-01-31 16:13:32',NULL,NULL),('cb3ff4692357e91826394b4f8409de72','关于申报民盟贵州省委2018年度委托调研课题的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/附件2民盟贵州省委2018年委托调研课题申报参考目录.xlsx','attaches/file/20190131/附件2民盟贵州省委2018年委托调研课题申报参考目录.xlsx','file','2019-01-31 16:22:38','2019-01-31 16:22:38',NULL,NULL),('d06e2cf68e0a916a8bf1c5f614151592','民盟贵州大学委员会第四次全体会议召开','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151737285048.png','attaches/image/20190215/201902151737285048.png','image','2019-02-15 17:37:30','2019-02-15 17:37:30',NULL,NULL),('d7257a098bbbd9a087de3a9d858febf5','《牢记历史、铭记宗旨、不忘初心、继续前行》','/data/projects/minmeng/resources/ROOT/attaches/file/20190128/201901281434433780.jpg','attaches/image/20190128/201901281434433780.jpg','image','2019-01-28 14:35:42','2019-01-28 14:35:42',NULL,NULL),('d79c52824aff0bbae811f99121a9b312','民盟贵阳市委回访贫困户','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151739485207.png','attaches/image/20190215/201902151739485207.png','image','2019-02-15 17:40:19','2019-02-15 17:40:19',NULL,NULL),('d7ab200a6e1b1964799162e0eb136706','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121520094175.png','attaches/image/20190412/201904121520094175.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('d8759dac380c111e23a2f3e2d23c8c4a','民盟盟员、全国劳模张明富赴京参加庆祝“五一”表彰大会','/data/projects/minmeng/resources/ROOT/attaches/file/20190214/201902141220575944.jpg','attaches/image/20190214/201902141220575944.jpg','image','2019-02-14 12:21:01','2019-02-14 12:21:01',NULL,NULL),('db3c58978934e0d9c99fa5eaa4591af6','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/民盟贵州省委2017年部门决算.pdf','attaches/file/20190412/民盟贵州省委2017年部门决算.pdf','file','2019-04-12 15:27:36','2019-04-12 15:27:36',NULL,NULL),('db67576dcdb50f85f0b2d0c4776f15e2','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519187772.png','attaches/image/20190412/201904121519187772.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('dca5764f20fad112e7bcdf806974799f','访“中国阳明文化园”心得','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121440348355.jpg','attaches/image/20190212/201902121440348355.jpg','image','2019-02-12 14:40:37','2019-02-12 14:40:37',NULL,NULL),('df937c225f4f0169745ee3e273eb87c3','民盟省委领导班子走访、慰问老主委','/data/projects/minmeng/resources/ROOT/attaches/file/20190228/201902281647234379.jpg','attaches/image/20190228/201902281647234379.jpg','image','2019-02-28 16:48:05','2019-02-28 16:48:05',NULL,NULL),('e28b34107ddaf181642065494d1dc3c0','散文三味','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151746511145.png','attaches/image/20190215/201902151746511145.png','image','2019-02-15 17:46:53','2019-02-15 17:46:53',NULL,NULL),('e2ced6bc03147bb262d0564fcee5b5de','民盟省直综合支部召开乡村振兴战略与山地经济发展建言献策座谈会','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151737548534.png','attaches/image/20190215/201902151737548534.png','image','2019-02-15 17:37:57','2019-02-15 17:37:57',NULL,NULL),('e58ac0591537e276057d279764e7fb73','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121518276152.png','attaches/image/20190412/201904121518276152.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('e9fbb2a0d384f5a8b0941b8f56e95d3d','科普活边—参观天眼','/data/projects/minmeng/resources/ROOT/attaches/file/20190212/201902121136258594.jpg','attaches/image/20190212/201902121136258594.jpg','image','2019-02-12 11:38:14','2019-02-12 11:38:14',NULL,NULL),('eedda68347b1debf07f1963045a53622','2017年决算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/201904121519464485.png','attaches/image/20190412/201904121519464485.png','image','2019-04-12 15:21:11','2019-04-12 15:21:11',NULL,NULL),('ef555613cabcc60d15027d1ae1113355','民盟贵州省第十二届第三次全委（扩大）会议在贵阳召开 ','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311016153555.jpg','attaches/image/20190131/201901311016153555.jpg','image','2019-01-31 10:16:18','2019-01-31 10:16:18',NULL,NULL),('f25112c3c57c465e53d6d1c5df151d5c','关于积极参加《2018年贵州社会主义学院学报征稿启事》活动的通知','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/20180418113949834983 (1).doc','attaches/file/20190131/20180418113949834983 (1).doc','file','2019-01-31 16:10:48','2019-01-31 16:10:48',NULL,NULL),('f87c84677f751ae2be9ff6baf190f3ed','中共贵州省委常委、省委统战部部长严朝君到民盟省委机关走访调研','/data/projects/minmeng/resources/ROOT/attaches/file/20190131/201901311007011776.jpg','attaches/image/20190131/201901311007011776.jpg','image','2019-01-31 10:07:44','2019-01-31 10:07:44',NULL,NULL),('f91e19423f1debd21acecdc23a0c0453','2019年预算公开','/data/projects/minmeng/resources/ROOT/attaches/file/20190412/2019年度民盟贵州省委部门预算及说明.pdf','attaches/file/20190412/2019年度民盟贵州省委部门预算及说明.pdf','file','2019-04-12 15:30:14','2019-04-12 15:30:14',NULL,NULL),('fefa0da49ec67e4a773ce7afafe99cd2','今天是你的生日','/data/projects/minmeng/resources/ROOT/attaches/file/20190215/201902151745551992.png','attaches/image/20190215/201902151745551992.png','image','2019-02-15 17:46:37','2019-02-15 17:46:37',NULL,NULL);
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
  `cat_type` tinyint(1) NOT NULL COMMENT '分类类型：1:列表栏目，2：单页栏目',
  `list_style` varchar(32) NOT NULL COMMENT '列表显示样式：1:文字列表,2:图文列表,3:缩略图,4:缩略图文',
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
INSERT INTO `cats` VALUES ('201901271334151096','基层动态',NULL,'jcdt',1,'attaches/image/20190128/201901281323445261.png','',1,'2','1',999,'2019-01-27 13:35:26','2019-01-27 13:35:26'),('201901281126523605','社会服务',NULL,'shfw',1,'attaches/image/20190128/201901281431598936.png','',1,'2','1',999,'2019-01-28 11:27:07','2019-01-28 11:27:07'),('201901281133158053','盟务要闻',NULL,'mwyw',1,NULL,'',1,'2','1',999,'2019-01-28 11:33:29','2019-01-28 11:33:29'),('201901281135209206','自身建设',NULL,'zsjs',1,NULL,'',1,'2','1',999,'2019-01-28 11:36:05','2019-01-28 11:36:05'),('201901281148584199','思想建设',NULL,'sxjs',1,'attaches/image/20190128/201901281154363454.png','201901281135209206',1,'1','1',1,'2019-01-28 11:54:45','2019-01-28 11:54:45'),('201901281154468862','组织建设',NULL,'zzjs',1,'attaches/image/20190128/201901281155101708.png','201901281135209206',1,'1','1',2,'2019-01-28 11:55:13','2019-01-28 11:55:13'),('201901281204155229','机关建设',NULL,'jgjs',1,'attaches/image/20190128/201901281256381709.png','201901281135209206',1,'1','1',3,'2019-01-28 12:56:44','2019-01-28 12:56:44'),('201901281256458651','制度建设',NULL,'zdjs',1,'attaches/image/20190128/201901281257058662.png','201901281135209206',1,'2','1',4,'2019-01-28 12:57:08','2019-01-28 12:57:08'),('201901281258263730','学习园地',NULL,'xxyd',1,NULL,'',1,'2','1',999,'2019-01-28 12:58:40','2019-01-28 12:58:40'),('201901281258415849','年度重点',NULL,'ndzd',1,'attaches/image/20190131/201901311702222895.png','',1,'2','1',999,'2019-01-28 12:58:53','2019-01-28 12:58:53'),('201901281259013421','盟员风采',NULL,'myfc',1,NULL,'',1,'2','1',999,'2019-01-28 12:59:13','2019-01-28 12:59:13'),('201901281259416783','公示公告',NULL,'gsgg',1,NULL,'',1,'2','1',999,'2019-01-28 12:59:50','2019-01-28 12:59:50'),('201901281301345980','省直属支部',NULL,'szszb',1,'attaches/image/20190218/201902181056131725.png','201901271334151096',1,'2','1',999,'2019-01-28 13:01:48','2019-01-28 13:01:48'),('201901281301492444','地方盟务',NULL,'dfmw',1,'attaches/image/20190215/201902151805039905.png','201901271334151096',1,'2','1',999,'2019-01-28 13:02:00','2019-01-28 13:02:00'),('201901281303545733','人物写真',NULL,'rwxz',1,NULL,'201901281259013421',1,'2','1',999,'2019-01-28 13:04:06','2019-01-28 13:04:06'),('201901281304073092','盟员作品',NULL,'myzp',1,NULL,'201901281259013421',1,'2','1',999,'2019-01-28 13:04:18','2019-01-28 13:04:18'),('201901281304496344','民盟概括',NULL,'zsjs',1,NULL,'',1,'2','1',999,'2019-01-28 13:05:00','2019-01-28 13:05:00'),('201901281306501322','黔地盟音',NULL,'qdmy',1,'attaches/image/20190131/201901311704166322.png','201901281258263730',1,'2','1',999,'2019-01-28 13:07:11','2019-01-28 13:07:11'),('201901281307135465','理论文章',NULL,'llwz',1,'attaches/image/20190131/201901311705202938.png','201901281258263730',1,'2','1',999,'2019-01-28 13:07:33','2019-01-28 13:07:33'),('201901281739296542','参政议政','参政议政','czyz',1,'attaches/image/20190131/201901311621252163.png','',1,'2','1',4,'2019-01-28 17:40:55','2019-01-28 17:40:55'),('201901281748048864','中国民主同盟简介',NULL,'zgmmjj',1,NULL,'201901281304496344',2,'2','1',999,'2019-01-28 17:48:40','2019-01-28 17:48:40'),('201901281751454556','中国民主同盟章程',NULL,'articles',1,NULL,'201901281304496344',2,'2','1',999,'2019-01-28 17:52:13','2019-01-28 17:52:13'),('201901281757291959','贵州民盟简介',NULL,'gzmmjj',1,NULL,'201901281304496344',1,'1','1',999,'2019-01-28 17:57:58','2019-01-28 17:57:58'),('201901281758095240','历届领导',NULL,'ljld',1,NULL,'201901281304496344',1,'2','1',999,'2019-01-28 17:58:27','2019-01-28 17:58:27'),('201901281758506985','地方组织',NULL,'dfzz',1,NULL,'201901281304496344',1,'2','1',999,'2019-01-28 17:59:08','2019-01-28 17:59:08'),('201901281759097363','省盟大事记',NULL,'smdsj',1,NULL,'201901281304496344',1,'2','1',999,'2019-01-28 17:59:43','2019-01-28 17:59:43'),('201901281812219944','领导班子建设',NULL,'artile',1,NULL,'201901281135209206',1,'1','1',999,'2019-01-28 18:12:36','2019-01-28 18:12:36'),('201902140945492804','热烈庆祝党十九大胜利召开',NULL,'qzd',1,'attaches/image/20190214/201902141057549424.jpg','201901281258415849',1,'2','1',999,'2019-02-14 09:46:06','2019-02-14 09:46:06'),('201902140949276121','扶贫攻坚',NULL,'fpgj',1,NULL,'201901281258415849',1,'2','1',999,'2019-02-14 09:49:49','2019-02-14 09:49:49'),('201902140949561502','基层组织建设',NULL,'jczz',1,NULL,'201901281258415849',1,'2','1',999,'2019-02-14 09:50:18','2019-02-14 09:50:18'),('201902141100432544','资料下载',NULL,'zlxz',1,'attaches/image/20190131/201901311704166322.png','',1,'2','1',999,'2019-02-14 11:01:13','2019-02-14 11:01:13'),('201902141447328606','民盟贵阳市委',NULL,'gys',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:48:01','2019-02-14 14:48:01'),('201902141448039714','民盟遵义市委',NULL,'zys',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:48:21','2019-02-14 14:48:21'),('201902141448226257','民盟安顺市委',NULL,'ass',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:48:35','2019-02-14 14:48:35'),('201902141448369080','民盟六盘水市委',NULL,'lpss',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:48:57','2019-02-14 14:48:57'),('201902141449365658','民盟黔西南州委',NULL,'qxn',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:50:03','2019-02-14 14:50:03'),('201902141450048036','民盟毕节市委',NULL,'bjs',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:50:20','2019-02-14 14:50:20'),('201902141450225888','民盟黔东南工委',NULL,'qdn',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:50:37','2019-02-14 14:50:37'),('201902141450377857','民盟黔南州委',NULL,'qnz',1,NULL,'201901281301492444',1,'2','1',999,'2019-02-14 14:50:52','2019-02-14 14:50:52'),('201902151040084015','贵州统战联席会议新闻',NULL,'tzl',1,'attaches/image/20190215/201902151521504147.png','',1,'1','0',999,'2019-02-15 10:42:04','2019-02-15 10:42:04'),('201903221724144398','学习贯彻全国“两会”精神',NULL,'xxlh',1,NULL,'201901281258415849',1,'','1',100,'2019-03-22 17:27:19','2019-03-22 17:27:19');
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
INSERT INTO `friend_urls` VALUES ('201901271551247406','','中国民盟','http://www.dem-league.org.cn/',0),('201902141103396964','','中国民主同盟','http://http://www.dem-league.org.cn/',1),('201902141104104302','','贵州统一战线','http://http://www.gzswtzb.org.cn/',2),('201902141104278137','','贵州信息网','http://http://www.gzxxw.com/',3);
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
INSERT INTO `global_settings` VALUES ('footerHtml',''),('icp',''),('siteName','');
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
INSERT INTO `sys_admins` VALUES ('20141225001','admin','c0b9963cca3816a39eff2a947a21cf0b',NULL,NULL,'1','za18xf9dc1baa531s3eedf81q4c3w804e23f59939',NULL),('20190131001','管理员A','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','18c670232112336a944d01715685796c7615e4',NULL),('20190131002','管理员B','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','12eb8d24a5713e6de04d43595023fa64c42ffa',NULL),('20190131003','管理员C','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','',NULL),('20190131004','管理员D','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','1a619823be8139597544556a51e125635c67ec',NULL),('20190131005','管理员E','e10adc3949ba59abbe56e057f20f883e',NULL,'18985411113','1','1edf6223b4863d029f40399b5428776e207663',NULL);
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

-- Dump completed on 2019-05-09 13:09:31
