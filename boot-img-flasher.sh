#!/system/bin/sh

set_read_write() {
for NAMES in $NAME; do
  blockdev --setrw $DIR$NAMES
done
}
remount_rw() {
DIR=/dev/block/mapper
NAME="/system_a /system_ext_a"
set_read_write
DIR=/dev/block/mapper
set_read_write
DIR=$MAGISKTMP/block
NAME="/vendor /system_root /system /system_ext"
set_read_write
mount -o rw,remount $MAGISKTMP/mirror/system
mount -o rw,remount $MAGISKTMP/mirror/system_root
mount -o rw,remount $MAGISKTMP/mirror/system_ext
mount -o rw,remount $MAGISKTMP/mirror/vendor
mount -o rw,remount /system
mount -o rw,remount /
mount -o rw,remount /system_root
mount -o rw,remount /system_ext
mount -o rw,remount /vendor
}


echo  "########################################"
echo  "#  Boot Image Flasher for A/B devices  #"
echo  "#           Made by Abhijeet           #"
echo  "########################################"
echo " "
echo "Finding the location's of both boot slots!"

# Find the path to the by-name directory
by_name_path=$(find /dev/block/platform -type d -name by-name)

# Check if the directory was found
if [ -z "$by_name_path" ]; then
  echo"Error: by-name directory not found"
  exit 1
fi

# List the contents of the directory with detailed information
ls -la "$by_name_path" > /dev/null 2>&1

# Find the location of the boot_a and boot_b symlinks
boot_a_symlink=$(readlink "$by_name_path/boot_a")
boot_b_symlink=$(readlink "$by_name_path/boot_b")

# Check if the symlinks were found
if [ -z "$boot_a_symlink" ] || [ -z "$boot_b_symlink" ]; then
  echo"Error: boot_a or boot_b SLOT location not found"
  exit 1
fi

sleep 5
echo ""
# Print the location of the symlinks
echo "The location of the boot_a SLOT is: $boot_a_symlink"
echo ""
echo "The location of the boot_b SLOT is: $boot_b_symlink"

boot_image="/storage/emulated/0/Download/boot.img"

# Flash the boot image to the boot_a and boot_b slot
echo ""
echo "Flashing boot image to $boot_a_symlink..."

dd if="$boot_image" of="$boot_a_symlink"

sleep 0.5

echo ""

echo "Flashing boot image to $boot_b_symlink..."

dd if="$boot_image" of="$boot_b_symlink"

sleep 0.5
echo ""
echo "Boot image flashed successfully."
echo ""
echo "Now reboot"
exit 0
