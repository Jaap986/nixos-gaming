{ config, lib, ... }:

let
  cfg = config.custom.other.polkit;
in
{
  options.custom.other.polkit.enable = lib.mkEnableOption "custom polkit rules";

  config = lib.mkIf cfg.enable {
    security.polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users") &&
            (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
              action.id == "org.freedesktop.login1.suspend" ||
              action.id == "org.freedesktop.login1.suspend-multiple-sessions"
            )
          ) {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };
}
