# Introduction #

Lagarto can be run on a Raspberry Pi. Either you can install everything from scratch or you could download our image based on Raspbian which includes Lagarto-SWAP, Lagarto-MAX and an OpenRemote version which can be integrated with Lagarto.

http://www.panstamp.com/_/rsrc/1352127280683/announcements/newupdatedimageforraspberrypi/raspberry_01.png?height=222&width=400


# Getting started #

  1. Download the latest image here: http://www.panstamp.org/lagarto_images/lagarto_rpi_0.8_2gb.zip
  1. Unzip and write the image to the SD card (at least 2 GB) according to the [Raspberry Pi Wiki](http://elinux.org/RPi_Easy_SD_Card_Setup#Copying_the_image_to_an_SD_Card_on_Windows):
    * For Windows, use [Win32 Disk Imager](http://sourceforge.net/projects/win32diskimager/)
    * For Linux, use `dd if=lagarto_rpi_xyz.img of=/dev/sdc`
  1. Insert the SD card in your Raspberry Pi and boot it up.
  1. By default, Raspbian comes with with DHCP enabled so you need to get the IP-address from your DHCP server.
  1. Once started, you should be able to access:
    * http://ip-address:8001 for Lagarto-SWAP
    * http://ip-address:8002 for Lagarto-MAX
  1. You can SSH to the Raspberry and login using username "pi" and password "raspberry"


# Raspberry Pi configuration #

  * To change IP-address, edit **`/etc/network/interfaces`**
  * To change which DNS servers to use, edit **`/etc/resolv.conf`**


# Raspberry Pi updates #

Between each Raspberry Pi, Lagarto applications will probably get updated. To update your applications, ssh to the Raspberry Pi and run the following command to install svn (subversion) which is needed on the Raspberry Pi to update Lagarto. This only needs to be run once.

```
sudo aptitude install subversion
```

Then run the following to update Lagarto:

```
cd ~/panStamp/lagarto/
# If the version is very old, you might need to run
sudo svn upgrade
# Then update
sudo svn update
```


# Raspberry Pi re-install #

If you decide to re-install your Raspberry Pi, you might want to backup your current configuration.

For **Lagarto-SWAP**, you need to backup:
  * `~/panStamp/lagarto/lagarto-swap/config/`

For **Lagarto-MAX**, you need to backup:
  * `~/panStamp/lagarto/lagarto-max/config`
  * `~/panStamp/lagarto/lagarto-max/webscripts.py`


# Raspberry Pi version history #

  * 0.1: Initial release.
  * 0.2: Including autostart och Lagarto.
  * 0.3: Including OpenRemote.
  * 0.6: Compatible with any version/revision of Raspberry hardware.
  * 0.7: Included OpenRemote in image.