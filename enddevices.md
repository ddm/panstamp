# Existing SWAP devices #

This page lists all the available SWAP devices and their associated resources. If you are looking for an existing device that may cover your needs, take a look at the following table. On the other hand, if you need a reference project to base your developments on, then the following informations may be of your interest too.

## Developer: panStamp (ID: 1) ##

| **Device** | **Description** | **Source code** | **Device Definition file** | **ID** |
|:-----------|:----------------|:----------------|:---------------------------|:-------|
| temp       | Temperature sensor. Needs a TMP36 sensor | temphumpress    | temp.xml                   | 4      |
| temphum    | Dual Temperature/Humidity sensor. Works with DHT11/DHT22 sensors | temphumpress    | temphum.xml                | 1      |
| temppress  | Dual Temperature/Barometric sensor. Works with BMP085 sensors | temphumpress    | temppress.xml              | 5      |
| chronos    | SWAP-enabled Chronos watch | [OpenChronos](https://github.com/dberenguer/OpenChronos) | chronos.xml                | 2      |
| rgbdriver  | RGB driver board | rgbdriver       | rgbdriver.xml              | 3      |
| bininps    | Binary/Counter input module | bininps         | bininps.xml                | 6      |
| binouts    | Binary/PWM output module | binouts         | binouts.xml                | 7      |
| binouts2   | Advanced Binary/PWM output module + repeater | binouts2        | binouts2.xml               | 12     |
| lcddriver  | Alphanumeric LCD driver | lcddriver       | lcddriver.xml              | 8      |
| pulsegen   | Programmable pulse generator | pulsegen        | pulsegen.xml               | 9      |
| pulsecounter | Pulse counter   | pulsecounter    | pulsecounter.xml           | 10     |
| meter      | Energy meter    | meter           | meter.xml                  | 11     |

Except the [OpenChronos](https://github.com/dberenguer/OpenChronos) image, all the above Arduino sketches are downloadable from our [SVN repository](http://code.google.com/p/panstamp/source/checkout) and from the [Download section](http://www.panstamp.com/downloads).