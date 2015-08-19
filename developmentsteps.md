# Steps to be done along the development of a new SWAP device #

  * [Introduction](developmentsteps#Introduction.md)
  * [Design process](developmentsteps#Design_process.md)
    * [Step 1: Choose your hardware](developmentsteps#Step_1:_Choose_your_hardware.md)
    * [Step 2: Create your Arduino sketch](developmentsteps#Step_2:_Create_your_Arduino_sketch.md)
      * [product.h: specify your product code](developmentsteps#product.h:_specify_your_product_code.md)
      * [regtable.ino: create your custom registers](developmentsteps#regtable.ino:_create_your_custom_registers.md)
      * [regtable.ino: define updater and setter functions for your registers](developmentsteps#regtable.ino:_define_updater_and_setter_functions_for_your_registers.md)
      * [regtable.h: define ID's for our custom registers](developmentsteps#regtable.h:_define_ID's_for_our_custom_registers.md)
      * [Main.ino file: initialize the board](developmentsteps#Main.ino_file:_initialize_the_board.md)
      * [Main.ino file: Run periodic tasks](developmentsteps#Main.ino_file:_Run_periodic_tasks.md)
    * [Step 3: Create a definition file for our new device](developmentsteps#Step_3:_Create_a_definition_file_for_our_new_device.md)
  * [Automatic generation of source code](developmentsteps#Automatic_generation_of_source_code.md)

# Introduction #

This tutorial explains some basic steps to follow during the development of new SWAP devices. If you base your development on a panStamp or any other Arduino-based platform and you follow this guide, you will surely find this process quite straightforward.

# Design process #

## Step 1: Choose your hardware ##

Choose your preferred sensors, power source and actuators that fit your design. Identify your endpoints and configuration parameters. Decide how you want to group these values in the panStamp register table.

## Step 2: Create your Arduino sketch ##

Create a new Arduino sketch based on our template or any of the existing sketches. Then make the necessary modifications, as explained below:

### product.h: specify your product code ###

**product.h** contains some fields that need to be filled in order to make our device identifiable from the SWAP network. Manufacturer ID and Product ID are the most important ones. Remember to use the unique Manufacturer ID, provided during the member registration process. Product ID can take any 4-byte value and should be used only in devices of the same type (same product). Once our developments completed, this Product ID and our new device definition file should be uploaded to the central repositories in order to make our devices identifiable by any application or device.

```
/**
 * Hardware version
 */
#define HARDWARE_VERSION        0x00000000

/**
 * Firmware version
 */
#define FIRMWARE_VERSION        0x00000000

/**
 * Manufacturer SWAP ID
 */
#define SWAP_MANUFACT_ID        0x00000000

/**
 * Product SWAP ID
 */
#define SWAP_PRODUCT_ID         0x00000000
```

### regtable.ino: create your custom registers ###

**regtable.ino** is the place where to define custom registers and their behavior. To make this tutorial a bit easier, let's suppose we want to implement a sketch for a device that has two analog inputs and two PWM outputs. Thus, we can define two custom registers, each containing two endpoints:

```
/*
 * Definition of custom registers
 */
// ADC inputs
static byte dtADCinputs[4];                   // Data container: two 10-bit ADC values
REGISTER regADCinputs(dtADCinputs,            // Pointer to the data container
                      sizeof(dtADCinputs),    // Size of the data container
                      &updtADCinputs,         // Pointer to the updater function
                      NULL);                  // Pointer to the setter function

// PWM outputs
static byte dtPWMoutput0[1];                  // Data container: one 8-bit PWM value
REGISTER regPWMoutput0(dtPWMoutput0,          // Pointer to the data container
                      sizeof(dtPWMoutput0),   // Size of the data container
                      NULL,                   // Pointer to the updater function
                      &setPWMoutput);         // Pointer to the setter function

static byte dtPWMoutput1[1];                  // Data container: one 8-bit PWM value
REGISTER regPWMoutput1(dtPWMoutput1,          // Pointer to the data container
                      sizeof(dtPWMoutput1),   // Size of the data container
                      NULL,                   // Pointer to the updater function
                      &setPWMoutput);         // Pointer to the setter function
```

And now we have to insert pointers to the above registers into the global table of registers. These pointers have to be inserted in the same order as they were defined.

```
/**
 * Initialize table of registers
 */
DECLARE_REGISTERS_START()
  &regADCinputs,    // Register ID = 11 (0x0B)
  &regPWMoutput0,   // Register ID = 12 (0x0C)
  &regPWMoutput1,   // Register ID = 13 (0x0D)
DECLARE_REGISTERS_END()
```

The above declaration appends our custom registers after the first [standard (mandatory) registers](SWAPregisters.md) (Register ID's 0 to 10) so that every register, custom or standard, can be accessed in the same way, via _getRegister_. Also note that whilst PWM output values are placed in two independent registers (regPWMoutput0 and regPWMoutput1), ADC inputs share a common register (regADCinputs). Doing this, only one SWAP status packet will be needed in order to inform about the value of both ADC readings. On the output side, each PWM output will be controllable through a different register command (Register ID 12 and 13). This could be done differently but we think that grouping inputs in common registers and maintaining outputs in independent registers is a good practice, a good compromise between low bandwidth consumption (input side) and logic isolation between outputs.

### regtable.ino: define updater and setter functions for your registers ###

Let's now define every _updater_ and _setter_ function. _Updater_ functions are responsible of updating registers values before  transmitting _status_ packets. On the other hand, _setter_ functions are the only means to modify registers from the outside by sending _commands_ to our device. As result, regADCinputs, defines only an updater function since it contains only inputs (ADC inputs) and they are not modifiable from the outside. regPWMoutputs contains only outputs so we only need the _setter_ function in this case. [This page](panstampstack.md) explains how _updater_ and _setter_ functions work  and how they interact with the SWAP network.

In our example, we have to define an _updater_ function, called **updtADCinputs**, that will have to read both ADC inputs and then place the readings into the data container (**dtADCinputs**):

```
/**
 * updtADCinputs
 *
 * Read ADC inputs and place the readings into the corresponding
 * register bytes
 *
 * 'rId'  Register ID
 */
const void updtADCinputs(byte rId)
{
  int reading;

  // Read ADC input 0 (panStamp pin 4)
  reading = analogRead(0);
  // Pace reading into the first two bytes of the register. Big endian representation
  dtADCinputs[0] = (reading >> 8) & 0xFF;   // Replaceable by: regTable[rId]->value[0] = (reading >> 8) & 0xFF;
  dtADCinputs[1] = reading & 0xFF;          // Replaceable by: regTable[rId]->value[1] = reading & 0xFF;

  // Read ADC input 1 (panStamp pin 5)
  reading = analogRead(1);
  // Pace reading into the first two bytes of the register. Big endian representation
  dtADCinputs[2] = (reading >> 8) & 0xFF;   // Replaceable by: regTable[rId]->value[2] = (reading >> 8) & 0xFF;
  dtADCinputs[3] = reading & 0xFF;          // Replaceable by: regTable[rId]->value[3] = reading & 0xFF;
}
```

And now we have to define **setPWMoutputs**, the setter function for both PWM output registers (regPWMoutput0 and regPWMoutput1):

```
/**
 * setPWMoutput
 *
 * Set PWM levels
 *
 * 'rId'     Register ID
 * 'level'    New PWM level
 */
const void setPWMoutputs(byte rId, byte *level)
{
  int pin;

  // Update register
  memcpy(regTable[rId]->value, level, sizeof(regTable[rId]->value));

  // Set output pin
  switch(rId):
  {
    case 12:
      pin = 3;    // Arduino digital pin 3 - panStamp pin 18
      break;
    case 13:
      pin = 5;    // Arduino digital pin 5 - panStamp pin 20
      break;
    default:
      return;
  }

  // Control PWM output
  analogWrite(pin, level[0]);
}
```

### regtable.h: define ID's for our custom registers ###

Finally, we have to define ID's for our new registers. Open _regtable.h_ and enter your ID's between _DEFINE\_REGINDEX\_START()_ and _DEFINE\_REGINDEX\_END()_ as follows:

```
/**
 * Register indexes
 */
DEFINE_REGINDEX_START()
  REGI_ADCINPUTS,
  REGI_PWMOUTPUT0,
  REGI_PWMOUTPUT1
DEFINE_REGINDEX_END()
```

Now our new registers can be accessed using _getRegister_ from our sketch:

```
// Update ADC values and transmit SWAP status packet
getRegister(REGI_ADCINPUTS)->getData();

// Set first PWM output level and transmit SWAP status packet
getRegister(REGI_PWMOUTPUT0)->setData(85);

// Read second PWM register value and transmit SWAP status packet
getRegister(REGI_PWMOUTPUT1)->getData();
```

### Main.ino file: initialize the board ###

The rest of the work is very simple. From our main INO file we first have to include these two files:

```
#include "regtable.h"
#include "panstamp.h"
```

And then initialize the panStamp board:

```
**
 * setup
 *
 * Arduino setup function
 */
void setup()
{
  // Initialize PWM outputs
  pinMode(3, OUTPUT);
  digitalWrite(3, LOW);
  pinMode(5, OUTPUT);
  digitalWrite(5, LOW);

  // Initialize panStamp
  panstamp.init();

  // Transmit product code
  getRegister(REGI_PRODUCTCODE)->getData();
}
```

The above code is suitable for a device that is always listening to the SWAP network, that is the case of our ADC/PWM example. But, what if we need to write some registers onto a low-power device? What if this device sleeps most of the time? In this case, we recommend to setup an initial synchronization period within which the board will be ready to accept commands:

```
**
 * setup
 *
 * Arduino setup function
 */
void setup()
{
  int i;

  pinMode(LEDPIN, OUTPUT);
  digitalWrite(LEDPIN, LOW);

  // Init panStamp
  panstamp.init();

  // Transmit product code
  getRegister(REGI_PRODUCTCODE)->getData();

  // Enter SYNC state
  panstamp.enterSystemState(SYSTATE_SYNC);

  // During 3 seconds, listen the network for possible commands whilst the LED blinks
  for(i=0 ; i<6 ; i++)
  {
    digitalWrite(LEDPIN, HIGH);
    delay(100);
    digitalWrite(LEDPIN, LOW);
    delay(400);
  }
  // Transmit periodic Tx interval
  getRegister(REGI_TXINTERVAL)->getData();
  // Transmit power voltage
  getRegister(REGI_VOLTSUPPLY)->getData();
  // Switch to Rx OFF state
  panstamp.enterSystemState(SYSTATE_RXOFF);
}
```

The above is maybe the most simple way to put a low-power board in _SYNC_ mode. We just have to reset the board and it will enter the _SYNC_ mode for a given period.

### Main.ino file: Run periodic tasks ###

Finally we have to write the necessary code in _loop()_. We'll usually write here the code that periodically reads the sensors and puts the board in power-down mode. For our example we need no power-down function so we'd just write the following:

```
/**
 * loop
 *
 * Arduino main loop
 */
void loop()
{
  // Transmit ADC data
  getRegister(REGI_ADCINPUTS)->getData();

  // Wait 5 sec before sending ADC values again
  delay(5000);
}
```

If we want to put our panStamp in power-down mode we have to do the following:

```
/**
 * loop
 *
 * Arduino main loop
 */
void loop()
{
  // Transmit ADC data
  getRegister(REGI_ADCINPUTS)->getData();

  // Sleep for the amount of seconds specified in "Tx interval register" (standard register with ID = 10)
  panstamp.goToSleep();
}
```

## Step 3: Create a definition file for our new device ##

Device definition files are explained in [this page](devicexml.md). They are basically xml files defining registers, parameters and endpoints for a given SWAP product. If you plan to configure your panStamps from [SWAPdmt](SWAPdmt.md) or use any computer application based on our [Python pyswap library](pyswap.md) then you definitely need a proper [Device Definition File](devicexml.md). Otherwise, you can skip this step.

In our example we should create a definition file similar to this one:

```
<?xml version="1.0"?>
<device>
  <developer>MyDevName</developer>
  <product>ADC/PWM module</product>
  <pwrdownmode>false</pwrdownmode>
  <regular>
    <reg name="ADC inputs" id="11">
      <endpoint name="ADC input 0" type="num" dir="inp">
        <position>0</position>
        <size>2</size>
      </endpoint>
      <endpoint name="ADC input 1" type="num" dir="inp">
        <position>2</position>
        <size>2</size>
      </endpoint>
    </reg>
    <reg name="PWM output 0" id="12">
      <endpoint name="PWM output 0" type="num" dir="inp">
        <size>1</size>
      </endpoint>
    </reg>
    <reg name="PWM output 1" id="13">
      <endpoint name="PWM output 1" type="num" dir="inp">
        <size>1</size>
      </endpoint>
    </reg>
  </regular>
</device>
```

Our [Device Definition File](devicexml.md) is now ready for final consumption. We can now submit this file, named _mynewdevice.xml\_and the product code to the Product Registration section of the forum. Once received, definition file and product code will be uploaded to the central repositories._

# Automatic generation of source code #

Since the release of [SWAPmaker](SWAPmaker.md), source code can be easily initialized with the most common parts, including the definition of registers and callback functions. We now strongly suggest to use this wizard and then complete the source code with your desired functionality (read sensors, write outputs, etc). SWAPmaker also generates the Device Definition File so developers no longer need to manually edit the xml files by hand.