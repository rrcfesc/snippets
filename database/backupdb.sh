#!/bin/bash

#
# 	Use this script to perform backups of one or more MySQL databases.
#

# Databases that you wish to be backed up by this script. You can have any number of databases specified; encapsilate each database name in single quotes and separate each database name by a space.
#
# Example:
# databases=( '__DATABASE_1__' '__DATABASE_2__' )
databases=('bizzarro_db')
inicio=$(date +"%F-%H:%I:%S")
echo "Inicio del proceso: $inicio"
# The host name of the MySQL database server; usually 'localhost'
db_host="bizzarro-db.c5lq6ulpztfe.us-west-2.rds.amazonaws.com"

# The port number of the MySQL database server; usually '3306'
db_port="3306"

# The MySQL user to use when performing the database backup.
db_user="bizzarroadm"

# The password for the above MySQL user.
db_pass="4YrdESTR53"

# Directory to which backup files will be written. Should end with slash ("/").
backups_dir_temp=$(pwd)
backups_dir="$backups_dir_temp/dbbackup/"

backups_user="backups"

# Date/time included in the file names of the database backup files.
datetime=$(date +"%d_%m_%Y_%H_%I_%S")

for db_name in ${databases[@]}; do
        # Create database backup and compress using gzip.
        echo $(date +"%F-%H:%I:%S")
        mysqldump -u $db_user -h $db_host -P $db_port --password=$db_pass $db_name | gzip -9 > $backups_dir$db_name--$datetime.sql.gz
done

# Set appropriate file permissions/owner.
#chown $backups_user:$backups_user $backups_dir*--$datetime.sql.gz
#chmod 0400 $backups_dir*--$datetime.sql.gz

fin=$(date +"%F-%H:%I:%S")
echo "Fin del proceso: $fin"