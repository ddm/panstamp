# Lagarto: open automation platform #

  * [Introduction](lagarto#Introduction.md)
  * [Architecture](lagarto#Architecture.md)
  * [Protocol](lagarto#Protocol.md)
  * [Web interface](lagarto#Web_interface.md)
  * [HTTP GET/POST interface](lagarto#HTTP_GET/POST_interface.md)
    * [Raw format](lagarto#Raw_format.md)
    * [JSON format](lagarto#JSON_format.md)
  * [Installation](lagarto#Installation.md)
  * [Available lagarto processes](lagarto#Available_processes.md)
  * [Screenshots](lagarto#Screenshots.md)
  * [Supported web browsers](lagarto#Supported_web_browsers.md)

# Introduction #

Lagarto is an open platform designed to automate physical tasks in homes, buildings and industrial plants. Lagarto provides the necessary communication tools and computing infrastructure to build complex networking applications, capable to integrate resources from very different technologies and present them in an homogeneous way.

<p align='center'>
<img src='https://lh4.googleusercontent.com/-8P1_7FhVg-M/T0EkElm04XI/AAAAAAAAAKA/JB-ytn3w4Pg/s211/lagarto.png' />
</p>

Lagarto is the process "behind the scene". It provides the ability to access heterogeneous automation networks in a common way whilst doing the necessary computing tasks and routing data to/from third-party applications.

# Architecture #

Lagarto is a networked application written in Python. It consisting of two different types of processes:

  * **Lagarto servers**: servers connect the Lagarto infrastructure with external physical networks. Lagarto-SWAP is the reference implementation for this kind of component. Integrating Lagarto with other physical networks requires developing a custom Lagarto server.
  * **Lagarto clients**: clients are data consumers. They receive events from servers and send commands to them in a bi-directional way. Lagarto clients are typically implemented by computing services, scripting engines and graphical interfaces.

<p align='center'>
<img src='https://lh3.googleusercontent.com/-qqvlaJqjOJw/T0F9OJOZZuI/AAAAAAAAAMA/g3mNrfDfFO8/s512/Lagarto_arch.png' />
</p>

Communication between servers and clients are simple but efficient. Every Lagarto server provides a HTTP GET/POST interface used to control values from clients or any other application providing HTTP client capabilities (Web browser, javascript, Flash). Thus, Lagarto servers are very easily integrated into any Web-based platform through local network or the Internet. Besides, Lagarto servers use a common ZeroMQ Publishing socket used to notify events to clients so that clients have not to continuously poll for changes from the physical networks. This dual communication mechanism (ZeroMQ + HTTP) results in a powerful bi-directional solution whilst covering two major requirements: cross-platform and cross.network.

Compared to other automation solutions, Lagarto introduces a small but important difference: it does not require a controller or central piece of software. Lagarto servers are autonomous processes whilst clients can access them in a direct way. No need for a main daemon to be running all the time. Thus, we may say that Lagarto's architecture is totally distributed. Another important feature is that Lagarto processes can run in a common platform or be distributed across multiple computers, locally (LAN) or globally (Internet).

In order to make Lagarto servers really autonomous, they provide their own embedded Web server for the configuration tasks and also for basic monitoring purposes.

# Protocol #

Lagarto uses a custom JSON-based communication protocol between servers and clients. The following message is an example:

```
{
  "lagarto":
  {
    "procname": "SWAP network",
    "httpserver": "192.168.1.34:8001",
    "status":
    [
      {
        "id": "10.12.0",
        "location": "SWAP",
        "name": "Temperature",
        "value": 15.0,
        "unit": "C",
        "type": "num",
        "direction": "inp",
        "timestamp": "19 Feb 2012 16:15:17"
      },
      {
        "id": "10.12.1",
        "location": "SWAP",
        "name": "Humidity",
        "value": 20.0,
        "unit": "%",
        "type": "num",
        "direction": "inp",
        "timestamp": "19 Feb 2012 16:15:17",
      }
    ]
  }
}
```


# Web interface #
Lagarto processes provide a web interface for configuration and basic monitoring purposes. Every process binds to a different port number, allowing the existence of multiple servers on the same computer.

The HTTP port number is set from lagarto/Lagarto-Server/config/lagarto.xml. In the case of Lagarto-SWAP, the default HTTP port is 8001.

# HTTP GET/POST interface #
SWAP values can be queried and controlled through Lagarto-SWAP using simple HTTP commands. Lagarto servers accept both GET and POST methods for retrieving and setting values. Depending on the syntax of the HTTP request, values returned will present one of the following formats:

## Raw format ##
Raw format is a simple string containing the the endpoint value and unit. In order to get this format, the following syntax must be used:

**http://ip_address:port/values/endpoint_location/endpoint_name/?value=endpoint_value***

For a SWAP endpoint containing temperature data, with location = "SWAP" and name = "temperature" we should use this url in the HTTP GET request:

```
Request -> http://localhost:8001/values/SWAP/temperature/
Response -> 25.6 C
```

Now if we want to control an output:

```
Request -> http://localhost:8001/values/SWAP/relay5/?value=on
Response -> on
```

## JSON format ##
The raw format is good for basic applications since data returned may be directly used by the consumer without much work. However, in some other situations we may want to retrieve or control multiple endpoints at the same time. In this case, we need to use the JSON method:

**http://ip_address:port/values/?location=endpoint_location&name=name_location&...***

Not let's assume that we want to read a couple of temperature and humidity values:

```
Request -> http://localhost:8001/values/?location=garden&name=temperature5&location=bathroom&name=humidity1
Response ->
{
  "lagarto":
  {
    "procname": "SWAP network",
    "httpserver": "192.168.1.34:8001",
    "status":
    [
      {
        "id": "10.12.0",
        "location": "garden",
        "name": "temperature5",
        "value": 15.0,
        "unit": "C",
        "type": "num",
        "direction": "inp",
        "timestamp": "19 Feb 2012 16:15:17"
      },
      {
        "id": "10.12.1",
        "location": "bathroom",
        "name": "humidity1",
        "value": 20.0,
        "unit": "%",
        "type": "num",
        "direction": "inp",
        "timestamp": "19 Feb 2012 16:15:17",
      }
    ]
  }
}
```

If we want to read the whole SWAP network from a single HTTP GET request then we just run:

_http://localhost:8001/values_

and a complete list of values will be returned, following the same format as the above example.

And now we are going to control a couple of relays:

```
Request -> http://localhost:8001/values/?location=garden&name=relay1&value=on&location=garden&name=relay2&value=off
Response ->
{
  "lagarto":
  {
    "procname": "SWAP network",
    "httpserver": "192.168.1.34:8001",
    "status":
    [
      {
        "id": "10.12.0",
        "location": "garden",
        "name": "relay1",
        "value": "ON",
        "type": "bin",
        "direction": "out",
        "timestamp": "19 Feb 2012 16:15:17"
      },
      {
        "id": "10.12.1",
        "location": "garden",
        "name": "relay2",
        "value": "OFF",
        "type": "bin",
        "direction": "out",
        "timestamp": "19 Feb 2012 16:15:17",
      }
    ]
  }
}
```

# Installation #

Before installing Lagarto you need to install pyserial, ZeroMQ with the Python bindings and Barrel.

  1. Download [pyserial](http://pypi.python.org/pypi/pyserial) and install it by running this command:
```
# python setup.py install
```
  1. To install ZeroMQ just download the necessary package from [here](http://www.zeromq.org/area:download) and follow the provided instructions. Most popular OS's also provide [pre-packaged installers](http://www.zeromq.org/distro:_start). Then follow [these instructions](http://www.zeromq.org/bindings:python) for the Python bindings
  1. Barrel is the middleware used to provide HTTP Basic Authentication for the HTTP services. Download teh latest version from [here](http://pypi.python.org/pypi/barrel/0.1.3), untar the package and complete the installation using the following command:
```
# python setup.py install
```

Now, if you want to run [Lagarto-SWAP](LagartoSWAP.md), you need to install pyswap. At the moment of writing this tutorial there was no setup script do you will have to do the followng:

  1. [Download our Python toolbox](http://www.panstamp.com/downloads/panStamp_apps.zip?attredirects=0&d=1) for panStamp and SWAP.
  1. Enter the pyswap directory and install the package using this command:
```
# python setup.py install
```

If you want to run [Lagarto-MAX](LagartoMAX.md), you need to install [PyEphem](http://rhodesmill.org/pyephem/) first. Download the PyEphem package and run this command:
```
# python setup.py install
```

And also install the [Python Twitter Tools](http://mike.verdone.ca/twitter/):
```
# easy_install twitter
```

After installing PTT, send a first message to your Twitter account from PTT's command-line tool:

```
# twitter -emyemail@address.com Hello world!
```

This will set your Twitter account as the default one on your computer so that Lagarto-MAX won't have to worry about this.

And finally run the necessary Lagarto processes. For Lagarto-SWAP:
```
# python lagarto/lagarto-swap/lagarto-swap.py
```
For Lagarto-MAX:
```
# python lagarto/lagarto-max/lagarto-max.py
```

# Available processes #

  * [Lagarto-SWAP](LagartoSWAP.md): lagarto server for SWAP networks and panStamps
  * [Lagarto-MAX](LagartoMAX.md): lagarto client providing event management and connectivity to cloud data services

# Screenshots #

<p align='center'>
<img src='https://lh3.googleusercontent.com/-RuXgt1GFqQc/T0EnK7uOLHI/AAAAAAAAALM/khH86oZHl08/s591/lagarto_web_2.png' />
</p>

<p align='center'>
<img src='https://lh4.googleusercontent.com/-gbXrbZaYKuE/T0Elh3N7VPI/AAAAAAAAAKU/FswIVwaZJ_w/s571/lagarto_web_1.png' />
</p>

# Supported web browsers #

Mozilla Firefox and Google Chrome have proven to work well with lagarto's web pages. Internet Explorer is able to display most pages except for the ones running AJAX (device and endpoint browsers).