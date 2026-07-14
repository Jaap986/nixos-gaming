{ config, pkgs, lib, ... }:

let
  cfg = config.custom.gaming.steam;
  steamvrStreamingCfg = config.custom.gaming.steamvrStreaming;
in
{
  options.custom.gaming.steam.enable = lib.mkEnableOption "Steam setup";
  options.custom.gaming.steamvrStreaming.enable =
    lib.mkEnableOption "SteamVR streaming support";

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {

      programs.steam = {
        enable = true;
      };

      environment.systemPackages = [
        pkgs.adwsteamgtk
      ];

    })

    (lib.mkIf steamvrStreamingCfg.enable {
      programs.steam.remotePlay.openFirewall = true;
      programs.steam.localNetworkGameTransfers.openFirewall = true;
      networking.firewall.allowedUDPPorts = [ 10400 10401 ];
      networking.firewall.allowedTCPPorts = [ 27037 ];

      # Steam's hardware udev rules cover VR device access and uinput setup.
      hardware.steam-hardware.enable = true;
    })
  ];
}
