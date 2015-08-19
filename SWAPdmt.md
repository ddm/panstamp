# SWAPdmt, Device Management Tool for SWAP networks #

  * [Introduction](SWAPdmt#Introduction.md)
  * [Installation](SWAPdmt#Installation.md)
  * [Serial port](SWAPdmt#Serial_port.md)
  * [Serial gateway network settings](SWAPdmt#Serial_gateway_network_settings.md)
  * [Identify SWAP devices](SWAPdmt#Identify_SWAP_devices.md)
  * [Device network settings](SWAPdmt#Device_network_settings.md)
  * [Configuring custom settings](SWAPdmt#Configuring_custom_settings.md)


# Introduction #
SWAPdmt is a software tool, written in Python, designed to configure SWAP devices wirelessly. There is a command-line version and a graphical one (wxPython).  The current tutorial will focus on the GUI version only. SWAPdmt basically acts as a remote editor for any register belonging to any of the wireless devices (motes) within the same SWAP network.

SWAPdmt lets us configure the following parameters:

  * Serial port settings on the modem (serial interface).
  * Network settings on the modem: frequency channel, network ID, address and security options.
  * Network settings on any mote: frequency channel, network ID, address, security options and periodic Tx interval.
  * Custom registers on any mote

Besides, SWAPdmt can identify every SWAP mote in the network (with the same frequency channel and network id as the modem) and monitors the network, providing feedback for register values and device addresses.

# Installation #

Before installing SWAPdmt, you should check that your computer meets the following requirements:

  * Python 2.6 or 2.7
  * [wxPython 2.8](http://wxpython.org/) and [pyserial](http://pyserial.sourceforge.net/) installed

Once the above requirements met, you can start installing SWAPdmt as follows:

  1. Download the latest version of our [Python tools](http://www.panstamp.com/downloads/panStamp_apps.zip?attredirects=0&d=1), where you will find all the necessary to install pyswap and SWAPdmt.
  1. Enter the pyswap directory and install the package with this command
```
# python setup.py install
```
  1. Now enter the SWAPdmt folder and run the application as follows:
```
# python path/to/swapdmt/pyswapdmtgui.py
```

# Serial port #
In order to connect SWAPdmt to the network, a SWAP wireless gateway must be available on the computer. At the moment of writing this document only panStick or a usb/serial panStamp can be used as SWAP interfaces. The SWAP modem communicates with the computer via serial port (a real serial port or a virtual one) so before pressing the “Connect” button you should check the serial settings.

<p align='center'>
<img src='https://lh4.googleusercontent.com/-Hqu8dLcPgrM/TvuDix4tt-I/AAAAAAAAADk/KMM3f_iVxpY/s220/swapdmtgui_gateway_serial.png' />
</p>
<p align='center'>
Figure 1: Serial port settings<br>
</p>

Once the serial port configured, you can connect SWAPdmt to the wireless network by pressing _Gateway->Connect_.


# Serial gateway network settings #
SWAPdmt can only be connected to a single SWAP network at the same time. This said, specific network parameter for the management tool can be configured from _Gateway->Network_. Frequency channel, network id, device address and security can be directly changed from this menu.

<p align='center'>
<img src='https://lh3.googleusercontent.com/-JxAQ4itFQfE/TvuDivuVA8I/AAAAAAAAAD0/Hacg4bzAdH8/s302/swapdmtgui_gateway_network.png' />
</p>
<p align='center'>
Figure 2: Serial gateway network settings<br>
</p>


# Identify SWAP devices #
Once SWAPdmt connected to the wireless network, it continuously listens to any SWAP packet being transmitted over the air. SWAPdmt sends queries in order to get the product code from the existing motes and checks these codes against the database of [device description files (xml)](devicexml.md). This procedure lets SWAPdmt automatically discover devices, identifying them and their respective I/O resources.

<p align='center'>
<img src='https://lh5.googleusercontent.com/-DFfl6rHvaY0/TvuDjl0rFlI/AAAAAAAAAEE/TY-PtffxrAw/s640/swapdmtgui_main.png' />
</p>
<p align='center'>
Figure 3: Main SWAPdmt window.<br>
</p>

SWAPdmt basically consists in three panels:

## SWAP network browser ##

This is a SWAP browsing tree containing every SWAP device detected in the network and its associated resources (registers, configuration parameters and endpoints). Parameters and motes can be edited from this tree by right-clicking on the corresponding branch.

## Wireless packet sniffer ##

SWAP packets read by the serial gateway are displayed in this panel. Packet details can be  displayed too by rignt-clicking on any SWAP frame.

## Network events ##

Any event occurred in the SWAP network such as "New mote detected" or "Endpoint value changed" is displayed in this panel.


# Device network settings #

_Devices->Network_ opens a configuration window that lets you configure the configuration registers that have to do with network connectivity on each wireless device (mote). Frequency channel, network id, device address, security and Tx interval are the most important network parameters when you need to add new motes to a SWAP network. Just remember that in order to connect to a given wireless device, SWAP gateway and wireless device must share the same network parameters, except address, that must be different.

As a side note, SWAP devices, including serial gateways, can take any address from 1 to 255. 0 is reserved as broadcast address.

<p align='center'>
<img src='https://lh6.googleusercontent.com/-36SDntXLGQE/TvuDiJPWWtI/AAAAAAAAADQ/Qw7MLir87O4/s361/swapdmtgui_device_network.png' />
</p>
<p align='center'>
Figure 4: Device network settings<br>
</p>

After pressing _OK_ SWAPdmt checks the availability of the wireless device. If the device is supposed to be sleeping – mostly happening on battery-operated devices – the user will be asked to manually put the device into _SYNC_ mode. This action will awake the wireless mote from its sleeping state and will let the mote receive the necessary wireless commands before leaving the _SYNC_ state again.


# Configuring custom settings #

The configuration procedure is quite straightforward. First click on Devices->Custom Settings and then select "your wireless device from the list. This action will tell SWAPdmt which settings to edit. Then, the configuration tool will sequentially prompt the user for the required values. At the end, SWAPdmt will ask the user to put his device in SYNC mode, probably pressing a button.

The magics behind this procedure resides in the existence of a XML definition file for each type of mote. Every XML file defines the position of each register within the device, bit length, data type and the way to filter the user input.

<p align='center'>
<img src='https://lh5.googleusercontent.com/-yxH2mbU2lz4/TvuDhzJuIJI/AAAAAAAAADE/P61lT7F9WHU/s512/swapdmtgui_chronos4.png' />
<p align='center'>
Figure 5: ez430-Chronos custom settings dialog<br>
</p>