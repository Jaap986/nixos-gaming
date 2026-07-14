{ config, lib, ... }:

let
  cfg = config.custom.hardware.bluetooth;
in
{
  options.custom.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth support";
    experimental = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable experimental Bluetooth features";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Experimental = cfg.experimental;
        FastConnectable = true;
      };
    };
  };
}
