-- 内容管理系统数据库
use minmeng_cms;

DROP TABLE IF EXISTS content_attaches;
DROP TABLE IF EXISTS content_infos;

-- 内容
CREATE TABLE IF NOT EXISTS content_infos(
	id					varchar(32)		NOT NULL,
	cat_id				varchar(32)		NOT NULL COMMENT '分类ID',	
	title				varchar(255)	NOT NULL COMMENT '标题',					
	subtitle			varchar(255)			 COMMENT '副标题',	
	content				longtext		NOT NULL COMMENT '内容',
	source				varchar(32)				 COMMENT '作者/来源',
	keywords			varchar(255)	 		 COMMENT '关键词',
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
	creater				varchar(32)		NOT NULL COMMENT '创建用户ID',	
	updater				varchar(32)		NOT NULL COMMENT '更新用户ID',
	video				varchar(255)	default '' 	 COMMENT '视频地址',
	brower				int(11)			NOT NULL DEFAULT 0 COMMENT '访问量',
	like_total			int(11)			NOT NULL DEFAULT 0 COMMENT '点赞数',
	status				char(2)			NOT NULL DEFAULT '0' COMMENT '0:创建,1:提交未审核,2：审核通过,3:审核不通过,－1:关闭',
	recom				char(2)			NOT NULL default "0" COMMENT '0:默认，1:推荐到列表页，2:推荐到内页，3:推到全站首页',
	href				varchar(255)	default '' 	 COMMENT '自定义链接',
  	PRIMARY KEY (id),
  	FOREIGN KEY (cat_id) REFERENCES minmeng_common.cats(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 内容附件
CREATE TABLE IF NOT EXISTS content_attaches(
	id					varchar(32)		NOT NULL,
	content_id			varchar(32)		NOT NULL COMMENT '内容ID',	
	attach_id			varchar(32)		NOT NULL COMMENT '附件ID',	
  	PRIMARY KEY (id),
  	FOREIGN KEY (content_id) REFERENCES content_infos(id) ON DELETE CASCADE ON UPDATE CASCADE,
  	FOREIGN KEY (attach_id) REFERENCES minmeng_common.attaches(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 专题
DROP TABLE IF EXISTS forums;
CREATE TABLE IF NOT EXISTS forums(
	id					varchar(32)		NOT NULL,
	name				varchar(32)		NOT NULL COMMENT '名称',				
	uri					varchar(255)	NOT NULL COMMENT 'URI',		
	image				varchar(255) 			 COMMENT '专题图片',	
	status				char(2)			NOT NULL default "1" COMMENT '状态:0:未启用,1:启用',	
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',	
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 专题内容
DROP TABLE IF EXISTS forum_contents;
CREATE TABLE IF NOT EXISTS forum_contents(
	id					varchar(32)		NOT NULL,
	forum_id			varchar(32)		NOT NULL COMMENT '专题ID',	
	content_id			varchar(32)		NOT NULL COMMENT '内容ID',	
	status				char(2)			NOT NULL default "1" COMMENT '状态:0:未启用,1:启用',	
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',	
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 抓取记录
DROP TABLE IF EXISTS fetch_records;
CREATE TABLE IF NOT EXISTS fetch_records(
	id					varchar(32)		NOT NULL,
	fetch_type			varchar(32)				 COMMENT 'list:列表，detail:详情',	
	url					varchar(255)	NOT NULL COMMENT '链接地址',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

show tables;
