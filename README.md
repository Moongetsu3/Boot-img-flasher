# Boot-img-flasher
This is a shell script written in bash made for flashing a boot image onto an Android device with A/B partitions without using any custom recovery and fastboot.
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
the Boot image with magisk Otherwise if it flashed directly it will give bootloop

So Whenever a new magisk updates comes we first need to patch the boot.img using latest Magisk app
Then we need to sign it with private keys then we can flash it using fastboot
And this whole process takes a lot of time.

So i made this script for flashing boot img to both A/B slot without using
Any custom recovery and fastboot it will save much time and it is very easy to use
and this script can be used in all devices.

## How this script works ❓
This script is very simple yet powerful and has many difference from other script because
It doesn't replace your ramdisk by unpacking and repacking the boot image,it directly flashes the boot image.
Also This script can automatically finds the partition location of the both boot slots,
and can flash a specified boot image to both slots using the dd command, It also includes functions for setting 
read-write permissions for several directores and remounting the device partitions as read writeable.

> The 'dd' command is a Linux/Unix command used for copying and converting data. It can be used to copy data between files, devices, and partitions, and can also be used to create disk images, wipe data, and perform other data manipulation tasks.
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
must need be in your internal storage's download folder in both cases and the boot image file name should be 'boot.img'**
**Otherwise the script will not work because it looks for boot image in the**
```/storage/emulated/0/Download``` directory.

# ⚙️ Other benefits
If you are on gsi that comes with prebuilt root access
You can use magisk app to patch your boot image and then
You can directly flash the image using my script by just giving root permission 
Using **PHH Superuser App**

**Note 1** 📝 : You only need the magisk app for this It doesn't matter if the boot image is rooted using Magisk or not.

**Note 2** 📝 : You Must need to flash your custom signed vbmeta-sign.img first if your device has unisoc cpu that running on android 10 and up.
                Because you have to also sign the boot image with private keys after patching it with magisk you can't flash it directly as i mentioned earlier

For more info about signing a unisoc image with private keys read this : [**Guide**](https://www.hovatek.com/forum/thread-32674.html)

For More info about custom vbmeta-sign image read this : [**Guide**](https://www.hovatek.com/forum/thread-32664.html)

So now a question will be pop up in your mind
 
**Where can i find a gsi that comes with prebuilt root access?**

Answer : All gsi comes with some Naming rules 
So download and flash a GSI that has
bvs,bvz,bgs or bgz naming on the archive.

**Here is some info about naming rules in GSI**

 S: *Built* with PHH Superuser (app needed to download)

 Z: *Built* with eremitein's Dynamic Superuser

 v: Vanilla, i.e. no GAPPS

 g: With regular GAPPS

 b: "AB", i.e. system-as-root

 # Disclaimer❗ 
**This script should only be used by experienced users who are familiar with the risks and consequences of flashing a boot image. Incorrect usage of this script can result in the bricking of the device or loss of data. Use at your own risk.**
