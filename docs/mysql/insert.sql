
-- 栏目》分类
DROP TABLE IF EXISTS cats;
CREATE TABLE IF NOT EXISTS cats(
	id					varchar(32)		NOT NULL,
	module				varchar(32)		NOT NULL COMMENT '模块：content:内容分类，shop：商品分类',
	name				varchar(32)		NOT NULL COMMENT '分类名称',	
	alias				varchar(32)				 COMMENT '别名',					
	uri					varchar(255)	NOT NULL COMMENT '分类URI',	
	enable_uri			tinyint(1)		NOT NULL default 1 COMMENT '允许URI链接地址：0：禁止，1：允许',		
	icon				varchar(255) 			 COMMENT '分类图标',			
	parent_id			varchar(32) 			 COMMENT '上级分类',	
	cat_type			boolean			 		 COMMENT '分类类型：1:列表栏目，2：单页栏目',
	list_style			varchar(32)				 COMMENT '列表显示样式：1:文字列表,2:图文列表,3:缩略图,4:缩略图文',
	status				char(2)			NOT NULL default "1" COMMENT '状态:0:未启用,1:启用',	
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',	
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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