**SWAP registers and the importance of interoperability**

# Standard SWAP registers #

  * [Introduction](SWAPregisters#Introduction.md)
  * [Standard registers](SWAPregisters#Standard_registers.md)
    * [Product code](SWAPregisters#Product_code.md)
    * [Hardware Version](SWAPregisters#Hardware_Version.md)
    * [Firmware Version](SWAPregisters#Firmware_Version.md)
    * [System state](SWAPregisters#System_state.md)
    * [Frequency channel](SWAPregisters#Frequency_channel.md)
    * [Security option](SWAPregisters#Security_option.md)
    * [Security password](SWAPregisters#Security_password.md)
    * [Security nonce](SWAPregisters#Security_nonce.md)
    * [Network ID](SWAPregisters#Network_ID.md)
    * [Device address](SWAPregisters#Device_address.md)
    * [Periodic Tx Interval](SWAPregisters#Periodic_Tx_interval.md)
  * [Custom registers](SWAPregisters#Custom_registers.md)

# Introduction #

We commented in the [SWAP description page](http://code.google.com/p/panstamp/wiki/SWAP) the importance of registers. Every wireless parameter, endpoint value or user configuration setting can have a register representation. Doing this, SWAP can address very different actions using a basic packet exchange schema. In other words, using abstract data registers is the main reason of SWAP being so simple and flexible.

Developers may create their own registers for their own purposes. However, all SWAP devices have to include a number of standard registers that provide a basic functionality, common to any SWAP mote, as a way of guaranteeing a basic interoperability between devices.

# Standard registers #

The following registers must be included by any device implementing the SWAP protocol:

## Product code ##

Register ID = 0

Length = 8 bytes

Access: read only

Description: code is formed by Manufacturer ID (4 bytes) and Product ID (4 bytes)

![https://lh4.googleusercontent.com/-O0yUvAEqRgY/TYDko4wALjI/AAAAAAAAAy4/CgFfzcjaK88/s1600/product_code.png](https://lh4.googleusercontent.com/-O0yUvAEqRgY/TYDko4wALjI/AAAAAAAAAy4/CgFfzcjaK88/s1600/product_code.png)

**Manufacturer ID**

Each developer or manufacturer of SWAP devices owns a unique Manufacturer ID. This ID is part of the product code of any device made by this developer.

**Product Id**

Each type of wireless device is identified by a unique Product ID, common to all devices of the same type belonging to the a given manufacturer.

## Hardware Version ##

Register ID = 1

Length = 4 bytes

Access: read only

Description: 4-byte code identifying the hardware version of the wireless device

## Firmware Version ##

Register ID = 2

Length = 4 bytes

Access: read only

Description: 4-byte code identifying the firmware version of the wireless device

## System state ##

Register ID = 3

Length = 1 byte

Access: read and write

Description: 1-byte register used to query and control the state of the wireless device. Developers are free to define their own states but, at least, the following should be used:

  * State = 0 (RESTART) -> Restart wireless device
  * State = 1 (RXON) -> Wireless reception enabled
  * State = 2 (RXOFF) -> Wireless reception disabled
  * State = 3 (SYNC) -> Synchronization mode, wireless reception enabled
  * State = 4 (LOWBAT) -> Low battery state

## Frequency channel ##

Register ID = 4

Length = 1 byte

Access: read and write

Description: RF frequency channel used by the wireless device

## Security option ##

Register ID = 5

Length = 1 byte

Access: read and write

Description: type of security protection used against different wireless attacks.

  * Security option = 0 -> No security
  * Security option = 1 -> Data encryption disabled, security nonce enabled
  * Security option = 2 -> Basic data encryption enabled, security nonce enabled

Developers are free to define new security options, using custom encryption algorithms.

## Security password ##

(Not supported yet)

Register ID = 6

Length = n bytes

Access: read and write

Description: Encryption password, to be used according to _Security option_.

## Security nonce ##

Register ID = 7

Length = 1 byte

Access: read only

Description: when enabled, security nonces add protection against play-back attacks. As explained in the protocol definition page, security nonces can be queried before sending commands to a given device.

## Network ID ##

Register ID = 8

Length = 2 bytes

Access: read and write

Description: each SWAP network is identified by a 2-byte code. This ID is appended by the CC11XX IC at the beginning of every wireless packet, just after the preamble.

## Device address ##

Register ID = 9

Length = 1 byte

Access: read and write

Description: 1-byte SWAP address

## Periodic Tx interval ##

Register ID = 10

Length = 2 bytes

Access: read and write

Description: Interval (in seconds) between periodic transmissions. _panstamp.goToSleep()_ uses this interval to put the panStamp in power-down mode.

# Custom registers #

Custom registers may be of any type and any length. They must have unique register ID's and process commands and queries in the same way standard registers do, as explained in this section of the SWAP description page. However, a question arises: how can other wireless devices know about the nature of these custom registers? What if a visual application wants to display information about a given register or value? Abstract protocols like SWAP rarely solve this kind of limitation. Instead, we suggest the use of static resources, accessible from local or on-line repositories, that identify and describe wireless devices from a basic starting point: the product code.

The first custom register always takes ID = 11. The second one will take ID = 12 and so on...