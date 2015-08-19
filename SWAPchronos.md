**SWAPping packets from your ez430-Chronos watch**

# SWAP-enabled Chronos watch #

  * [Introduction](SWAPchronos#Introduction.md)
  * [How to compile the code](SWAPchronos#How_to_compile_the_code.md)
  * [How to install the new firmware](SWAPchronos#How_to_install_the_new_firmware.md)
  * [Links](SWAPchronos#Links.md)
  * [How to configure your SWAP Chronos](SWAPchronos#How_to_configure_your_SWAP_Chronos.md)

# Introduction #

The [ez430-Chronos watch](http://processors.wiki.ti.com/index.php/EZ430-Chronos?DCMP=Chronos&HQS=Other+OT+chronoswiki) is a development platform manufactured by Texas Instruments. Based on the [CC430F6137](http://focus.ti.com/docs/prod/folders/print/cc430f6137.html) core, this micro-controlled watch is capable to communicate on several ISM bands, 868 MHz and 915 MHz included. It can be programmed using [MSPGCC4](http://mspgcc4.sourceforge.net) and the open source port of TI's official sources, [OpenChronos](https://github.com/poelzi/OpenChronos).

<p align='center'>
<img src='https://lh4.googleusercontent.com/-o3jMe5ZGqiA/TXZUnWrsZCI/AAAAAAAAAyk/U3dIeFHOcXc/s720/ez430-chronos_800.jpg' width='400' />
</p>

CC430 processors share the same packet structure as the CC11XX family of RF interfaces. Thus, potential synergies came into the picture once the first panStamp boards started working. A [fork](https://github.com/dberenguer/OpenChronos) from the OpenChronos project was created and new [SWAP](SWAP.md) communication capabilities were added onto the existing features. Among them:

  * Ability to periodically broadcast (SWAP status) temperature, pressure and altitude data measured from the internal sensors
  * Wireless configuration (synchronization) from a PC tool called SWAPdmt.
  * Possibility to enter in ACC mode, where accelerometer data is boradcasted every second.
  * SWAP browser: a number of external SWAP values can be browsed and controlled from the watch.

One of the interesting things about this new firmware is that most of the above functions can be configured wirelessly so there is no need to recompile the code for every SWAP network.

# How to compile the code #

Under Linux:

  1. First of all, you need to install [MSPGCC4](http://mspgcc4.sourceforge.net) on your PC.
  1. Then, download the new OpenChronos sources from [here](https://github.com/dberenguer/OpenChronos).
  1. Then _cd_ into OpenChronos and run _make clean main_.
  1. The new binary image will be found into OpenChronos/build.

# How to install the new firmware #

Under Linux:

  1. Install [MSPDEBUG](http://mspdebug.sourceforge.net/) on your PC.
  1. Compile the code following the above instructions or download the image from the _Download_ page.
  1. Open the watch and connect the USB/JTAG programmer supplied with the development kit
  1. Run this other command: _mspdebug rf2500_. A MSPdebug console will open.
  1. Run this new command from the MSPDEBUG console: _prog build/eZChronos.txt_
  1. Wait the necessary time until the flashing process completes (usually some minutes on my computer).

# How to configure your SWAP Chronos #

Once the new firmware installed, your SWAP Chronos watch can be wirelessly configured from [SWAPdmt](SWAPdmt.md). Simply click on Devices->Custom settings and then select "SWAP Chronos watch" from the Device Selector window. [SWAPdmt](SWAPdmt.md) will then sequentially ask you to enter the configuration parameters.

# Links #

  * [Tour around the main features of the SWAP Chronos port](http://panstamp.blogspot.com/2011/06/openchronos-is-finally-swap-enabled.html).
  * [SWAPping packets with my ez430-Chronos](http://panstamp.blogspot.com/2011/05/swapping-packets-with-my-ez430-chronos.html)
  * [SWAPping packets with my ez430-Chronos – Part 2 ](http://panstamp.blogspot.com/2011/06/swapping-packets-with-my-ez430-chronos.html)
  * [OpenChronos Google Group](http://www.google.com/url?sa=t&source=web&cd=1&sqi=2&ved=0CBQQFjAA&url=http%3A%2F%2Fgroups.google.com%2Fgroup%2Fopenchronos&rct=j&q=openchronos&ei=CCkWTs6RI8i6-Aa2wPET&usg=AFQjCNFg97VM6QNMJjyz3LIP3CNGRL6qdQ&sig2=GV2XMHVzjbgVsrYNbEpnmA&cad=rja)