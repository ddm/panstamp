**This wiki refers to the old API for Arduino IDE 1.0.x. For the latest API (still under beta-test) compatible with Arduino IDE 1.5.x, we recommend visiting our [new wiki](https://github.com/panStamp/panstamp/wiki).**

# Introduction #

panStamps are small wireless boards designed for anyone wanting to monitor and control things without wires. Since they contain an Atmega328p, they are entirely programmable from the Arduino IDE. On the RF side, a robust CC1101 IC from Texas Instruments provides communication lengths of more than 200 meters in open spaces.

<p align='center'>
<img src='http://www.panstamp.com/products/wirelessarduino/panstamp_cover_01.jpg'>

This project page describes the libraries, protocols and software tools developed around the panStamp project. This page also acts as the official documentation platform for any technical thing related to the project.<br>
<br>
<h1>Index</h1>

<ul><li>Technical details<br>
<ul><li><a href='panStamp.md'>panStamp AVR (compatible with Arduino IDE)</a>
</li><li><a href='panStamp_NRG.md'>panStamp NRG (compatible with Energia IDE)</a>
</li></ul></li><li><a href='firststeps.md'>Working with panStamps: first steps</a>
</li><li><a href='antennalengths.md'>Antenna lengths</a>
</li><li><a href='SWAP.md'>Simple Wireless Abstract Protocol in detail</a>
</li><li><a href='SWAPregisters.md'>Standard SWAP registers</a>
</li><li><a href='devicexml.md'>Device Definition Files</a>
</li><li><a href='SerialProtocol.md'>Serial protocol for gateways</a>
</li><li><a href='PANSTAMPstack.md'>How the panStamp firmware stack works</a>
</li><li><a href='ArduinoLibrary.md'>Arduino library. Main classes and methods</a>
</li><li><a href='developmentsteps.md'>How to develop your own SWAP device using panStamps</a>
</li><li><a href='Repeater.md'>Make a wireless node work as repeater</a>
</li><li><a href='SWAPmaker.md'>SWAPmaker: source code generation wizard for developers</a>
</li><li><a href='enddevices.md'>Existing SWAP devices</a>
</li><li><a href='pyswap.md'>Python SWAP library</a>
</li><li><a href='SWAPdmt.md'>SWAP Device Management Tool</a>
</li><li><a href='SWAPchronos.md'>SWAP-enabled Chronos watch</a>
</li><li><a href='lagarto.md'>Lagarto: open automation platform for SWAP and other networks</a>
<ul><li><a href='LagartoSWAP.md'>Lagarto-SWAP: connecting SWAP networks to the IP world</a>
</li><li><a href='LagartoMAX.md'>Lagarto-MAX: extended automation client with event manager</a>
</li><li><a href='RaspberryPI_image.md'>Lagarto on the RaspberryPI</a></li></ul></li></ul>

<h1>Links</h1>

<ul><li><a href='http://panstamp.blogspot.com'>panStamp weblog</a>
</li><li><a href='http://groups.google.com/group/panstamp'>Discussion group</a>
</li><li><a href='http://www.panstamp.com'>Commercial website</a>
</li><li><a href='http://www.arduino.cc'>Arduino official page</a>
</li><li><a href='http://fhem.de/fhem.html'>FHEM</a>, Open Source Home Automation software compatible with panStamp and SWAP<br>
</li><li><a href='https://github.com/ntruchsess/panstamp/tree/device_panstamp/perl/Device'>Perl SWAP library</a>