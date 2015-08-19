  * [Introduction](ArduinoLibrary#Introduction.md)
  * [Complete panStamp stack](ArduinoLibrary#Complete_panStamp_stack.md)
  * [Low level CC1101 API](ArduinoLibrary#Low_level_CC1101_API.md)

# Introduction #

Developing new applications for panStamps can be easily done using the available Arduino library. However, two different API's (cpp classes) can be used so you will have to decide your preferred method before starting your developments. Depending on your application and the need for interoperability you will find easier to work with either the complete panStamp stack or the low-level CC1101 class.

# Complete panStamp stack #

Using the [PANSTAMP class](PANSTAMPclass.md) from your application should be the default development method if you wish to keep the power of the complete stack. The stack's main features are listed here:

  * SWAP protocol integrated in the stack.
  * Straight interoperability across multiple devices and vendors.
  * No need to work with send/receive commands. The stack does this for you.
  * Automatic handling of commands and queries received.
  * Automatic power management via simple instructions.
  * Availability of open source computer applications as [SWAPdmt](SWAPdmt.md) and [Lagarto](lagarto.md).

The main strength of the panStamp stack is that it handles everything related to communications, including the protocol and interoperability between devices. Thanks to this, different developers can create very different applications that will be able to communicate and interoperate between them. Thus, a growing repository of open source interoperable devices will be available for the community.

[This page](developmentsteps.md) is a guide about how to develop new code using the [panStamp stack](PANSTAMPstack.md).

# Low level CC1101 API #

The panStamp stack relies on the CC1101 class, a set of low-level methods which include the typical send/receive functions. In case you don't want to use the whole PANSTAMP stack then you can use the CC1101 class directly from your application. [This page](LowLevelLibrary.md) explains the procedure and shows some examples.

This approach may be valid in the following cases:

  * No need to interoperate with other devices/developers/applications. Use of custom protocol and custom software.
  * Direct migration from XBees or other wireless shields for Arduino.