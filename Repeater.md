  * [Introduction](Repeater#Introduction.md)
  * [Repeaters](Repeater#Repeaters.md)
  * [How to use](Repeater#How_to_use.md)
  * [Example](Repeater#Example.md)

# Introduction #

The panStamp stack provides a way to repeat packets along the wireless network. This mechanism relies on special nodes called repeaters, which can also work as standard sensors and actuators.

# Repeaters #

Repeater nodes need to be powered from an external power source, not a low-power battery since they need to continuously stay in reception mode. Thus, output boards, energy meters and light controls are perfect candidates for acting as repeaters.

In order to avoid unnecessary repeating loops, repeaters maintain transaction tables where any incoming packet is checked before allowing the repetition or not. Each transaction is basically identified by its transmission source, cyclic nonce, SWAP function and register address. Time stamps are also kept associated to each transaction in order to make it expire after a predefined amount of time.

# How to use #

Repeater mode can be enabled  simply by including the following sentence in setup() after panstamp.init();

```
// Enable repeater mode
panstamp.enableRepeater(4);
```

Where 4 is the amount of times that a packet can be repeated (maximum hop count). You can replace this value by any other value between 1 and 15.

# Example #

This is a very basic example of a SWAP repeater. Note that _repeater_ has to be initialized after initializing the _panstamp_ object:

```
#include "regtable.h"
#include "panstamp.h"

void setup()
{
  // Init panStamp
  panstamp.init();
  
  // Enable repeater mode
  panstamp.enableRepeater(4);
}

void loop()
{
}
```