
drop database minmeng_guiyang;

create database minmeng_guiyang;

grant all privileges on minmeng_guiyang.* to minmeng@127.0.0.1 identified by 'minmeng@20181214' WITH GRANT OPTION;
flush privileges;

 use minmeng_guiyang;
 source /data/dump/minmeng.sql;