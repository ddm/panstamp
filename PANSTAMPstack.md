**The stack, core of panStamps**

# PANSTAMP stack #

  * [Introduction](PANSTAMPstack#Introduction.md)
  * [Functionality](PANSTAMPstack#Functionality.md)
  * [How it works](PANSTAMPstack#How_it_works.md)
  * [Table of registers](PANSTAMPstack#Table_of_registers.md)
  * [Other examples](PANSTAMPstack#Other_examples.md)

# Introduction #

The panStamp stack is the firmware behind the scenes. It primarily consists of a public set of functions, variables and, the most important, all the automatic procedures that deal with the SWAP protocol.

# Functionality #

The stack is responsible of doing the following tasks:

  * Listening to the wireless SWAP network
  * Parsing incoming SWAP packets
  * Transmission of SWAP packets
  * Automatic generation of responses to incoming SWAP commands and queries
  * Management of registers, including updates and external control
  * Control of the internal state machine
  * Power management
  * Storage of configuration registers in EEPROM

All the above features provide a high degree of isolation between network communications, endpoint management and user code. In fact, the main goal of using this stack is letting the user concentrate on developing the application whilst the stack does the rest.

<p align='center'><img src='https://lh6.googleusercontent.com/-9pPNOkG2-Os/ThCPlE7RceI/AAAAAAAAA9s/vZb_3ZX4GiM/stack_3.png' /></p>


# How it works #

Stack and application run on a single-thread. Through the use of interruptions, the stack receives and parses wireless packets without interfering the normal operation of the user application. The CC1101 IC does an address check on each packet received. Thus, only packets addressed to our device are passed to the stack. Whenever a SWAP packet is received, the following mechanisms come into play:

**1. SWAP query addressed to our device**
The panStamp stack looks up the table of registers and responds with a status packet.

**2. SWAP command addressed to our device**
The panStamp stack looks up the table of registers, runs register's setter function (if exists) and responds with a status packet

**3. SWAP status packet broadcasted**
The panStamp stack calls a user callback function so that the status packet can be dispatched from the Arduino sketch.

With the above automatic procedures, a good degree of abstraction between stack and user application is achieved. At the same time, user application is freed from having to deal with SWAP-related details. Which is the magics behind all this?

In order to make this engine work, developers have to build a table of registers for each device (each sketch). The first part of the table is common to all devices, formed by some standard registers as _channel number_, _address_ or _network id_. The rest of registers are proprietary to each application.


# Table of registers #

_regTable_ is the global table of registers. Each member of this table (REGISTER) has to be created using the following constructor:

```
    /**
     * REGISTER
     * 
     * Constructor
     * 
     * 'val'          Pointer to the register value
     * 'len'          Length of the register value
     * 'getValH'      Pointer to the getter function
     * 'setValH'      Pointer to the setter function
     */
    REGISTER(byte *val, const byte len, const void (*updateValH)(byte rId), const void (*setValH)(byte rId, byte *v)):id(regIndex++), value(val), length(len), updateValue(updateValH), setValue(setValH) {};
```

For example, let's imagine that we want to create a custom register intended to store humidity and temperature values. In our example, temperature and humidity take one byte each one so we need a two-byte register:

```
// Allocating the two-byte register field
static byte dtTempHum[2];
// Definition of the register itself
REGISTER regTempHum(dtTempHum, sizeof(dtTempHum), &updtTempHum, NULL);
```

On the above example _dtTempHum_ is the array that really stores the value of the _regTempHum_ register. _updtTempHum_ is the _getter function_, a callback function defined by the user and called whenever _regTempHum.getValue()_ is called from the Arduino sketch. Thus, if you need to run ADC conversions and do other calculations over the register value, this callback function is the place to do it.

Following with the above example, let's suppose that we need to update the "temperature & humidity" register every 8 seconds and then go to sleep. We would do the following in the main loop:

```
/**
 * loop
 *
 * Arduino main loop
 */
void loop()
{
  // Update _updtTempHum_ register and send SWAP status packet
  getRegister(REGI_HUMIDTEMP)->getData();
  
  // Sleep for 8 seconds
  panstamp.sleepFor(WDTO_8S);
}
```

Back to the above register definition, there is no pointer to a _setter function_ (null). A _setter function_ is another callback function to be defined by the user. However, unlike the _getter function_, a _setter function_ is called from register.setValue(val). In other words, this function automatically runs whenever a SWAP command is addressed to the register. Since _regTempHum_ is not controllable (it's just a couple of ADC inputs), there is no setter function associated to the register. As result, whenever a SWAP command is sent to our register the panStamp will respond with a SWAP status packet containing the value unaltered. That's all.

OK, once our custom register defined, let's define _regTable_, the complete array of registers:

```
/**
 * Initialize table of registers (regTable)
 */
DECLARE_REGISTERS_START()
  &regVoltSupply,
  &regTempHum
DECLARE_REGISTERS_END()
```

_regTable_ is in fact an array of pointers to registers. This let us manipulate very diverse information and variable data-lengths without having to allocate any unused memory space.

The above macro automatically adds the main [standard registers](SWAPregisters#Standard_registers.md), common to all SWAP devices. The index of each register within _regTable_ matches its ID so whenever a SWAP command or query is addressed to our device, the id is used to find the register in _regTable_ and run the necessary operations with the help of the pre-defined callback functions. This would seem a bit complicated but it's fast, saves a lot of flash and prevents the user from having to deal with the SWAP protocol.

# Other examples #

Reviewing some real code is maybe the best way to understand these concepts. Any _regtable.pde_ file from any of the available sample sketches will show you how to define custom registers and create your own _getter_/_setter_ callback functions.

For example, from the temphum sample code: [regtable.ino](http://code.google.com/p/panstamp/source/browse/trunk/arduino/sketches/temphumpress/regtable.ino)

# More details #

[This page](panstampstack.md) shows some additional details about how the panStamp stack works.