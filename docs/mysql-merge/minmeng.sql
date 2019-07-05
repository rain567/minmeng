
-- 系统管理员
DROP TABLE IF EXISTS sys_admins;
CREATE TABLE IF NOT EXISTS sys_admins(
	id					varchar(32)	NOT NULL,
	username			varchar(32)	NOT NULL COMMENT '用户名',			
	password			varchar(64)	NOT NULL COMMENT '密码',	
	name				varchar(32) COMMENT '姓名',			
	mobile				varchar(15) COMMENT '手机号',					
	status				char(1)		NOT NULL default "1" COMMENT '状态',	
	sessionid			varchar(255) default '' COMMENT '会话ID,用户退出时清除',	
	role				varchar(32) COMMENT '角色：101:全权限,102:',					
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 初始化系统管理员
delete from sys_admins;
insert into sys_admins(id,username,password,mobile,status)
values('20141225001','admin',MD5('111111'),'18985411113','1');

insert into sys_admins(id,username,password,mobile,status)
values('20190131001','管理员A',MD5('123456'),'18985411113','1');
insert into sys_admins(id,username,password,mobile,status)
values('20190131002','管理员B',MD5('123456'),'18985411113','1');
insert into sys_admins(id,username,password,mobile,status)
values('20190131003','管理员C',MD5('123456'),'18985411113','1');
insert into sys_admins(id,username,password,mobile,status)
values('20190131004','管理员D',MD5('123456'),'18985411113','1');
insert into sys_admins(id,username,password,mobile,status)
values('20190131005','管理员E',MD5('123456'),'18985411113','1');

-- 附件
DROP TABLE IF EXISTS attaches;
CREATE TABLE IF NOT EXISTS attaches(
	id					varchar(32)		NOT NULL,	
	alt					varchar(255)	NOT NULL COMMENT '说明',					
	file_path			varchar(255)	NOT NULL COMMENT '文件路径',	
	url					varchar(255)	NOT NULL COMMENT '访问地址',
	att_type			varchar(32)				 COMMENT '类型：image,file,video,flash,txt,doc',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
	user_id				varchar(32)				 COMMENT '创建会员',	
	editor_id			varchar(32)				 COMMENT '创建编辑员',	
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 栏目》分类
DROP TABLE IF EXISTS cats;
CREATE TABLE IF NOT EXISTS cats(
	id					varchar(32)		NOT NULL,
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

-- alter table cats CHANGE  image icon varchar(255)   COMMENT '分类图标'
-- 广告
DROP TABLE IF EXISTS ads;
CREATE TABLE IF NOT EXISTS ads(
	id					varchar(32)		NOT NULL COMMENT '主键',		
	position			varchar(32)		NOT NULL default '' COMMENT '广告位：index_rotaion:首页轮播，index_banner:首页横幅广告',		
	image				varchar(255)	NOT NULL COMMENT '图片',				
	href				varchar(255)			 COMMENT '链接地址',		
	text				varchar(999)			 COMMENT '广告内容',						
	price				double(11,2)			 COMMENT '价格',	
	descri				varchar(255)			 COMMENT '广告说明',				
	create_time			datetime		NOT NULL COMMENT '创建时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',
	effect_time			datetime				 COMMENT '生效时间',
	expire_time			datetime				 COMMENT '过期时间',
	status				char(2)			NOT NULL default "1" COMMENT '状态:0:未启用,1:启用',	
	sorter				int(11)			NOT NULL default 99  COMMENT '排序',				
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--  友情链接
DROP TABLE IF EXISTS friend_urls;
CREATE TABLE IF NOT EXISTS friend_urls(
	id				varchar(32)		NOT NULL,	
	logo			varchar(255) 		 	 COMMENT '网站LOGO',	
	sitename		varchar(64)		NOT NULL COMMENT '网站名称',
	url				varchar(64)		NOT NULL COMMENT '网址',
	sorter			int(11)			NOT NULL COMMENT '排序',
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--  滚动链接
DROP TABLE IF EXISTS slide_links;
CREATE TABLE IF NOT EXISTS slide_links(
	id				varchar(32)		NOT NULL,	
	text			varchar(255)	NOT NULL COMMENT '文本',
	url				varchar(255)	NOT NULL COMMENT '链接地址',
	sorter			int(11)			NOT NULL COMMENT '排序',
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 全局设置
DROP TABLE IF EXISTS global_settings;
CREATE TABLE IF NOT EXISTS global_settings(
	id					varchar(32)		NOT NULL COMMENT '键',		
	value				text			NOT NULL COMMENT '值',		
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 留言
CREATE TABLE IF NOT EXISTS boards(
	id				varchar(32)		NOT NULL COMMENT '键',	
	title			varchar(64)	 	NOT NULL COMMENT '留言标题',	
	content			text		 		  	 COMMENT '留言内容',	
	mobile			varchar(15)	 			 COMMENT '手机号',	
	name			varchar(32)	 			 COMMENT '姓名',	
	create_time		datetime		NOT NULL COMMENT '发布时间',
	update_time		datetime		NOT NULL COMMENT '修改时间',
	address			varchar(255) 			 COMMENT '地址',		
	fax				varchar(64) 			 COMMENT '传真/电话',
	remark			varchar(255)			 COMMENT '备注', 
	status			char(2)			NOT NULL default "1" COMMENT '状态:0:未公开,1:公开',
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 搜索词语
DROP TABLE IF EXISTS keywords;
CREATE TABLE IF NOT EXISTS keywords(
	id					varchar(32)		NOT NULL,	
	keyword				varchar(255)	NOT NULL COMMENT '词语',			
	tag					varchar(32)		NOT NULL COMMENT 'hot：热搜recommend:推荐history:用户搜索历史',
	sorter				int(11) 		COMMENT '序号',			
	qcount				int(11) 		COMMENT '查询次数',		
	create_time			datetime		NOT NULL COMMENT '发布时间',
	update_time			datetime		NOT NULL COMMENT '修改时间',	
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  	FOREIGN KEY (cat_id) REFERENCES cats(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 内容附件
CREATE TABLE IF NOT EXISTS content_attaches(
	id					varchar(32)		NOT NULL,
	content_id			varchar(32)		NOT NULL COMMENT '内容ID',	
	attach_id			varchar(32)		NOT NULL COMMENT '附件ID',	
  	PRIMARY KEY (id),
  	FOREIGN KEY (content_id) REFERENCES content_infos(id) ON DELETE CASCADE ON UPDATE CASCADE,
  	FOREIGN KEY (attach_id) REFERENCES attaches(id) ON DELETE CASCADE ON UPDATE CASCADE
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

-- 数据库备份
DROP TABLE IF EXISTS sql_dumps;
CREATE TABLE IF NOT EXISTS sql_dumps(
	id					int(11)			NOT NULL AUTO_INCREMENT,
	mode				varchar(2)		NOT NULL COMMENT '0:备份，1：还原',
	name				varchar(64)		NOT NULL DEFAULT '' COMMENT '名称',
	sql_file			varchar(255)	NOT NULL DEFAULT '' COMMENT 'sql文件',
	descri				varchar(255)	NOT NULL DEFAULT '' COMMENT '说明',
	create_time			datetime		NOT NULL COMMENT '发布时间',
	username			varchar(32)		NOT NULL DEFAULT '' COMMENT '操作员用户名',	
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

