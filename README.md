# Boot-img-flasher
This is a shell script written in bash designed to flash a boot image onto an Android device with A/B partitions. 
A boot image is a small, self-contained Linux kernel which is the core of the operating system, 
along with other essential files needed to start the Android device.

## Requirements ⛏️
 - An Android device with A/B partitions
 - Root access on the device

## Why i made this script❓

Most of the devices don't have any custom recovery support so in order to
Flash any images everyone uses fastboot.

Another reason :   
 > Devices with unisoc cpu running on Android 10 and up comes with vbmeta-sign and for this we needed to sign boot images with private keys after patching 
The Boot image with magisk Otherwise if it flashed directly it will give bootloop

So Whenever a new magisk updates comes we first need to patch the boot.img using latest Magisk spp
Then we need to sign it with private keys then we can flash it using fastboot
And this takes a lot of time.

So i made this script for flashing boot img to both A/B slot without using
Any custom recovery and fastboot it will save much time and it is very easy to use
and this script can be used in all devices.

## How this script works ❓

This script can automatically finds the location of the boot_a and boot_b slots,
and can flash a specified boot image to both slots using the dd command, It also includes functions for setting 
read-write permissions and remounting the system partitions.

> The 'dd' command it is a Linux/Unix command used for copying and converting data. It can be used to copy data between files, devices, and partitions, and can also be used to create disk images, wipe data, and perform other data manipulation tasks.

## ℹ️ Usage

This Script Can be used in two ways 

1. **Using any terminal emulator**

Download the boot-img-flasher.sh script to your device.
Open a terminal emulator for example termux or a command prompt on your device and navigate to the directory where the script is located.
Make the script executable by running the command 
> chmod +x boot-img-flasher.sh

Then give Superuser permission By typing
> su

Run the script by entering the command 
> ./boot-img-flasher.sh

Then reboot 

2. **Using Magisk**

Download the 
>boot_flash.zip

And flash it as a Magisk module
Then reboot

**Note 📝 : The boot image you are going to flash 
must need be placed in your internal storage's download folder in both cases**

```/storage/emulated/0/Download```

# Misc ⚙️
If you are on gsi that comes with prebuilt root access
You can use magisk app to patch your boot image and then
You can directly flash the image using my script by just giving root permission 
Using **PHH Superuser App**

So now a question will be pop up in your 
mind **Where can i find a gsi that comes with prebuilt root access?**

Answer : All gsi comes with some Naming rules 
So download and flash GSI that has
bvs,bvz,bgs or bgz naming on archive.

**Here is some info about naming rules in GSI**

 S: *Built* with PHH Superuser (app needed to download)

 Z: *Built* with eremitein's Dynamic Superuser

 v: Vanilla, i.e. no GAPPS

 g: With regular GAPPS

 b: "AB", i.e. system-as-root

 # Disclaimer❗ 
**This script should only be used by experienced users who are familiar with the risks and consequences of flashing a boot image. Incorrect usage of this script can result in the bricking of the device or loss of data. Use at your own risk.**
