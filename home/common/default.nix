{ pkgs, lib, ... }:
{
  # ============================================================================
  # General Configuration
  # ============================================================================
  home.username = "gamer";
  home.homeDirectory = "/home/gamer";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # ============================================================================
  # XDG Desktop Portal
  # ============================================================================
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";
  home.packages = [ pkgs.xdg-user-dirs ];
  home.activation.createXdgUserDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -L "$HOME/.config/user-dirs.dirs" ]; then
      rm "$HOME/.config/user-dirs.dirs"
    fi
    ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
  '';
}
