use minmeng_cms;

-- 抓取记录
DROP TABLE IF EXISTS fetch_records;
CREATE TABLE IF NOT EXISTS fetch_records(
	id					varchar(32)		NOT NULL,
	fetch_type			varchar(32)				 COMMENT 'list:列表，detail:详情',	
	url					varchar(32)		NOT NULL COMMENT '链接地址',	
	create_time			datetime		NOT NULL COMMENT '发布时间',
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- update attaches set url=replace(url,'http://localhost','http://local/gzztctx.com');

--INSERT INTO content_infos(`id`,`cat_id`,`title`,`subtitle`,`content`,`source`,`keywords`,`create_time`,`update_time`,`like_total`,`brower`,`status`,`recom`,`video`,`href`,`creater`,`updater`)
--VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?),
--VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);