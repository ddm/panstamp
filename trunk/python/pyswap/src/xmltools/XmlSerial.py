#########################################################################
#
# XmlSerial
#
# Copyright (c) 2011 Daniel Berenguer <dberenguer@usapiens.com>
# 
# This file is part of the panStamp project.
# 
# panStamp  is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# panStamp is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with panLoader; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
# USA
#
#########################################################################
__author__="Daniel Berenguer"
__date__ ="$Aug 20, 2011 10:36:00 AM$"
#########################################################################

import xml.etree.ElementTree as xml

class XmlSerial(object):
    """
    Serial configuration settings
    """
    def read(self):
        """ 
        Read configuration file
        """
        # Parse XML file
        tree = xml.parse(self.fileName)
        if tree is None:
            return
        # Get the root node
        root = tree.getroot()
        # Get serial port
        elem = root.find("port")
        if elem is not None:
            self.port = elem.text
        # Get serial speed
        elem = root.find("speed")
        if elem is not None:
            self.speed = int(elem.text)
    
    def save(self):
        """
        Save serial port settings in disk
        """
        file = open(self.fileName, 'w')
        file.write("<?xml version=\"1.0\"?>\n")
        file.write("<serial>\n")
        file.write("\t<port>" + self.port + "</port>\n")
        file.write("\t<speed>" + str(self.speed) + "</speed>\n")
        file.write("</serial>\n")
        file.close()
    
    
    def __init__(self, fileName = "serial.xml"):
        """
        Class constructor
        
        @param filename: Path to the serial configuration file
        """
        ## Name/path of the current configuration file
        self.fileName = fileName
        ## Name/path of the serial port
        self.port = "/dev/ttyUSB0"
        ## Speed of the serial port in bps
        self.speed = 9600
        # Read XML file
        self.read()

  