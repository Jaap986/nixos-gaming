{ config, lib, ... }:

let
  cfg = config.custom.hardware.base;
in
{
  options.custom.hardware.base = {
    enable = lib.mkEnableOption "Base hardware configuration (fileSystems, initrd, etc.)";
    swapSize = lib.mkOption {
      type = lib.types.int;
      default = 32768; # 32 GB
      description = "Swap file size in MB";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [{
      device = "/var/lib/swapfile";
      size = cfg.swapSize;
    }];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    # AMD common base configurations
    hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
    hardware.enableAllFirmware = true;
  };
}
