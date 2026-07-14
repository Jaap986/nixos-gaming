{ config, lib, pkgs, ... }:

let
  cfg = config.custom.hardware.input.logitech;
in
{
  options.custom.hardware.input.logitech = {
    enable = lib.mkEnableOption "Logitech hardware support (logiops)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.logiops ];
    systemd.packages = [ pkgs.logiops ];
    systemd.services.logid.wantedBy = [ "multi-user.target" ];
  };
}
