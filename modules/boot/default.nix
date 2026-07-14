{ config, pkgs, lib, ... }:

let
  cfg = config.custom.boot.default;
  transparentPng = pkgs.writeTextDir "transparent.png" ''
    iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=
  '';
in
{
  options.custom.boot.default.enable = lib.mkEnableOption "standard boot configuration";
  imports = [ ];

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      initrd.systemd.enable = true;

      initrd.kernelModules = [ ];


      plymouth = {
        enable = true;
        theme = "bgrt";
        logo = lib.mkDefault "${transparentPng}/transparent.png";
      };

      consoleLogLevel = 0;
      initrd.verbose = false;

      kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
        "vt.global_cursor_default=0"
      ];

      loader.systemd-boot.consoleMode = "keep";
      loader.timeout = 0;
    };
  };
}
