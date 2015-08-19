# panStamp AVR - Technical details #

  * [Pin mapping](panStamp#Pin_mapping.md)
  * [Specifications](panStamp#Specifications.md)
  * [Programming panStamps](panStamp#Programming_panStamps.md)
  * [Bootloader](panStamp#Bootloader.md)

# Specifications #

  * Dimmensions: 0.7 x 1.2 in (17.7 x 30.5 mm)
  * MCU: Atmega328p
  * Radio chip: CC1101 (Texas Instruments)
  * Speed: 8MHz
  * Flash: 32KB
  * RAM: 2KB
  * EEPROM: 1KB
  * Voltage range: from 2.5VDC to 3.6VDC
  * Rx current: 24 mA max
  * Tx current: 36 mA max
  * Sleep current: 1 uA
  * Maximum Tx power: +12 dBm
  * RF bands: 868/905/915/918 MHz ISM bands
  * Communication length: 200m in open spaces at 0dBm with pigtail

# Pin mapping #
Sample sketches and libraries use either the Arduino pin naming, panStamp pin numbers or Atmega's port register/masks. Depending on the library being used and the degree of control to be achieved over the microcontroller I/O's, you'll find any of the mentioned conventions.

![https://0cdf7099-a-3ce7cda5-s-sites.googlegroups.com/a/panstamp.com/panstamp/pinmap.png](https://0cdf7099-a-3ce7cda5-s-sites.googlegroups.com/a/panstamp.com/panstamp/pinmap.png)

# Programming panStamps #
panStamps can be programmed in two ways:
  1. **Serial programming**. This is the recommended way for programming panStamps, Like Arduinos, panStamps can be programmed serially, through the UART. In order to interface the panStamp UART from your computer, a panStick or any other USB-TTL or RS232-TTL adapter has to be used.
  1. **In-Circuit programming (ICP)**. programming is done through the SPI port. This kind of programming requires you to use an ICP programmer for Atmega's (STK500 or similar). This programming method is not recommended since it erases the pre-installed bootloader.

![https://lh6.googleusercontent.com/-p5yT4u48UWI/T0QZpNQNFzI/AAAAAAAAAMY/Meq15WEX88k/s912/programports.png](https://lh6.googleusercontent.com/-p5yT4u48UWI/T0QZpNQNFzI/AAAAAAAAAMY/Meq15WEX88k/s912/programports.png)

# Bootloader #

panStamps come with the Arduino bootloader preinstalled. Fuse values are listed here:

  * Extended = 0x07
  * High = 0xD8
  * Low = 0xE2