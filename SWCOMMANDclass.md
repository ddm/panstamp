# Introduction #

When you need to send a SWAP command to another device, this is your class. SWAP commands address a given remote register, trying to alter it. If the remote device can not alter the addressed register then it must respond with a status message containing the unaltered value. Otherwise, the remote device responds with a status message after having altered the register value.

# Public constructor #

```
    /**
     * SWCOMMAND
     * 
     * Class constructor
     * 
     * 'destAddr'   Destination address
     * 'secNonce'   Security nonce
     * 'rAddr'	    Register address
     * 'rId'	    Register id
     * '*val'	    New value
     * 'len'	    Buffer length
     */
    SWCOMMAND(byte destAddr, byte secNonce, byte rAddr, byte rId, byte *val, byte len);
```

The rest of arguments and methods are heritaded from the SWPACKET class.

# Example #

```
  // New value for the remote device
  byte value[] = {'A', 'B', 'C'};

  // Create SWAP command packet, to be sent to the device with address 7
  SWCOMMAND command = SWCOMMAND(7, 0, 7, 11, value, sizeof(value));

  // Send SWAP command to device address = 7, register id = 11
  command.send();
```