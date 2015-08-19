# panStamp stack: the intelligence behind the scenes #

  * [Introduction](panstampstack#Introduction.md)
  * [Details](panstampstack#Details.md)
    * [Data container](panstampstack#Data_container.md)
    * [Updater and setter functions](panstampstack#Updater_and_seter_functions.md)
      * [Updater function](panstampstack#Updater_function.md)
      * [Setter function](panstampstack#Setter_function.md)

# Introduction #

The panStamp stack has been designed to simplify adoption by developers, reducing the need of custom code to the minimum and still occupy very low footprint (less than 6 Kb of Flash and less than 1 Kb of RAM). The stack also intends to isolate user code from SWAP communications so that developers can really focus on their applications without having to worry about incoming commands or queries or about having to send status packets.

# Details #

But, what is behind this magic? SWAP is a protocol that allows the creation of a register-centered stack. From a practical point of view, we can say that the core of the stack is a table of register objects. This table consists of a mix of [standard registers](SWAPregisters#Standard_registers.md) and custom ones. Moreover, the index of each register within the table matches the register ID. This fact lets the stack link SWAP packets and registers quickly and efficiently without having to use intermediary look-up tables.

<p align='center'>
<img src='https://lh5.googleusercontent.com/-9XBVAn3Uj6o/TwHmi7NovtI/AAAAAAAAAG8/8_VSykFhI2w/s615/registers.png' />
</p>

Register objects are simple collections of pointers that help trigger actions and access data upon reception of SWAP packets. Registers consist of a pointer to a data container (an array of bytes) and a couple of optional pointers to an _updater_ and a _setter_ function.

<p align='center'>
<img src='https://lh6.googleusercontent.com/-NLw1J4iwLn8/Tv8RGoDk1uI/AAAAAAAAAFU/1sPtTc0vqD8/s339/regpointers.png' />
</p>

## Data container ##

Data containers can take any length so that, despite the limitation to 255 registers, panStamps' data limits actually reside in the amount of available RAM and not in the stack itself. When transmitting SWAP command and status packets, data is copied to/from these arrays, keeping the same format and length.

<p align='center'>
<img src='https://lh5.googleusercontent.com/-TXXc-5cCiOA/Tv8V5UR0skI/AAAAAAAAAF8/gwFaGqXgr9w/s846/datacontainer_packet.png' />
</p>

## Updater and setter functions ##

_Updater_ and _setter_ functions are user callback methods made to work with registers and to interface the SWAP network in a simple way.

<p align='center'>
<img src='https://lh5.googleusercontent.com/-MD_M0RX6Ras/TwHiUwGEqkI/AAAAAAAAAGc/nzwbq5FWRds/s828/regpointers2.png' />
</p>

### Updater function ###

_Updater_ functions take care of updating register values after the reception of a SWAP query or simply when calling _REGISTER::getData()_ These functions are usually implemented by developers to read sensors, switches or just for updating internal parameters. For example, if we define the following _updater_ function for one of our custom registers:

```
const void updtADCinput(byte rId)
{
  // Read ADC input 0 (panStamp pin 4)
  int reading = analogRead(0);
  // Pace reading into the first two bytes of the register. Big endian representation
  regTable[rId]->value[0] = (reading >> 8) & 0xFF;
  regTable[rId]->value[1] = reading & 0xFF;
}
```

whenever our application or the stack itself calls _getReg(REGI\_OURREG)->getData()_ the above _updater\_function is called by the stack. As result, The reading of ADC0 is placed into our register and finally a SWAP status packet is brodcasted._


### Setter function ###

Setter functions are responsible for modifying registers when calling **REGISTER::setData(byte_value)_. Although _setData_ may be used from the user sketch, it is mainly called by the panStamp stack whenever a SWAP command packet is received by our device. If a custom register is modifiable from the outside (relay, PWM output, LCD text, configuration parameter, etc.) then this register needs a _setter_ function.**

In summary, _updater_ functions, used by _REGISTER::getData_, are called  by the stack when a SWAP query is received. On the other hand, _setter\_functions, used by_REGISTER::setData_, are called by the stack after receiving a SWAP command. In both cases, a SWAP status packet is returned to the network._

Example of setter function:

```
const void setRGBlevel(byte rId, byte *levels)
{
  // Update register
  memcpy(dtRGBlevel, levels, sizeof(dtRGBlevel));

  // Control RGB LED
  rgbLed.setColor(levels[0], levels[1], levels[2]);
}
```