show databases;
use mysql;
show tables;
select host, user, authentication_string from user;

create user 'test1'@'localhost' identified by 'k404';

show grants for 'test1'@'localhost';

grant all privileges on k404db.* to 'test1'@'localhost';

revoke all on k404db.* from 'test1'@'localhost';