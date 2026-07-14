{ config, lib, extraArgs ? {}, ... }:

with lib;

{
  options.custom.other.ulimit = {
    enable = mkEnableOption "ulimit configuration for user limits";

    user = mkOption {
      type = types.str;
      default = "gamer";
      description = "User to apply the limits to";
    };
  };

  config = mkIf config.custom.other.ulimit.enable {
    security.pam.loginLimits = [
      { domain = config.custom.other.ulimit.user; item = "nofile"; type = "soft"; value = "1048576"; }
      { domain = config.custom.other.ulimit.user; item = "nofile"; type = "hard"; value = "1048576"; }
      { domain = config.custom.other.ulimit.user; item = "memlock"; type = "soft"; value = "unlimited"; }
      { domain = config.custom.other.ulimit.user; item = "memlock"; type = "hard"; value = "unlimited"; }
    ];
  };
}
