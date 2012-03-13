#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#       tokenizing.py
#       
#       Copyright 2012 Wolf Halton <wolf@sourcefreedom.com>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

import os
import datetime
import csv
# from plural import plural ## plural snippet for practice (even oneliner)


def main():
	for data in import_text('names.dat', '\n'):
		print (data), "is the import line"
		dz = str(data)
		print dz, "is the stringified version"
		x = os.path.splitext(os.path.splitext(dz)[0])[0].split('_')[-3]
		print x, "is the string date from the filename"
		date_object = datetime.datetime.strptime(x, '%Y-%m-%d')
		print date_object
	
		xx = datetime.date.today()
		print xx, " is a datetime object that shows the date today"
	
		# The following changes a datetime object into a string
		xxx = str(xx)
		print xxx , "is a stringified datetime object"
		print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	
		#if date_object < xx:
		#		print "Delete file!"
		
	
	
	return 0
	
def import_text(filename, separator):
    for line in csv.reader(open(filename), delimiter=separator,  skipinitialspace=True):
        if line:
            yield line
    

## try..except removed by request
def todate_m(datestring): ## month first
    """ To date month first. Input string in month, day, year order
Returns date object for date string with any separator between the parts.
"""
    sep=[s for s in datestring if not s.isdigit()]

    if len(sep)!=2 or sep[0] != sep [1]:
        print "Mixup in separators",sep
    else:
        datesep=sep[0]
        mm,dd,yy = (int(part) for part in datestring.split(datesep))
        return datetime.date(yy,mm,dd)
    
def todate_d(datestring): ## day first
    """ To date day first. Input string in day, month,year order
It returns date object for date string with any separator between the parts.
"""
    sep=[s for s in datestring if not s.isdigit()]

    if len(sep)!=2 or sep[0] != sep [1]:
        print "Mixup in separators",sep
    else:
        datesep=sep[0]
        dd,mm,yy = (int(part) for part in datestring.split(datesep))
        return datetime.date(yy,mm,dd)
	


if __name__ == '__main__':
	main()
