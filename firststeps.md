**This wiki refers to the old API for Arduino IDE 1.0.x. For the latest API (still under beta-test) compatible with Arduino IDE 1.5.x, we recommend visiting our [new wiki](https://github.com/panStamp/panstamp/wiki).**

# Working with panStamps: first steps #

These are some important steps to follow before you start playing with
panStamps:

1. Install Arduino IDE 1.0 or newer.

2. Download the panstamp library for Arduino from the [Download section](http://www.panstamp.com/downloads) and place it under arduino/libraries/ or wherever your libraries are located in your Arduino environment.

3. Download [TimerOne](http://arduino.cc/playground/Code/Timer1) for Arduino. This library is only needed by the
modem application.
http://code.google.com/p/arduino-timerone/downloads/list

4. Download any of [the sample Arduino sketches](enddevices.md) from the [Download section](http://www.panstamp.com/downloads). Once the sketches downloaded, you have two possibilities:

> 4.1. Add the sketches into your "Sketchbook location" (File->Preferebces). Then these applications will appear under the File->Sketchbook menu.

> 4.2 Create an "examples" subdirectory in arduino/libraries/panstamp/ and add the sketches into that folder. Then you will be able to find them under File->Examples->panstamp

5. Select "Arduino Pro or Pro Mini (3.3V, 8MHz) w/ Atmega328" from
Tools->Boards on the Arduino IDE. Otherwise, you can download [boards.txt](http://code.google.com/p/panstamp/downloads/detail?name=boards.txt&can=2&q=) from our [code.google.com/p/panstamp/downloads Download section]. The latter option will add "panStamps" to the list under Tools->Boards.

6. Load one of the sample sketches into your panStamp.

7. panStamps can work in both 868 MHz and 915 MHz ISM bands without any hardware modification. However, the panStamp library always sets the carrier frequency to 868 MHz by default. If you wish to work in the 915 MHz band then you simply have to enter your desired frequency as the argument for the panstamp.init call:

```
void setup()
{
  // Init panStamp
  panstamp.init(CFREQ_915);  // CFREQ_868 and CFREQ_918 also supported
                             // CFREQ_433 supported by the library but not by the hardware modules
}
```

If you are using the CC1101 class with the [basic radio example](https://code.google.com/p/panstamp/wiki/LowLevelLibrary#Basic_example), then you can enter your carrier frequency in a similar way:

```
void setup()
{
  // Init radio class
  cc1101.init(CFREQ_915);    // CFREQ_868 and CFREQ_918 also supported
                             // CFREQ_433 supported by the library but not by the hardware modules
}
```

In case that no argument were provided in the init call, 868 MHz will be selected as the default carrier frequency.

8. Place an antenna according to your carrier frequency. A wire stub
works just fine:
http://code.google.com/p/panstamp/wiki/antennalengths

9. panStamps come with the modem application (at 868 MHz) preinstalled. If
you use one of your panStamps as a serial gateway, program your serial
terminal for 38400 bps, 8n1 and no handshake. Then you will be able to monitor the SWAP traffic on your network and also send commands to your wireless motes.

10. Eventually install SWAPdmt on your computer and configure your motes using your custom settings.