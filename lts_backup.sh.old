#!/bin/sh -x
####--Instructions to back up this server and Some Comments--###
# To become the administrative 'root' user to run this script, ##
# Enter 'sudo su -i' at the command prompt. LTS Servers        ##
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
# (c) Copyright 2012 Wolf Halton, Lyrasis                      ##
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

echo "*******************************************"
echo "* Welcome to the Lyrasis Backup Procedure *"
echo "* --------------------------------------- *"
echo "* You need do nothing but wait for        *"
echo "* the secure transfer of this week's      *"
echo "*                                         *"
echo "* Failure to do these steps in the        *"
echo "* right order will result in freezing     *"
echo "* the server or corrupting the backup     *"
echo "* file.                                   *"
echo "******************************************  "

#  The following 2 lines makes the script treat the spaces in the
#  variables as 'just another character'
IFS='
'
#-----------------
#  This section guarantees that there is a directory into 
#    which to put all the backups.
directory2="/backup/backs/"
directory1="/backup/"
if [ ! -d "${directory2}" ]; then
    mkdir -p "${directory2}"
    chmod 777 -R /backup
fi

#echo `hostname` " is the hostname function"
h=`hostname`
#echo "$h is the hostname"


rsync -av ${directory1}*.tar.gz /mnt/mfs/

# The following lines find and compress what will go into this week's
# backup archive files and delete the old file copies.
#-----------------------------------------

if [ -d /var/lib/mysql ]; then
    mysqldump -u root -pltslyr@s1s1438 --all-databases > "${directory2}""$h"_mysql_dumpall.sql
    # Makes a new data-dump 
fi
tar czf "${directory2}""$h"_mysql_dump_`date '+%F_%H_%M'`.tar.gz "${directory2}""$h"_mysql_dumpall.sql
# compress newest data-dump

cp /var/lib/postgresql/*.gz "${directory2}"

tar czf "${directory2}""$h"_etc.tar.gz /etc
# Replace existing archive of the /etc directory

tar czf "${directory2}""$h"_opt.tar.gz /opt
# Replace existing archive of the /opt

tar czf "${directory2}""$h"_mysql_files.tar.gz /var/lib/mysql
# Replace existing archive of mysql files (in case needed)

tar czf "${directory2}""$h"_pgsql_files.tar.gz /var/lib/postgresql/
# Replace existing archive of postgresql files (in case needed)

tar czf "${directory2}""$h"_www_files.tar.gz /var/www
# Replace existing archive of web-site files

tar czf "${directory2}""$h"_homes.tar.gz /home
# much custom coding appears to be in these directories

tar czf "${directory2}""$h"_roothome.tar.gz /root
# some custom coding appears to be in this directory

# -------------------------------------------
tar czf "${directory1}""$h"_backups_`date '+%F_%H_%M'`.tar.gz "${directory2}"*.tar.gz
# Bundle the archives for transit

find "${directory1}"\*.tar.gz -mtime +14 -exec rm {} \;
# Remove 2 week old back-ups of server from /root/ folder

# rsync -av /src/foo/ /dest/foo
rsync -av "${directory1}"*tar.gz /mnt/mfs/

find /mnt/mfs/\*.tar.gz -mtime +28 -exec rm {} \;
# Remove 4 week old back-ups of server from /root/ folder

