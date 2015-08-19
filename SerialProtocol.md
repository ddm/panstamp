**panStamp serial protocol**

  * [Introduction](SerialProtocol#Introduction.md)
  * [Modes of operation](SerialProtocol#Modes_of_operation.md)
    * [Data mode](SerialProtocol#Data_mode.md)
    * [Command mode](SerialProtocol#Command_mode.md)
  * [Existing software libraries](SerialProtocol#Existing_software_libraries.md)

# Introduction #
Serial gateways are crucial pieces of hardware in wireless networks. In order to communicate wirelessly from a computer, we need a modem, gateway or interface capable to translate wireless packets into a byte stream, readable by the host computer.

The _modem_ application has been developed for this purpose; any panStamp connected serially to a computer can work as a wireless gateway when running this firmware. Wireless packets captured by the gateway are passed to the host in form of streams of characters whilst the host can control the gateway with standard AT commands.

# Modes of operation #
The modem or serial gateway has two modes of operation: **data mode** and **command mode**. _Data mode_ is a running state where wireless packets are passed to the host and where the host can send wireless packets through the gateway. _Command mode_ disables the reception/transmission of wireless packets and lets configure the gateway through the use of AT commands.

## Data mode ##
_Data mode_ is the default state, initially adopted when the gateway starts-up. This mode listens the wireless network and converts incoming wireless packets into ASCII strings, which are then passed to the host via serial port.

The _modem_ application is protocol-agnostic, that means that each ASCII string contains the whole information found in the wireless packet received. Thus, any protocol decoding process must be done by the host. The structure of the ASCII wireless packets is described below:

Incoming wireless packets are passed to the host with the following structure:

**_(RR,QQ)DDpayload_**

  * RR (1 byte) : RSSI value calculated by the serial gateway
  * QQ (1 byte) : LQI value calculated by the serial gateway
  * DD (1 byte) : Destination address
  * payload (n byte) : Data payload

Bytes are represented in HEX format. All ASCII packets are terminated by carriage return (\r = 0x0D).

Outgoing packets are passed to the serial gateway following the same structure shown above without the (RSSI,LQI) pair:

**_DDpayload_**

Implementing custom protocols over the above packet structure is quite straightforward. For example, SWAP fields from source address to the last data byte sit onto the data payload as described in [this page](SWAP#Packet_structure.md).

## Command mode ##
_Command mode_ is entered from _data mode_  following a simple process:

  1. Send +++ without trailing carriage return
  1. At least 1 second of silence
  1. Command mode entered

Once in _command mode_, the _modem_ application accepts the following set of AT commands (followed by carriage return):

| **AT Command** | **Description** |
|:---------------|:----------------|
| AT             | Basic Attention command |
| ATZ            | Reset modem     |
| ATO            | Go to data mode |
| ATCH?          | Return frequency channel |
| ATCH=XX        | Set frequency channel to XX (HEX) |
| ATSW?          | Return synchronization word |
| ATSW=XXXX      | Set synchronization word to XXXX (HEX) |
| ATDA?          | Return device address |
| ATDA=XX        | Set device address to XX (HEX) |
| ATAC?          | Return address check. 1 = enabled, 0 = disabled |
| ATAC=XX        | Set address check to XX. 01 = enabled, 00 = disabled |
| ATHV?          | Return Hardware version |
| ATFV?          | Return Firmware version |

# Existing software libraries #
pyswap is the official library created to interface the modem application. Written using Python, this library is the basis of [SWAPdmt](SWAPdmt.md) and other plugins currently being developed.
