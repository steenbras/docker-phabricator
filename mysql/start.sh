#!/bin/sh
set -e
if [ ! -d /var/lib/mysql/mysql ]; then
  echo "creating database"
  mysql_install_db --user mysql --datadir=/var/lib/mysql
  cat << EOF | mysqld --user mysql --bootstrap
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by 'notsosecret' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' identified by 'notsosecret' WITH GRANT OPTION;
CREATE USER '${PHAB_USER}'@'%' IDENTIFIED BY '${PHAB_PWD}';
CREATE USER '${PHAB_USER}'@'localhost' IDENTIFIED BY '${PHAB_PWD}';
GRANT ALL PRIVILEGES ON *.* TO '${PHAB_USER}'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO '${PHAB_USER}'@'localhost' WITH GRANT OPTION;
UPDATE user SET password = PASSWORD("") WHERE user='root' AND host='localhost';
EOF
fi
exec mysqld
