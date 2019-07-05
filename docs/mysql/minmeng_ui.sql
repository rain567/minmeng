-- UI
 use minmeng_ui;

-- 导航
DROP TABLE IF EXISTS navs;
CREATE TABLE IF NOT EXISTS navs(
	id					varchar(32)		NOT NULL,
	name				varchar(64)		NOT NULL COMMENT '名称',
	alias				varchar(64)				 COMMENT '别名',
	link				varchar(255)	NOT NULL COMMENT '链接地址',
	nav_type			varchar(2)		NOT NULL default '1' COMMENT '导航类型：1:文本导航，2：关联分类',
	cat_id				varchar(32)				 COMMENT '关联分类ID,可以为空',
	sub_depth			int(11)			NOT NULL default 0 COMMENT '子导航深度，深度的显示决定于栏目分类下级分类深度',
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',		
	status				char(2)			NOT NULL default "1" COMMENT '状态:1:启用,0:未启用',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 页面
 DROP TABLE IF EXISTS pages;
 CREATE TABLE IF NOT EXISTS pages(
 	id					varchar(32)		NOT NULL,
 	name				varchar(32) 			 COMMENT '页面：index：首页',
 	title				varchar(255) 			 COMMENT '标题',	
 	keywords			varchar(255) 			 COMMENT '页面关键字',	
 	descri				varchar(255) 			 COMMENT '页面说明',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
  PRIMARY KEY (id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建页面
delete from pages;
insert into pages(id,name,title,keywords,descri,create_time,update_time)
values('20150522001','index','标题','关键词','描述','2018-12-18','2018-12-18'),
('20150522002','list','标题','关键词','描述','2018-12-18','2018-12-18'),
('20150522003','info','标题','关键词','描述','2018-12-18','2018-12-18');

-- 控件
DROP TABLE IF EXISTS views;
DROP TABLE IF EXISTS view_items;
DROP TABLE IF EXISTS page_views;
CREATE TABLE IF NOT EXISTS views(
	id					varchar(32)		NOT NULL,
	name				varchar(32)		NOT NULL COMMENT '识别名称',
	mode				varchar(255) 			 COMMENT '类型：0:容器，1：关联分类，2：自定义内容',	
	style				varchar(255) 			 COMMENT '样式',	
	max_items			int(11)			NOT NULL default 8  	COMMENT '最大条目数',
	link				varchar(255)			 default ''  	COMMENT '链接地址',
	parent_id			varchar(32)				 COMMENT '父层组件ID',
	status				char(2)			NOT NULL default "1" COMMENT '状态:1:启用,0:未启用',
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',	
	out_mode			varchar(32)				 COMMENT '当前控件为子控件时使用，输出的方式:before，在前面输出，after:在后面输出',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- alter table views add column sorter int(11)			NOT NULL default 99 COMMENT '排序';
-- alter table views add column out_mode varchar(32)				 COMMENT '当前控件为子控件时使用，输出的方式:before，在前面输出，after:在后面输出'

-- 控件条目
CREATE TABLE IF NOT EXISTS view_items(
	id					varchar(32)		NOT NULL,
	cat_id				varchar(32)				 COMMENT '分类ID',
	view_id				varchar(32)		NOT NULL COMMENT '组件ID',
	content				text		 			 COMMENT '文本内容',
	link				varchar(255)			 COMMENT '链接地址',	
	image				varchar(255)			 COMMENT '图片',	
	target				varchar(32)				 default '_blank' COMMENT '打开目标',
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
	effect_time			datetime				 COMMENT '生效时间',
	expire_time			datetime				 COMMENT '过期时间',
	is_ad				boolean			NOT NULL COMMENT '是否为广告,0：否，1:是',	
	price				double(11,2)			 COMMENT '广告价格',	
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',	
	status				char(2)			NOT NULL default "1" COMMENT '状态:1:启用,0:未启用',		
  	PRIMARY KEY (id),
  	FOREIGN KEY (view_id) REFERENCES views(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 页面控件
CREATE TABLE IF NOT EXISTS page_views(
	id					varchar(32)		NOT NULL,
	page_id				varchar(32)		NOT NULL COMMENT '页面ID',
	view_id				varchar(32)		NOT NULL COMMENT '控件ID',
	sorter				int(11)			NOT NULL default 99 COMMENT '排序',	
	status				char(2)			NOT NULL default "1" COMMENT '状态:1:启用,0:未启用',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',	
  	PRIMARY KEY (id),
  	FOREIGN KEY (view_id) REFERENCES views(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


show tables;
