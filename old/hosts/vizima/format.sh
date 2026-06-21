#!/bin/sh

label_prefix=$1

# E.g. '/dev/sda'. The device will be wiped
device=$2
# Amount in mibibytes
esp_size=1024
esp_size="$(($esp_size + 1))MiB"
# IMPORTANT!!! There seems to be some sort of bug or whatever but for some reason end-alignment doesn't seem to work. Find out the best end in sectors and set below!
# esp_end=262655 # NEWER!!! Or maybe the error I get is completely fine since the boot partition isn't going to be encrypted anyways. Maybe it just doesn't matter.

sgdisk -Z $device

boot_num=2
root_num=1

# Partition

sgdisk --align-end --new=$boot_num:$esp_start:$esp_end --typecode=$boot_num:ef00 --change-name=$boot_num:"${label_prefix}-physical-boot" $device
sgdisk --align-end --new=$root_num:0:0 --typecode=$root_num:8300 --change-name=$root_num:"${label_prefix}-physical-root" $device

sgdisk --verify --print $device

# Enter a number in gibibytes
swap_size=$3
swap_size="${swap_size}GiB"

# Gets a /dev/* disks number in /dev/disk/by-diskseq which can then be used with the partition numbers to reference the partitions using just their number as previously defined
find_diskseq_number() {

	local dev="$(readlink -f "$1")"
	for path in /dev/disk/by-diskseq/*; do
		if [[ "$(readlink -f "$path")" == "$dev" ]]; then
			basename "$path"
			return 0
		fi
	done
	return 1
}

disk_seq_num=$(find_diskseq_number $device)

boot_dev="/dev/disk/by-diskseq/${disk_seq_num}-part${boot_num}"
root_dev="/dev/disk/by-diskseq/${disk_seq_num}-part${root_num}"

# Format

mkfs.fat -F 32 $boot_dev -n "${label_prefix}-boot"

cryptsetup luksFormat --verify-passphrase --label="${label_prefix}-encrypted-root" $root_dev
cryptsetup luksOpen $root_dev "${label_prefix}-cryptroot"

cryptroot_dev="/dev/mapper/${label_prefix}-cryptroot"

pvcreate $cryptroot_dev

lvm_group="${label_prefix}_lvm"
vgcreate $lvm_group $cryptroot_dev

lvcreate --size $swap_size $lvm_group --name "swap"
lvcreate -l 100%FREE $lvm_group --name "base"

swap_dev="/dev/mapper/${lvm_group}-swap"
base_dev="/dev/mapper/${lvm_group}-base"

mkswap -L "${label_prefix}-swap" $swap_dev

mkfs.btrfs -L "${label_prefix}-base" $base_dev
mount --mkdir $base_dev /mnt

btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix

umount -R /mnt

mount --mkdir -o compress=zstd,subvol=root $base_dev /mnt
mount --mkdir -o compress=zstd,subvol=home $base_dev /mnt/home
mount --mkdir -o compress=zstd,subvol=nix $base_dev /mnt/nix

mount --mkdir $boot_dev /mnt/boot

swapon $swap_dev
