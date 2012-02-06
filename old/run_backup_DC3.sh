#!/bin/sh 
#####--Instructions and Comments on the way to back up DC3--####
# To become the administrative 'root' user to run this script, ##
# Enter 'sudo su -i' at the command prompt.  DC3 is set up to  ##
# allow certain users to access root privilege without a       ##
# password. No other users (beyond these specified) are        ##
# allowed to act as root at all (with or without password)     ##
#                                                              ##
# When you run the command above, it automatically puts you in ##
# root's home directory, /root/ This script resides in root's  ##
# home directory and is executable only from that place in the ##
# file system.                                                 ##
#                                                              ##
# To run the backup application, type                          ##
#     'run_backup_DC3.sh'                                      ##
# as the root user                                             ##
#                                                              ##
# (c) Copyright 2011 Wolf Halton, Lyrasis                      ##
#                                                              ##
#    This program is free software: you can redistribute it    ##
#   and/or modify it under the terms of the GNU General        ##
#   Public License as published by the Free Software           ##
#   Foundation, either version 3 of the License, or any later  ##
#   version.                                                   ##
#                                                              ##
#   This program is distributed in the hope that it will be    ##
#   useful, but WITHOUT ANY WARRANTY; without even the implied ##
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR    ##
#   PURPOSE.  See the GNU General Public License for more      ##
#   details.                                                   ##
#                                                              ##
#    You should have received a copy of the GNU General        ##
#   Public License along with this program.  If not, see       ##
#   <http://www.gnu.org/licenses/>.                            ##
#################################################################
 ################################################################

## What follows is the content of the script. You will be
## prompted to enter the root password at least once.

echo "***************************************"
echo "* Welcome to the DC3 Backup Procedure *"
echo "* ----------------------------------- *"
echo "* You need do nothing but wait for    *"
echo "* the secure transfer of this week's  *"
echo "* fer of this week's 118 MB file.     *"
echo "* Failure to do these steps in the    *"
echo "* right order will result in freezing *"
echo "* the portal server by entirely fil-  *"
echo "* ling the hard drive of that server. *"
echo "***************************************"

# this gives the user 3 minutes
# sleep 3m

scp /root/DC3_backups_* 128.119.168.20:/root/

# The following lines find and compress what will go into this week's
# DC3_backups archive file
#-----------------------------------------

rm /root/dc3_mysql_dumpall*
#Delete  last week's data-dump

mysqldump --all-databases -u bpl > /root/dc3_mysql_dumpall.sql
# Makes a new data-dump 
tar czf /root/backups/mysql_dump`date '+%F_%H_%M'`.tar.gz /root/dc3_mysql_dumpall.sql
# move in newest data-dump

tar czf /root/backups/etc.tar.gz /etc
# Replace existing archive of the /etc directory

tar czf /root/backups/opt.tar.gz /opt/local
# Replace existing archive of the Dspace-related portal directories

tar czf /root/backups/mysql.tar.gz /var/lib/mysql
# Replace existing archive of mysql (in case it is needed)

tar czf /root/backups/www.tar.gz /var/www
# Replace existing archive of web-site files

# tar czf /root/backups/homes.tar.gz /home
# much custom coding appears to be in these directories

# -------------------------------------------
tar czf /root/DC3_backups_`date '+%F_%H_%M'`.tar.gz /root/backups
# Bundle the archives for transit

# find /root/DC3_backups* -mtime +7 -exec rm {} \;
# Remove 1-week old back-ups of server DC4

find /root/DC4_backups* -mtime +14 -exec rm {} \;
# Remove 2 week old back-ups of server DC3

