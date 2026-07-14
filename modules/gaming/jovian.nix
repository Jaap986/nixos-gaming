{ config, pkgs, lib, options, inputs, extraArgs ? {}, ... }:

let
  cfg = config.custom.gaming.jovian;
  hasJovian = options ? jovian;
in
{
  options.custom.gaming.jovian.enable = lib.mkEnableOption "Jovian gaming configuration";

  config = lib.mkIf cfg.enable (lib.optionalAttrs hasJovian {

    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    nixpkgs.config.permittedInsecurePackages = [
      "pnpm-9.15.9"
    ];

    jovian.steam = {
      enable = true;
      user = "gamer";
      autoStart = true;
      desktopSession = "gnome";
    };

    systemd.services."galileo-mura-setup".enable = lib.mkForce false;

    jovian.devices.steamdeck.enableVendorDrivers = lib.mkDefault false;

    services.inputplumber.enable = lib.mkDefault true;
    services.displayManager.gdm.enable = lib.mkForce false;
    services.speechd.enable = lib.mkForce false;

    jovian.steamos = {
      useSteamOSConfig = lib.mkDefault false;
      enableDefaultCmdlineConfig = lib.mkDefault false;
      enableBluetoothConfig = true;
      enableProductSerialAccess = false;
      enableSysctlConfig = false; # Scheduling etc tweaks
    };

    jovian.hardware.has.amd.gpu = true;

    jovian.decky-loader = {
      enable = true;
      package = pkgs.decky-loader-prerelease;
      user = "gamer";
      extraPackages = with pkgs; [
        curl
        unzip
        util-linux
        gnugrep
        readline.out
        procps
        pciutils
        libpulseaudio
        ryzenadj
        kmod
        python3
      ];
      extraPythonPackages = pythonPackages:
        with pythonPackages; [
          pyyaml
          hidapi
        ];
    };
  });
}
