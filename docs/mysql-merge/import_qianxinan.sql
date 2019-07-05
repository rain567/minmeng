
drop database minmeng_qianxinan;

create database minmeng_qianxinan;

grant all privileges on minmeng_qianxinan.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_qianxinan;
 source /data/dump/mysql-merge/minmeng_merge.sql;