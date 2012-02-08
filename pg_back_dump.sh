#!/bin/sh
########################################################################
# Directions and Suggestions ###########################################
# Postgresql database back-up and file maintenance - this is a        ##
# cron job called daily at about midnight                             ##
# (see crontab -l for details).                                       ## 
#                                                                     ## 
# The postgres user can call this by typing 'bash pg_back_dump.sh'    ##
# from the directory in which the script resides                      ##
#     -- '/var/lib/postgresql'                                        ##
# The above folder is the 'home folder' for the postgres user         ##
#                                                                     ##
# The way to become the postgres user in the simplest possible        ##
# way, change to being the administrative 'root' user by typing       ##
# 'sudo su -i' on the command line, then 'sudo - postgres' will       ##
# automatically get you to postgres user's home folder.               ##
#                                                                     ##
# If you skip the free-standing hyphen between 'sudo' and 'postgres'  ##
# you will become postgres but your environment will still be root's  ##
# environment.  You will be wherever in the filesystem that root was  ##
# before you made the metamorphosis.                                  ##
#                                                                     ##
# Since root can go places postgres user cannot, some things may be   ##
# strange for you.  If you find yourself in this predicament, the     ##
# command 'cd' without any argument should get you to the postgres    ##
# user's home folder.                                                 ##
#                                                                     ##
# The 'pwd' command will show you where you are in the file system by ##
# returning the full path to that location. '/var/lib/postgresql'     ##
#                                                                     ##
# The 'ls -l' command will show you the contents of the folder.       ##
#                                                                     ##
# (c)2011-2012 -  Wolf Halton, Lyrasis                               ########
#    This program is free software: you can redistribute it    #######
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

##  As postgres user...
pg_dumpall > `hostname`_pg_dumpall.sql
# makes a data-dump

tar czf `hostname`_pg_dumpall_`date '+%F_%H_%M'`.tar.gz `hostname`_pg_dumpall.sql		
# Copies the compressed data-dump to the backups prep folder

find /var/lib/postgresql/`hostname`_pg_dumpall* -mtime +11 -exec rm {} \;
# Removes any data-dump older than 7 days
## This is all done 'silently'
