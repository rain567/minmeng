
drop database minmeng_bijie;

create database minmeng_bijie;

grant all privileges on minmeng_bijie.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_bijie;
 source /data/dump/mysql-merge/minmeng_merge.sql;