
drop database minmeng_qiannan;

create database minmeng_qiannan;

grant all privileges on minmeng_qiannan.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_qiannan;
 source /data/dump/mysql-merge/minmeng_merge.sql;