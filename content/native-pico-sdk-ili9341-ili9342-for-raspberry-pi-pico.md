---
title: "Native pico-sdk ILI9341/ILI9342 display drivere library for Raspberry Pi Pico in C++"
date: 2022-09-19T20:08:23+01:00
tags: ["c++", "c", "cplusplus", "embedded", "pico", "raspberry-pi-pico", "ILI9341", "display"]
author: ["darren"]
---

The ILI9341/ILI9342 works as display driver for a TFT display, and is available as either a standalone IC, or as a breakout board and is usually conntected up via SPI. I have added a [ILI9341 raspberry pi pico library](https://github.com/bizzehdee/pico-libs/tree/master/src/common/ili934x) as part of my group of libraries at the [pico-libs](https://github.com/bizzehdee/pico-libs/) repository on github.
<!--more-->
The library is easy to use and is easily includable in your project via cmake, and libraries are added in, in the same way that you add in the individual libraries from the pico-sdk its self.

You will first need to check out the pico-libs repository, and then copy external/pico_libs_import.cmake from the repository to the root of your firmware application.

You can add the library from the pico-lib's adding ```ili934x``` onto the end of your target_link_libraries in cmake:

```cmake
target_link_libraries([your executable] pico_stdlib ili934x)
```

You can then include "ili934x.h" and use the following methods from the ```ili934x``` class.

 * setRotation(ILI934X_ROTATION rotation = R0DEG)
   * set the rotation of the display
 * setPixel(uint16_t x, uint16_t y, uint16_t colour)
   * set the value of an individual pixel
 * fillRect(uint16_t x, uint16_t y, uint16_t h, uint16_t w, uint16_t colour)
   * fill a rect defined by x, y, h and w
 * drawLine(uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, uint16_t color)
   * draw a line from any point, to any other point
 * drawCircle(uint16_t x0, uint16_t y0, uint16_t r, uint16_t color)
   * draw a circle, specifying the centre and the radius
 * clear(uint16_t colour = COLOUR_BLACK)
   * clear the whole screen
 * blit(uint16_t x, uint16_t y, uint16_t h, uint16_t w, uint16_t *bltBuf)
   * draw a set of RGB data defined by h and w, to the position x and y
 * drawChar(uint16_t x, uint16_t y, char c, uint16_t colour, GFXfont *font)
   * draw a single character on screen
 * charBounds(char c, int16_t *x, int16_t *y, int16_t *minx, int16_t *miny, int16_t *maxx, int16_t *maxy, GFXfont *font)
   * measure the size of an individual character
 * textBounds(const char *str, int16_t x, int16_t y, int16_t *x1, int16_t *y1, uint16_t *w, uint16_t *h, GFXfont *font)
   * measure the size of a string of text

All in native C++ with the pico-sdk.
