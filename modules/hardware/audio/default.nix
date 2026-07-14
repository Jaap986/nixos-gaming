{ config, lib, ... }:

let
  cfg = config.custom.hardware.audio;
in
{
  options.custom.hardware.audio = {
    enable = lib.mkEnableOption "Enable audio configuration (Pipewire/PulseAudio/RTKit)";
  };

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
