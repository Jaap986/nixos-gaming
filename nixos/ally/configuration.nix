{ config, pkgs, lib, extraArgs ? {}, ... }:
{
  # ============================================================================
  # Boot Configuration
  # ============================================================================
  custom.boot.default.enable = true;

  boot = {
    extraModprobeConfig = ''
      options mt7921_common disable_clc=1
    '';
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  # ============================================================================
  # Networking Configuration
  # ============================================================================
  networking.hostName = "ally";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
  };

  # ============================================================================
  # Hardware Configuration
  # ============================================================================
  custom.hardware.base.enable = true;
  custom.hardware.base.swapSize = 32768;
  custom.hardware.bluetooth.enable = true;
  custom.hardware.graphics.enable = true;

  custom.hardware.audio.enable = true;

  custom.hardware.input."8bitdo".enable = true;
  custom.hardware.input.logitech.enable = true;

  jovian.hardware.has.amd.gpu = true;

  # ============================================================================
  # Gaming Configuration
  # ============================================================================
  custom.gaming.jovian.enable = true;
  services.inputplumber.enable = lib.mkForce false;
  services.handheld-daemon = {
    enable = true;
    user = "gamer";
    adjustor.enable = true;
  };

  # ============================================================================
  # Services Configuration
  # ============================================================================
  services.fwupd.enable = true;

  # ============================================================================
  # System Configuration
  # ============================================================================
  custom.other.polkit.enable = true;
  custom.other.ulimit.enable = true;

  # ============================================================================
  # Nixpkgs Configuration
  # ============================================================================
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      handheld-daemon = prev.handheld-daemon.overrideAttrs (oldAttrs: {
        version = "4.1.12";
        src = prev.fetchFromGitHub {
          owner = "hhd-dev";
          repo = "hhd";
          tag = "v4.1.12";
          hash = "sha256-Cv6kDrPm8AIB+JleZ8e17NF3EX+lOFk4Ndc1eJO3J8Y=";
        };
      });
    })
  ];

  # ============================================================================
  # Nix Configuration
  # ============================================================================
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ============================================================================
  # System Version
  # ============================================================================
  system.stateVersion = "25.11";
}
