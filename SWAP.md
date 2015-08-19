<p align='center'>
<img src='https://lh3.googleusercontent.com/-KZ9Zlvb-eOg/T0EostQvb5I/AAAAAAAAAL4/AP4LPEC3tfQ/s159/custom_logo.jpg' />
</p>
<p align='center'>
<b>SWAP, a very tiny protocol for constrained wireless M2M networks</b>
</p>

# Simple Wireless Abstract Protocol (SWAP) #

  * [Motivation](SWAP#Motivation.md)
  * [Introduction](SWAP#Introduction.md)
  * [Supported IC's](SWAP#Supported_IC's.md)
  * [Registers and values](SWAP#Registers_and_values.md)
  * [Packet structure](SWAP#Packet_structure.md)
    * [Network id](SWAP#Network_id.md)
    * [Function codes](SWAP#Function_codes.md)
      * [Status packets](SWAP#Status_packets_(function_code_=_0x00).md)
      * [Query packets](SWAP#Query_packets_(function_code_=_0x01).md)
      * [Command packets](SWAP#Command_packets_(function_code_=_0x02).md)
    * [Device address](SWAP#Device_address.md)
    * [Register ID](SWAP#Register_ID.md)
    * [Wireless hop](SWAP#Wireless_hop.md)
    * [Security option](SWAP#Security_option.md)
    * [Security nonce](SWAP#Security_nonce.md)
    * [Cyclic Redundancy Check](SWAP#Cyclic_Redundancy_Check.md)

# Motivation #

We needed a very simple and lightweight protocol for our panStamp boards, 8-bit AVR MCU's interfacing CC1101 RF front-ends. Most of the existing protocols provide an excess of functionality (and size) that was not necessary for the project. Again, we really needed a very low-footprint stack with enough flexibility to do great things.

# Introduction #

SWAP (Simple Wireless Abstract Protocol) is a compact and lightweight protocol designed to be used on Texas Instruments CC11XX-based radios. SWAP primarily focus on these radio chips because it relies on their packet structure but any other RF front-end with a similar frame format may be used too. On the other hand, this protocol can be adapted to other packet structures (and hence to other IC's) with little work.

# Supported IC's #

  * The whole CC11XX radio family, including the popular CC1100 and CC1101 front-ends
  * CC430 MCU's with integrated RF interfaces

# Registers and values #

Registers are SWAP's unit of information. Measured values, I/O's, and configuration parameters are treated as registers by SWAP. Every register has its own 1-byte identifier. Combining register address and register ID, each register is uniquely identified within a SWAP network (see [Packet structure section](SWAP#Packet_structure.md)).

Register values have not a fixed length but must not be longer than 55 bytes. Developers may decide whether to combine multiple endpoint values (I/O's) into a single register or allocate a register per endpoint. Both approaches are valid but, from a practical point of view, each of these options becomes more interesting depending on the use case:

  1. Multi-sensor boards typically run all ADC conversions at the same interval. Thus, the developer may prefer to maintain a single register combining all ADC values so that only a single status packet is needed.
  1. Multi-output boards are usually easier to control using one command packet per endpoint (or in other words, one register per endpoint). Otherwise, the sender risks to unintentionally alter any other output when trying to control one of them.

In summary, input endpoints can efficiently be combined into a single register whilst outputs are better managed from multiple registers.

This register approach has been inspired on Modbus, an abstract protocol that has proven its flexibility and adaptability in almost any application since the 70's. Working with abstract registers provides us with a way of transmitting different data independently from its type and origin, in a homogeneous manner. SWAP does not provide a way of identifying the nature of the data being transmitted, it just provides the necessary mechanisms for sending, requesting and controlling _abstract_ data registers. Freeing the protocol from having to deal with functional profiles, data types or dictionaries simplifies the implementation (smaller firmware footprint, faster processing speed, ...). Instead, end applications may compensate this by accessing central (or remote) repositories containing data descriptions in form of [XML files](devicexml.md). Besides, SWAP devices have to maintain a small amount of mandatory registers containing basic information like communication channel, device address and network id. The following chapter describes these [mandatory registers](SWAPregisters#Introduction.md).

# Packet structure #

![http://www.panstamp.com/swap_frame.png](http://www.panstamp.com/swap_frame.png)

SWAP can be used under two different addressing schemes: single-byte addresses and 2-byte addresses. The function byte will tell the application which schema is being used in each frame.

## Network ID ##

SWAP uses CC1101's Synchronization Word to identify the wireless network. Defining different network id's, multiple wireless networks can co-exist without interaction between them. Length of the Network ID: 2 bytes.

## Function codes ##

There are only three function codes:

  * 0x00 - Status packet
  * 0x01 - Query packet
  * 0x02 - Command packet

All SWAP packets share the same structure except query packets (function code = 0x01) that don't contain a data field. This makes parsing wireless packets a simple task.

Besides, bit 7 (most significant bit) from the function byte shows the length of the address fields. When function code, bit 7 is equal to 0 then single-byte addresses are being used. If bit 7 is equal to 1 then this means that the frame is using the extended address schema.

### Status packets (function code = 0x00) ###

Status packets report actual register values. Any device wanting to inform about a register value has to send a status packet. In order to guarantee interoperability between devices, the following conventions must be guaranteed:

  * The reception of a query packet must be followed by the transmission of a status message. Thus, querying a register must be answered by a status packet containing the register value being queried.
  * After receiving a command packet, a status message has to be sent with the register being modified.
  * Developers may decide whether transmit periodic status message or not and the transmission interval in each case. In general, sending periodic status about the most relevant registers may be a good practice.

Status messages are always broadcasted.

### Query packets (function code = 0x01) ###

Query packets are intended to request information from remote devices. Queries are directly addressed to the requested registers and remote nodes must reply with a status packet. Query packets can be occasionally broadcasted (address 0) only in some situations. For example, when a new high-end device (ex: IP gateway) starts or enters the network the first time then it can broadcast a query on register "Product Code" in order to know which awake nodes are available in the network.

### Command packets (function code = 0x02) ###

Command packets are used to control register values on any remote device. After completing the necessary changes on the register, the remote device must reply with a status packet informing about the value of the affected register. In case the register could not be modified, the remote device should reply with the contents of the unaltered register.

Command packets can never be broadcasted.

## Device address ##

SWAP device addresses are 1-byte or 2-byte length, depending on the addressing schema being used. In both cases the automatic address filtering may be enabled on the RF IC. Broadcast address is 0 so wireless devices must take an addresses between 1 and 255 (0xFF) for the simple addressing schema or between 1 and 65535 (0xFFFF) for the extended schema.

Each SWAP packet contains three different device addresses:

  * **Destination address** is the address of the device targeted by the SWAP packet.
  * **Source address** is the address of the device that sends the packet.
  * **Register address** is the address of the device that actually owns the register being queried, controlled or reported.

SWAP adds the register address field as a way to provide access to off-line data. Battery-based sensors typically pass most of the time asleep so they can not respond to queries and commands instantaneously. On the other hand, central controllers or data recorders, that are always listening the media, can store off-line data and process queries sent from other devices.

As an example, let's suppose we have a device with address 0x05 that sends the contents of a register (register id = 0x0A) containing a temperature value. We also have an "always listening" device with address 0x06, connected to the mains, that acts as data recorder. Finally, a mobile device with address 0x07 needs to query the temperature register. Initially, our mobile device may send the query packet directly to the sensor device as follows:

0x05 0x07 0x00 0x00 0x01 0x05 0x0A

But the sensor device would unlikely respond to the query since it passes most of the time asleep. Thus, our mobile device may try one of the following procedures:

  1. Listen for the register value being sent by the sensor device periodically.
  1. Wait until the sensor device wakes up and then send the query to it.
  1. Query the register directly to the data recorder device:

**0x06** 0x07 0x00 0x00 0x01 0x05 0x0A

## Register ID ##

Each register is uniquely identified within a device by this 1-byte digit. Combined with the register address, any register is uniquely identified within a wireless network. Length of the register id: 1 byte.

## Wireless hop ##

This 4-bit field counts the amount of times that a wireless packet is repeated. When a packet is originally generated, the hop counter is 0.

## Security option ##

This 4-bit value specifies the type of security defense used to protect data fields and avoid external attacks.

  * bit 3 -> Reserved.
  * bit 2 -> AES encryption bit. 1: enabled, 0: disabled
  * bit 1 -> Smart encryption bit. 1: enabled, 0: disabled
  * bit 0 -> Security nonce bit. 1: enabled, 0: disabled


## Security nonce ##

When enabled, security nonces provide a way of combating against play-back attacks. Every wireless device maintains its own single nonce counter. Whenever a device sends a status packet, the nonce is incremented by one. Status packets that do not contain the correct nonce have to be discarded by any other device listening the media. Later, any device wanting to send a command has to include the current nonce of the targeted device.

Query packets do not have to include the correct nonce. Thus, nonce = 0 in all query messages.

## Cyclic Redundancy Check ##

This is a simple 16-bit CRC field, automatically calculated and appended by the CC11XX IC, based on the contents of the cc11XX data payload.