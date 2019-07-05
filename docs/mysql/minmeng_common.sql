-- 公共数据库
use minmeng_common;

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

show tables;
