SET GLOBAL validate_password_number_count=0;
SET GLOBAL validate_password_length=6;
SET GLOBAL validate_password_policy=LOW;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;