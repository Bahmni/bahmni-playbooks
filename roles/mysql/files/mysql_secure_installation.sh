password=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $11}')
mysql -sfu root -p$password --connect-expired-password < "/tmp/mysql_secure_installation.sql"