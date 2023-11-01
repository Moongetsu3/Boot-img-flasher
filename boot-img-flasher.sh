#!/system/bin/sh

# Check for root
check_root() {
  if [ "$(id -u)" != "0" ]; then
    echo "Error: This script must be run as root"
    echo "Please give root permission first!"
    exit 1
  fi
}

by_name_path=""
# Remount directories as read-write
find_and_remount_directories() {
  by_name_path=$(find /dev/block/platform -type d -name by-name 2>/dev/null)
  if [ -z "$by_name_path" ]; then
    echo "Error: Unable to locate the 'by-name' directory in /dev/block/platform."
    echo "Your device's partition structure may differ."
    exit 1
  fi

  mount -o rw,remount /dev/block 2>/dev/null
  mount -o rw,remount /dev/block/bootdevice/by-name 2>/dev/null
  mount -o rw,remount "$by_name_path" 2>/dev/null
}

# Find boot partitions and remount them as read-write
find_and_remount_boot_partitions() {
  boot_a="$by_name_path/boot_a"
  boot_b="$by_name_path/boot_b"

  boot_a_partition=$(readlink -f "$boot_a")
  boot_b_partition=$(readlink -f "$boot_b")

  if [ ! -e "$boot_a_partition" ] || [ ! -e "$boot_b_partition" ]; then
    echo "Error: Unable to locate 'boot_a' or 'boot_b' partition paths."
    echo "Make sure your android device has A/B partitions."
    echo ""
    echo "Alternatively, your Android device could use a different partitioning scheme or naming convention for partitions."
    exit 1
  fi

  mount -o rw,remount "$boot_a_partition" 2>/dev/null
  mount -o rw,remount "$boot_b_partition" 2>/dev/null
}

# Function to flash the boot image
flash_boot_image() {
  if [ "$1" = "$boot_a_partition" ]; then
    slot="slot_a"
  elif [ "$1" = "$boot_b_partition" ]; then
    slot="slot_b"
  fi
  echo "Flashing the boot image to $slot"
  if ! dd if="$2" of="$1"; then
    echo ""
    echo "Error: Flashing the boot image to $slot failed."
    exit 1
  fi
  sleep 3
}

# Start main action
check_root
# HEADER message
echo "########################################"
echo "#  Boot Image Flasher for A/B devices  #"
echo "#           Made by Abhijeet           #"
echo "########################################"
echo ""
echo "Finding both boot slot's partition location.."
echo "Done ✓"
sleep 1
echo ""

find_and_remount_directories
find_and_remount_boot_partitions
boot_image="/storage/emulated/0/Download/boot.img"

if [ ! -f "$boot_image" ]; then
  echo "Error: Boot image file not found in $(dirname "$boot_image")"
  echo "Please make sure the boot image file exists at the specified path."
  exit 1
fi

flash_boot_image "$boot_a_partition" "$boot_image"
flash_boot_image "$boot_b_partition" "$boot_image"

echo ""
echo "The boot image was successfully flashed in both slots."
echo "Now reboot."

exit 0