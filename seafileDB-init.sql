create database `ccnet-db` character set = 'utf8';
create database `seafile-db` character set = 'utf8';
create database `seahub-db` character set = 'utf8';
GRANT ALL PRIVILEGES ON `ccnet-db`.* to `seafile`@'%' identified by 'seafile';
GRANT ALL PRIVILEGES ON `seafile-db`.* to `seafile`@'%' identified by 'seafile';
GRANT ALL PRIVILEGES ON `seahub-db`.* to `seafile`@'%' identified by 'seafile';
