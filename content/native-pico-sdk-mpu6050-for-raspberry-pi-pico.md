---
title: "Native pico-sdk mpu6050 accelerometer and gyroscope library for Raspberry Pi Pico in C++"
date: 2022-09-19T20:08:23+01:00
tags: ["c++", "c", "cplusplus", "embedded", "pico", "raspberry-pi-pico", "mpu6050"]
author: ["darren horrocks"]
---

The mpu6050 works as an accelerometer and gyroscope, and is available as either a standalone IC, or as a breakout board and is usually conntected up via I2C (IIC, ICC or I<sup>2</sup>C or SPI, depending on your preference). I have added a [mpu6050 raspberry pi pico library](https://github.com/bizzehdee/pico-libs/tree/master/src/common/mpu6050) as part of my group of libraries at the [pico-libs](https://github.com/bizzehdee/pico-libs/) repository on github.
<!--more-->
The library is easy to use and is easily includable in your project via cmake, and libraries are added in, in the same way that you add in the individual libraries from the pico-sdk its self.

You will first need to check out the pico-libs repository, and then copy external/pico_libs_import.cmake from the repository to the root of your firmware application.

You can add the library from the pico-lib's adding ```mpu6050``` onto the end of your target_link_libraries in cmake:

```cmake
target_link_libraries([your executable] pico_stdlib mpu6050)
```

You can then include "mpu6050.h" and use the following methods from the ```mpu6050``` class.

 * getEvent(sensors_event_t *accel, sensors_event_t *gyro, sensors_event_t *temp)
   * Getting the accelerometer values
   * the gyroscope values
   * and the temperature values

All in native C++ with the pico-sdk.
