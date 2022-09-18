---
title: "Native pico-sdk BMP280 library for Raspberry Pi Pico in C++"
date: 2022-09-18T22:38:46+01:00
tags: ["c++", "c", "cplusplus", "embedded", "pico", "raspberry-pi-pico", "bmp280"]
author: ["darren"]
---

The BMP280 works as an ambient temperature sensor and air pressure sensor, and is available as either a standalone IC, or as a breakout board and is usually conntected up via I2C (IIC, ICC or I<sup>2</sup>C, depending on your preference). I have written a [bmp280 raspberry pi pico library](https://github.com/bizzehdee/pico-libs/tree/master/src/common/bmp280) as part of a group of libraries over at the [pico-libs](https://github.com/bizzehdee/pico-libs/) repository on github.
<!--more-->
The library is easy to use and is easily includable in your project via cmake, and libraries are added in, in the same way that you add in the individual libraries from the pico-sdk its self.

You will first need to check out the pico-libs repository, and then copy external/pico_libs_import.cmake from the repository to the root of your firmware application.

You can add the library from the pico-lib's adding ```bmp280``` onto the end of your target_link_libraries in cmake:

```cmake
target_link_libraries([your executable] pico_stdlib bmp280)
```

You can then include "bmp280.h" and use the following methods from the ```BMP280``` class.

 * readTemperature();
 * readPressure(void);
 * readAltitude(float seaLevelhPa = 1013.25);
 * seaLevelForAltitude(float altitude, float atmospheric);
 * waterBoilingPoint

