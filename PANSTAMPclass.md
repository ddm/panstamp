# PANSTAMP class #

  * [Introduction](PANSTAMPclass#Introduction.md)
  * [Public arguments](PANSTAMPclass#Public_arguments.md)
  * [Public methods](PANSTAMPclass#Public_methods.md)
  * [Public macros](PANSTAMPclass#Public_macros.md)
  * [Example](PANSTAMPclass#Example.md)

# Introduction #

The PANSTAMP class contains the necessary mechanisms to control the board. This class provides some basic methods that will let you initialize and reset the panStamp board and enter the low-power mode. Everything related to the board is contained into this class. Behind the scenes, PANSTAMP automatically dispatches SWAP commands and queries, replaying with SWAP status packets when necessary.

# Public arguments #

```
    /**
     * CC1101 radio interface
     */
    CC1101 cc1101;
    
    /**
     * Security options
     */
    byte security;

    /**
     * Security cyclic nonce
     */
    byte nonce;
    
    /**
     * System state
     */
    byte systemState;

    /**
     * SWAP status packet received. Callaback function
     */
    void (*statusReceived)(SWPACKET *status);
```

# Public methods #

```
    /**
     * init
     * 
     * Initialize panStamp board
     */
    void init(void);

    /**
     * reset
     * 
     * Reset panStamp
     */
    void reset(void);

    /**
     * sleepFor
     * 
     * Put panStamp into Power-down state during "time".
     * This function uses the internal watchdog timer in order to exit (interrupt)
     * from the power-doen state
     * 
     * 'time'	Sleeping time:
     *  WDTO_15MS  = 15 ms
     *  WDTO_30MS  = 30 ms
     *  WDTO_60MS  = 60 ms
     *  WDTO_120MS  = 120 ms
     *  WDTO_250MS  = 250 ms
     *  WDTO_500MS  = 500 ms
     *  WDTO_1S = 1 s
     *  WDTO_2S = 2 s
     *  WDTO_4S = 4 s
     *  WDTO_8S = 8 s
     */
    void sleepFor(byte time);
    
    /**
     * getInternalTemp
     * 
     * Read internal (ATMEGA328 only) temperature sensor
     * 
     * Return:
     * 	Temperature in milli-degrees Celsius
     */
    long getInternalTemp(void);
```

# Public macros #

Apart from the above methods, developers can use any of the available macros:

```
/**
 * setSwapStatusCallBack
 *
 * Set callback function for any status packet received.
 *
 * 'ptrFunc'  Pointer to the callback function
 *
 * Usage:
 * 
 * void myFunction(SWPACKET *status)
 * {
 *   ...
 * }
 *
 * panstamp.setSwapStatusCallBack(myFunction);
 */
setSwapStatusCallBack(ptrFunc)

/**
 * eepromToFactoryDefaults
 *
 * Restore EEPROM to the factory defaults
 *
 * Usage:
 * 
 * panstamp.eepromToFactoryDefaults();
 */
eepromToFactoryDefaults()

/**
 * setHighTxPower
 *
 * Set Tx power to the maximum. Increases transmission distances but the current
 * consumption switches to 33-35 mA when transmitting.
 *
 * Usage:
 * 
 * panstamp.setHighTxPower();
 */
setHighTxPower()

/**
 * setLowTxPower
 *
 * Set Tx power to a medium reasonable value. Decreases transmission distances
 * (~200 m) but the current consumption is maintained in the 17-19 mA range
 * when transmitting. This is the default mode.
 *
 * Usage:
 * 
 * panstamp.setLowTxPower();
 */
setLowTxPower()
```

# Example #

[temphumpress.ino](http://code.google.com/p/panstamp/source/browse/trunk/arduino/sketches/temphumpress/temphumpress.ino) is a good example about the use of this class. Generally, you will want to use something similar to the following code:

```
void setup()
{ 
  // Init panStamp
  panstamp.init();

  // Send SWAP status packet containing product information
  getRegister(REGI_PRODUCTCODE)->getData();

  // Run here your initialization code
}

void loop()
{
  // Run ADC conversions and send SWAP status packet
  getRegister(REGI_HUMIDTEMP)->getData();
  
  // Only for battery-operated devices, sleep the board for a given time
  panstamp.sleepFor(WDTO_8S);   // Sleep for 8 seconds
}
```

The above code is specially suited for a sensor that sleeps most of the time. Let's imagine now that we have a node permanently connected to the mains. This node continuously listens to the network, awaiting for specific SWAP status:

```
// Define here what you want to do with the incoming SWAP status
void swapStatusReceived(SWPACKET *status)
{
  // SWAP status packet received
  byte sAddr = status->srcAddr;       // Source address
  byte rAddr = status->regAddr;       // Register address
  byte rId = status->regId;           // Register id
  byte len = status->value.length;   // Length of the register value
  byte *val = status->value.data;    // register value

  // Run here your code
}

void setup()
{ 
  // Init panStamp
  panstamp.init();

  // Declare SWAP status callback function
  panstamp.setSwapStatusCallBack(swapStatusReceived);

  // Send SWAP status packet containing product information
  getRegister(REGI_PRODUCTCODE)->getData();

  // Run here your initialization code
}

void loop()
{
  // Run ADC conversions and send SWAP status packet
  getRegister(REGI_HUMIDTEMP)->getData();
  
  // Only for battery-operated devices, sleep the board for a given time
  panstamp.sleepFor(WDTO_8S);   // Sleep for 8 seconds
}
```

Defining the "statusReceived" callback function is the way to pick up SWAP status packets. SWAP status are always broadcasted so our device maybe wants to do something with a status coming from a given device and register.

On the other hand, SWAP commands and queries addressed to our device are automatically dispatched by the panstamp stack, as explained in [this page](PANSTAMPstack#How_it_works.md).