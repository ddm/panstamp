# Lagarto-SWAP: lagarto server for SWAP networks #

  * [Introduction](LagartoSWAP#Introduction.md)
  * [Configuration](LagartoSWAP#Configuration.md)
    * [General Settings](LagartoSWAP#General_Settings.md)
    * [Lagarto Settings](LagartoSWAP#Lagarto_Settings.md)
    * [Serial port settings](LagartoSWAP#Serial_port_settings.md)
    * [Wireless network settings](LagartoSWAP#Wireless_network_settings.md)
  * [Control and monitoring page](LagartoSWAP#Control_and_monitoring_page.md)

# Introduction #

Lagarto-SWAP is the server that talks to panStamps. This process relies on [pyswap](pyswap.md) and takes advantage of the whole functionality provided by the python library.

# Configuration #

Lagarto-SWAP is entirely configured from the web interface. Default HTTP port is 8001 so in order to access the web interface we have to open the following URL:

http:\\ip\_address:8001

## General Settings ##

This page lets us define the location for the different configuration files and remote repositories. Debug level can be configured from this page as well. You can leave the default parameters.

<p align='center'>
<img src='https://lh3.googleusercontent.com/-RuXgt1GFqQc/T0EnK7uOLHI/AAAAAAAAALM/khH86oZHl08/s591/lagarto_web_2.png' />
</p>
## Lagarto settings ##

Every lagarto process needs some configuration parameters to be edited from this page:

  * process name: name of the lagarto process. This name has to be unique across all lagarto process
  * Broadcast channel: TCP/IP address and port to be used for notifications. This channel must be the same for all lagarto processes.
  * HTTP server port: unique for each lagarto process running in the same machine.Default value is 8001.

<p align='center'>
<img src='https://lh3.googleusercontent.com/-pQzfFhX1pfY/T4dMMifBnnI/AAAAAAAAAOw/xCCxaBkEA_o/s590/lagarto_swap_lagarto_settings.png' />
</p>

## Serial port settings ##

Serial port and speed of the SWAP modem connected to the Lagarto-SWAP computer. panStamps running the modem application use 38400 bps as the default serial speed.

<p align='center'>
<img src='https://lh6.googleusercontent.com/-PMDPQdmLzsA/T4dMNQx5gpI/AAAAAAAAAPI/5_5uby9BhEY/s578/lagarto_swap_modem_serial.png' />
</p>

## Wireless network settings ##

Configuration of the wireless network settings.

<p align='center'>
<img src='https://lh3.googleusercontent.com/-92yeMqIL6H4/T4dMMgPB6FI/AAAAAAAAAO0/ExEqgih7lEc/s582/lagarto_swap_modem_network.png' />
</p>

# Control and monitoring page #

This web page provides a simple interface for viewing and controlling SWAP values. It also lets us configure some cosmetic parameters related to the values such as units, name and location of the endpoint.

<p align='center'>
<img src='https://lh4.googleusercontent.com/-gbXrbZaYKuE/T0Elh3N7VPI/AAAAAAAAAKU/FswIVwaZJ_w/s571/lagarto_web_1.png' />
</p>