{ pkgs, extraArgs ? {}, ... }:
{
  # ============================================================================
  # Shell Configuration
  # ============================================================================
  programs.zsh.enable = true;

  # ============================================================================
  # User Configuration
  # ============================================================================
  users.groups.gamer.gid = 1000;
  nix.settings.trusted-users = [ "gamer" ];
  users.users.gamer = {
    uid = 1000;
    isNormalUser = true;
    description = "Gamer";
    initialPassword = "changeme";
    extraGroups = [
      "gamer"
      "networkmanager"
      "wheel"
      "data"
      "video"
      "audio"
      "input"
      "docker"
      "render"
      "dialout"
      "adbusers"
    ];
    shell = pkgs.zsh;
  };

  # ============================================================================
  # Environment Setup
  # ============================================================================
  environment.localBinInPath = true;

}
