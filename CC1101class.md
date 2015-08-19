# CC1101 class #

  * [Introduction](CC1101class#Introduction.md)
  * [Public arguments](CC1101class#Public_arguments.md)
  * [Public methods](CC1101class#Public_methods.md)
  * [Example](CC1101class#Example.md)

# Introduction #

Description of the CC1101 class, its public arguments and methods. Any developer wanting to receive and transmit raw wireless data may use this class instead of the higher level PANSTAMP class.

# Public arguments #

```
    /**
     * Carrier frequency
     */
    CARRIER_FREQ carrierFreq;

    /**
     * Frequency channel
     */
    byte channel;

    /**
     * Synchronization word
     */
    byte syncWord[2];

    /**
     * Device address
     */
    byte devAddress;
```

# Public methods #

```
    /**
     * reset
     * 
     * Reset CC1101
     */
    void reset(void);
    
    /**
     * init
     * 
     * Initialize CC1101
     */
    void init(void);

    /**
     * setSyncWord
     * 
     * Set synchronization word
     * 
     * 'sync'	Synchronization word
     */
    void setSyncWord(byte *sync);

    /**
     * setDevAddress
     * 
     * Set device address
     * 
     * 'addr'	Device address
     */
    void setDevAddress(byte addr);

    /**
     * setCarrierFreq
     * 
     * Set carrier frequency
     * 
     * 'value'	New carrier frequency
     */
    void setCarrierFreq(CARRIER_FREQ freq);
    
    /**
     * setChannel
     * 
     * Set frequency channel
     * 
     * 'chnl'	Frequency channel
     */
    void setChannel(byte chnl);

    /**
     * setRxState
     * 
     * Enter RX state
     */
    void setRxState(void);

    /**
     * setPowerDownState
     * 
     * Put CC1101 into power-down state
     */
    void setPowerDownState(void);
    
    /**
     * sendData
     * 
     * Send data packet via RF
     * 
     * 'packet'	Packet to be transmitted
     *
     *  Return:
     *    True if the transmission succeeds
     *    False otherwise
     */
    boolean sendData(CCPACKET packet);

    /**
     * receiveData
     * 
     * Read data packet from RX FIFO
     * 
     * 'packet'	Container for the packet received
     *
     * Return:
     * 	Amount of bytes received
     */
    byte receiveData(CCPACKET *packet);
```

## Example ##

See [panstamp.cpp](http://code.google.com/p/panstamp/source/browse/trunk/arduino/libraries/panstamp/panstamp.cpp) for a complete example about the use of the CC1101 class.