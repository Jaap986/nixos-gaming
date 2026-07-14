{ pkgs, inputs, ...}:
{

  home.packages = with pkgs; [
    adw-gtk3
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.rounded-corners
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.app-hider

  ];


  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" "pkcs11" ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Adwaita Sans 10";
      monospace-font-name = "Hack Nerd Font 10";
      font-antialiasing = "rgba";
      font-hinting = "none";

      gtk-theme = "adw-gtk3";
      icon-theme = "Papirus";

      color-scheme = "default";
      clock-format = "24h";

      show-battery-percentage = true;
      enable-hot-corners = false;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        rounded-window-corners-reborn.extensionUuid
        rounded-corners.extensionUuid
        dash-to-dock.extensionUuid
        appindicator.extensionUuid
        app-hider.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/appindicator" = {
      legacy-tray-enable = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = false;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-color = "rgb(0,0,0)";
      background-opacity = 0.3;
      custom-background-color = true;
      dash-max-icon-size = 32;
      disable-overview-on-startup = true;
      running-indicator-style = "DOTS";
      show-icon-emblems = false;
      show-mounts = false;
      show-trash = false;
      transparency-mode = "FIXED";
    };

    "org/gnome/shell/extensions/color-picker" = {
      color-picker-shortcut = [ "<Control>F4" ];
      enable-shortcut = true;
      enable-systray = false;
    };
  };

}
