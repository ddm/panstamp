# Lagarto-MAX: extended automation client #

  * [Introduction](LagartoMAX#Introduction.md)
  * [Features](LagartoMAX#Features.md)
  * [Configuration](LagartoMAX#Configuration.md)
    * [Lagarto settings](LagartoMAX#Lagarto_settings.md)
  * [Lagarto-MAX as a network hub](LagartoMAX#Lagarto-MAX_as_a_network_hub.md)
  * [Event programming](LagartoMAX#Event_programming.md)
  * [Custom Python scripts](LagartoMAX#Custom_Python_scripts.md)
    * [NetworkAPI](LagartoMAX#NetworkAPI.md)
    * [CloudAPI](LagartoMAX#CloudAPI.md)
  * [Supported cloud data services](LagartoMAX#Supported_cloud_data_services.md)

# Introduction #

Lagarto-MAX is a lagarto process which receives, resends and processes events transmitted from any lagarto server running on the same IP network. Lagarto-MAX is a key piece into the lagarto architecture since it's able to integrate real values belonging to different networks and present them to the user in a homogeneous way. Moreover, being user-programmable, Lagarto-MAX can take decisions based on time or network events.

# Features #

Lagarto-MAX, due to its nature, is one of those components that will be continuously growing in functionalities. The following is a list of features provided by this lagarto client:

  * Reception of network events from any lagarto server on the same IP network (LAN or Internet)
  * Transmission of commands to any lagarto server on the same IP network (LAN or Internet)
  * Common web control/monitoring interface for all lagarto endpoints
  * Event manager entirely programmable from the Web interface
  * Automatic upload of values to different cloud data services (Pachube, ThingSpeak, ...)
  * Simple thread-independent interface for running user Python scripts.
  * Python API for managing values such as "get\_value" or "set\_value".
  * Local database (SQLite) storage of values.
  * On-the-fly creation of web graphs and charts.

# Configuration #

Lagarto-MAX is entirely configured from the web interface. Default HTTP port is 8002 so in order to access the web interface we have to open the following URL:

http:\\ip\_address:8002

## Lagarto settings ##

Every lagarto process needs some configuration parameters to be edited from this page:

  * process name: name of the lagarto process. This name has to be unique across all lagarto process
  * Broadcast channel: TCP/IP address and port to be used for notifications. This channel must be the same for all lagarto processes.
  * HTTP server port: unique for each lagarto process running in the same machine.Default value is 8002.

<p align='center'>
<img src='https://lh5.googleusercontent.com/-ggjb-vUbvHg/T4gFdwyN5MI/AAAAAAAAAPg/q8OgILFoArE/s600/lagarto_max_lagarto_settings.png' />
</p>

# Lagarto-MAX as a network hub #

Lagarto-MAX is a central piece in the lagarto ecosystem, not only for its wide functionality but also because it acts as a hub between servers and clients.

<p align='center'>
<img src='http://www.panstamp.com/images/lagarto_hub.png' alt='lagarto-max as the central hub' width='350' />
</p>

In order for lagarto-max to run as the central hub or concentrator, it has to be started before any other lagarto process. Then, lagarto servers need to connect to lagarto-max via its broadcast port, that is the one being configured from the lagarto settings page. Finally, lagarto clients will connect to lagarto-max via the secondary broadcast port, that is the main broadcast port + 1.

# Event programming #

Programming events from the web interface is simple and intuitive. The _Event Panel_ lists all the programmed events and lets us create new ones by pressing the "New Event" button:

<p align='center'>
<img src='https://lh4.googleusercontent.com/-FnuRQ81mkDE/T4gX5SYe1CI/AAAAAAAAAP0/H69VaO0MUcc/s593/lagarto_max_event_panel.png' />
</p>

Each event page shows three different sections: triggers. additional conditions and actions.

  * **Triggers** are initial conditions required to start an action. We can create multiple triggers on a single event but only one of them has to be fulfilled in order to run the subsequent actions. Two different types: lagarto network conditions and time conditions.
  * **Additional conditions** don't trigger the event by themselves but all of them must be fulfilled. Two different types: lagarto network conditions and time conditions.
  * **Actions**. Two different types: lagarto network conditions and cloud data service.

<p align='center'>
<img src='https://lh6.googleusercontent.com/-tCAeutQBNog/T4g4YU5M3RI/AAAAAAAAAQI/FTlubJ95Xwk/s621/lagarto_max_event_editor.png' />
</p>

Defining new triggers and additional conditions is just a matter of pressing the "New" button and fill each requested field.

<p align='center'>
<img src='https://lh4.googleusercontent.com/-IjJ2Ef2wWfo/T4g839ZkjMI/AAAAAAAAAQg/P9jDxtt10hs/s623/lagarto_max_condition.png' />
</p>

And the same applies for actions. The following is an example of lagarto value being pushed to [Pachube](https://pachube.com):

<p align='center'>
<img src='https://lh5.googleusercontent.com/-rmQaM6OfLoU/T4g835TBISI/AAAAAAAAAQc/TmNqye3S9lE/s576/lagarto_max_action.png' />
</p>

In summary. the web event editor provides a simple interface for programming the behaviour of any lagarto network based on the event-action paradigm.

# Custom Python scripts #

Lagarto-MAX also provides a scripting mechanism for those wanting to develop their own Python scripts. "scripts/events.py" is the starting point for any user-defined event. This Python module contains a method named "event\_handler". This method is called once per minute and whenever a network value changes. This method has two arguments: "evnsrc" that shows the nature of the event (network and clock), and "evnobj", containing the related event object (lagarto endpoint or time data). Example of user code:

```
def event_handler(evnsrc, evnobj):
    """
    Event handling function
    
    @param evnsrc: event source ("network", "clock")
    @param evnobj: event object
    
    evnsrc = "network" -> evnobj = lagarto endpoint
    evnsrc = "clock" -> evnobj = time.localtime() object
    """
    
    if evnsrc == "network":
        print time.strftime("%d %b %Y %H:%M:%S", time.localtime()), evnobj
        
        value = network.get_value("SWAP-network.SWAP.Temperature")
        print "Temperature =", value
    elif evnsrc == "clock":
        print time.strftime("%d %b %Y %H:%M:%S", evnobj), "Time event"
```

The above is just an example. Users are allowed to develop large amounts of code and place them in separate modules, import Python libraries, run independent threads, etc.

## NetworkAPI ##

In order to interact with lagarto networks, Lagarto-MAX provides the class api.NetworkAPI. The following are some of the methods provided by this API:

```
def get_endpoint(endp):
    """
    Get Lagarto endpoint
        
    @param endp: endpoint identification string
    format 1: process.location.name
    format 2: process.id
        
    @return lagarto endpoint object
    """

    def get_value(endp):
        """
        Get endpoint value
        
        @param endp: endpoint identification string
        format 1: process.location.name
        format 2: process.id
        
        @return endpoint value
        """

    def set_value(endp, value):
        """
        Set endpoint value
        
        @param endp: endpoint identification string
        format 1: process.location.name
        format 2: process.id
        @param value: new endpoint value
        
        @return endpoint value
        """
```

Example of use:

```
from api import NetworkAPI as network

# Lagarto endpoint
endpoint = network.get_endpoint("SWAP-network.SWAP.Temperature")

print endpoint.name, "in", endpoint.location, "is", endpoint.value, endpoint.unit

# The above code prints the same result as the following:
value = network.get_endpoint("SWAP-network.SWAP.Temperature")

print "Temperature in SWAP is", value, " C"
```

## CloudAPI ##

CouldAPI provides direct mechanisms to push data to any of the [supported cloud services](LagartoMAX#Supported_cloud_data_services.md):

```
    def push_pachube(endp, sharing_key, feed_id, datastream_id):
        """
        Push data to pachube

        @param endp: endpoint identification string
        format 1: process.location.name
        format 2: process.id        
        @param sharing_key: Pachube sharing key
        @param feed_id: Pachube feed ID
        @param datastream_id: Pachube datastream ID
        
        @return HTTP response from Pachube
        """
    def push_thingspeak(endp, api_key, field_id):
        """
        Push data to ThingSpeak

        @param endp: endpoint identification string
        format 1: process.location.name
        format 2: process.id        
        @param api_key: ThingSpeak API key
        @param field_id: ThingSpeak field ID
        
        @return HTTP response from ThingSpeak
        """
```

Example of use

```
from api import CloudAPI as cloud

# Push humidity value to Pachube
cloud.push_pachube("SWAP-network.SWAP.Humidity",
                   "cykPX_p0wDMmAm8VDXXel3lqv8-SAKx4UlFJT3lyYWhSND0g",
                   "54081",
                   "10.12.1")

# And push it to ThingSpeak too
cloud.push_thingspeak("SWAP-network.SWAP.Humidity",
                      "VTPX8MN9BFZ7M8MZ",
                      "field2")
```

# Supported cloud data services #

Any value can be pushed to the following cloud services via custom scripting or web event:

## twitter ##

http://twitter.com

## Cosm ##

[Cosm](https://cosm.com)

## ThingSpeak ##

[ThingSpeak](https://www.thingspeak.com)

## Sen.se ##

[open.sen.se](http://open.sen.se/)

## AutoRemote ##

[AutoRemote](https://play.google.com/store/apps/details?id=com.joaomgcd.autoremote&hl=en)

AutoRemote acts as a messaging bus across a number of different platforms and applications. Very useful for pushing endpoint information to Android/iOS.

#### Usage Note ####
  * Message - Formatting string. The following are placeholders that can be used. When the message is sent, Lagarto will replace the placeholders with the relevant enpoint information. Ex: "${id} ${location} ${name} ${type} ${value} ${unit}=:=${name} is now ${value}"
    * ${id}
    * ${location}
    * ${name}
    * ${type}
    * ${direction}
    * ${value}
    * ${unit}