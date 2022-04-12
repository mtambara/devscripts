echo "set GLOBAL general_log=on; set GLOBAL general_log_file='/var/log/mysql/mysql.log';" | mysql
tail -f /var/log/mysql/mysql.log
