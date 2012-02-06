#!/bin/sh

#####--Instructions and Comments on the way to back up DC4--####
# To become the administrative 'root' user to run this script, ##
# Enter 'sudo su -i' at the command prompt.  DC4 is set up to  ##
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
#     'run_backup_DC4.sh'                                      ##
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

# What follows is the content of the script.

echo "***************************************"
echo "* Welcome to the DC4 Backup Procedure *"
echo "* ----------------------------------- *"
echo "* This utility will not transfer any  *"
echo "* data to the portal server, dc3      *"
echo "* It is a safe procedure to follow    *"
echo "* the transfer utility.               *"
echo "***************************************"

# The following lines find and compress what will go into this week's 
# DC4_backups archive file
#-----------------------------------------   

rm -f /root/backups/DC4_pg_dumpall*
#Delete  last week's data-dump

find /var/lib/pgsql/DC4_pg_dumpall_* -mtime -2 -exec cp {} /root/backups \;
# move in newest data-dump

tar czf /root/backups/etc.tar.gz /etc
# Replace existing archive of the /etc directory

tar czf /root/backups/opt_dc.tar.gz /opt/local/dc
# Replace existing archive of the DSpace directory

tar czf /root/backups/pgsql.tar.gz /var/lib/pgsql
# Replace existing archive of pgsql (in case it is needed)

tar czf /root/backups/www.tar.gz /var/www
# Replace existing archive of web-site files

tar czf /root/backups/homedspace.tar.gz /home/dspace
# Replaces existing archive of /home/dspace

tar czf /root/backups/yummy.tar.gz /var/cache/yum
# Replaces locally stored packages 
# -------------------------------------------
tar czf /root/DC4_backups_`date '+%F_%H_%M'`.tar.gz /root/backups
# Bundle the archives for transit

find /root/DC4_backups* -mtime +7 -exec rm -f {} \;
# Remove 1-week old back-ups of server DC4

find /root/DC3_backups* -mtime +14 -exec rm -f {} \;
# Remove 2 week old back-ups of server DC3
