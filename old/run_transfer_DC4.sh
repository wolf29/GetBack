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
#     'run_transfer_DC4.sh'                                    ##
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

# What follows is the content of the script. You will be 
# prompted to enter the root password at least once.

echo "***************************************"
echo "* Welcome to the DC4 Transfer Procedure *"
echo "* ----------------------------------- *"
echo "* Always back-up the DC3 server first!*"
echo "* If you have not removed the 2-week- *"
echo "* old backup file from the portal     *"
echo "* server, DC3.library.umass.edu, by   *"
echo "* running the back-up script on DC3   *"
echo "* STOP this process NOW by holding    *"
echo "* the ctrl key and hitting the        *"
echo "* 'c' key. You will be given 3        *"
echo "* minutes to comply if necessary.     *"
echo "* If you are certain that the portal  *"
echo "* back-up procedure has taken place,  *"
echo "* you need do nothing but wait for    *"
echo "* the secure transfer to begin        *"
echo "*                                     *"
echo "* Failure to do these steps in the    *"
echo "* right order will result in freezing *"
echo "* the portal server by entirely fil-  *"
echo "* ling the hard drive of that server. *"
echo "***************************************"
echo ''
echo ''
echo 'Your three-minute countdown starts now'
# this gives the user 3 minutes
sleep 1m
echo '..Two minutes.........................'
# this gives the user 3 minutes
sleep 1m
echo '..One minute..........................'

scp /root/DC4_backups_* 128.119.168.15:/root/
# This copies your week-old archive to the DC3 server

