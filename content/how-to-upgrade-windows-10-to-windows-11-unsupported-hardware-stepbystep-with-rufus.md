---
title: "How to Upgrade Windows 10 to Windows 11 on Unsupported Hardware (Step-by-Step with Rufus)"
date: 2025-09-11T13:25:45+01:00
draft: false
author: ["darren horrocks"]
tags: ["windows-10", "rufus", "windows-11"]
---

If your computer doesn’t meet Microsoft’s system requirements for Windows 11, you may have seen the dreaded message: *“This PC can’t run Windows 11.”* The usual culprits are missing **TPM 2.0**, no **Secure Boot**, or an older CPU.

But here’s the good news: you can still **upgrade Windows 10 to Windows 11 on unsupported hardware** using a free tool called **Rufus**. This method avoids complicated registry edits and gives you a cleaner installation experience.

In this guide, I’ll show you step by step how to install Windows 11 on unsupported PCs using Rufus.

<!--more-->

## Before You Start: Important Note

This method works well, but keep in mind:

* Microsoft does **not officially support Windows 11 on unsupported hardware**.
* You may not receive future feature updates automatically.
* Security updates could be limited in the future.
* Always **back up your files** before starting the upgrade.

## What You Need to Upgrade to Windows 11 with Rufus

To follow this tutorial, make sure you have:

* A USB drive with at least **8GB** of storage
* The latest version of **Rufus** (free download)
* The official **Windows 11 ISO file** from Microsoft
* A PC currently running **Windows 10**

## Step 1: Download Rufus and the Windows 11 ISO

1. Go to the [Rufus website](https://rufus.ie/) and download the newest version.
2. Visit the [Microsoft Windows 11 download page](https://www.microsoft.com/software-download/windows11).
3. Choose **Download Windows 11 Disk Image (ISO)** and save the file.

## 💻 Step 2: Create a Bootable Windows 11 USB with Rufus

Now let’s prepare the installation media:

1. Insert your USB drive into your computer.
2. Open **Rufus**.
3. Under **Device**, select your USB drive.
4. Under **Boot selection**, browse and select the Windows 11 ISO you downloaded.

When you choose the ISO, Rufus will display customization options that let you bypass Windows 11 requirements. These include:

* Remove requirement for **TPM 2.0**
* Remove requirement for **Secure Boot**
* Remove requirement for **RAM and CPU checks**

Tick the options that apply to your situation (or to be safe, just tick all three).

Click **Start**, and Rufus will create a bootable USB installer that bypasses all hardware checks.

## Step 3: Upgrade from Windows 10 to Windows 11

Once Rufus finishes:

1. Open your new USB drive in **File Explorer**.
2. Run **setup.exe**.
3. Select **Keep personal files and apps** if you want to upgrade without losing your data.
4. Accept the warning about unsupported hardware.

Windows 11 will now install on your PC, even if it doesn’t meet Microsoft’s official system requirements.

## Step 4: Enjoy Windows 11 on Unsupported PCs

When your computer restarts, you’ll be greeted with Windows 11 running smoothly on your previously unsupported hardware.

### A few things to remember:

* You should still receive **security updates** from Microsoft.
* Major **feature updates** may require repeating this process.
* Always keep a **backup** of important files, just in case.

## Final Thoughts

Upgrading from **Windows 10 to Windows 11 on unsupported hardware with Rufus** is one of the easiest and safest methods. It removes the need for registry hacks and gives you control over which requirements to skip.

If you’ve been waiting to try Windows 11 but your PC isn’t supported, Rufus makes it possible in just a few clicks.
