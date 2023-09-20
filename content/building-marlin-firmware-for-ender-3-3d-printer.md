---
title: "Building Marlin 2.0.x Firmware for Ender 3 3D Printer and Ender 3 Clones"
date: 2023-09-20T15:58:05Z
draft: false
author: ["darren horrocks"]
tags: ["C++", "cplusplus", "auduino", "3dprinting", "anet", "anet3d", "platformio", "ender3", "ctc"]
---

The Marlin firmware is an open-source firmware widely used in 3D printers, known for its flexibility and extensive feature set. This tutorial will guide you through the process of building the Marlin firmware for the Creality Ender 3 using PlatformIO, a powerful open-source ecosystem for IoT development, and Visual Studio Code (VSCode), a popular code editor.
<!--more-->

## Prerequisites
Before we begin, make sure you have the following:

* **Visual Studio Code (VSCode)**

Download and install Visual Studio Code.

* **PlatformIO Extension**

Open VSCode, go to the Extensions view (Ctrl+Shift+X or Cmd+Shift+X on Mac), and search for "PlatformIO IDE". Install it.

* **Clone Marlin Firmware Repository**

Open a terminal or command prompt and navigate to the directory where you want to store the Marlin firmware.
Run the command:

```bash
git clone https://github.com/MarlinFirmware/Marlin.git
```

## Building Marlin Firmware for Ender 3

* **Open Project in VSCode**

  * Open VSCode, and go to ```File > Open Folder...```, then select the ```Marlin``` folder you just cloned.

* **Select Board Configuration**

  * In the VSCode sidebar, expand the ```Marlin``` folder and navigate to ```Marlin/Configuration.h```. This file contains the configuration settings for your printer. Look for the section that mentions ```ENDER_3``` or similar. Make sure it's uncommented (remove ```//``` at the beginning of the line) and save the file.

* **Select Printer Options**

  * In the same Configuration.h file, scroll down to customize other settings like bed size, stepper driver type, and more according to your specific Ender 3 model and any modifications you've made.

* **Select Environment in PlatformIO**

  * Click on the PlatformIO icon on the sidebar (looks like a little alien head). Under "Project Tasks", expand the ```env```: dropdown and select ```STM32F103RET6_creality``` for Ender 3.

* **Build the Firmware**

  * Click on the "PlatformIO: Build" icon in the PlatformIO sidebar.

* **Upload the Firmware**

  * If you have a bootloader installed on your Ender 3, you can use a USB cable to upload the firmware. Otherwise, you'll need to use an ISP programmer.

## Flashing Firmware (Optional)

* **Bootloader Method (Recommended)**

  * If you have a bootloader, you can use a USB cable to flash the firmware:
  * Connect your printer to your computer via USB.
  * Click on "PlatformIO: Upload" in the PlatformIO sidebar.

* **ISP Programmer Method (If No Bootloader)**

  * You'll need an ISP programmer like an AVRISP mkII.
  * Connect the ISP programmer to your printer's board.
  * In PlatformIO, click on "PlatformIO: Upload using Programmer" in the sidebar

## Notes

* Backup Configuration: Before you make any changes, always back up your original ```Configuration.h``` and ```Configuration_adv.h``` files.
* Test the Firmware: After flashing, test the printer to ensure it functions correctly.

Remember, modifying firmware can potentially damage your printer if done incorrectly. Proceed with caution and double-check your configurations. If you encounter issues, refer to the [Marlin Documentation](https://marlinfw.org/docs/configuration/configuration.html) and community forums for help.
