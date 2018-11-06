password=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $11}')
echo "innodb_file_format=Antelope" >> /etc/my.cnf
echo "innodb_default_row_format=COMPACT" >> /etc/my.cnf
systemctl restart mysqld
mysql -sfu root -p$password --connect-expired-password < "/opt/bahmni-installer/bahmni-playbooks/roles/mysql/tasks/mysql_secure_installation.sql"