Thanks
======
https://github.com/marcoskirsch/nodemcu-httpserver

Wiring
=====

Wire ESP8266 as follows:
* D1 - SDA on OLED
* D2 - SDL on OLED
* D5 - SCK on SD Card
* D6 - MISO on SD Card
* D7 - MOSI on SD Card
* D8 - CS on SD Card

Both SD card and OLED runs off 3.3v DC, so wire to the appropriate pins

RECOMMENDED: a LIGHT usb battery pack - running wire down your leg all con is a pain

I used a D1 Mini, so this will run on pretty much anything as long as you have a tiny handful of data pins

Setup
=====
Flash NodeMCU to the esp8266 compiled with the following libraries:

file, gpio, i2c, mdns, net, node, spi, tmr, u8g, uart, wifi

((probably via https://nodemcu-build.com/ ))


Upload user.lua and init.lua to the ESP8266

Upload all other files to the SD card

Reboot the chip, you should start serving as soon as the background is no longer mostly white


Parts
=====

https://www.banggood.com/WeMos-D1-Mini-V2-NodeMcu-4M-Bytes-Lua-WIFI-Internet-Of-Things-Development-Board-Based-ESP8266-p-1115398.html?rmmds=search

https://www.banggood.com/0_96-Inch-4Pin-White-IIC-I2C-OLED-Display-Module-12864-LED-For-Arduino-p-958196.html?rmmds=search

https://www.banggood.com/5Pcs-Slot-Socket-Reader-SD-Card-Module-For-Mp3-Arduino-Compatible-p-955686.html?rmmds=search
