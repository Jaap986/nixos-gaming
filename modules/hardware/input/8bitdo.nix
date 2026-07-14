{ config, lib, pkgs, ... }:

with lib;

{
  options.custom.hardware.input."8bitdo" = {
    enable = mkEnableOption "8bitdo controller udev rules";
  };

  config = mkIf config.custom.hardware.input."8bitdo".enable {
    services.udev.packages = [
      (pkgs.writeTextFile {
        name = "8bitdo-udev-rules";
        text = ''
          # 2.4GHz/Dongle
          KERNEL=="hidraw*", ATTRS{idProduct}=="6012", ATTRS{idVendor}=="2dc8", MODE="0660", TAG+="uaccess"
          # Bluetooth
          KERNEL=="hidraw*", KERNELS=="*2DC8:6012*", MODE="0660", TAG+="uaccess"
        '';
        destination = "/etc/udev/rules.d/70-8bitdo.rules";
      })
    ];
  };
}
