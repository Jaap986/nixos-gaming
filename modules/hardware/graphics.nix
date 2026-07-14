{ config, lib, pkgs, ... }:

let
  cfg = config.custom.hardware.graphics;
in
{
  options.custom.hardware.graphics = {
    enable = lib.mkEnableOption "General graphics support (Mesa, Vulkan, 32-bit)";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        libvdpau-va-gl
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
      ];
    };
  };
}
