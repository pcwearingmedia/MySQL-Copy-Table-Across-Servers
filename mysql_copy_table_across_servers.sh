#!/bin/bash

# Script name: mysql_copy_table_across_servers.sh
#
# Author: P-C Markovski.
# Date (Git repo init): 2017-08-17.
# Purpose: Copy database table from local MySQL server to remote MySQL server. Replace existing remote table with copy.



			# Copy table $TABLENAME (passed as argument)
			# from server A to server B.


# Dump table into /root/bash on this server.
mysqldump -h localhost -u root -p'------' dbname $TABLENAME > ./$TABLENAME.sql

# Copy table to remote server.
scp ./$TABLENAME.sql root@127.0.0.1:/root/$TABLENAME.sql2

# Replace table with the same name in the database on the remote server.
ssh root@192.168.56.1 "mysql -f -u root -p'-------' dbname -e 'source /root/bash/$TABLENAME.sql2'" 

# Remove the .sql file on the remote server.
ssh root@192.168.56.1 "rm /root/$TABLENAME.sql2"

# Remove file on this server, where the Bash script is running.
rm ./$TABLENAME.sql
