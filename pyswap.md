**Python SWAP library**

  * [Introduction](pyswap#Introduction.md)
  * [Description](pyswap#Description.md)
    * [Interface](pyswap#Interface.md)
    * [Mote iteration](pyswap#Mote_iteration.md)
  * [Documentation](pyswap#Documentation.md)

# Introduction #

**pyswap** is a Python library made to communicate with SWAP networks through a serial panStamp. This library is the core of every application written for computers in the scope of the panStamp project; SWAPdmt and the SWAP plugin for HouseAgent are also based on this library.

**pyswap** is more than a communication library in fact. It takes care of discovering motes, registering resources in memory and maintaining configuration files. You'll find that this library does the most part of whatever computer application you may need. At the end, you'll need to subscribe to some callback functions that will alert your application about any event in the network.

# Description #

In order to use **pyswap** you should follow these steps:

  1. Download this library and add it to your PYTHONPATH variable.
  1. Copy _settings.xml_, _serial.xml_ and _network.xml_ into your application source folder and change their contents according to your settings (serial port, Network Id, gateway address, etc).
  1. Download "devices" from our repositories and place it wherever you want in your computer. Then set _device_ to the correct location in settings.xml. Next time you run your application, it will be able to find static descriptions about any device in your SWAP network.
  1. Write your application

## Interface ##

**pyswap** provides an event-based interface that frees your application from having to store devices, registers or parameters by itself. This interface just notifies your application about any event occurred in the SWAP network, including value changes and detection of new motes and their endpoints. In order to use this interface, you must create a Python module containing a class deriving from _SwapInterface_. Then, according to your needs, you'll end by defining different callback methods that will notify your application about the occurrence of certain events. The following is just a useless example that illustrates how the callbacks are used:

```
from swap.SwapInterface import SwapInterface

class MySwapManager(SwapInterface):
    """
    SWAP Manager
    """
    def newMoteDetected(self, mote):
        """
        New mote detected by SWAP server
        
        'mote'  mote detected
        """
        pass

    def newParameterDetected(self, parameter):
        """
        New configuration parameter detected by SWAP server
        
        'parameter'  Endpoint detected
        """
        pass

    def newEndpointDetected(self, endpoint):
        """
        New endpoint detected by SWAP server
        
        'endpoint'  Endpoint detected
        """
        pass

    def moteStateChanged(self, mote):
        """
        Mote state changed
        
        'mote'  Mote having changed
        """
        pass

    def moteAddressChanged(self, mote):
        """
        Mote address changed
        
        'mote'  Mote having changed
        """
        pass

    def registerValueChanged(self, register):
        """
        Register value changed
        
        'register'  Register having changed
        """
        pass
    
    def endpointValueChanged(self, endpoint):
        """
        Endpoint value changed
        
        'endpoint'  Endpoint having changed
        """
        pass
    
    def parameterValueChanged(self, parameter):
        """
        Configuration parameter changed
        
        'parameter'  configuration parameter having changed
        """
        pass

    def __init__(self, verbose=False):
        """
        Class constructor
        """    
        SwapInterface.__init__(self, verbose)
```

Depending on your needs, you'll want to define all the above callback methods or only some of them. Whenever you want to be notified about the discovery of new SWAP resources you'll define some of these methods:

  * newMoteDetected
  * newParameterDetected
  * newEndpointDetected

Then, if you want to receive notifications about value changes you'll define:

  * registerValueChanged
  * parameterValueChanged
  * endpointValueChanged

Finally, if you want to be notified about a mote's state having changed your callback method is:

  * moteStateChanged

And for an address change:

  * moteAddressChanged


Once your SWAP manager class defined, we only have to create an instance of this class from our application:

```
if __name__ == "__main__":
    """
    An example of the use of our new MySwapManager class
    """
    manager = MySwapManager()
```

This instance will have access to every additional method provided by the _SwapInterface_ superclass:

```
    getNbOfMotes(self)
    """
    Return the amounf of motes available in lstMotes
    """

    getMote(self, index=None, address=None)
    """
    Return mote from list
    
    'index'    Index of the mote within lstMotes
    'address'  SWAP address of the mote
    """

    setMoteRegister(self, mote, regId, value)
    """
    Set new register value on wireless mote
        
    'mote'    Mote targeted by this command
    'regId'   Register ID
    'value'   New register value
        
    Return True if the command is correctly ack'ed. Return False otherwise
    """

    queryMoteRegister(self, mote, regId)
    """
    Query mote register, wait for response and return value
    Non re-entrant method!!
        
    'mote'    Mote to be queried
    'regID'   Register ID
        
    Return register value
    """

    stop(self)
    """
    Stop SWAP server
    """
```

## Mote iteration ##

Whenever you want to iterate among all the existing motes in a given SWAP network, the _lstMotes_ attribute is your allied. You'll be able to do things like the following from MySwapManager:

```
    for mote in self.lstMotes:
        print "Device with address", mote.address, mote.definition.product
```

# Documentation #

The **pyswap** code is documented by means of the generated class docs: [HTML documentation](http://panstamp.googlecode.com/svn/trunk/python/pyswap/doc/annotated.html).