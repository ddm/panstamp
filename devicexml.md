# Static XML definition files: definition of SWAP devices #

  * [Introduction](devicexml#Introduction.md)
  * [How XML files are organized](devicexml#How_XML_files_are_organized.md)
  * [Structure of XML definition files](devicexml#Structure_of_XML_definition_files.md)
  * [Registers, endpoints and parameters](devicexml#Registers,_endpoints_and_parameters.md)
    * [Units and modifiers](devicexml#Units_and_modifiers.md)
    * [Optional attributess](devicexml#Optional_attributes.md)

# Introduction #

We've seen that panStamps rely on a compact wireless protocol called [SWAP](SWAP.md). This protocol was designed to provide high flexibility without compromising the size of the stack. Wanting something really compact and flexible, we decided to define a register-based protocol, something really pointing to memory locations instead of having to deal with function profiles and complex resource discovery mechanisms. We also explained that, in order for gateways and software applications to understand what the wireless network is talking about, we need to define each wireless product by a XML file. This file will tell the application about the existing custom registers, how to configure them and how to modify their readings in order to make them understandable by the use.

Thus, if you want your own SWAP devices to be compatible with existing software tools ([SWAPdmt](SWAPdmt.md), HouseAgent) and future new applications, you'll need to create a XML file for each new device. Then, each new file will be placed in central repositories in order for our applications to have access to them. Then, you or any user having flashed a panStamp with your firmware will be able to configure it wirelessly, make the necessary value conversions depending on units, write values, etc.

# How XML files are organized #

Before publishing your own panStamp firmware you need to get a unique developer name. This name will also be given to the directory containing your custom XML definition files. You'll also need a unique 4-byte developer ID. This ID will combine with each product ID to form the product code, as explained [here](SWAPregisters#Product_code.md). Product codes and developer/product names will be linked in devices.xml, a general file acting as a product directory.

Example of devices.xml file:

```
<?xml version="1.0"?>
<devices>
  <developer id="1" name="panStamp">
    <dev id="1" name="temphum" label="Dual Temperature/Humidity sensor"/>
    <dev id="2" name="chronos" label="SWAP-enabled Chronos watch"/>
    <dev id="3" name="rgbdriver" label="RGB driver board"/>
    <dev id="4" name="temp" label="Temperature sensor"/>
    <dev id="5" name="temphumpress" label="Temperature/Humidity/Barometric sensor"/>
    <dev id="6" name="rfidtag" label="RFID tag"/>
    <dev id="7" name="rfidreader" label="RFID reader"/>
  </developer>
</devices>
```

# Structure of XML definition files #

The following is an example of a SWAP device, a dual temperature-humidity sensor developed by panStamp:

```
<?xml version="1.0"?>
<device>
  <developer>panStamp</developer>
  <product>Dual Temperature-Humidity sensor</product>
  <pwrdownmode>true</pwrdownmode>
  <regular>
    <reg name="Voltage supply" id="11">
      <endpoint name="Voltage" type="num" dir="inp">
        <size>2</size>
        <units>
          <unit name="V" factor="0.001" offset="0"/>
        </units>
      </endpoint>
    </reg>
    <reg name="Humidity and Temperature" id="12">
      <endpoint name="Temperature" type="num" dir="inp">
        <position>0</position>
        <size>2</size>
        <units>
          <unit name="C" factor="0.01" offset="0"/>
          <unit name="F" factor="0.018" offset="32"/>
          <unit name="K" factor="0.01" offset="273.15"/>
        </units>
      </endpoint>
      <endpoint name="Humidity" type="num" dir="inp">
        <position>2</position>
        <size>2</size>
        <units>
          <unit name="%" factor="0.01" offset="0"/>
        </units>
      </endpoint>
    </reg>
  </regular>
</device>
```

The above device contains no configuration parameter. It simply provides two regular registers (voltage and temperature/humidity), with ID 11 and 12 respectively. Configuration registers are contained in the **config** section, not in **regular** as the rest of registers. Also note that basic parameters such us device address, network ID, or frequency channel are neither defined in this file (or any other definition file). This is simply because common configuration parameters are internally defined and managed by the panStamp firmware stack, as explained here.

But if you want to create a full-featured device definition file, with configuration parameters and regular endpoints, using [this template](http://panstamp.googlecode.com/svn/trunk/devices/template.xml) is probably the best way to go. The [Chronos watch definition file](http://panstamp.googlecode.com/svn/trunk/devices/panStamp/chronos.xml) is also a good example of mixing configuration with sensor readings.

# Registers, endpoints and parameters #

This has already been discussed in [this section](SWAP#Registers_and_values.md) but it's maybe a good idea to check these concepts from one of the existing definition files. Note that each register can contain multiple endpoints or multiple configuration parameters and that each endpoint or parameter occupies a specific place within the container register. This particularity lets us transmit multiple values (endpoints) using a single SWAP status packet, thus minimizing bandwidth consumption and reducing transmission times.

When displaying endpoint data from web servers or computer applications, device definition files provide a way to tell the application what to do with received packets - how to extract endpoint values and configuration parameters from transmitted registers and how to transform values to make them readable by the end user -.

## Units and modifiers ##

For new devices, it's a good idea to provide multiple units for each endpoint whenever possible. This is simply done by adding a new **unit** line in the **units** section. The transforming formula is very straightforward:

_reading = factor x (endpoint value) + offset (unit name)_

Modifiers can take any real value. Default modifiers: factor = 1, offset = 0.

## Optional attributes ##

the register node in the device description file can contain two optional attributes:

**hwmask**: a bitmask in hexadecimal format to indicate for which Hardware Version (SWAP register 0x01) this register is available. As an example, this attribute can be used to indicate if specific hardware features (like connected sensors) are available for a given instance
of panStamp. this can be statically set at compile time or determined at runtime. Whenever **hwmask** is present for a given register, this register is considered as available only if ( hwmask & HardwareVersion ) == hwmask.

**swversion**: the minimum Firmware Version (SWAP register 0x02) for which this register is available. This allows to add features to the firmware over the lifetime of a product and have different software revisions
of a product deployed at the same time. Whenever **swversion** is present, the register is considered as available only if FirmwareVersion >= swversion.

during the evolution of a product both attributes will often be used in conjunction.

examples:

- a first version of a product is created
-> the device description file would contain no registers with the hwmask or swversion attribute.

- a second version of the product is created that has an additional register to indicate a sensor reading
-> the swversion attribute of this register would indicate that it is only available in firmware version 2.

- different versions of the second generation product will be deployed with or without the additional sensor attached
-> hwmask would use a bit in the HardwareVersion to indicate if the sensor is present.

- the first gen. hardware will get the firmware from gen. two as an upgrade
-> the indicator bit would show that the additional sensor and the associated register is not available.