{ pkgs, lib, extraArgs ? {}, ... }:
{
  # ============================================================================
  # Boot Configuration
  # ============================================================================
  custom.boot.default.enable = true;

  boot.kernelPatches = [
    {
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }
  ];

  # ============================================================================
  # Networking Configuration
  # ============================================================================
  networking.hostName = "steambox";
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp40s0.wakeOnLan = { enable = true; };

  networking.firewall = {
    enable = true;
  };

  # ============================================================================
  # Hardware Configuration
  # ============================================================================
  custom.hardware.base.enable = true;
  custom.hardware.base.swapSize = 32768;

  custom.hardware.bluetooth.enable = true;
  custom.hardware.bluetooth.experimental = false;

  custom.hardware.graphics.enable = true;

  custom.hardware.audio.enable = true;
  custom.hardware.input."8bitdo".enable = true;

  # ============================================================================
  # Gaming Configuration
  # ============================================================================
  custom.gaming.jovian.enable = true;
  custom.gaming.steamvrStreaming.enable = true;

  services.inputplumber.enable = lib.mkForce false;

  # ============================================================================
  # Services Configuration
  # ============================================================================
  services.fwupd.enable = true;

  services.udev.extraRules = ''
    # Enable wakeup for the Bluetooth USB receiver (MediaTek 13d3:3563)
    ACTION=="add|bind", SUBSYSTEM=="usb", ATTRS{idVendor}=="13d3", ATTRS{idProduct}=="3563", ATTR{power/wakeup}="enabled"

    # Enable wakeup for USB root hubs to propagate wake signals
    ACTION=="add|bind", SUBSYSTEM=="usb", ATTRS{idVendor}=="1d6b", ATTRS{idProduct}=="0002", ATTR{power/wakeup}="enabled"
    ACTION=="add|bind", SUBSYSTEM=="usb", ATTRS{idVendor}=="1d6b", ATTRS{idProduct}=="0003", ATTR{power/wakeup}="enabled"
  '';

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
