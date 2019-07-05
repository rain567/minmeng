
drop database minmeng_sys;
drop database minmeng_ui;
drop database minmeng_cms;
drop database minmeng_common;

create database minmeng_common;
create database minmeng_cms;
create database minmeng_ui;
create database minmeng_sys;

grant all privileges on minmeng_common.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
grant all privileges on minmeng_cms.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
grant all privileges on minmeng_ui.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
grant all privileges on minmeng_sys.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_common;
 source /data/tmp/mysql/minmeng/minmeng_common.sql;
 use minmeng_cms;
 source /data/tmp/mysql/minmeng/minmeng_cms.sql;
 use minmeng_ui;
 source /data/tmp/mysql/minmeng/minmeng_ui.sql;
 use minmeng_sys;
 source /data/tmp/mysql/minmeng/minmeng_sys.sql;
 
 update content_infos set content=REPLACE(content, 'http://120.77.95.50', 'http://resources.mmgzsw.org.cn'); 