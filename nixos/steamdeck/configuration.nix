{ pkgs, lib, modulesPath, extraArgs ? {}, ... }:
{
  # ============================================================================
  # Boot Configuration
  # ============================================================================
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  custom.boot.default.enable = true;

  # ============================================================================
  # Networking Configuration
  # ============================================================================
  networking.hostName = "steamdeck";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
  };

  # ============================================================================
  # Hardware Configuration
  # ============================================================================
  custom.hardware.base.enable = true;
  custom.hardware.base.swapSize = 16384;
  custom.hardware.bluetooth.enable = true;
  custom.hardware.graphics.enable = true;

  custom.hardware.audio.enable = true;
  custom.hardware.input."8bitdo".enable = true;
  custom.hardware.input.logitech.enable = true;

  # ============================================================================
  # Gaming Configuration
  # ============================================================================
  custom.gaming.jovian.enable = true;
  jovian.devices.steamdeck.enable = true;

  # ============================================================================
  # Services Configuration
  # ============================================================================
  services.fwupd.enable = true;
  services.inputplumber.enable = lib.mkForce true;

  # ============================================================================
  # System Configuration
  # ============================================================================
  custom.other.polkit.enable = true;
  custom.other.ulimit.enable = true;

  # ============================================================================
  # Nixpkgs Configuration
  # ============================================================================
  nixpkgs.config.allowUnfree = true;

  # ============================================================================
  # Nix Configuration
  # ============================================================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ============================================================================
  # System Version
  # ============================================================================
  system.stateVersion = "25.11";
}
