#!/usr/bin/env bash
set -euo pipefail

red="$(printf '\033[0;31m')"
green="$(printf '\033[0;32m')"
reset="$(printf '\033[0m')"

available_systems="ally steambox steamdeck"

echo "${green}Starting NixOS installer...${reset}"

if [ "${EUID}" -ne 0 ]; then
  echo "${red}Please run as root: sudo install-nixos${reset}" >&2
  exit 1
fi

system="${1:-}"
if [ -z "${system}" ]; then
  echo "Available systems:"
  for candidate in ${available_systems}; do
    echo " - ${candidate}"
  done
  printf "Enter the system to install: "
  read -r system
fi

valid_system=false
for candidate in ${available_systems}; do
  if [ "${candidate}" = "${system}" ]; then
    valid_system=true
    break
  fi
done

if [ "${valid_system}" != true ]; then
  echo "${red}Error: invalid system '${system}'. Available: ${available_systems}${reset}" >&2
  exit 1
fi

disk="${2:-}"
if [ -z "${disk}" ]; then
  echo "Available disks:"
  lsblk -d -n -o NAME,SIZE,MODEL | grep -vE '^(loop|sr0)' || true
  printf "Enter the target device, for example nvme0n1 or sda: "
  read -r disk_name
  disk="/dev/${disk_name}"
fi

if [ ! -b "${disk}" ]; then
  echo "${red}Error: device ${disk} not found.${reset}" >&2
  exit 1
fi

echo "${red}WARNING: ALL DATA ON ${disk} WILL BE ERASED.${reset}"
echo "${red}Installing system: ${system}${reset}"
printf "Type 'yes' to continue: "
read -r confirm
if [ "${confirm}" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

umount -R /mnt 2>/dev/null || true
swapoff -a 2>/dev/null || true

echo "Partitioning ${disk}..."
parted -s "${disk}" -- mklabel gpt
parted -s "${disk}" -- mkpart ESP fat32 1MB 512MB
parted -s "${disk}" -- set 1 esp on
parted -s "${disk}" -- mkpart primary 512MB 100%

partprobe "${disk}"
sleep 2

if [ -e "${disk}p1" ]; then
  boot_part="${disk}p1"
  root_part="${disk}p2"
else
  boot_part="${disk}1"
  root_part="${disk}2"
fi

echo "${green}Partitions: boot=${boot_part}, root=${root_part}${reset}"

echo "Formatting boot partition..."
mkfs.vfat -F 32 -n BOOT "${boot_part}"

echo "Formatting root filesystem..."
mkfs.ext4 -L nixos "${root_part}"

partprobe "${disk}"
sleep 2

echo "Mounting filesystems..."
mount "${root_part}" /mnt
mkdir -p /mnt/boot
mount "${boot_part}" /mnt/boot

echo "Creating temporary 32G swapfile..."
fallocate -l 32G /mnt/swapfile
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile

echo "Copying configuration..."
mkdir -p /mnt/etc/nixos
if [ -d /etc/nixos-config ]; then
  cp -r /etc/nixos-config/. /mnt/etc/nixos/
  chmod -R +w /mnt/etc/nixos
else
  echo "${red}Error: flake source not found at /etc/nixos-config${reset}" >&2
  exit 1
fi


echo "Installing NixOS (${system})..."
nixos-install --flake "/mnt/etc/nixos#${system}" --no-root-passwd


echo "Removing temporary swapfile..."
swapoff /mnt/swapfile
rm /mnt/swapfile

echo "${green}Installation complete. You can now reboot.${reset}"
