
drop database minmeng_qiandongnan;

create database minmeng_qiandongnan;

grant all privileges on minmeng_qiandongnan.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_qiandongnan;
 source /data/dump/mysql-merge/minmeng_merge.sql;