#!/bin/sh 
####--Instructions to back up this server and Some Comments--###
# To become the administrative 'root' user to run this script, ##
# Enter 'sudo su -i' at the command prompt. Linux Servers can  ##
# allow certain users to access root privilege.                ##
# No other users (beyond these specified) are                  ##
# allowed to act as root at all.                               ##
#                                                              ##
# When you run the command above, it automatically puts you in ##
# root's home directory, /root/ This script resides in root's  ##
# home directory and is executable only by sudoers and root.   ##
# (/root/bin/)                                                 ##
#                                                              ##
# To run the backup application, type                          ##
#     'lts_backup.sh'                                          ##
# as the root user                                             ##
#                                                              ##
# (c) Copyright 2012 Wolf Halton                               ##
#                          <wolf@sourcefreedom.com>            ##
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

#  The following 2 lines makes the script treat the spaces in the
#  variables as 'just another character'
IFS='
'
#-----------------
#  This section guarantees that there is a directory into 
#    which to put all the backups.
directory2="/home/backup/backs/"
directory1="/home/backup/"
if [ ! -d "${directory2}" ]; then
    mkdir -p "${directory2}"
    chmod 777 -R /backup
fi

# This sets the hostname variable to be put into the filenames for the tarballs
h=`hostname`

# The following lines find and compress what will go into this week's
# backup archive files and delete the old file copies.

rm -f ${directory2}*.* 
# Deletes the 1st-stage tarballs, so they are not duplicated in the transferred tarball
#-----------------------------------------

if [ -d /var/lib/mysql ]; then
    mysqldump -u root -pYOURSECRETPASSWORD --all-databases > "${directory2}""$h"_mysql_dumpall.sql
    # Makes a new data-dump 
	# For mysqldump to work, there needs to be a space between -u and the username, 
	#  but no space betweep -p and the password
    tar czf "${directory2}""$h"_mysql_dump_`date '+%F_%H_%M'`.tar.gz "${directory2}""$h"_mysql_dumpall.sql
    # compress newest data-dump
fi

if [ -f /var/lib/postgresql/*.gz ]; then
    cp /var/lib/postgresql/*.gz "${directory2}"
fi

tar czf "${directory2}""$h"_etc.tar.gz /etc
# Replace existing archive of the /etc directory

tar czf "${directory2}""$h"_opt.tar.gz /opt
# Replace existing archive of the /opt

if [ -d /var/lib/mysql ]; then
tar czf "${directory2}""$h"_mysql_files.tar.gz /var/lib/mysql
# Replace existing archive of mysql files (in case needed)
fi

if [ -d /var/lib/openils ]; then
    tar czf "${directory2}""$h"_ils_files.tar.gz /openils
    # Replace existing archive of mysql files (in case needed)
fi

if [ -d /var/lib/postgresql ]; then
tar czf "${directory2}""$h"_pgsql_files.tar.gz /var/lib/postgresql/[89]*/
# Replace existing archive of postgresql files (in case needed)
fi

if [ -d /var/w* ]; then
tar czf "${directory2}""$h"_www_files.tar.gz /var/w*
# Replace existing archive of web-site files
fi

tar czf "${directory2}""$h"_homes.tar.gz --exclude="/home/backup" /home
# much custom coding appears to be in these directories

tar czf "${directory2}""$h"_roothome.tar.gz /root
# some custom coding appears to be in this directory

# -------------------------------------------
tar czf "${directory1}""$h"_backups_`date '+%F_%H_%M'`.tar.gz "${directory2}"*.tar.gz
# Bundle the archives for transit

find "${directory1}""$h"* -mtime +4 -exec rm -f {} \;
# Remove 4-day-old back-ups of server from /backup/ folder

# The following line sends the transfer tarball to storage 
rsync -av "${directory1}"*tar.gz storrac@backup-01:/home/storrac/"$h"/


