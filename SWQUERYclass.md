# Introduction #

SWAP queries are used to request information about remote registers. Any device receiving a SWAP query must respond with a SWAP status packet containing information about the queried register. This class controls everything related to queries: construction and transmission.

# Public constructor #

```
    /**
     * SWQUERY
     * 
     * Class constructor
     * 
     * 'destAddr'   Destination address
     * 'rAddr'	    Register address
     * 'rId'	    Register id
     */
    SWQUERY(byte destAddr, byte rAddr, byte rId);
```

The rest of arguments and methods are heritaded from the SWPACKET class.

# Example #

```
  // Create SWAP query packet, to be sent to the device with address 7
  SWQUERY query = SWQUERY(7, 7, 11);

  // Send SWAP query to device address = 7, register id = 11
  query.send();
```