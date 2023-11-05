---
title: "Setting Up Bitlocker With SSD/NVME Hardware Encryption (it can be faster than no encryption at all)"
date: 2023-10-24T11:23:23+01:00
draft: false
tags: ["guide", "windows", "encryption", "nvme", "ssd", "bitlocker", "how-to", "windows-11"]
author: ["darren horrocks"]
---

[It has recently been reported](https://www.neowin.net/news/microsofts-default-bitlocker-on-your-windows-11-pc-is-hitting-even-the-fastest-ssds-hard/) that Windows 11's default always-on bitlocker protection, with software encryption, [could be crippling upto 45% of your storage performance](https://www.tomshardware.com/news/windows-software-bitlocker-slows-performance).

To use Bitlocker with SSD Hardware full disk encryption, it's crucial that your SSD supports TCG Opal and the eDrive standard (IEEE-1667). Unfortunately, many manufacturers omit this information from their datasheets, making it hard to find. To identify compatible devices with TCG Opal support, you can use the filter on the German Website [Geizhals](https://geizhals.de/?cat=hdssd&xf=8525_TCG+Opal).

You will also require the manufacturer's software for your SSD, such as Samsung Magician or Kingston’s SSD Manager.

<!--more-->

## Where to start

* SSD Compatibility Check:
  * Ensure your SSD supports TCG Opal and eDrive standard.
  * Visit [Geizhals](https://geizhals.de/?cat=hdssd&xf=8525_TCG+Opal) for a filtered list of compatible devices.

* Obtain Manufacturer's Software:
  * Download and install the specific software for your SSD (e.g., Samsung Magician or Kingston’s SSD Manager).

* Windows 2 Go Installation (Optional but Recommended):
  * Download the latest Windows ISO from [Microsoft](https://www.microsoft.com/software-download/windows11).
  * Create a Windows 2 Go installation on a fast USB Stick, preferably NVME based, using [Rufus](https://rufus.ie).

## What to do next

* BIOS Configuration
  * Install the SSD into the target computer.
  * Disable the Compatibility Support Module (CSM) in the BIOS. This option is typically found in the BOOT settings, though it may be hidden if fast boot is enabled.

* Boot into Windows Installation
  * Boot into a Windows installation; ideally, use a USB Stick with Windows 2 Go.

* SSD Software Component Installation:
  * Install the SSD software component and locate the option to prepare the drive for encryption. In Samsung Magician, find it under "Data Management - Encrypted Drive," while in Kingston’s SSD Manager, it's called "IEEE 1667 Enable."

* Secure Erase:
  * Perform a secure erase of the drive. You can do this directly in the tool or through BIOS options (found in the "Tools" section). Alternatively, you can use hdparm on Linux or diskpart on Windows.

* Block SID Configuration:
  * Disable "Block SID" in the BIOS alongside TPM configuration. If this option is not available in the BIOS, follow these steps in a Windows 2 Go installation:
    * Open Powershell as administrator.
    * Run: ```$tpm = gwmi -n root\cimv2\security\microsofttpm win32_tpm```
    * Run: ```$tpm.SetPhysicalPresenceRequest(97)```
  * Reboot.

* Complete Windows Installation:
  * On the next boot, follow the prompts on the POST screen.
  * Plug in your Windows installation stick and remove the Windows 2 Go stick.
  * Press "F10" to accept the command, and the computer will reboot.
  * Install Windows on the target SSD without accessing BIOS or Boot menu beforehand.

* Enable Hardware-Based Encryption via Group Policy
  * Open "group policies" via start.
  * Navigate to Computer Configuration > Administrative Templates > Windows Components > Bitlocker > System Drive > Administrative Configure use of hardware-based encryption for fixed data drives.
  * Activate the policy and disable fallback to software encryption in the lower left.

* Encrypt System Drive:
  * Open Bitlocker and initiate the encryption process for your system drive.

* Optional Step (if "Block SID" config is persistent):
  * If the POST screen indicates that the "Block SID" configuration is persistent, re-enable it either in the BIOS or via Windows Powershell:
    * Open Powershell as admin in Windows 2 Go.
    * Run: ```$tpm = gwmi -n root\cimv2\security\microsofttpm win32_tpm```
    * Run: ```$tpm.SetPhysicalPresenceRequest(96)```
  * Reboot.

* Enjoy better SSD performance... 😁



