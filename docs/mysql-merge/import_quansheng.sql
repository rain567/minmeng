
drop database minmeng;

create database minmeng;

grant all privileges on minmeng.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng;
 source /data/dump/minmeng.sql;