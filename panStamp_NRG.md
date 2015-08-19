For any question related to panStamp NRG we recommend visiting our [new wiki](https://github.com/panStamp/panstamp/wiki).

# panStamp NRG - Technical details #

  * [Specifications](panStamp_NRG#Specifications.md)
  * [Pin mapping](panStamp_NRG#Pin_mapping.md)
  * [Info memory](panStamp_NRG#Info_memory.md)
  * [Memory Organization](panStamp_NRG#Memory_Organization.md)
  * [Programming methods](panStamp_NRG#Programming_methods.md)
  * [Energia IDE](panStamp_NRG#Energia_IDE.md)
  * [Documents](panStamp_NRG#Documents.md)

# Specifications #

  * Dimmensions: 0.7 x 1.2 in (17.7 x 30.5 mm)
  * MCU: CC430F5137 (MSP430 core + CC11XX radio SOC)
  * Speed: Programmable speed between 8MHz and 24MHz
  * Flash: 32KB
  * RAM: 4KB
  * Info memory: 512 bytes
  * Unique MAC address
  * Voltage range: from 2VDC to 3.6VDC
  * Rx current: 18 mA max
  * Tx current: 36 mA max
  * Sleep current: 1-2 uA
  * Maximum Tx power: +12 dBm
  * RF bands: 868/905/915/918 MHz ISM bands
  * Communication length: 200m in open spaces at 0dBm with pigtail antenna
  * 128-bit AES Security Encryption
  * (Optional) MMA8652FFC 3-axis accelerometer on the top layer
  * (Optional) SI7021 dual temperature – humidity sensor on the bottom layer
  * (Optional) Thermistor on the bottom layer
  * On-board LED
  * Footprint for SMA edge connector
  * Programmable via SBW and serial GDB

<img width='400' align='center' src='http://www.panstamp.com/images/panStamp_NRG_parts.png' title='panStamp NRG top view'></img>

# Pin mapping #

The following is the pin diagram of _panStamp NRG_:

<img width='500' align='center' src='http://www.panstamp.com/images/nrg_pinout.png' title='panStamp NRG pin mapping'></img>

One of the great things about the CC430 processor is that digital functions (green lines) can be moved to any P1 or P2 pin. Green text shows the default position of these functions.

# Memory Organization #

The following table shows how the memory of the CC430F5137 MCU is distributed:

<img src='http://www.panstamp.com/images/cc430_memory.png' height='600'></img>

One of the interesting things about the MSP430 architecture is that Flash and RAM share a common addressing schema so that we can access address locations in the same way, regardless of the nature of the memory. This is really appreciated for example when a given constant variable needs to be permanently located in flash since this variable will never be copied into RAM by the stack.

# Info memory #

CC430 processors do not include EEPROM space. Instead, they provide a special region in Flash to store configurations. This region is called info memory and is 512 bytes long in the CC430F5137 MCU. The panStamp library provides the necessary functions to use this info space as any other EEPROM-based region.

# Programming methods #

_panStamp NRG_ can be programmed in two different ways. The first method is SBW (Serial bi-wire) JTAG interface. Any MSP430 programmer supporting SBW can be used to program panStamps, including [MSP430 Launchpads](http://www.ti.com/tool/msp-exp430g2) and [ez430 programmers](http://www.ti.com/tool/ez430-f2013), which are very low cost programming interfaces.

On the other hand, _panStamp NRG_ can also be programmed serially from [GDB](http://www.sourceware.org/gdb/), the popular open source debugging software. Any kind of USB-UART converter can be used for this task. Serial programming is the method used when loading firmware images from the [Energia IDE](http://energia.nu/).

The following is the necessary wiring diagram according of the programming method being used:

<img width='600' align='center' src='http://www.panstamp.com/images/nrg_pgm_layout.png' title='panStamp NRG pin mapping'></img>

## Serial programming - Booting sequence ##

panStamp's serial firmware loader, developed by [Rick Kimball](http://kimballsoftware.com/), is a compact implementation of the GDB server for the CC430 familly. Although this server doesn't provide full debugging capabilities, it can be used to read and write memory sections without having to load any specific firmware into the target board. This GDB bootloader replaces the old BSL loader flashed by Texas Instruments in their chips. Unlike Atmega's, CC430 processors include a separate 2KB region in flash called "BSL memory" that can be used to store bootloaders. Thus, programmers can still keep the whole 32KB flash region for their programs.

In order to load a new firmware, the _panStamp NRG_ board has to enter the bootloading mode. This is achieved by connecting P2.0 to ground before rebooting the board. Once the board has been programmed and in order to exit from bootloading mode, P2.0 has to be unconnected from ground and then a new reset or power-cycle has to be applied to the board.

# Energia IDE #

[Energia](http://www.energia.nu) is a variation of [Processing](http://processing.org/), the original IDE used by [Arduino](http://www.arduino.cc/), for MSP430's and Stellaris processors. Energia now provides support for _panStamp NRG_ as well so that users switching from _panStamp AVR_ to _panStamp NRG_ will notice very few differences on the programming side.

Like the AVR version of panStamp with the Arduino IDE, most of the critical aspects of the NRG board (radio, power management, RTC, ...) are covered by the panStamp library and only generic functions like UART, SPI, I2C and I/O management are delegated to Energia in order to guarantee compatibility with other libraries.

# Documents #

  * [Schematics](https://sites.google.com/a/panstamp.com/panstamp/downloads/panstamp-nrg.pdf)