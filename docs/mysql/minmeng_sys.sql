-- SYS
 use minmeng_sys;

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


show tables;
