# Customization of existing devices #

# Introduction #

Customizing SWAP devices is something that can be done in different ways. Basic customization is always available via the [SWAPdmt tool](SWAPdmt.md). Network parameters and periodic transmission interval are configurable in all panStamp-based products. Moreover, developers can decide whether to make custom parameters configurable from the software tool too so, in some cases, you may find that your device can be customized even without having to recompile the Arduino sketch.

If you still need something that can not be done from [SWAPdmt](SWAPdmt.md), then you have to open the Arduino IDE. However, developing a new device may not be necessary in some situations. For instance, let's suppose that we want to use an existing temperature device with a different sensor (other than a TMP36 sensor for example). In this case, there are some basic steps that you need to follow.

# Customization options #

We are considering here different methods, depending on the type of customization we need to undertake.

## Use a different sensor ##

As explained in the introduction, using a different sensor in one of the existing sketches is something quite recurrent. In order to read data from a different sensor you have to write your own reading procedure. The _updater_ function is usually the place to do this.