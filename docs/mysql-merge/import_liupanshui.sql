
drop database minmeng_liupanshui;

create database minmeng_liupanshui;

grant all privileges on minmeng_liupanshui.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_liupanshui;
 source /data/dump/mysql-merge/minmeng_merge.sql;