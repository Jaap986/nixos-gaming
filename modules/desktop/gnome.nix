{ config, pkgs, lib, ... }:
let
  cfg = config.custom.desktop.gnome;
in {
  options.custom.desktop.gnome.enable = lib.mkEnableOption "Gnome Desktop Environment";

  config = lib.mkIf cfg.enable {
    documentation.enable = false;

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    programs.dconf.profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/login-screen" = {
            logo = "";
          };
          "org/gnome/desktop/interface" = {
            font-name = "Adwaita Sans 10";
            font-antialiasing = "rgba";
            font-hinting = "none";

            color-scheme = "default";
            clock-format = "24h";
          };
        };
      }
    ];

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "blackbox";
    };

    environment.pathsToLink = [ "/libexec" "/share/nautilus-python/extensions" ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      inter
      corefonts
      nerd-fonts.fira-code
      nerd-fonts.hack
    ];

    environment.systemPackages = with pkgs; [
      nautilus
      nautilus-python
      evince
      blackbox-terminal
      gnome-icon-theme
      adwaita-icon-theme
      papirus-icon-theme
      unrar
      flatpak
    ];

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit # text editor
      gnome-console
      cheese # webcam tool
      gnome-music
      gnome-weather
      gnome-maps
      gnome-text-editor
      simple-scan
      yelp
      gnome-user-docs
      epiphany # web browser
      geary # email reader
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      snapshot
      gnome-clocks
    ]);

    fonts = {
      fontconfig = {
        antialias = true;
        hinting.enable = true;
        hinting.autohint = true;
      };
    };

    system.fsPackages = [ pkgs.bindfs ];
    fileSystems = let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };

    services.gnome.evolution-data-server.enable = true;
    services.flatpak.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm-password.enableGnomeKeyring = true;
    security.pam.services.gdm.enableGnomeKeyring = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
