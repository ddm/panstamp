**Table of contents**:
  * [Introduction](RaspberryPI_image#Introduction.md)
  * [Download image and grab SD card](RaspberryPI_image#Download_image_and_grab_SD_card.md)
  * [Initializing Raspbian](RaspberryPI_image#Initializing_Raspbian.md)
  * [Connecting via SSH](RaspberryPI_image#Connecting_via_SSH.md)
  * [Test lagarto](RaspberryPI_image#Test_lagarto_and_OpenRemote.md)
  * [Run OpenRemote](RaspberryPI_image#Run_OpenRemote.md)

# Introduction #

Running [Lagarto](https://code.google.com/p/panstamp/wiki/lagarto) on a RaspberryPI is now a straightforward process. With panStamp's official image based on Raspbian you can avoid the steps about installing Python, ZeroMQ and the rest of dependencies necessary to make lagarto work on this platform.

# Download image and grab SD card #

You can download the latest panStamp image for Raspberry from [here](http://www.panstamp.org/lagarto_images/lagarto_rpi_0.8_2gb.zip).

This image is created from the standard Raspbian image, which is then modified for own purposes. This image does not provide a graphical desktop interface and comes with all the necessary to run Lagarto.

Once you download the zip file, you have to decompress it and grab the contents into your SD card. [This page](http://elinux.org/RPi_Easy_SD_Card_Setup#Copying_the_image_to_an_SD_Card_on_Windows) explains how to flash your image under different OS's.

Under Linux, you can use _dd_ to copy the image into the flash card:

```
# dd if=lagarto_rpi_XXXX.img of=/dev/sdc
```

where /dev/sdc is the SD card file system on your computer.

# Initializing Raspbian #

You will notice that the image only takes 2 GB of your SD card. If your card has a bigger size you can then expand the image. Logging into Raspbian for the first time will prompt you to configure your installation. Otherwise, you can run _raspi-config_ any time.

![http://www.panstamp.com/raspi-config.png](http://www.panstamp.com/raspi-config.png)

# Connecting via SSH #

Raspbian comes with DHCP enabled by default so you will probably want to edit /etc/network/interfaces if you want to enter static network settings and /etc/resolv.cong for your DNS's. After that you can connect via SSH. Default user is "pi". Default password is "raspberry".

# Test lagarto #

[lagarto-max](https://code.google.com/p/panstamp/wiki/LagartoMAX) and [lagarto-swap](https://code.google.com/p/panstamp/wiki/LagartoSWAP) are launched at start-up from a system script (/etc/init.d/panstamp) so 30 seconds after powering your Raspberry you should be able to connect to lagarto's embedded web server entering the following addresses from a web browser:

```
lagarto-swap : http://rpi_ip_address:8001
lagarto-max : http://rpi_ip_address:8002
```

# Run OpenRemote #

Even if [OpenRemote](http://www.openremote.com) is installed by default, it has been disabled from the official image due to an incompatibility with Oracle's license for the distribution of their new (pre-production) JDK8 for ARM. Instead, you have to manually install JDK8 for ARM with support for hard-float ABI by following [this tutorial](http://www.savagehomeautomation.com/projects/raspberry-pi-installing-oracle-java-se-8-with-javafx-develop.html). After that, you have to re-enable all the lines about OpenRemote from /etc/init.d/panstamp

Finally, you can check that [OpenRemote](http://www.openremote.org) is running by opening the controller page from a web browser: http://rpi_ip_address:8080/Controller

[This review](http://www.panstamp.com/announcements/openremotejoinsthepanstampecosystem) explains how to use OpenRemote with lagarto.